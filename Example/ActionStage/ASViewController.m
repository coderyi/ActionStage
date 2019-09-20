//
//  ASViewController.m
//  ActionStage
//
//  Created by coderyi on 09/16/2019.
//  Copyright (c) 2019 coderyi. All rights reserved.
//

#import "ASViewController.h"
#import "ActionStage.h"
#import "ASTestView.h"

@interface ASViewController ()<ASWatcher>

@property (nonatomic, strong) ASHandle *actionHandle;

@end

@implementation ASViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _actionHandle = [[ASHandle alloc] initWithDelegate:self releaseOnMainThread:true];
    
    [ActionStageInstance() requestActor:@"/as/test/(1)" options:[[NSDictionary alloc] initWithObjectsAndKeys:@"helloWorld", @"testKey", nil] watcher:self];

    [ActionStageInstance() requestActor:@"/as/file/(1)" options:[[NSDictionary alloc] initWithObjectsAndKeys:@"http://www.helloWorld.com", @"url", nil] watcher:self];

    [ActionStageInstance() requestActor:@"/as/service/auth/sendCode" options:[[NSDictionary alloc] initWithObjectsAndKeys:@"123", @"phoneNumber", nil] watcher:self];

    
    [ActionStageInstance() watchForPaths:@[
                                           @"/as/unreadMessageCount",
                                           ] watcher:self];
    [ActionStageInstance() dispatchResource:@"/as/unreadMessageCount" resource:[[NSNumber alloc] initWithInt:2]];

    ASTestView *testView = [[ASTestView alloc] init];
    testView.actionHandle = _actionHandle;
    [self.view addSubview:testView];
    [testView testViewClick];

}

- (void)actorMessageReceived:(NSString *)path messageType:(NSString *)messageType message:(id)message
{
    if ([messageType isEqualToString:@"requestResults"])
    {
        NSLog(@"actorMessageReceived %@", message);
    }
}

- (void)actorReportedProgress:(NSString *)path progress:(float)progress
{
    NSLog(@"actorReportedProgress %@ %@", path, @(progress));
}

- (void)actorCompleted:(int)resultCode path:(NSString *)path result:(id)result
{
    NSLog(@"requestActor completed %@",path);
}

- (void)actionStageResourceDispatched:(NSString *)path resource:(id)resource arguments:(id)arguments;
{
    NSLog(@"ResourceDispatch %@ %@", path, resource);
}

- (void)actionStageActionRequested:(NSString *)action options:(NSDictionary *)options
{
    NSLog(@"actionStageActionRequested %@ %@", action, options);
}

@end
