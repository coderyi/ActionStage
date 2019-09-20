//
//  ASHandle.m
//  ActionStage
//
//  Created by coderyi on 2019/9/16.
//

#import "ASHandle.h"
#import "ASWatcher.h"
#import <pthread.h>

#define AS_SYNCHRONIZED_DEFINE(lock) pthread_mutex_t _AS_SYNCHRONIZED_##lock
#define AS_SYNCHRONIZED_INIT(lock) pthread_mutex_init(&_AS_SYNCHRONIZED_##lock, NULL)
#define AS_SYNCHRONIZED_BEGIN(lock) pthread_mutex_lock(&_AS_SYNCHRONIZED_##lock);
#define AS_SYNCHRONIZED_END(lock) pthread_mutex_unlock(&_AS_SYNCHRONIZED_##lock);

@interface ASHandle ()
{
    AS_SYNCHRONIZED_DEFINE(_delegate);
}

@end

@implementation ASHandle

@synthesize delegate = _delegate;
@synthesize releaseOnMainThread = _releaseOnMainThread;

- (id)initWithDelegate:(id<ASWatcher>)delegate
{
    self = [super init];
    if (self != nil)
    {
        AS_SYNCHRONIZED_INIT(_delegate);
        
        _delegate = delegate;
    }
    return self;
}

- (id)initWithDelegate:(id<ASWatcher>)delegate releaseOnMainThread:(bool)releaseOnMainThread
{
    self = [super init];
    if (self != nil)
    {
        AS_SYNCHRONIZED_INIT(_delegate);
        
        _delegate = delegate;
        _releaseOnMainThread = releaseOnMainThread;
    }
    return self;
}

- (void)reset
{
    AS_SYNCHRONIZED_BEGIN(_delegate);
    _delegate = nil;
    AS_SYNCHRONIZED_END(_delegate);
}

- (bool)hasDelegate
{
    bool result = false;
    
    AS_SYNCHRONIZED_BEGIN(_delegate);
    result = _delegate != nil;
    AS_SYNCHRONIZED_END(_delegate);
    
    return result;
}

- (id<ASWatcher>)delegate
{
    id<ASWatcher> result = nil;
    
    AS_SYNCHRONIZED_BEGIN(_delegate);
    result = _delegate;
    AS_SYNCHRONIZED_END(_delegate);
    
    return result;
}

- (void)setDelegate:(id<ASWatcher>)delegate
{
    AS_SYNCHRONIZED_BEGIN(_delegate);
    _delegate = delegate;
    AS_SYNCHRONIZED_END(_delegate);
}

- (void)requestAction:(NSString *)action options:(id)options
{
    __strong id<ASWatcher> delegate = self.delegate;
    if (delegate != nil && [delegate respondsToSelector:@selector(actionStageActionRequested:options:)])
        [delegate actionStageActionRequested:action options:options];
    
    if (_releaseOnMainThread && ![NSThread isMainThread])
    {
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           [delegate class];
                       });
    }
}

- (void)receiveActorMessage:(NSString *)path messageType:(NSString *)messageType message:(id)message
{
    __strong id<ASWatcher> delegate = self.delegate;
    if (delegate != nil && [delegate respondsToSelector:@selector(actorMessageReceived:messageType:message:)])
        [delegate actorMessageReceived:path messageType:messageType message:message];
    
    if (_releaseOnMainThread && ![NSThread isMainThread])
    {
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           [delegate class];
                       });
    }
}

- (void)notifyResourceDispatched:(NSString *)path resource:(id)resource
{
    [self notifyResourceDispatched:path resource:resource arguments:nil];
}

- (void)notifyResourceDispatched:(NSString *)path resource:(id)resource arguments:(id)arguments
{
    __strong id<ASWatcher> delegate = self.delegate;
    if (delegate != nil && [delegate respondsToSelector:@selector(actionStageResourceDispatched:resource:arguments:)])
        [delegate actionStageResourceDispatched:path resource:resource arguments:arguments];
    
    if (_releaseOnMainThread && ![NSThread isMainThread])
    {
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           [delegate class];
                       });
    }
}


@end
