//
//  CJHomeController.h
//  deliciousDinner
//
//  Created by 凤凰金服 on 16/8/12.
//  Copyright © 2016年 碧桂园. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CJHomeDelegate <NSObject>
@optional
- (void)tableViewDidScrolleToTopWithOffset:(CGPoint) offset;
@end

@interface CJHomeController : UITableViewController
- (void)refresh;
/** 代理对象 */
@property (nonatomic, weak) id<CJHomeDelegate> delegate;
@end
