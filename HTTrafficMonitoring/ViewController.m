//
//  ViewController.m
//  HTTrafficMonitoring
//
//  Created by 一米阳光 on 17/2/27.
//  Copyright © 2017年 一米阳光. All rights reserved.
//

#import "ViewController.h"
#import "HTTraffic.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 300)];
    self.label.textColor = [UIColor purpleColor];
    self.label.numberOfLines = 0;
    [self.view addSubview:self.label];
    
    NSDictionary *trafficDict = [HTTraffic getTrafficMonitorings];
    self.label.text = [NSString stringWithFormat:@"WiFi状态下发送流量%@(字节)\nWiFi状态下接收流量%@(字节)\nWiFi状态下消耗总流量%@(字节)\n移动网络下发送流量%@(字节)\n移动网络下接收流量%@(字节)\n移动网络下消耗总流量%@(字节)\n",trafficDict[@"WiFiSentTraffic"],trafficDict[@"WiFiReceivedTraffic"],trafficDict[@"WiFiTotalTraffic"],trafficDict[@"WWANSentTraffic"],trafficDict[@"WWANReceivedTraffic"],trafficDict[@"WWANTotalTraffic"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
