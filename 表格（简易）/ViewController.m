 //
//  ViewController.m
//  表格（简易）
//
//  Created by WF on 2017/2/20.
//  Copyright © 2017年 WF. All rights reserved.
//

#import "ViewController.h"
#import "MyTableListView.h"
#import "BCContentOB.h"
@interface ViewController ()<MyTableListViewDelegate>
@property(strong,nonatomic) MyTableListView *vc123;
@property(strong,nonatomic) MyTableListView *vcTWO;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *dic=[[NSMutableArray alloc] init];
     NSMutableArray *dic2=[[NSMutableArray alloc] init];
    //修改表格显示内容标题 只需要在BCContentOB文件中修改属性以及其他
    //调整第一列的宽度 可在MyTableListView.m中最上面修改 FIRSTCELLWIDTH
    //调整每一行的高度 可在MyTableListView.m中最上面修改 ALLCELLHIGH
    //调整第一列后的宽度 可在MyTableListView.m中最上面修改 OTHERCELLWIDTH
    //点击下面按钮 可增加一行显示在最上面 如有需要可自行 调整更新以及添加代理等
    //若有其他调整 可自调
    for (int i=0; i<10; i++) {
        BCContentOB *ddd=[[BCContentOB alloc] init];
        ddd.name=@"啦啦";
        ddd.attributeFirst=@"1";
        ddd.attributeSecond=@"2";
        ddd.attributeThird=@"3";
        ddd.attributeFourth=@"4";
        ddd.attributeFifth=@"5";
        ddd.attributeSixth=@"6";
        ddd.attributeSeventh=@"7";
        ddd.attributeEighth=@"8";
        [dic addObject:ddd];
    }
    
   _vc123 = [[MyTableListView alloc] initWithFrame:CGRectMake(0, 50,self.view.frame.size.width, 300) andContentDicArray:dic andType:1];
    _vc123.delegate=self;//设置代理作用:选中某一个 可自行修改
    [self.view addSubview:_vc123];
    
    for (int i=0; i<6; i++) {
        BCContentOB *ddd=[[BCContentOB alloc] init];
        ddd.name=@"呵呵";
        ddd.attributeFirst=@"哈哈";
        ddd.attributeSecond=@"是不";
        ddd.attributeThird=@"傻";
        
        [dic2 addObject:ddd];
    }

    
    
    
    _vcTWO = [[MyTableListView alloc] initWithFrame:CGRectMake(0, 350,self.view.frame.size.width, 400) andContentDicArray:dic2 andType:2];
    _vcTWO.delegate=self;//设置代理作用:选中某一个 可自行修改
    [self.view addSubview:_vcTWO];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(50, 500, 244, 50);
    button.backgroundColor=[UIColor orangeColor];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)successOfCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击第%ld行 第%ld个",indexPath.section,indexPath.row);
}
-(void)click{
    BCContentOB *ddd=[[BCContentOB alloc] init];
    ddd.name=@"啦啦2";
    ddd.attributeFirst=@"11";
    ddd.attributeSecond=@"22";
    ddd.attributeThird=@"33";
    ddd.attributeFourth=@"44";
    ddd.attributeFifth=@"55";
    ddd.attributeSixth=@"66";
    ddd.attributeSeventh=@"77";
    ddd.attributeEighth=@"88";
    [_vc123 addOneOb:ddd];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
