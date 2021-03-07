#line 1 "Tweak.x"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSDistributedNotificationCenter : NSNotificationCenter
@end

@interface SFSafariViewController : UIViewController
@end

@interface SFBarRegistration : NSObject
-(void)_itemReceivedTap:(UIBarButtonItem *)arg1;
@end

int openOption;


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class SFSafariViewController; @class SFBarRegistration; 


#line 16 "Tweak.x"
static void (*_logos_orig$closeInAppSafariViewGroup$SFBarRegistration$_itemReceivedTap$)(_LOGOS_SELF_TYPE_NORMAL SFBarRegistration* _LOGOS_SELF_CONST, SEL, UIBarButtonItem *); static void _logos_method$closeInAppSafariViewGroup$SFBarRegistration$_itemReceivedTap$(_LOGOS_SELF_TYPE_NORMAL SFBarRegistration* _LOGOS_SELF_CONST, SEL, UIBarButtonItem *); static SFSafariViewController* (*_logos_orig$closeInAppSafariViewGroup$SFSafariViewController$initWithURL$configuration$)(_LOGOS_SELF_TYPE_INIT SFSafariViewController*, SEL, NSURL *, id) _LOGOS_RETURN_RETAINED; static SFSafariViewController* _logos_method$closeInAppSafariViewGroup$SFSafariViewController$initWithURL$configuration$(_LOGOS_SELF_TYPE_INIT SFSafariViewController*, SEL, NSURL *, id) _LOGOS_RETURN_RETAINED; static void _logos_method$closeInAppSafariViewGroup$SFSafariViewController$YLKDissmissViewController(_LOGOS_SELF_TYPE_NORMAL SFSafariViewController* _LOGOS_SELF_CONST, SEL); 

static void _logos_method$closeInAppSafariViewGroup$SFBarRegistration$_itemReceivedTap$(_LOGOS_SELF_TYPE_NORMAL SFBarRegistration* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIBarButtonItem * arg1) {
    _logos_orig$closeInAppSafariViewGroup$SFBarRegistration$_itemReceivedTap$(self, _cmd, arg1);
    UIBarButtonItem *openInSafariItem = [self valueForKey:@"_openInSafariItem"];
    if(arg1 == openInSafariItem){
        [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"YLKCloseInAppSafariViewController" object:nil];
    }
}



static SFSafariViewController* _logos_method$closeInAppSafariViewGroup$SFSafariViewController$initWithURL$configuration$(_LOGOS_SELF_TYPE_INIT SFSafariViewController* __unused self, SEL __unused _cmd, NSURL * arg1, id arg2) _LOGOS_RETURN_RETAINED {
    [[NSDistributedNotificationCenter defaultCenter] addObserver:self selector:@selector(YLKDissmissViewController) name:@"YLKCloseInAppSafariViewController" object:nil];
    return _logos_orig$closeInAppSafariViewGroup$SFSafariViewController$initWithURL$configuration$(self, _cmd, arg1, arg2);
}

static void _logos_method$closeInAppSafariViewGroup$SFSafariViewController$YLKDissmissViewController(_LOGOS_SELF_TYPE_NORMAL SFSafariViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    [self dismissViewControllerAnimated:NO completion:nil];
}



static SFSafariViewController* (*_logos_orig$automaticallyOpenSafariGroup$SFSafariViewController$initWithURL$configuration$)(_LOGOS_SELF_TYPE_INIT SFSafariViewController*, SEL, NSURL *, id) _LOGOS_RETURN_RETAINED; static SFSafariViewController* _logos_method$automaticallyOpenSafariGroup$SFSafariViewController$initWithURL$configuration$(_LOGOS_SELF_TYPE_INIT SFSafariViewController*, SEL, NSURL *, id) _LOGOS_RETURN_RETAINED; static void (*_logos_orig$automaticallyOpenSafariGroup$SFSafariViewController$viewWillAppear$)(_LOGOS_SELF_TYPE_NORMAL SFSafariViewController* _LOGOS_SELF_CONST, SEL, BOOL); static void _logos_method$automaticallyOpenSafariGroup$SFSafariViewController$viewWillAppear$(_LOGOS_SELF_TYPE_NORMAL SFSafariViewController* _LOGOS_SELF_CONST, SEL, BOOL); 

static SFSafariViewController* _logos_method$automaticallyOpenSafariGroup$SFSafariViewController$initWithURL$configuration$(_LOGOS_SELF_TYPE_INIT SFSafariViewController* __unused self, SEL __unused _cmd, NSURL * arg1, id arg2) _LOGOS_RETURN_RETAINED{
    [[UIApplication sharedApplication] openURL:arg1 options:@{} completionHandler:nil];
    return _logos_orig$automaticallyOpenSafariGroup$SFSafariViewController$initWithURL$configuration$(self, _cmd, arg1, arg2);
}

static void _logos_method$automaticallyOpenSafariGroup$SFSafariViewController$viewWillAppear$(_LOGOS_SELF_TYPE_NORMAL SFSafariViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, BOOL arg1) {
    _logos_orig$automaticallyOpenSafariGroup$SFSafariViewController$viewWillAppear$(self, _cmd, arg1);
    [self dismissViewControllerAnimated:NO completion:nil];
}



static void loadPrefs(){
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/User/Library/Preferences/com.galacticdev.yulkariprefs.plist"];
    openOption = [[prefs objectForKey:@"openOption"] intValue];
}


static __attribute__((constructor)) void _logosLocalCtor_f1ee81aa(int __unused argc, char __unused **argv, char __unused **envp) {
    loadPrefs();
    NSArray *args = [[NSClassFromString(@"NSProcessInfo") processInfo] arguments];
    if(args.count != 0) {
        NSString *executablePath = args[0];
    
        
        if(executablePath) {      
            
            BOOL isApplication = [executablePath rangeOfString:@"/Application"].location != NSNotFound;
            if(isApplication) {
                if (openOption == 0){
                    {Class _logos_class$closeInAppSafariViewGroup$SFBarRegistration = objc_getClass("SFBarRegistration"); { MSHookMessageEx(_logos_class$closeInAppSafariViewGroup$SFBarRegistration, @selector(_itemReceivedTap:), (IMP)&_logos_method$closeInAppSafariViewGroup$SFBarRegistration$_itemReceivedTap$, (IMP*)&_logos_orig$closeInAppSafariViewGroup$SFBarRegistration$_itemReceivedTap$);}Class _logos_class$closeInAppSafariViewGroup$SFSafariViewController = objc_getClass("SFSafariViewController"); { MSHookMessageEx(_logos_class$closeInAppSafariViewGroup$SFSafariViewController, @selector(initWithURL:configuration:), (IMP)&_logos_method$closeInAppSafariViewGroup$SFSafariViewController$initWithURL$configuration$, (IMP*)&_logos_orig$closeInAppSafariViewGroup$SFSafariViewController$initWithURL$configuration$);}{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$closeInAppSafariViewGroup$SFSafariViewController, @selector(YLKDissmissViewController), (IMP)&_logos_method$closeInAppSafariViewGroup$SFSafariViewController$YLKDissmissViewController, _typeEncoding); }}
                }
                else {
                    {Class _logos_class$automaticallyOpenSafariGroup$SFSafariViewController = objc_getClass("SFSafariViewController"); { MSHookMessageEx(_logos_class$automaticallyOpenSafariGroup$SFSafariViewController, @selector(initWithURL:configuration:), (IMP)&_logos_method$automaticallyOpenSafariGroup$SFSafariViewController$initWithURL$configuration$, (IMP*)&_logos_orig$automaticallyOpenSafariGroup$SFSafariViewController$initWithURL$configuration$);}{ MSHookMessageEx(_logos_class$automaticallyOpenSafariGroup$SFSafariViewController, @selector(viewWillAppear:), (IMP)&_logos_method$automaticallyOpenSafariGroup$SFSafariViewController$viewWillAppear$, (IMP*)&_logos_orig$automaticallyOpenSafariGroup$SFSafariViewController$viewWillAppear$);}}
                }
            }
        }
    }
}
