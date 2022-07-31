# RatulBook-master
Bangla Ebook App

The code is universal and does not require any XIBs, All UI elements are code generated. Compatible with all iOS version.

![left1](https://user-images.githubusercontent.com/22914512/182013762-2797bbac-bcfb-4495-95f2-9da574d0cd21.jpg)


There's a lot that goes into each app development. At StarHOST, true to the spirit of a full service mobile aplication development firm we just don't code your app but we actively work with you to create solutions for your business. 

Currently StarHOST is the only Localized mobile application provider in Bangladesh. 

For more information about our products and services visit:
http://starhostbd.com/

For any question(s)/comment(s) please email us at:
info@starhostbd.com

Development credits:
iOS XCode Engineering and UI design:
I.M. Tanjin Ahsan


Below are the configurable parameters I have kept: 

ReaderConstants.h the following #define options are available:

READER_FLAT_UI - If TRUE, follows the Fuglyosity of Flat Fad
(flattens the UI).

READER_SHOW_SHADOWS - If TRUE, a shadow is shown around each page
and page thumbnail.

READER_ENABLE_THUMBS - If TRUE, a thumbs button is added to the main
toolbar enabling page thumbnail document navigation.

READER_DISABLE_RETINA - If TRUE, sets the CATiledLayer contentScale
to 1.0f. This effectively disables retina support and results in
non-retina device rendering speeds on retina display devices at
the loss of retina display quality.

READER_ENABLE_PREVIEW - If TRUE, a medium resolution page thumbnail
is displayed before the CATiledLayer starts to render the PDF page.

READER_DISABLE_IDLE - If TRUE, the iOS idle timer is disabled while
viewing a document (beware of battery drain).

READER_STANDALONE - If FALSE, a "Done" button is added to the toolbar
and the -dismissReaderViewController: delegate method is messaged when
it is tapped.

READER_BOOKMARKS - If TRUE, enables page bookmark support.
