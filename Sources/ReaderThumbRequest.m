//
//	ReaderThumbRequest.m
//	Bangla Book App
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

#import "ReaderThumbRequest.h"
#import "ReaderThumbView.h"

@implementation ReaderThumbRequest
{
	NSURL *_fileURL;

	NSString *_guid;

	NSString *_password;

	NSString *_cacheKey;

	NSString *_thumbName;

	ReaderThumbView *_thumbView;

	NSUInteger _targetTag;

	NSInteger _thumbPage;

	CGSize _thumbSize;

	CGFloat _scale;
}

#pragma mark - Properties

@synthesize guid = _guid;
@synthesize fileURL = _fileURL;
@synthesize password = _password;
@synthesize thumbView = _thumbView;
@synthesize thumbPage = _thumbPage;
@synthesize thumbSize = _thumbSize;
@synthesize thumbName = _thumbName;
@synthesize targetTag = _targetTag;
@synthesize cacheKey = _cacheKey;
@synthesize scale = _scale;

#pragma mark - ReaderThumbRequest class methods

+ (instancetype)newForView:(ReaderThumbView *)view fileURL:(NSURL *)url password:(NSString *)phrase guid:(NSString *)guid page:(NSInteger)page size:(CGSize)size
{
	return [[ReaderThumbRequest alloc] initForView:view fileURL:url password:phrase guid:guid page:page size:size];
}

#pragma mark - ReaderThumbRequest instance methods

- (instancetype)initForView:(ReaderThumbView *)view fileURL:(NSURL *)url password:(NSString *)phrase guid:(NSString *)guid page:(NSInteger)page size:(CGSize)size
{
	if ((self = [super init])) // Initialize object
	{
		NSInteger w = size.width; NSInteger h = size.height;

		_thumbView = view; _thumbPage = page; _thumbSize = size;

		_fileURL = [url copy]; _password = [phrase copy]; _guid = [guid copy];

		_thumbName = [[NSString alloc] initWithFormat:@"%07i-%04ix%04i", (int)page, (int)w, (int)h];

		_cacheKey = [[NSString alloc] initWithFormat:@"%@+%@", _thumbName, _guid];

		_targetTag = [_cacheKey hash]; _thumbView.targetTag = _targetTag;

		_scale = [[UIScreen mainScreen] scale]; // Thumb screen scale
	}

	return self;
}

@end
