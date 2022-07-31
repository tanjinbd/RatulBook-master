//
//	ReaderContentTile.m
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

#import "ReaderContentTile.h"

@implementation ReaderContentTile

#pragma mark - Constants

#define LEVELS_OF_DETAIL 16

#pragma mark - ReaderContentTile class methods

+ (CFTimeInterval)fadeDuration
{
	return 0.001; // iOS bug (flickering tiles) workaround
}

#pragma mark - ReaderContentTile instance methods

- (instancetype)init
{
	if ((self = [super init])) // Initialize superclass
	{
		self.levelsOfDetail = LEVELS_OF_DETAIL; // Zoom levels

		self.levelsOfDetailBias = (LEVELS_OF_DETAIL - 1); // Bias

		UIScreen *mainScreen = [UIScreen mainScreen]; // Main screen

		CGFloat screenScale = [mainScreen scale]; // Main screen scale

		CGRect screenBounds = [mainScreen bounds]; // Main screen bounds

		CGFloat w_pixels = (screenBounds.size.width * screenScale);

		CGFloat h_pixels = (screenBounds.size.height * screenScale);

		CGFloat max = ((w_pixels < h_pixels) ? h_pixels : w_pixels);

		CGFloat sizeOfTiles = ((max < 512.0f) ? 512.0f : 1024.0f);

		self.tileSize = CGSizeMake(sizeOfTiles, sizeOfTiles);
	}

	return self;
}

@end
