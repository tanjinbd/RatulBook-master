//
//	ReaderThumbRequest.h
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

@class ReaderThumbView;

@interface ReaderThumbRequest : NSObject <NSObject>

@property (nonatomic, strong, readonly) NSURL *fileURL;
@property (nonatomic, strong, readonly) NSString *guid;
@property (nonatomic, strong, readonly) NSString *password;
@property (nonatomic, strong, readonly) NSString *cacheKey;
@property (nonatomic, strong, readonly) NSString *thumbName;
@property (nonatomic, strong, readwrite) ReaderThumbView *thumbView;
@property (nonatomic, assign, readonly) NSUInteger targetTag;
@property (nonatomic, assign, readonly) NSInteger thumbPage;
@property (nonatomic, assign, readonly) CGSize thumbSize;
@property (nonatomic, assign, readonly) CGFloat scale;

+ (instancetype)newForView:(ReaderThumbView *)view fileURL:(NSURL *)url password:(NSString *)phrase guid:(NSString *)guid page:(NSInteger)page size:(CGSize)size;

@end
