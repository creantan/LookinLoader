#import <UIKit/UIKit.h>
#include <dlfcn.h>

%group UIDebug

%hook UIResponder

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        UIAlertView *alertView = [[UIAlertView alloc] init];
        alertView.delegate = self;
        alertView.tag = 0;
        alertView.title = @"Lookin UIDebug";
        [alertView addButtonWithTitle:@"2D Inspection"];
        [alertView addButtonWithTitle:@"3D Inspection"];
        [alertView addButtonWithTitle:@"Export"];
        [alertView addButtonWithTitle:@"Cancel"];
        [alertView show];
    }
}

%new
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 0) {
        
        if (buttonIndex == 0) {//审查元素2D
			[[NSNotificationCenter defaultCenter] postNotificationName:@"Lookin_2D" object:nil];
        } else if (buttonIndex == 1) {//3D视图
			[[NSNotificationCenter defaultCenter] postNotificationName:@"Lookin_3D" object:nil];
        }else if (buttonIndex == 2) {//导出当前UI结构
        	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
				/*
					修复弹出UIDebug菜单导致QQ无法正确弹出UIDocumentInteractionController问题，延后1秒等UIDebug菜单消失
				*/
				[[NSNotificationCenter defaultCenter] postNotificationName:@"Lookin_Export" object:nil];
			});
        }
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
