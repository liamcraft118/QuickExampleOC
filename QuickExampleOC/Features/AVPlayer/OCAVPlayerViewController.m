//
//  OCAVPlayerViewController.m
//  QuickExampleOC
//
//  Created by Liam on 2021/5/7.
//

/**
 AVPlayerItem
 status ReadyToPlay时可以播放
 loadedTimeRanges 以数组形式返回已经缓存进度
 AVPlayerItem播放完成后会发出系统通知
 
 AVPlayer
 通过replaceCurrentItemWithPlayerItem来加载AVPlayerItem
 有play, pause, seekToTime方法，使用的time为CMTime，其中包含帧数和帧率
 addPeriodicTimeObserverForInterval:queue:block
 
 AVPlayer
 核心，根据URL播放网络音频
 基础，播放、暂停、上一首、下一首
 基础，监听播放进度，获取音频总时间、当前时间
 基础，监听播放器状态，加载状态，数据缓冲状态，播放完成状态
 Remote Control
 Now Playing Center
 ref: https://www.jishudog.com/118/html
 
 */

#import "OCAVPlayerViewController.h"

@interface OCAVPlayerViewController ()

@end

@implementation OCAVPlayerViewController

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
