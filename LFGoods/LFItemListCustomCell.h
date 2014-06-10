//
//  LFItemListCustomCell.h
//  LFGoods
//
//  Created by 古田貴久 on 2014/06/09.
//  Copyright (c) 2014年 古田貴久. All rights reserved.
//

#import "SWTableViewCell.h"
@import UIKit;

@interface LFItemListCustomCell : SWTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property int itemNum;
@property BOOL isChecked;

@end
