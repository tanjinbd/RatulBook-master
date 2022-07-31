//
//	ReaderContentView.h
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

#import <UIKit/UIKit.h>

#import "ReaderThumbView.h"

@class ReaderContentView;
@class ReaderContentPage;
@class ReaderContentThumb;

@protocol ReaderContentViewDelegate <NSObject>

@required // Delegate protocols

- (void)contentView:(ReaderContentView *)contentView touchesBegan:(NSSet *)touches;

@end

@interface ReaderContentView : UIScrollView

@property (nonatomic, weak, readwrite) id <ReaderContentViewDelegate> message;

- (instancetype)initWithFrame:(CGRect)frame fileURL:(NSURL *)fileURL page:(NSUInteger)page password:(NSString *)phrase;

- (void)showPageThumb:(NSURL *)fileURL page:(NSInteger)page password:(NSString *)phrase guid:(NSString *)guid;

- (id)processSingleTap:(UITapGestureRecognizer *)recognizer;

- (void)zoomIncrement:(UITapGestureRecognizer *)recognizer;
- (void)zoomDecrement:(UITapGestureRecognizer *)recognizer;
- (void)zoomResetAnimated:(BOOL)animated;

@end

#pragma mark -

//
//	ReaderContentThumb class interface
//

@interface ReaderContentThumb : ReaderThumbView

@end
