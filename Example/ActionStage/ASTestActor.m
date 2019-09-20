//
//  ASTestActor.m
//  ActionStage_Example
//
//  Created by coderyi on 2019/9/17.
//  Copyright © 2019 coderyi. All rights reserved.
//

#import "ASTestActor.h"
#import "ActionStage.h"

@implementation ASTestActor

+ (NSString *)genericPath
{
    return @"/as/test/@";
}

- (void)execute:(NSDictionary *)options
{
    NSString *testKey = [options objectForKey:@"testKey"];
    NSLog(@"ASTestActor %@",testKey);
    [self testRequest];
}

- (void)testRequest
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [ActionStageInstance() dispatchMessageToWatchers:self.path messageType:@"requestResults" message:@[@"test1", @"test2"]];
        [self testCompleted];
    });
}

- (void)testCompleted
{
    [ActionStageInstance() actionCompleted:self.path result:nil];
}
@en
d
