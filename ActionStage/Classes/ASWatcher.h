//
//  ASWatcher.h
//  ActionStage
//
//  Created by coderyi on 2019/9/16.
//

#import <Foundation/Foundation.h>
#import "ASHandle.h"

NS_ASSUME_NONNULL_BEGIN


@protocol ASWatcher <NSObject>

@required

@property (nonatomic, strong, readonly) ASHandle *actionHandle;

@optional

// actor执行完成
- (void)actorCompleted:(int)status path:(NSString *)path result:(id)result;
// 用于通知进度，来自ActionStage的nodeRetrieveProgress的回调
- (void)actorReportedProgress:(NSString *)path progress:(float)progress;
// 接收dispatchResource消息
- (void)actionStageResourceDispatched:(NSString *)path resource:(id)resource arguments:(id)arguments;
// 接收ASHandle调用requestAction的回调
- (void)actionStageActionRequested:(NSString *)action options:(id)options;
// 接收ActionStage的dispatchMessageToWatchers的消息
- (void)actorMessageReceived:(NSString *)path messageType:(NSString *)messageType message:(id)message;

@end
NS_ASSUME_NONNULL_END
