//
//	CGPDFDocument.m
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

#import "CGPDFDocument.h"

//
//	CGPDFDocumentRef CGPDFDocumentCreateUsingUrl(CFURLRef, NSString *) function
//

CGPDFDocumentRef CGPDFDocumentCreateUsingUrl(CFURLRef theURL, NSString *password)
{
	CGPDFDocumentRef thePDFDocRef = NULL; // CGPDFDocument

	if (theURL != NULL) // Check for non-NULL CFURLRef
	{
		thePDFDocRef = CGPDFDocumentCreateWithURL(theURL);

		if (thePDFDocRef != NULL) // Check for non-NULL CGPDFDocumentRef
		{
			if (CGPDFDocumentIsEncrypted(thePDFDocRef) == TRUE) // Encrypted
			{
				// Try a blank password first, per Apple's Quartz PDF example

				if (CGPDFDocumentUnlockWithPassword(thePDFDocRef, "") == FALSE)
				{
					// Nope, now let's try the provided password to unlock the PDF

					if ((password != nil) && (password.length > 0)) // Not blank?
					{
						char text[128]; // char array buffer for the string conversion

						[password getCString:text maxLength:126 encoding:NSUTF8StringEncoding];

						if (CGPDFDocumentUnlockWithPassword(thePDFDocRef, text) == FALSE) // Log failure
						{
							#ifdef DEBUG
								NSLog(@"CGPDFDocumentCreateUsingUrl: Unable to unlock [%@] with [%@]", theURL, password);
							#endif
						}
					}
				}

				if (CGPDFDocumentIsUnlocked(thePDFDocRef) == FALSE) // Cleanup unlock failure
				{
					CGPDFDocumentRelease(thePDFDocRef), thePDFDocRef = NULL;
				}
			}
		}
	}
	else // Log an error diagnostic
	{
		#ifdef DEBUG
			NSLog(@"CGPDFDocumentCreateUsingUrl: theURL == NULL");
		#endif
	}

	return thePDFDocRef;
}

//
//	CGPDFDocumentRef CGPDFDocumentCreateUsingData(CGDataProviderRef, NSString *) function
//

CGPDFDocumentRef CGPDFDocumentCreateUsingData(CGDataProviderRef dataProvider, NSString *password)
{
	CGPDFDocumentRef thePDFDocRef = NULL; // CGPDFDocument

	if (dataProvider != NULL) // Check for non-NULL CGDataProviderRef
	{
		thePDFDocRef = CGPDFDocumentCreateWithProvider(dataProvider);

		if (thePDFDocRef != NULL) // Check for non-NULL CGPDFDocumentRef
		{
			if (CGPDFDocumentIsEncrypted(thePDFDocRef) == TRUE) // Encrypted
			{
				// Try a blank password first, per Apple's Quartz PDF example

				if (CGPDFDocumentUnlockWithPassword(thePDFDocRef, "") == FALSE)
				{
					// Nope, now let's try the provided password to unlock the PDF

					if ((password != nil) && (password.length > 0)) // Not blank?
					{
						char text[128]; // char array buffer for the string conversion

						[password getCString:text maxLength:126 encoding:NSUTF8StringEncoding];

						if (CGPDFDocumentUnlockWithPassword(thePDFDocRef, text) == FALSE) // Log failure
						{
							#ifdef DEBUG
								NSLog(@"CGPDFDocumentCreateUsingData: Unable to unlock data with '%@'", password);
							#endif
						}
					}
				}

				if (CGPDFDocumentIsUnlocked(thePDFDocRef) == FALSE) // Cleanup unlock failure
				{
					CGPDFDocumentRelease(thePDFDocRef), thePDFDocRef = NULL;
				}
			}
		}
	}
	else // Log an error diagnostic
	{
		#ifdef DEBUG
			NSLog(@"CGPDFDocumentCreateUsingData: theURL == NULL");
		#endif
	}

	return thePDFDocRef;
}

//
//	BOOL CGPDFDocumentUrlNeedsPassword(CFURLRef, NSString *) function
//

BOOL CGPDFDocumentUrlNeedsPassword(CFURLRef theURL, NSString *password)
{
	BOOL needPassword = NO; // Default flag

	if (theURL != NULL) // Check for non-NULL CFURLRef
	{
		CGPDFDocumentRef thePDFDocRef = CGPDFDocumentCreateWithURL(theURL);

		if (thePDFDocRef != NULL) // Check for non-NULL CGPDFDocumentRef
		{
			if (CGPDFDocumentIsEncrypted(thePDFDocRef) == TRUE) // Encrypted
			{
				// Try a blank password first, per Apple's Quartz PDF example

				if (CGPDFDocumentUnlockWithPassword(thePDFDocRef, "") == FALSE)
				{
					// Nope, now let's try the provided password to unlock the PDF

					if ((password != nil) && (password.length > 0)) // Not blank?
					{
						char text[128]; // char array buffer for the string conversion

						[password getCString:text maxLength:126 encoding:NSUTF8StringEncoding];

						if (CGPDFDocumentUnlockWithPassword(thePDFDocRef, text) == FALSE)
						{
							needPassword = YES;
						}
					}
					else
					{
						needPassword = YES;
					}
				}
			}

			CGPDFDocumentRelease(thePDFDocRef); // Cleanup CGPDFDocumentRef
		}
	}
	else // Log an error diagnostic
	{
		#ifdef DEBUG
			NSLog(@"CGPDFDocumentUrlNeedsPassword: theURL == NULL");
		#endif
	}

	return needPassword;
}

//
//	BOOL CGPDFDocumentUrlNeedsPassword(CGDataProviderRef, NSString *) function
//

BOOL CGPDFDocumentDataNeedsPassword(CGDataProviderRef dataProvider, NSString *password)
{
	BOOL needPassword = NO; // Default flag

	if (dataProvider != NULL) // Check for non-NULL CGDataProviderRef
	{
		CGPDFDocumentRef thePDFDocRef = CGPDFDocumentCreateWithProvider(dataProvider);

		if (thePDFDocRef != NULL) // Check for non-NULL CGPDFDocumentRef
		{
			if (CGPDFDocumentIsEncrypted(thePDFDocRef) == TRUE) // Encrypted
			{
				// Try a blank password first, per Apple's Quartz PDF example

				if (CGPDFDocumentUnlockWithPassword(thePDFDocRef, "") == FALSE)
				{
					// Nope, now let's try the provided password to unlock the PDF

					if ((password != nil) && (password.length > 0)) // Not blank?
					{
						char text[128]; // char array buffer for the string conversion

						[password getCString:text maxLength:126 encoding:NSUTF8StringEncoding];

						if (CGPDFDocumentUnlockWithPassword(thePDFDocRef, text) == FALSE)
						{
							needPassword = YES;
						}
					}
					else
					{
						needPassword = YES;
					}
				}
			}

			CGPDFDocumentRelease(thePDFDocRef); // Cleanup CGPDFDocumentRef
		}
	}
	else // Log an error diagnostic
	{
		#ifdef DEBUG
			NSLog(@"CGPDFDocumentUrlNeedsPassword: theURL == NULL");
		#endif
	}

	return needPassword;
}

// EOF
