//
//  MyTableListView.h
//  xxxxxxxx
//
//  Created by WF on 2017/1/14.
//  Copyright © 2017年 WF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCContentOB.h"
@protocol MyTableListViewDelegate <NSObject>
@optional
-(void)successOfCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end
@interface MyTableListView : UIView
@property(strong,nonatomic)NSDictionary* upOnedic;
@property(weak,nonatomic)id<MyTableListViewDelegate>delegate;
-(instancetype)initWithFrame:(CGRect)frame andContentDicArray:(NSMutableArray *)contentDicArray andType:(NSInteger)type;
-(void)addOneOb:(BCContentOB *)oneOb;
@end
