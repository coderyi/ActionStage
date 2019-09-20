//
//  ActionStage.h
//  ActionStage
//
//  Created by coderyi on 2019/9/16.
//

#import <Foundation/Foundation.h>
#import "ASWatcher.h"
#import "ASActor.h"

typedef enum {
    ASStatusSuccess = 0,
    ASStatusFailed = -1
} ASStatus;

#ifdef DEBUG
#define dispatchOnStageQueue dispatchOnStageQueueDebug:__FILE__ line:__LINE__ block
#endif

@class ActionStage;

#ifdef __cplusplus
extern "C" {
#endif
    
    ActionStage *ActionStageInstance();
    
#ifdef __cplusplus
}
#endif

typedef enum {
    ASActorRequestChangePriority = 1
} ASActorRequestFlags;



@interface ActionStage : NSObject

- (dispatch_queue_t)globalStageDispatchQueue;
#ifdef DEBUG
- (void)dispatchOnStageQueueDebug:(const char *)function line:(int)line block:(dispatch_block_t)block;
#else
- (void)dispatchOnStageQueue:(dispatch_block_t)block;
#endif

- (bool)isCurrentQueueStageQueue;

- (void)cancelActorTimeout:(NSString *)path;

// 根据path获取genericPath
- (NSString *)genericStringForParametrizedPath:(NSString *)path;

// 执行Actor，触发Actor的execute方法
- (void)requestActor:(NSString *)path options:(NSDictionary *)options flags:(int)flags watcher:(id<ASWatcher>)watcher;
- (void)requestActor:(NSString *)path options:(NSDictionary *)options watcher:(id<ASWatcher>)watcher;
- (void)changeActorPriority:(NSString *)path; // 改变Actor执行优先级

- (NSArray *)rejoinActionsWithGenericPathNow:(NSString *)genericPath prefix:(NSString *)prefix watcher:(id<ASWatcher>)watcher; // 再次加入actor，如果actor正在执行则会出发Actor相应方法，如果actor没在执行，则不做响应
// Actor是否正在执行
- (bool)isExecutingActorsWithGenericPath:(NSString *)genericPath;
- (bool)isExecutingActorsWithPathPrefix:(NSString *)pathPrefix;
- (NSArray *)executingActorsWithPathPrefix:(NSString *)pathPrefix;
// 获取执行中的Actor
- (ASActor *)executingActorWithPath:(NSString *)path;

// 增加Watcher
- (void)watchForPath:(NSString *)path watcher:(id<ASWatcher>)watcher;
- (void)watchForPaths:(NSArray *)paths watcher:(id<ASWatcher>)watcher;
- (void)watchForGenericPath:(NSString *)path watcher:(id<ASWatcher>)watcher;
- (void)watchForMessagesToWatchersAtGenericPath:(NSString *)genericPath watcher:(id<ASWatcher>)watcher;
- (void)removeWatcherByHandle:(ASHandle *)actionHandle;
- (void)removeWatcher:(id<ASWatcher>)watcher;
- (void)removeWatcherByHandle:(ASHandle *)actionHandle fromPath:(NSString *)path;
- (void)removeWatcher:(id<ASWatcher>)watcher fromPath:(NSString *)path;
- (void)removeAllWatchersFromPath:(NSString *)path;

// 获取Actor是否正在执行
- (bool)requestActorStateNow:(NSString *)path;
// 触发Watcher的actionStageResourceDispatched
- (void)dispatchResource:(NSString *)path resource:(id)resource arguments:(id)arguments;
- (void)dispatchResource:(NSString *)path resource:(id)resource;
// 触发Watcher的actorCompleted:path:result:
- (void)actionCompleted:(NSString *)action result:(id)result;
// 用于发送消息给Watcher，ASWatcher会收到actorMessageReceived的回调
- (void)dispatchMessageToWatchers:(NSString *)path messageType:(NSString *)messageType message:(id)message;
// action失败方法，触发Watcher的actorCompleted:path:result:
- (void)actionFailed:(NSString *)action reason:(int)reason; 
- (void)nodeRetrieveProgress:(NSString *)path progress:(float)progress; // 通知进度的消息
- (void)nodeRetrieveFailed:(NSString *)path; // 调用actionFailed


@end


