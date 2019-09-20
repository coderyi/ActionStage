//
//  ASTestView.h
//  ActionStage_Example
//
//  Created by coderyi on 2019/9/18.
//  Copyright © 2019 coderyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASHandle.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASTestView : UIView
@property (nonatomic, strong) ASHandle *actionHandle;
- (void)testViewClick;
@end

NS_ASSUME_NONNULL_END
