# ActionStage






ActionStage来自于Telegram官方开源的iOS客户端。

ActionStage是一个消息通信、模块解耦的框架。

ActionStage，消息的中枢派发模块

Handle，定义为管理Watcher，给Watcher发消息的模块

Actor，处理requestActor的模块

Watcher，观察协议，定义为接收ActionStage的消息

设计图如下

![](https://github.com/coderyi/ActionStage/blob/master/ActionStage.jpg)

## Installation

```ruby
pod 'ActionStage'
```

## Example

在 Example 文件夹下运行`pod install` 

## Usage


### dispatchResource

dispatchResource类似于通知，

发送消息

```
[ActionStageInstance() dispatchResource:@"/as/unreadMessageCount" resource:[[NSNumber alloc] initWithInt:2]];
```

监听对应path，在回调可以接收消息

```
_actionHandle = [[ASHandle alloc] initWithDelegate:self releaseOnMainThread:true];

[ActionStageInstance() watchForPaths:@[
                                       @"/as/unreadMessageCount",
                                       ] watcher:self];

- (void)actionStageResourceDispatched:(NSString *)path resource:(id)resource arguments:(id)arguments;
{
    NSLog(@"ResourceDispatch %@ %@", path, resource);
}
```

### requestActor

requestActor

```
[ActionStageInstance() requestActor:@"/as/service/auth/sendCode" options:[[NSDictionary alloc] initWithObjectsAndKeys:@"123", @"phoneNumber", nil] watcher:self];
```

这时可以定一个一个Actor处理sendCode的网络任务，如ASTestSendCodeRequestActor

```
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
```


### actionCompleted

当Actor执行完成后，可以发起actionCompleted

```
[ActionStageInstance() actionCompleted:self.path result:nil];
```

在Watcher可以接收到消息

```
- (void)actorCompleted:(int)resultCode path:(NSString *)path result:(id)result
{
    NSLog(@"requestActor completed %@",path);
}
```


## Author

coderyi, coderyi@foxmail.com

## License

ActionStage is available under the MIT license. See the LICENSE file for more info.
