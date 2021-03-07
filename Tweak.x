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

%group closeInAppSafariViewGroup
%hook SFBarRegistration
-(void)_itemReceivedTap:(UIBarButtonItem *)arg1 {
  %orig;
  UIBarButtonItem *openInSafariItem = [self valueForKey:@"_openInSafariItem"];
  if(arg1 == openInSafariItem){
    [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"CloseInAppSafariViewController" object:nil];
  }
}
%end

%hook SFSafariViewController
-(id)initWithURL:(NSURL *)arg1 configuration:(id)arg2 {
  [[NSDistributedNotificationCenter defaultCenter] addObserver:self selector:@selector(YLKDissmissViewController) name:@"CloseInAppSafariViewController" object:nil];
  return %orig;
}
%new
-(void)YLKDissmissViewController {
  [self dismissViewControllerAnimated:NO completion:nil];
}
%end
%end

%group automaticallyOpenSafariGroup
%hook SFSafariViewController
-(id)initWithURL:(NSURL *)arg1 configuration:(id)arg2{
  [[UIApplication sharedApplication] openURL:arg1 options:@{} completionHandler:nil];
  return %orig;
}

-(void)viewWillAppear:(BOOL)arg1 {
  %orig;
  [self dismissViewControllerAnimated:NO completion:nil];
}
%end
%end

static void loadPrefs(){
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/User/Library/Preferences/com.galacticdev.yulkariprefs.plist"];
		openOption = [[prefs objectForKey:@"openOption"] intValue];
}


%ctor {
  loadPrefs();
  if (openOption == 0){
    %init(closeInAppSafariViewGroup);
  }
  else {
    %init(automaticallyOpenSafariGroup);
  }
}
