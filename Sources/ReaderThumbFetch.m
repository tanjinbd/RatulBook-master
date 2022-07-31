//
//	ReaderThumbFetch.m
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

#import "ReaderThumbFetch.h"
#import "ReaderThumbRender.h"
#import "ReaderThumbCache.h"
#import "ReaderThumbView.h"

#import <ImageIO/ImageIO.h>

@implementation ReaderThumbFetch
{
	ReaderThumbRequest *request;
}

#pragma mark - ReaderThumbFetch instance methods

- (instancetype)initWithRequest:(ReaderThumbRequest *)options
{
	if ((self = [super initWithGUID:options.guid]))
	{
		request = options;
	}

	return self;
}

- (void)cancel
{
	[super cancel]; // Cancel the operation

	request.thumbView.operation = nil; // Break retain loop

	request.thumbView = nil; // Release target thumb view on cancel

	[[ReaderThumbCache sharedInstance] removeNullForKey:request.cacheKey];
}

- (NSURL *)thumbFileURL
{
	NSString *cachePath = [ReaderThumbCache thumbCachePathForGUID:request.guid]; // Thumb cache path

	NSString *fileName = [[NSString alloc] initWithFormat:@"%@.png", request.thumbName]; // Thumb file name

	return [NSURL fileURLWithPath:[cachePath stringByAppendingPathComponent:fileName]]; // File URL
}

- (void)main
{
	CGImageRef imageRef = NULL; NSURL *thumbURL = [self thumbFileURL];

	CGImageSourceRef loadRef = CGImageSourceCreateWithURL((__bridge CFURLRef)thumbURL, NULL);

	if (loadRef != NULL) // Load the existing thumb image
	{
		imageRef = CGImageSourceCreateImageAtIndex(loadRef, 0, NULL); // Load it

		CFRelease(loadRef); // Release CGImageSource reference
	}
	else // Existing thumb image not found - so create and queue up a thumb render operation on the work queue
	{
		ReaderThumbRender *thumbRender = [[ReaderThumbRender alloc] initWithRequest:request]; // Create a thumb render operation

		[thumbRender setQueuePriority:self.queuePriority]; //[thumbRender setThreadPriority:(self.threadPriority - 0.1)]; // Priority

		if (self.isCancelled == NO) // We're not cancelled - so update things and add the render operation to the work queue
		{
			request.thumbView.operation = thumbRender; // Update the thumb view operation property to the new operation

			[[ReaderThumbQueue sharedInstance] addWorkOperation:thumbRender]; return; // Queue the operation
		}
	}

	if (imageRef != NULL) // Create a UIImage from a CGImage and show it
	{
		UIImage *image = [UIImage imageWithCGImage:imageRef scale:request.scale orientation:UIImageOrientationUp];

		CGImageRelease(imageRef); // Release the CGImage reference from the above thumb load code

		UIGraphicsBeginImageContextWithOptions(image.size, YES, request.scale); // Graphics context

		[image drawAtPoint:CGPointZero]; // Decode and draw the image on this background thread

		UIImage *decoded = UIGraphicsGetImageFromCurrentImageContext(); // Newly decoded image

		UIGraphicsEndImageContext(); // Cleanup after the bitmap-based graphics drawing context

		[[ReaderThumbCache sharedInstance] setObject:decoded forKey:request.cacheKey]; // Cache it

		if (self.isCancelled == NO) // Show the image in the target thumb view on the main thread
		{
			ReaderThumbView *thumbView = request.thumbView; // Target thumb view for image show

			NSUInteger targetTag = request.targetTag; // Target reference tag for image show

			dispatch_async(dispatch_get_main_queue(), // Queue image show on main thread
			^{
				if (thumbView.targetTag == targetTag) [thumbView showImage:decoded];
			});
		}
	}

	request.thumbView.operation = nil; // Break retain loop
}

@end
