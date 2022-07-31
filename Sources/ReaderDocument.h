//
//	ReaderDocument.h
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

@interface ReaderDocument : NSObject <NSObject, NSCoding>

@property (nonatomic, strong, readonly) NSString *guid;
@property (nonatomic, strong, readonly) NSDate *fileDate;
@property (nonatomic, strong, readwrite) NSDate *lastOpen;
@property (nonatomic, strong, readonly) NSNumber *fileSize;
@property (nonatomic, strong, readonly) NSNumber *pageCount;
@property (nonatomic, strong, readwrite) NSNumber *pageNumber;
@property (nonatomic, strong, readonly) NSMutableIndexSet *bookmarks;
@property (nonatomic, strong, readonly) NSString *password;
@property (nonatomic, strong, readonly) NSString *fileName;
@property (nonatomic, strong, readonly) NSURL *fileURL;

@property (nonatomic, readonly) BOOL canEmail;
@property (nonatomic, readonly) BOOL canExport;
@property (nonatomic, readonly) BOOL canPrint;

+ (ReaderDocument *)withDocumentFilePath:(NSString *)filePath password:(NSString *)phrase;

+ (ReaderDocument *)unarchiveFromFileName:(NSString *)filePath password:(NSString *)phrase;

- (instancetype)initWithFilePath:(NSString *)filePath password:(NSString *)phrase;

- (BOOL)archiveDocumentProperties;

- (void)updateDocumentProperties;

@end
