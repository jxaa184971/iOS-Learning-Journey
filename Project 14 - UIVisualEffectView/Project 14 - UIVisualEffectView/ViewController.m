//
//  ViewController.m
//  Project 14 - UIVisualEffectView
//
//  Created by Jamie on 2018/7/18.
//  Copyright © 2018年 Jamie. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIVisualEffectView *effectView1;
@property (nonatomic,strong) UIVisualEffectView *effectView2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"cell"];

    [self addEffectView];

    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 200, 40)];
    label1.text = @"磨砂效果";
    [self.view addSubview:label1];

    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 320, 200, 40)];
    label2.text = @"生动效果";
    label2.textColor = [UIColor whiteColor];
    [self.view addSubview:label2];
}

- (void)addEffectView {
    // 磨砂效果
    self.effectView1 = [[UIVisualEffectView alloc] initWithEffect: [UIBlurEffect effectWithStyle: UIBlurEffectStyleExtraLight]];
    self.effectView1.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 100);
    [self.view bringSubviewToFront:self.effectView1];
    [self.view addSubview:self.effectView1];


    // 生动效果
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVibrancyEffect *effect2 = [UIVibrancyEffect effectForBlurEffect:effect];
    self.effectView2 = [[UIVisualEffectView alloc] initWithEffect:effect2];
    self.effectView2.frame = CGRectMake(0, 300, [[UIScreen mainScreen] bounds].size.width, 100);

    // 这种效果仅仅对与添加到contentView中的内容有效果
    UIView *redView = [[UIView alloc]initWithFrame:self.effectView2.bounds];
    redView.backgroundColor = [UIColor redColor];
    redView.alpha = 0.8;
    [self.effectView2.contentView addSubview:redView];

    [self.view bringSubviewToFront:self.effectView2];
    [self.view addSubview:self.effectView2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSInteger picIndex = indexPath.row % 5;
    NSString *picFileName = [NSString stringWithFormat:@"%ld.jpeg",(long)picIndex];
    cell.picView.image = [UIImage imageNamed:picFileName];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


@end
