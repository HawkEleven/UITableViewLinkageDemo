# UITableViewLinkageDemo
iOS采用UITableView来实现Excel、课程表、汽车之家车辆参数对比的上下左右联动效果
### 引言
去年12月份在项目中遇到了这种需求，当时能参照的效果只有汽车之家，且没有开源的项目供参考，因此自己摸索了这种实现方式。早想将本方案呈现给大伙以供参考，无奈项目一直赶进度，因此拖到了现在。提笔之时发现其他网友已经贡献了类似项目的实现思路，那么，大家可以综合对比，撷取精华部分为自己所用。
### 需求描述
> 列表可以左右滑动，上下滚动，且能动态增加删除列表个数。

![列表.jpeg](http://upload-images.jianshu.io/upload_images/1338824-b1913d0aa37ca25a.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 效果如下

![列表左右上下滑动.gif](http://upload-images.jianshu.io/upload_images/1338824-46230582665664d3.gif?imageMogr2/auto-orient/strip)

### 方案实现
1）顶部配置项右边一行用UIScrollView来处理 (***self.littleScrollView***)；

2）下边整个背部是UITableView (***self.backgroundTableView***)；

3）绿色区域背部是UIScrollView (***self.scrollView***)；

4）绿色区域上边一列一列为UITableVie，切添加到self.scrollView。

#### 这里有两种情况：
**a)** sectionHeader只有左侧有视图显示，没有右侧“标配”、“选配”等视图。
此时的视图层级为：

```objc
[self.view addSubview:self.backgroundTableView];
[self.view addSubview:self.scrollView];
```
且将绿色区域上边TableView的sectionHeader视图隐藏，如：

```objc
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    label.text = [NSString stringWithFormat:@"   基本参数%zi", section];
    label.font = [UIFont systemFontOfSize:10];
    label.textColor = HexColorInt32_t(1E2124);
    label.backgroundColor = HexColorInt32_t(F0F0F0);
    if (tableView != self.backgroundTableView) {
        label.text = @"";
    }
    return label;
}
```

**b)** sectionHeader左侧、右侧视图同时显示，如GIF图所示，此时只能将self.backgroundTableView视图置于self.scrollView的上层，这样才能将sectionHeader显示出来，如下图所示：
![层级.jpeg](http://upload-images.jianshu.io/upload_images/1338824-4d3242e16a80e6d1.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

sectionHeader可以看到，但右侧的列表全被遮盖，因此将self.backgroundTableView的颜色设为clearColor，这样就可以看到背部的列表。但由于self.backgroundTableView在self.scrollView的上层，因此，self.scrollView的tableview不可以交互。要想交互，只能设置self.backgroundTableView的交互区域(左侧可以交互，右侧不可以交互)。那么就要重写self.backgroundTableView的-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event方法。


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

在scrollView的-(void)scrollViewDidScroll:(UIScrollView *)scrollView中设置交互区域path。

```objc
UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, scrollView.contentOffset.y, 94, CGRectGetHeight(self.backgroundTableView.frame))];
self.backgroundTableView.path = path;
```



#### 重点注意方面
self.scrollView的height等于self.backgroundTableView.contentSize.height。<del>同时，右侧列表的tableview的height也等于self.backgroundTableView.contentSize.height。

```objc
self.scrollView.frame = CGRectMake(kItemWidth, 0, kScreenWidth - kItemWidth, self.backgroundTableView.contentSize.height);
```
<del>

```objc
tableView.frame = CGRectMake(kItemWidth * self.count, 0, kItemWidth, self.backgroundTableView.contentSize.height);
```

</del>

### 结尾
本Demo是从项目中拆分整理而来，如有问题欢迎指正，若对你有所帮助，还望star支持下~
