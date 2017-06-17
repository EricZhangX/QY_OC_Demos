//
//  AppDelegate.m
//  LogDemo
//
//  Created by 张庆玉 on 02/06/2017.
//  Copyright © 2017 Qingyu. All rights reserved.
//

#import "AppDelegate.h"
#import "CocoaLumberjack.h"
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [DDLog addLogger:[DDTTYLogger sharedInstance]]; // TTY = Xcode console
    [DDLog addLogger:[DDASLLogger sharedInstance]]; // ASL = Apple System Logs
    
    setenv("XcodeColors", "YES", 0);
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // File Logger
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 2;
    [DDLog addLogger:fileLogger];
    
    NSString *path = [fileLogger.logFileManager logsDirectory];
    NSString *logName = fileLogger.currentLogFileInfo.fileName;
    NSString *logPath = [NSString stringWithFormat:@"%@/%@",path,logName];

    DDLogInfo(@"path - %@",logPath);
    
    NSData *data = [NSData dataWithContentsOfFile:logPath];
    NSString *logs = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"--%@",logs);
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
