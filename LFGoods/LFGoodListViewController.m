//
//  LFGoodListViewController.m
//  LFGoods
//
//  Created by 古田貴久 on 2014/06/08.
//  Copyright (c) 2014年 古田貴久. All rights reserved.
//

#import "LFGoodListViewController.h"
#import "LFTableViewConst.h"
#import <NSMutableArray+SWUtilityButtons.h>
#import "LFItem.h"

@interface LFGoodListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *goodListTable;
@property  NSDictionary *NameWithPriceDict;
@property  NSDictionary *NameWithDetailDict;
@property (nonatomic,strong) NSArray *items;

@property NSMutableArray *lfItems;

@property int checkedItemNum;

@end

@implementation LFGoodListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.goodListTable.delegate = self;
    self.goodListTable.dataSource = self;

    
    [self fetchDictKeys];
    
    //カスタムセルnibを登録
    UINib* nib = [UINib nibWithNibName:TableViewCustomCellIdentifier bundle:nil];
    [self.goodListTable registerNib:nib forCellReuseIdentifier:@"Cell"];
    
    //フェッチ
    self.lfItems = [[self fetchEntity]mutableCopy];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.lfItems = [[self fetchEntity] mutableCopy];
    [self.goodListTable reloadData];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableVie
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"未チェク";
            break;
            
        case 1:
            return @"買い物かご";
            break;
            
        default:
         break;
    }
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSPredicate *noPredicate = [NSPredicate predicateWithFormat:@"%K = NO",@"isChecked"];
    NSPredicate *yesPredicate = [NSPredicate predicateWithFormat:@"%K = YES",@"isChecked"];
    switch (section) {
        case 0:
            return [LFItem MR_countOfEntitiesWithPredicate:noPredicate];
            break;
        case 1:
            return [LFItem MR_countOfEntitiesWithPredicate:yesPredicate];
            break;
            
        default:
            break;
    }
    
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   LFItemListCustomCell *cell = [self.goodListTable dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.delegate = self;
    cell.rightUtilityButtons = [self rightButtons];
    cell.leftUtilityButtons = [self leftButtons];
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!tableView.isEditing) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void)configureCell:(LFItemListCustomCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
//    if (!cell.isChecked) {
//        cell.itemNumLabel.hidden = YES;
//    } else {
//        cell.itemNumLabel.hidden = NO;
//        [self addItemNum:cell];
//    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = NO",@"isChecked"];
    LFItem *item;
    
    if (indexPath.section == 0) {
        item = [self.lfItems objectAtIndex:indexPath.row];
    } else {
        //sectionが0の場合はrow+未チェックの数
        item = [self.lfItems objectAtIndex:(indexPath.row+[LFItem MR_countOfEntitiesWithPredicate:predicate])];
    }
    
    cell.nameLabel.text = item.name;
    cell.itemNum = [item.num intValue];
    
    int temp = item.priceValue;
    
    NSMutableString *yen = [NSMutableString stringWithFormat:@"￥"];
    NSString *value = [NSString stringWithFormat:@"%d",temp];
    [yen appendString:value];
    
    cell.priceLabel.text = yen;
    
}

- (void)fetchDictKeys
{
    self.items = [self.NameWithPriceDict.allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    
    
}

#pragma mark - SWSetting
- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0] title:@"ー"];
    
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0] title:@"＋"];
    
    return rightUtilityButtons;
    
}

- (NSArray *)leftButtons
{
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.07 green:0.75f blue:0.16f alpha:1.0]
                                                icon:[UIImage imageNamed:@"check.png"]];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188f alpha:1.0]
                                                icon:[UIImage imageNamed:@"cross.png"]];

    return leftUtilityButtons;
}

#pragma mark - SWTableViewCellDelegate
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            NSLog(@"left button 0 was pressed");
            //[self addEntity:(LFItemListCustomCell*)cell];
            [cell hideUtilityButtonsAnimated:YES];
            break;
        case 1:
            NSLog(@"left button 1 was pressed");
            [cell hideUtilityButtonsAnimated:YES];
            break;
        case 2:
            NSLog(@"left button 2 was pressed");
            break;
        case 3:
            NSLog(@"left btton 3 was pressed");
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            break;
        }
        case 1:
        {
            [self addItemNum:(LFItemListCustomCell*)cell];
            break;
        }
        default:
            break;
    }
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    // allow just one cell's utility button to be open at once
    return YES;
}

#pragma mark - SWCellAction

- (void)addItemNum:(LFItemListCustomCell *)cell
{
    if (cell.isChecked) {
        cell.itemNum++;
        cell.itemNumLabel.text = [NSString stringWithFormat:@"%0d",cell.itemNum];
    } else {
        return;
    }
    
    //saveAction
}

- (void)decreaseItemNum:(LFItemListCustomCell *)cell
{
    if (!cell.itemNum < 0 && cell.isChecked) {
        cell.itemNum--;
        cell.itemNumLabel.text = [NSString stringWithFormat:@"%0d",cell.itemNum];
    } else {
        return;
    }
    
    //saveAction
}

#pragma mark - CoreDataまわり
//- (void)addEntity:(LFItemListCustomCell *)cellº
//{
//    NSIndexPath *indexPath = [self.goodListTable indexPathForCell:cell];
//    cell.isChecked = YES;
//    [self configureCell:cell atIndexPath:indexPath];
//    
//    //データ永続化
//    LFItem *newItem = [LFItem MR_createEntity];
//    newItem.name = self.items[indexPath.row];
//    newItem.num = [NSNumber numberWithInt:cell.itemNum];
//    newItem.isChecked  = [NSNumber numberWithBool:cell.isChecked];
//    
//    NSManagedObjectContext *context = [NSManagedObjectContext defaultContext];
//    [context MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
//        if (success) {
//            NSLog(@"saved ---- >\n%@",newItem);
//        } else {ººººººº
//            NSLog(@"error : %@",error);
//        }
//    }];
//}

- (NSArray *)fetchEntity
{
    return [LFItem fetchSortedEntityCheckedInEnd];
    
}



@end
