#include <dlfcn.h>

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
