#import <UIKit/UIKit.h>
#include <dlfcn.h>

%hook UIResponder

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        // [[NSNotificationCenter defaultCenter] postNotificationName:@"Lookin_3D" object:nil];
    	UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.delegate = self;
        alertView.tag = 0;
        alertView.title = @"Lookin UIDebug菜单";
        [alertView addButtonWithTitle:@"审查元素2D"];
        [alertView addButtonWithTitle:@"3D视图"];
        [alertView addButtonWithTitle:@"取消"];
        [alertView show];
    }
}

%new
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 0) {
        
        if (buttonIndex == 0) {//审查元素2D
			[[NSNotificationCenter defaultCenter] postNotificationName:@"Lookin_2D" object:nil];
        } else if (buttonIndex == 1) {//3D视图
			[[NSNotificationCenter defaultCenter] postNotificationName:@"Lookin_3D" object:nil];
        }
    }
}


%end


%ctor{

	@autoreleasepool {

    	NSDictionary* lookinSettings = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.chinapyg.lookin.plist"];
		NSString* bundleID = [[NSBundle mainBundle] bundleIdentifier];
		BOOL appEnabled = [[lookinSettings objectForKey:[NSString stringWithFormat:@"LookinEnabled-%@",bundleID]] boolValue];
		if (appEnabled) {
			NSFileManager* fileManager = [NSFileManager defaultManager];

			NSString* libPath = @"/usr/lib/LookinServer.framework/LookinServer";

			if([fileManager fileExistsAtPath:libPath]) {
				dlopen([libPath UTF8String], RTLD_NOW);
				NSLog(@"[+] LookinLoader loaded!");
			}
		}

	}

}
