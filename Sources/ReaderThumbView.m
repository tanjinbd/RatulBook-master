//
//	ReaderThumbView.m
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

#import "ReaderThumbView.h"

@implementation ReaderThumbView
{
	NSOperation *_operation;

	NSUInteger _targetTag;
}

#pragma mark - Properties

@synthesize operation = _operation;
@synthesize targetTag = _targetTag;

#pragma mark - ReaderThumbView instance methods

- (instancetype)initWithFrame:(CGRect)frame
{
	if ((self = [super initWithFrame:frame]))
	{
		self.autoresizesSubviews = NO;
		self.userInteractionEnabled = NO;
		self.contentMode = UIViewContentModeRedraw;
		self.autoresizingMask = UIViewAutoresizingNone;
		self.backgroundColor = [UIColor clearColor];

		imageView = [[UIImageView alloc] initWithFrame:self.bounds];

		imageView.autoresizesSubviews = NO;
		imageView.userInteractionEnabled = NO;
		imageView.autoresizingMask = UIViewAutoresizingNone;
		imageView.contentMode = UIViewContentModeScaleAspectFit;

		[self addSubview:imageView];
	}

	return self;
}

- (void)showImage:(UIImage *)image
{
	imageView.image = image; // Show image
}

- (void)showTouched:(BOOL)touched
{
	// Implemented by ReaderThumbView subclass
}

- (void)removeFromSuperview
{
	_targetTag = 0; // Clear target tag

	[self.operation cancel]; // Cancel operation

	[super removeFromSuperview]; // Remove view
}

- (void)reuse
{
	_targetTag = 0; // Clear target tag

	[self.operation cancel]; // Cancel operation

	imageView.image = nil; // Release image
}

@end
