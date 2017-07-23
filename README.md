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

4）绿色区域上边一列一列为UITableView。

#### 重点注意方面
self.scrollView的height等于self.backgroundTableView.contentSize.height。同时，右侧列表的tableview的height也等于self.backgroundTableView.contentSize.height。

```objc
self.scrollView.frame = CGRectMake(kItemWidth, 0, kScreenWidth - kItemWidth, self.backgroundTableView.contentSize.height);
```
```objc
tableView.frame = CGRectMake(kItemWidth * self.count, 0, kItemWidth, self.backgroundTableView.contentSize.height);
```
### 结尾
本Demo是从项目中拆分整理而来，如有问题欢迎指正，若对你有所帮助，还望star支持下~
