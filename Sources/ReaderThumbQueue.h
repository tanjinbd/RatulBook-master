//
//	ReaderThumbQueue.h
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

#import <Foundation/Foundation.h>

@interface ReaderThumbQueue : NSObject <NSObject>

+ (ReaderThumbQueue *)sharedInstance;

- (void)addLoadOperation:(NSOperation *)operation;

- (void)addWorkOperation:(NSOperation *)operation;

- (void)cancelOperationsWithGUID:(NSString *)guid;

- (void)cancelAllOperations;

@end

#pragma mark -

//
//	ReaderThumbOperation class interface
//

@interface ReaderThumbOperation : NSOperation

@property (nonatomic, strong, readonly) NSString *guid;

- (instancetype)initWithGUID:(NSString *)guid;

@end
