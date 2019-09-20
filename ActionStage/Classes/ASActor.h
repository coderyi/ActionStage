//
//  ASActor.h
//  ActionStage
//
//  Created by coderyi on 2019/9/16.
//

#import <Foundation/Foundation.h>
#import "ASHandle.h"

@interface ASActor : NSObject

+ (void)registerActorClass:(Class)requestBuilderClass;

// 根据genericPath获取Actor
+ (ASActor *)requestBuilderForGenericPath:(NSString *)genericPath path:(NSString *)path;

+ (NSString *)genericPath;

@property (nonatomic, strong) NSString *path;

@property (nonatomic, strong) NSString *requestQueueName;
@property (nonatomic, strong) NSDictionary *storedOptions;

@property (nonatomic) NSTimeInterval cancelTimeout;
@property (nonatomic) bool cancelled;

- (id)initWithPath:(NSString *)path;
- (void)prepare:(NSDictionary *)options; // actor准备执行
- (void)execute:(NSDictionary *)options; // actor执行方法
- (void)cancel;

- (void)watcherJoined:(ASHandle *)watcherHandle options:(NSDictionary *)options waitingInActorQueue:(bool)waitingInActorQueue; // actor正在执行时，再次加入调用的方法

@end

