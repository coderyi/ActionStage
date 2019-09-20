//
//  ASTimer.h
//  ActionStage
//
//  Created by coderyi on 2019/9/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASTimer : NSObject
- (id)initWithTimeout:(NSTimeInterval)timeout repeat:(bool)repeat completion:(dispatch_block_t)completion nativeQueue:(dispatch_queue_t)nativeQueue;

- (void)start;
- (void)invalidate;
- (void)fireAndInvalidate;

@end

NS_ASSUME_NONNULL_END
