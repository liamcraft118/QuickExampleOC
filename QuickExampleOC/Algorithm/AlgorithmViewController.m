//
//  AlgorithmViewController.m
//  QuickExampleOC
//
//  Created by ingo on 2021/4/12.
//

#import "AlgorithmViewController.h"

/**
 剑指offer 68-2 二叉树的最近公共祖先
 深度优先遍历（后序遍历），通过((lson && rson) || ((p.val == root || q.val == root) && (lson || rson))来判断是否找到公共root
 
 剑指offer 68-1 二叉搜索树的最近公共祖先
 利用二叉搜索树的特性，左节点小于父节点，右节点大于父节点
 当p、q都在左子树或右子树时，公共祖先就会移动到左节点或者右节点
 当p、q一个在左子树，一个在右子树时，当前父节点就是公共祖先
 与深度优先遍历二叉树求解相比，这里空间复杂度为O(1)
 
 剑指offer 67 把字符串转换成整数
 考察的应该是各种corner case，依次判断即可
 数字转换的部分，利用字符减去"0"这个字符串即可
 从左到右遍历的时候，每一次让结果乘以10，再加上值即可
 
 */

@interface AlgorithmViewController ()

@end

@implementation AlgorithmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
