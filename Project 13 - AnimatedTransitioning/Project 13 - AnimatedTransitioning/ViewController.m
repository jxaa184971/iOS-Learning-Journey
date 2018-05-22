//
//  ViewController.m
//  Project 13 - AnimatedTransitioning
//
//  Created by Jamie on 2018/5/22.
//  Copyright © 2018年 Jamie. All rights reserved.
//

#import "ViewController.h"
#import "SceneBViewController.h"
#import "TransitionAnimation.h"

@interface ViewController ()<UINavigationControllerDelegate>  //在需要增加场景转换动画的VC实现该代理

@property (nonatomic, strong)UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.button];
    self.navigationController.navigationBar.hidden = YES;

    //将navigationController的代理设为自己
    self.navigationController.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(UIButton *)button {
    if (!_button) {
        _button = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 200, 20)];
        [_button setTitle:@"ToSceneB" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

-(void)buttonClicked:(id)sender {
    SceneBViewController *vc = [SceneBViewController new];
    [self.navigationController pushViewController:vc animated:YES]; //animated必须为YES才会调用下面的代理方法
}

//该代理方法会返回 UIViewControllerAnimatedTransitioning 对象，该对象实现了场景转换的动画。
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    //根据情况不同，可以将跳转的方式为push还是pop，fromVC和toVC是什么来作为判断条件。
    if ([fromVC isKindOfClass:[ViewController class]] && operation == UINavigationControllerOperationPush) {
        TransitionAnimation *animation = [[TransitionAnimation alloc] init];
        return animation;
    }else {
        //返回nil 会显示默认动画
        return nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    
}


@end
