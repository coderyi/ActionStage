//
//  ASHandle.h
//  ActionStage
//
//  Created by coderyi on 2019/9/16.
//

#import <Foundation/Foundation.h>

@protocol ASWatcher;

@interface ASHandle : NSObject

@property (nonatomic, weak) id<ASWatcher> delegate;
@property (nonatomic) bool releaseOnMainThread;

- (id)initWithDelegate:(id<ASWatcher>)delegate;
- (id)initWithDelegate:(id<ASWatcher>)delegate releaseOnMainThread:(bool)releaseOnMainThread;
- (void)reset;

- (bool)hasDelegate;

- (void)requestAction:(NSString *)action options:(id)options; // 出发Watcher的actionStageActionRequested
- (void)receiveActorMessage:(NSString *)path messageType:(NSString *)messageType message:(id)message; // 用于发送消息给Watcher，ASWatcher会收到actorMessageReceived的回调
- (void)notifyResourceDispatched:(NSString *)path resource:(id)resource; // Watcher的actionStageResourceDispatched会被调用
- (void)notifyResourceDispatched:(NSString *)path resource:(id)resource arguments:(id)arguments;

@end
