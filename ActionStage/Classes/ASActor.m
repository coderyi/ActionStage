//
//  ASActor.m
//  ActionStage
//
//  Created by coderyi on 2019/9/16.
//

#import "ASActor.h"

static NSMutableDictionary *registeredRequestBuilders()
{
    static NSMutableDictionary *dict = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      dict = [[NSMutableDictionary alloc] init];
                  });
    return dict;
}


@implementation ASActor

+ (void)registerActorClass:(Class)requestBuilderClass
{
    NSString *genericPath = [requestBuilderClass genericPath];
    if (genericPath == nil || genericPath.length == 0)
    {
#ifdef DEBUG
        NSLog(@"Error: ASActor::registerActorClass: genericPath is nil");
#endif
        return;
    }
    
    [registeredRequestBuilders() setObject:requestBuilderClass forKey:genericPath];
}

+ (ASActor *)requestBuilderForGenericPath:(NSString *)genericPath path:(NSString *)path
{
    Class builderClass = [registeredRequestBuilders() objectForKey:genericPath];
    if (builderClass != nil)
    {
        ASActor *builderInstance = [[builderClass alloc] initWithPath:path];
        return builderInstance;
    }
    return nil;
}

+ (NSString *)genericPath
{
#ifdef DEBUG
    NSLog(@"Error: ASActor::genericPath: no default implementation provided");
#endif
    return nil;
}

@synthesize path = _path;

@synthesize requestQueueName = _requestQueueName;
@synthesize storedOptions = _storedOptions;

@synthesize cancelTimeout = _cancelTimeout;
@synthesize cancelled = _cancelled;

- (id)initWithPath:(NSString *)path
{
    self = [super init];
    if (self != nil)
    {
        _cancelTimeout = 0;
        _path = path;
        
    }
    return self;
}

- (void)dealloc
{
}

- (void)prepare:(NSDictionary *)__unused options
{
}

- (void)execute:(NSDictionary *)__unused options
{
#ifdef DEBUG
    NSLog(@"Error: ASActor::execute: no default implementation provided");
#endif
}

- (void)cancel
{
    self.cancelled = true;
}

- (void)watcherJoined:(ASHandle *)__unused watcherHandle options:(NSDictionary *)__unused options waitingInActorQueue:(bool)__unused waitingInActorQueue
{
}
@end
