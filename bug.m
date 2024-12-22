In Objective-C, a common yet subtle issue arises when dealing with memory management and object lifecycles, especially within blocks or asynchronous operations.  Consider this scenario: 

```objectivec
@property (nonatomic, strong) MyObject *myObject;

- (void)someMethod {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ 
        MyObject *localObject = [[MyObject alloc] init];
        [weakSelf setMyObject:localObject]; // Potential issue here
    });
}
```

The `__weak` keyword is crucial to prevent retain cycles. However, if `self` is deallocated before the block executes, `weakSelf` will become nil.  Attempting to access and set `myObject` on a nil `weakSelf` will cause a crash. This is particularly sneaky because the crash isn't directly in the code setting `myObject`, but rather due to the timing of deallocation.