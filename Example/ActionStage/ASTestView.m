//
//  ASTestView.m
//  ActionStage_Example
//
//  Created by coderyi on 2019/9/18.
//  Copyright © 2019 coderyi. All rights reserved.
//

#import "ASTestView.h"

@interface ASTestView ()

@end

@implementation ASTestView

- (void)dealloc
{
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
    }
    
    return self;
}

- (void)testViewClick
{
    [_actionHandle requestAction:@"/testViewClick" options:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:2], @"testCount", nil]];

}
@end
