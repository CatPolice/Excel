//
//  MyTableListView.m
//  xxxxxxxx
//
//  Created by WF on 2017/1/14.
//  Copyright © 2017年 WF. All rights reserved.
//
#define FIRSTCELLWIDTH 80 //第一个cell的宽度

#define OTHERCELLWIDTH 80  //其他cell的宽度

#define ALLCELLHIGH 40  //所有cell的高度

#import "MyTableListView.h"
#import "BCMyCollectionViewCell.h"
#import "BCMyTableViewCell.h"
@interface MyTableListView()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UICollectionViewFlowLayout*customLayout;
@property(strong,nonatomic)UICollectionView*collectionView;

@property(strong,nonatomic)UIScrollView*scrollView;
@property(strong,nonatomic)UITableView*table;



@property(strong,nonatomic)NSArray*arrayAttributeName;//属性名字
@property(strong,nonatomic)NSArray*arrayAttribute;//属性

@property(strong,nonatomic)NSMutableArray*arrayContent;//内容列表

@property (nonatomic) NSInteger  type;
@end
@implementation MyTableListView

static NSString *const cellId = @"cellId";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";

-(void)addOneOb:(BCContentOB *)oneOb{
    [_arrayContent insertObject:oneOb atIndex:0];
    [_table reloadData];
    [_collectionView reloadData];
}

-(instancetype)initWithFrame:(CGRect)frame andContentDicArray:(NSMutableArray *)contentDicArray andType:(NSInteger)type{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame=frame;
        self.arrayContent=contentDicArray;
        _type = type;
        [self creatTableListViewUI];

    }
    return self;
}
-(void)creatTableListViewUI{
    if (_type == 1) {
        self.arrayAttribute=[[BCContentOB new] getAttributeArray];
        self.arrayAttributeName=[[BCContentOB new] getAttributeNameArray];
    }else{
        self.arrayAttribute=[[BCContentOB new] getAttributeArray2];
        self.arrayAttributeName=[[BCContentOB new] getAttributeNameArray2];
    }
    
    
    //整体布局 右 除了第一列以外的底层布局
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(FIRSTCELLWIDTH, 0,self.frame.size.width-FIRSTCELLWIDTH, self.frame.size.height)];
    if (OTHERCELLWIDTH*(self.arrayAttributeName.count-1)>CGRectGetWidth(_scrollView.frame)) {
        _scrollView.contentSize = CGSizeMake(OTHERCELLWIDTH*(self.arrayAttributeName.count-1), _scrollView.frame.size.height);
    }
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];

    //上层布局 左
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, FIRSTCELLWIDTH, ALLCELLHIGH)];
    label.layer.borderColor = [UIColor blackColor].CGColor;
    label.layer.borderWidth = 0.5f;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:17.f];
    label.text = [_arrayAttributeName objectAtIndex:0];
    [self addSubview:label];
    
    //最左一列 name
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, ALLCELLHIGH, FIRSTCELLWIDTH, self.frame.size.height-ALLCELLHIGH) style:UITableViewStylePlain];
    _table.dataSource = self;
    _table.delegate = self;
    _table.tag = 200;
    _table.showsVerticalScrollIndicator = NO;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_table];
    
    
    //上层布局 右
    for (int i = 0; i<_arrayAttributeName.count-1; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*OTHERCELLWIDTH, 0, OTHERCELLWIDTH, ALLCELLHIGH)];
        label.layer.borderColor = [UIColor blackColor].CGColor;
        label.layer.borderWidth = 0.5f;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:17.f];
        label.text = [_arrayAttributeName objectAtIndex:i+1];
        [_scrollView addSubview:label];
    }
    
    //左下布局
    _customLayout = [[UICollectionViewFlowLayout alloc] init]; // 自定义的布局对象
    // 定义大小
    _customLayout.itemSize = CGSizeMake(OTHERCELLWIDTH, ALLCELLHIGH);
    // 设置最小行间距
    _customLayout.minimumLineSpacing = 0;
    // 设置垂直间距
    _customLayout.minimumInteritemSpacing = 0;
    // 设置滚动方向（默认垂直滚动）
    _customLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, ALLCELLHIGH, OTHERCELLWIDTH*(_arrayAttributeName.count - 1), self.frame.size.height-ALLCELLHIGH) collectionViewLayout:_customLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.tag = 100;
    [_scrollView addSubview:_collectionView];
    
    
    // 注册cell、sectionHeader、sectionFooter
    [_collectionView registerClass:[BCMyCollectionViewCell class] forCellWithReuseIdentifier:cellId];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
}
#pragma mark--scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag==100) {
        _table.contentOffset = scrollView.contentOffset;
    }else if (scrollView.tag == 200){
        _collectionView.contentOffset = scrollView.contentOffset;
    }
}


#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _arrayContent.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _arrayAttributeName.count-1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BCMyCollectionViewCell *cell = (BCMyCollectionViewCell *)[_collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (_type == 1) {
         NSDictionary *oneOB = [(BCContentOB *)[_arrayContent objectAtIndex:indexPath.section] getDicOfOB];
        cell.label.text = oneOB[[_arrayAttribute objectAtIndex:indexPath.row+1]];
    }else{
         NSDictionary *oneOB = [(BCContentOB *)[_arrayContent objectAtIndex:indexPath.section] getDicOfOB2];
        cell.label.text = oneOB[[_arrayAttribute objectAtIndex:indexPath.row+1]];
    }
   

    
    return cell;
}
// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
        if(headerView == nil) {
            headerView = [[UICollectionReusableView alloc] init];
        }
        headerView.backgroundColor = [UIColor grayColor];
        
        return headerView;
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UICollectionReusableView *footerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerId forIndexPath:indexPath];
        if(footerView == nil){
            footerView = [[UICollectionReusableView alloc] init];
        }
        footerView.backgroundColor = [UIColor lightGrayColor];
        
        return footerView;
    }
    
    return nil;
}
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath{
    
}
#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return (CGSize){OTHERCELLWIDTH,ALLCELLHIGH};//方块大小
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);//前面2个数字是整个控件前的间隔
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return (CGSize){.0,.0};//后面数据为头高度
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return (CGSize){0,.0};//后面数据为低高度
}
#pragma mark ---- UICollectionViewDelegate

// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(successOfCollectionView:didSelectItemAtIndexPath:)]) {
        [self.delegate successOfCollectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }
}


#pragma mark table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arrayContent.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *strCell = @"cell";
    BCMyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if (!cell){
        cell = [[BCMyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (_type == 1) {
        NSDictionary *oneOB = [(BCContentOB *)[_arrayContent objectAtIndex:indexPath.section] getDicOfOB];
        cell.label.text = [oneOB objectForKey:[_arrayAttribute objectAtIndex:0]];
    }else{
        NSDictionary *oneOB = [(BCContentOB *)[_arrayContent objectAtIndex:indexPath.section] getDicOfOB2];
        cell.label.text = [oneOB objectForKey:[_arrayAttribute objectAtIndex:0]];
    }
   
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ALLCELLHIGH;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
