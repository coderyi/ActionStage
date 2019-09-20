//
//  ASFileDownloadActor.m
//  ActionStage_Example
//
//  Created by coderyi on 2019/9/18.
//  Copyright © 2019 coderyi. All rights reserved.
//

#import "ASFileDownloadActor.h"
@interface ASFileDownloadActor()
@property (nonatomic, strong) NSTimer *testTimer;
@property (nonatomic, assign) NSInteger testCount;
@end

@implementation ASFileDownloadActor

+ (NSString *)genericPath
{
    return @"/as/file/@";
}

- (void)execute:(NSDictionary *)options
{
//    NSString *url = [options objectForKey:@"url"];
    [ActionStageInstance() nodeRetrieveProgress:self.path progress:0.001f];
    if (!_testTimer) {
        _testTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(testFileDownloadProgress) userInfo:nil repeats:YES];
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        [runloop addTimer:_testTimer forMode:NSDefaultRunLoopMode];
        [runloop run];
        
    }
    [_testTimer invalidate];
    [_testTimer fire];
}

- (void)testFileDownloadProgress
{
    _testCount++;
    [ActionStageInstance() nodeRetrieveProgress:self.path progress:0.1 * _testCount];
    if (_testCount >= 10) {
        [_testTimer invalidate];
        _testTimer = nil;
        [ActionStageInstance() actionCompleted:self.path result:nil];
//        [ActionStageInstance() actionFailed:self.path reason:-1];
    }

}

- (void)dealloc
{
    NSLog(@"dealloc");
}

@end
