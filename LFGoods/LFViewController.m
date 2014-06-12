//
//  LFViewController.m
//  LFGoods
//
//  Created by 古田貴久 on 2014/06/07.
//  Copyright (c) 2014年 古田貴久. All rights reserved.
//

#import "LFViewController.h"
#import "LFManager.h"
#import "LFItem.h"

@interface LFViewController ()

@property (nonatomic,strong) UIImageView *blurredImageView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) CGFloat screenHeight;

@property UILabel *itemNumLabel;
@property UILabel *priceLabel;

@property (nonatomic,strong) NSDictionary *NameWithPriceDict;
@property (nonatomic,strong) NSDictionary *NameWithDetailDict;

@property NSArray *item;
@property NSMutableArray *lfItems;

@property BOOL isFullScreen;

- (IBAction)addAction:(id)sender;

@end

@implementation LFViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    //ブラーを挟むならこの位置でaddsub
    
    self.tableView = [[UITableView alloc]init];
    //self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.height-200)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor colorWithWhite:1 alpha:0.5];
    self.tableView.pagingEnabled = YES;
    [self.view addSubview:self.tableView];
    
    //ヘッダー設定
    CGRect headerFrame = [UIScreen mainScreen].bounds;
    //CGRect headerFrame = CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.height - 200);
        //Header
    UIView *header = [[UIView alloc]initWithFrame:headerFrame];
    header.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = header;
    
       
    //logo
    UILabel* logo1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 67, 135, 45)];
    logo1.backgroundColor = [UIColor clearColor];
    logo1.textColor = [UIColor whiteColor];
    logo1.font = [UIFont fontWithName:@"HelVeticaNeue-Bold" size:40];
    logo1.text = @"NANA";
    [header addSubview:logo1];
    
    UILabel* logo2 = [[UILabel alloc]initWithFrame:CGRectMake(8, 97, 135, 45)];
    logo2.backgroundColor = [UIColor clearColor];
    logo2.textColor = [UIColor whiteColor];
    logo2.font = [UIFont fontWithName:@"HelVeticaNeue-Bold" size:40];
    logo2.text = @"WING";
    [header addSubview:logo2];
    
    UIImageView* shopIconView = [[UIImageView alloc]initWithFrame:CGRectMake(24, 146, 275, 275)];
    shopIconView.image = [UIImage imageNamed:@"shopIcon.png"];
    [header addSubview:shopIconView];
    
    self.itemNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(135, 319, 99, 62)];
    self.itemNumLabel.backgroundColor = [UIColor clearColor];
    self.itemNumLabel.textColor = [UIColor whiteColor];
    self.itemNumLabel.font = [UIFont fontWithName:@"HelVeticaNeue-Bold" size:70];
    self.itemNumLabel.textAlignment = NSTextAlignmentCenter;
    self.itemNumLabel.text = @"0";
    [header addSubview:self.itemNumLabel];
    
    UILabel *yenLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height - 70, 70, 60)];
    yenLabel.textAlignment = NSTextAlignmentCenter;
    yenLabel.backgroundColor = [UIColor clearColor];
    yenLabel.textColor = [UIColor whiteColor];
    yenLabel.font = [UIFont fontWithName:@"HelVeticaNeue-Bold" size:70];
    yenLabel.text = @"￥";
    [header addSubview:yenLabel];
    
    self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(yenLabel.frame.size.width + 5, self.view.bounds.size.height-70, self.view.frame.size.width - yenLabel.frame.size.width + 5, 60)];
    self.priceLabel.backgroundColor = [UIColor clearColor];
    self.priceLabel.textColor = [UIColor whiteColor];
    self.priceLabel.font = [UIFont fontWithName:@"HelVeticaNeue-Bold" size:70];
    self.priceLabel.textAlignment = NSTextAlignmentLeft;
    self.priceLabel.text = @"0";
    [header addSubview:self.priceLabel];

    
    //DBからデータをフェッチ
    self.lfItems = [[self fetchEntity] mutableCopy];
    
    //初期時はナビゲーションバーを表示しておく
    self.isFullScreen = NO;
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGRect bounds = self.view.bounds;
    
    self.tableView.frame = bounds;
    
    self.lfItems = [[self fetchEntity] mutableCopy];
    [self.tableView reloadData];
    [self configureHeaderView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lfItems.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
//    if (indexPath.section == 0) {
//        if (indexPath.row == 0) {
//            [self configureHeaderCell:cell title:@"物販リスト"];
//        } else {
//            NSString* itemName = self.item[indexPath.row - 1];
//            [self configureGoodCell:cell item:itemName];
//        }
//    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
    
}

- (void)configureHeaderCell:(UITableViewCell *)cell title:(NSString *)title
{
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
    cell.textLabel.text = title;
    cell.detailTextLabel.text = @"";
    cell.imageView.image = nil;
}

- (void)configureGoodCell:(UITableViewCell *)cell item:(NSString *)itemName
{
    cell.textLabel.font = [UIFont fontWithName:@"HelvetivaNeue-Light" size:18];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
    cell.textLabel.text = itemName;
    
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    LFItem *item = self.lfItems[indexPath.row];
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",item.numValue];
}

- (void)configureHeaderView
{
    int itemSum = 0;
    int priceSum = 0;
    
    for(LFItem *item in self.lfItems) {
        itemSum += item.numValue;
        priceSum += (item.numValue * item.priceValue);
    }
    
    self.itemNumLabel.text = [NSString stringWithFormat:@"%d",itemSum];
    self.priceLabel.text = [NSString stringWithFormat:@"%d",priceSum];
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger cellCount = [self tableView:tableView numberOfRowsInSection:indexPath.section];
    return self.screenHeight / (CGFloat)cellCount;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    CGFloat height = scrollView.bounds.size.height;
//    CGFloat position = MAX(scrollView.contentOffset.y, 0.0);
//    CGFloat percent = MIN(position/height, 1.0);
    [self changeFullScreen];
}

- (IBAction)addAction:(id)sender
{
   [self performSegueWithIdentifier:@"GoToItemListView" sender:self];
}

#pragma mark - CoreData周り
- (NSArray *)fetchEntity
{
    return [LFItem fetchSortedEntityOnlyChecked];
}

#pragma mark - ナビゲーションバー周り
- (void)changeFullScreen
{
    if(!self.isFullScreen) {
    
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        self.isFullScreen = YES;
    } else {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.isFullScreen = NO;
    }
}

@end
