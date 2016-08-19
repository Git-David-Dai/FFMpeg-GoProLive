//
//  ViewController.m
//  GoProLive
//
//  Created by David.Dai on 16/5/23.
//  Copyright © 2016年 David.Dai. All rights reserved.
//

#import "ViewController.h"
#import "GPPreviewHack.h"
#import "GPFFMpegLive.h"
#import "GPAudioLive.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController
{
    GPPreviewHack               *_previewHack;
    GPFFMpegLive        *_ffmpegLive;
    GPAudioLive         *_phoneMicLive;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _previewHack = [[GPPreviewHack alloc]init];
    _ffmpegLive = [[GPFFMpegLive alloc]init];
    _phoneMicLive = [[GPAudioLive alloc]init];
    
    _imageView.backgroundColor = [UIColor blackColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reflashImage:) name:@"reflash" object:nil];
}

- (void)reflashImage:(NSNotification *)notice
{
    if(!notice) return;
    if(notice.object)
        [_imageView setImage:(UIImage*)notice.object];
}

- (IBAction)hackGoProLiveStream:(id)sender {
    [_ffmpegLive startLive:nil];
    [_previewHack startHack];
    [_phoneMicLive stratAACAudioFromMic];
}
- (IBAction)stopGoProLive:(id)sender {
    [_ffmpegLive stopLive];
    [_previewHack stopHack];
    [_phoneMicLive stopAACAudioFromMic];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end