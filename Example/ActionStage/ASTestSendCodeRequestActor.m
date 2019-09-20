//
//  ASTestSendCodeRequestActor.m
//  ActionStage_Example
//
//  Created by coderyi on 2019/9/19.
//  Copyright © 2019 coderyi. All rights reserved.
//

#import "ASTestSendCodeRequestActor.h"

@implementation ASTestSendCodeRequestActor

+ (NSString *)genericPath
{
    return @"/as/service/auth/sendCode";
}

- (void)execute:(NSDictionary *)options
{
    NSString *phoneNumber = [options objectForKey:@"phoneNumber"];
    [self sendNetwork:phoneNumber];
}

- (void)sendNetwork:(NSString *)phoneNumber
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [ActionStageInstance() actionCompleted:self.path result:nil];
    });
}
@end
