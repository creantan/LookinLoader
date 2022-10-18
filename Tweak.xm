#import <UIKit/UIKit.h>
#include <dlfcn.h>

%group UIDebug

%hook UIResponder

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {

		UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Lookin UIDebug" message:@"" preferredStyle:UIAlertControllerStyleAlert];

		[alertController addAction:[UIAlertAction actionWithTitle:@"3D Inspection" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		    [[NSNotificationCenter defaultCenter] postNotificationName:@"Lookin_3D" object:nil];
		}]];

		[alertController addAction:[UIAlertAction actionWithTitle:@"2D Inspection" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		    [[NSNotificationCenter defaultCenter] postNotificationName:@"Lookin_2D" object:nil];
		}]];

		[alertController addAction:[UIAlertAction actionWithTitle:@"Export" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
				[[NSNotificationCenter defaultCenter] postNotificationName:@"Lookin_Export" object:nil];
			});
		}]];

		[alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

		}]];
		UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
	
		[vc presentViewController:alertController animated:YES completion:nil];
    }
}
%end
%end


%ctor{

	@autoreleasepool {

    	NSDictionary* lookinSettings = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.chinapyg.lookin.plist"];
		NSString* bundleID = [[NSBundle mainBundle] bundleIdentifier];
		BOOL appEnabled = [[lookinSettings objectForKey:[NSString stringWithFormat:@"LookinEnabled-%@",bundleID]] boolValue];
		if (appEnabled) {
			NSFileManager* fileManager = [NSFileManager defaultManager];

			NSString* libPath = @"/usr/lib/Lookin/LookinServer.framework/LookinServer";

			if([fileManager fileExistsAtPath:libPath]) {
				void *lib = dlopen([libPath UTF8String], RTLD_NOW);
				if (lib) {
					%init(UIDebug)
					NSLog(@"[+] LookinLoader loaded!");
				}else {
					char* err = dlerror();
					NSLog(@"[+] LookinLoader load failed:%s",err);
				}
			}
		}

	}

}
