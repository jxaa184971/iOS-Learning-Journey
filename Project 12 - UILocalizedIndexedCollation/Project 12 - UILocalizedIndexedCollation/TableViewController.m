//
//  TableViewController.m
//  Project 12 - UILocalizedIndexedCollation
//
//  Created by Jamie on 2018/5/3.
//  Copyright © 2018年 Jamie. All rights reserved.
//

#import "TableViewController.h"
#import "Person.h"

@interface TableViewController ()

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) NSMutableArray *sectionTitleArray;
@property (nonatomic, strong) NSMutableArray *sectionIndexTitleArray;
@property (nonatomic, strong) UILocalizedIndexedCollation *localizedCollection;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sectionTitleArray = [[NSMutableArray alloc] init];
    self.sectionIndexTitleArray = [[NSMutableArray alloc] init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    //配置数据源
    NSArray *nameArray = @[@"赵大宝",@"朱逞燕",@"卫意琦",@"萧雯珠",@"甘有雯",@"林菁蝶",@"凌月青",@"陈琰俊",@"姜娰昀",@"张察妙",@"袁棋琴",@"孟鼎好",@"欧充舒",@"郑洋影",@"严凌"];
//    NSArray *nameArray = @[@"北京市",@"天津市",@"上海市",@"重庆市",@"河北省",@"山西省",@"辽宁省",@"吉林省",@"黑龙江省",@"江苏省",@"浙江省",@"安徽省",@"福建省",@"江西省",@"山东省",@"河南省",@"湖北省",@"湖南省",@"广东省",@"海南省",@"四川省",@"贵州省",@"云南省",@"陕西省",@"甘肃省",@"青海省",@"台湾省",@"内蒙古自治区",@"广西壮族自治区",@"西藏自治区",@"宁夏回族自治区",@"新疆维吾尔自治区",@"香港特别行政区",@"澳门特别行政区"];

    NSMutableArray *tempPersonArray = [NSMutableArray array];
    for (int i=0; i<nameArray.count; i++) {
        Person *person = [Person new];
        person.name = nameArray[i];
        [tempPersonArray addObject:person];
    }

    //初始化UILocalizedIndexedCollation
    self.localizedCollection = [UILocalizedIndexedCollation currentCollation];
    //得出collation索引的数量，这里是27个（26个字母和1个#）
    NSInteger sectionTitlesCount = [[self.localizedCollection sectionTitles] count];
    //初始化一个数组newSectionsArray用来存放最终的数据
    NSMutableArray *newSectionsArray = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
    //初始化27个空数组加入newSectionsArray
    for (NSInteger index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [newSectionsArray addObject:array];
    }

    //将每个人按name分到某个index下
    for (Person *temp in tempPersonArray) {
        //获取name属性的值所在的位置，比如"林丹"，首字母是L，在A~Z中排第11（第一位是0），sectionNumber就为11
        NSInteger sectionNumber = [self.localizedCollection sectionForObject:temp collationStringSelector:@selector(name)];
        NSMutableArray *sectionNames = newSectionsArray[sectionNumber];
        [sectionNames addObject:temp];
    }

    //对每个section中的数组按照name属性排序
    for (int index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *personArrayForSection = newSectionsArray[index];
        NSArray *sortedPersonArrayForSection = [self.localizedCollection sortedArrayFromArray:personArrayForSection collationStringSelector:@selector(name)];
        newSectionsArray[index] = sortedPersonArrayForSection;
    }

    //将为空的index数组删除，并且将有数据的index数组保存在array中，方便tableview调用
    NSMutableArray *tempArr = [NSMutableArray array];
    [newSectionsArray enumerateObjectsUsingBlock:^(NSArray *array, NSUInteger idx, BOOL * _Nonnull stop) {
        if (array.count == 0) {
            [tempArr addObject:array];
        }else{
            [self.sectionTitleArray addObject:[self.localizedCollection sectionTitles][idx]];
            [self.sectionIndexTitleArray addObject:[self.localizedCollection sectionIndexTitles][idx]];
        }
    }];
    [newSectionsArray removeObjectsInArray:tempArr];
    self.dataList = newSectionsArray.copy;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSMutableArray *)[self.dataList objectAtIndex:section]).count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.sectionTitleArray objectAtIndex:section];
}

//显示在右边的索引栏的标题，用户点击时跳转到索引所在的index的section位置
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.sectionIndexTitleArray;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    NSMutableArray *array =(NSMutableArray *)[self.dataList objectAtIndex:indexPath.section];
    Person *person = (Person *)[array objectAtIndex:indexPath.row];
    cell.textLabel.text = person.name;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
