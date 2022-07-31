//
//	ReaderThumbCache.m
//	Reader v2.9.0
//
//
//	2019-07-25: Version 1.6
//About the Developer:
//There's a lot that goes into each app development. At StarHOST, true to the spirit of a full service mobile aplication development firm we just don't code your app but we actively work with you to create solutions for your business. 
//Currently StarHOST is the only Localized mobile application provider in Bangladesh. 

//For more information about our products and services visit:
//http://starhostbd.com/apps/

//For any question(s)/comment(s) please email us at:
//info@starhostbd.com

//Development credits:
//iOS XCode Engineering and UI design:
//I.M. Tanjin Ahsan
//Production Management: 
//Kazi Zahidul Alam
//
//

#import "ReaderThumbCache.h"
#import "ReaderThumbQueue.h"
#import "ReaderThumbFetch.h"
#import "ReaderThumbView.h"

@implementation ReaderThumbCache
{
	NSCache *thumbCache;
}

#pragma mark - Constants

#define CACHE_SIZE 2097152

#pragma mark - ReaderThumbCache class methods

+ (ReaderThumbCache *)sharedInstance
{
	static dispatch_once_t predicate = 0;

	static ReaderThumbCache *object = nil; // Object

	dispatch_once(&predicate, ^{ object = [self new]; });

	return object; // ReaderThumbCache singleton
}

+ (NSString *)appCachesPath
{
	static dispatch_once_t predicate = 0;

	static NSString *theCachesPath = nil; // Application caches path string

	dispatch_once(&predicate, // Save a copy of the application caches path the first time it is needed
	^{
		NSArray *cachesPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);

		theCachesPath = [[cachesPaths objectAtIndex:0] copy]; // Keep a copy for later abusage
	});

	return theCachesPath;
}

+ (NSString *)thumbCachePathForGUID:(NSString *)guid
{
	NSString *cachesPath = [ReaderThumbCache appCachesPath]; // Caches path

	return [cachesPath stringByAppendingPathComponent:guid]; // Append GUID
}

+ (void)createThumbCacheWithGUID:(NSString *)guid
{
	NSFileManager *fileManager = [NSFileManager new]; // File manager instance

	NSString *cachePath = [ReaderThumbCache thumbCachePathForGUID:guid]; // Thumb cache path

	[fileManager createDirectoryAtPath:cachePath withIntermediateDirectories:NO attributes:nil error:NULL];
}

+ (void)removeThumbCacheWithGUID:(NSString *)guid
{
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0),
	^{
		NSFileManager *fileManager = [NSFileManager new]; // File manager instance

		NSString *cachePath = [ReaderThumbCache thumbCachePathForGUID:guid]; // Thumb cache path

		[fileManager removeItemAtPath:cachePath error:NULL]; // Remove thumb cache directory
	});
}

+ (void)touchThumbCacheWithGUID:(NSString *)guid
{
	NSFileManager *fileManager = [NSFileManager new]; // File manager instance

	NSString *cachePath = [ReaderThumbCache thumbCachePathForGUID:guid]; // Thumb cache path

	NSDictionary *attributes = [NSDictionary dictionaryWithObject:[NSDate date] forKey:NSFileModificationDate];

	[fileManager setAttributes:attributes ofItemAtPath:cachePath error:NULL]; // New modification date
}

+ (void)purgeThumbCachesOlderThan:(NSTimeInterval)age
{
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0),
	^{
		NSDate *now = [NSDate date]; // Right about now time

		NSString *cachesPath = [ReaderThumbCache appCachesPath]; // Caches path

		NSFileManager *fileManager = [NSFileManager new]; // File manager instance

		NSArray *cachesList = [fileManager contentsOfDirectoryAtPath:cachesPath error:NULL];

		if (cachesList != nil) // Process caches directory contents
		{
			for (NSString *cacheName in cachesList) // Enumerate directory contents
			{
				if (cacheName.length == 36) // This is a very hacky cache ident kludge
				{
					NSString *cachePath = [cachesPath stringByAppendingPathComponent:cacheName];

					NSDictionary *attributes = [fileManager attributesOfItemAtPath:cachePath error:NULL];

					NSDate *cacheDate = [attributes objectForKey:NSFileModificationDate]; // Cache date

					NSTimeInterval seconds = [now timeIntervalSinceDate:cacheDate]; // Cache age

					if (seconds > age) // Older than so remove the thumb cache
					{
						[fileManager removeItemAtPath:cachePath error:NULL];

						#ifdef DEBUG
							NSLog(@"%s purged %@", __FUNCTION__, cacheName);
						#endif
					}
				}
			}
		}
	});
}

#pragma mark - ReaderThumbCache instance methods

- (instancetype)init
{
	if ((self = [super init])) // Initialize
	{
		thumbCache = [NSCache new]; // Cache

		[thumbCache setName:@"ReaderThumbCache"];

		[thumbCache setTotalCostLimit:CACHE_SIZE];
	}

	return self;
}

- (id)thumbRequest:(ReaderThumbRequest *)request priority:(BOOL)priority
{
	@synchronized(thumbCache) // Mutex lock
	{
		id object = [thumbCache objectForKey:request.cacheKey];

		if (object == nil) // Thumb object does not yet exist in the cache
		{
			object = [NSNull null]; // Return an NSNull thumb placeholder object

			[thumbCache setObject:object forKey:request.cacheKey cost:2]; // Cache the placeholder object

			ReaderThumbFetch *thumbFetch = [[ReaderThumbFetch alloc] initWithRequest:request]; // Create a thumb fetch operation

			[thumbFetch setQueuePriority:(priority ? NSOperationQueuePriorityNormal : NSOperationQueuePriorityLow)]; // Queue priority

			request.thumbView.operation = thumbFetch; //[thumbFetch setThreadPriority:(priority ? 0.55 : 0.35)]; // Thread priority

			[[ReaderThumbQueue sharedInstance] addLoadOperation:thumbFetch]; // Queue the operation
		}

		return object; // NSNull or UIImage
	}
}

- (void)setObject:(UIImage *)image forKey:(NSString *)key
{
	@synchronized(thumbCache) // Mutex lock
	{
		NSUInteger bytes = (image.size.width * image.size.height * 4.0f);

		[thumbCache setObject:image forKey:key cost:bytes]; // Cache image
	}
}

- (void)removeObjectForKey:(NSString *)key
{
	@synchronized(thumbCache) // Mutex lock
	{
		[thumbCache removeObjectForKey:key];
	}
}

- (void)removeNullForKey:(NSString *)key
{
	@synchronized(thumbCache) // Mutex lock
	{
		id object = [thumbCache objectForKey:key];

		if ([object isMemberOfClass:[NSNull class]])
		{
			[thumbCache removeObjectForKey:key];
		}
	}
}

- (void)removeAllObjects
{
	@synchronized(thumbCache) // Mutex lock
	{
		[thumbCache removeAllObjects];
	}
}

@end
