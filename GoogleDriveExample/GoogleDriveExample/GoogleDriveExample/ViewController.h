#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

#import "GTMOAuth2ViewControllerTouch.h"
#import "GTLDrive.h"

@interface ViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, retain) GTLServiceDrive *driveService;

@end