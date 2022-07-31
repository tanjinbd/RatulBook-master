//
//	ReaderMainPagebar.h
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

@class ReaderMainPagebar;
@class ReaderTrackControl;
@class ReaderPagebarThumb;
@class ReaderDocument;

@protocol ReaderMainPagebarDelegate <NSObject>

@required // Delegate protocols

- (void)pagebar:(ReaderMainPagebar *)pagebar gotoPage:(NSInteger)page;

@end

@interface ReaderMainPagebar : UIView

@property (nonatomic, weak, readwrite) id <ReaderMainPagebarDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame document:(ReaderDocument *)object;

- (void)updatePagebar;

- (void)hidePagebar;
- (void)showPagebar;

@end

#pragma mark -

//
//	ReaderTrackControl class interface
//

@interface ReaderTrackControl : UIControl

@property (nonatomic, assign, readonly) CGFloat value;

@end

#pragma mark -

//
//	ReaderPagebarThumb class interface
//

@interface ReaderPagebarThumb : ReaderThumbView

- (instancetype)initWithFrame:(CGRect)frame small:(BOOL)small;

@end

#pragma mark -

//
//	ReaderPagebarShadow class interface
//

@interface ReaderPagebarShadow : UIView

@end
