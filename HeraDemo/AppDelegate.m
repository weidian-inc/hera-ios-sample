//
// Copyright (c) 2017, weidian.com
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// * Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation
// and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "RetrieveViewController.h"
#import "LinkViewController.h"
#import <Hera/WDHodoer.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	//注册自定义API 需立即返回结果类型
	[WHHybridExtension registerExtensionApi:@"openLink" handler:^id(id param) {
		LinkViewController *vc = [[LinkViewController alloc] init];
		vc.url = param[@"url"];
		UINavigationController *navi = (UINavigationController *)self.window.rootViewController;
		[navi pushViewController:vc animated:YES];

		// WDHExtensionKeyData 需要Dictionary类型
		return @{WDHExtensionKeyCode:@(WDHExtensionCodeSuccess), WDHExtensionKeyData: @{@"hello": @"iphoneX"}};
	}];

	//注册自定义API 需延迟返回结果类型
	[WHHybridExtension registerRetrieveApi:@"getResult" handler:^id(id param, WDHApiCompletion completion) {

		RetrieveViewController *vc = [[RetrieveViewController alloc] init];
		if([vc respondsToSelector:@selector(didReceiveApi:withParam:completion:)]){
			[vc didReceiveApi:@"getResult" withParam:param completion:completion];
		}
		UINavigationController *navi = (UINavigationController *)self.window.rootViewController;
		[navi pushViewController:vc animated:YES];

		return @{WDHExtensionKeyCode:@(WDHExtensionCodeSuccess)};
	}];
	
	return YES;
}

@end

