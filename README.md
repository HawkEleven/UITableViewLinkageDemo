# UITableViewLinkageDemo

iOS采用UITableView来实现Excel、课程表、汽车之家车辆参数对比的上下左右联动效果。已重构。

### 引言

2016年 12月份在项目中遇到了这种需求，当时能参照的效果只有汽车之家，且没有开源的项目供参考，因此自己摸索了这种实现方式。早想将本方案呈现给大伙以供参考，无奈项目一直赶进度，因此拖到了现在。提笔之时发现其他网友已经贡献了类似项目的实现思路，那么，大家可以综合对比，撷取精华部分为自己所用。

### 需求描述

> 列表可以左右滑动，上下滚动，且能动态增加删除列表个数。

![列表.jpeg](http://upload-images.jianshu.io/upload_images/1338824-b1913d0aa37ca25a.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 效果如下

![列表左右上下滑动.gif](http://upload-images.jianshu.io/upload_images/1338824-46230582665664d3.gif?imageMogr2/auto-orient/strip)

### 方案实现(2018-08-14重构)

1）视图有两部分组成：左侧**ConfigurationView**和右侧**CompareDetailView**；

2）CompareDetailView在视图底层，宽度为绿色区域宽，核心为UICollectionView，collectionViewCell上添加“头部蓝色视图”和“UITableview”；

3）ConfigurationView在视图顶层，宽度为屏幕宽，核心为UITableview，且tableviewCell宽度为红色区域宽度。

#### 注意点
ConfigurationView在CompareDetailView顶部是因为要显示图中灰色sectionHeader，
此时CompareDetailView被遮盖且不能交互。因此将ConfigurationView里面的视图设置为clearColor，还要重写ConfigurationView的 - (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event 方法，来设置交互区域：图中红色区域。

```objc
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
	if (CGPathIsEmpty(self.path.CGPath)) {
        return YES;
    } else if (CGPathContainsPoint(self.path.CGPath, nil, point, nil)) {
        return YES;
    } else {
        return NO;
    }
}
```


```objc
// 设置tableView的交互区域
UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, ITEM_WIDTH, self.bounds.size.height)];
self.path = path;
```


### 结尾

本Demo是从项目中拆分整理而来，如有问题欢迎指正，若对你有所帮助，还望star支持下~
