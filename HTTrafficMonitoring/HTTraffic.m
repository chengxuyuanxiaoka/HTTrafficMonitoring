//
//  HTTraffic.m
//  HTTrafficMonitoring
//
//  Created by 一米阳光 on 17/2/27.
//  Copyright © 2017年 一米阳光. All rights reserved.
//

#import "HTTraffic.h"
#include <arpa/inet.h>
#include <net/if.h>
#include <ifaddrs.h>
#include <net/if_dl.h>

@implementation HTTraffic

/**
 *  WiFiSent WiFi发送流量
 *  WiFiReceived WiFi接收流量
 *  WWANSent 移动网络发送流量
 *  WWANReceived 移动网络接收流量
 */
+ (NSDictionary *)getTrafficMonitorings {
    NSDictionary * trafficDict = [[NSDictionary alloc] init];
    BOOL success;
    struct ifaddrs *addrs;
    const struct ifaddrs *cursor;
    const struct if_data *networkStatisc;
    int WiFiSent = 0;
    int WiFiReceived = 0;
    int WWANSent = 0;
    int WWANReceived = 0;
    NSString *name=[[NSString alloc]init];
    success = getifaddrs(&addrs) == 0;
    if (success) {
        cursor = addrs;
        while (cursor != NULL) {
            name=[NSString stringWithFormat:@"%s",cursor->ifa_name];
            
            if (cursor->ifa_addr->sa_family == AF_LINK) {
                //wifi消耗流量
                if ([name hasPrefix:@"en"]) {
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    WiFiSent+=networkStatisc->ifi_obytes;
                    WiFiReceived+=networkStatisc->ifi_ibytes;
                }
                
                //移动网络消耗流量
                if ([name hasPrefix:@"pdp_ip0"]) {
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    WWANSent+=networkStatisc->ifi_obytes;
                    WWANReceived+=networkStatisc->ifi_ibytes;
                }
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    NSString *WiFiSentTraffic = [NSString stringWithFormat:@"%d",WiFiSent];
    NSString *WiFiReceivedTraffic = [NSString stringWithFormat:@"%d",WiFiReceived];
    NSString *WiFiTotalTraffic = [NSString stringWithFormat:@"%d",WiFiSent + WiFiReceived];
    NSString *WWANSentTraffic = [NSString stringWithFormat:@"%d",WWANSent];
    NSString *WWANReceivedTraffic = [NSString stringWithFormat:@"%d",WWANReceived];
    NSString *WWANTotalTraffic = [NSString stringWithFormat:@"%d",WWANSent+WWANReceived];
    trafficDict = @{
                    @"WiFiSentTraffic":WiFiSentTraffic,
                    @"WiFiReceivedTraffic":WiFiReceivedTraffic,
                    @"WiFiTotalTraffic":WiFiTotalTraffic,
                    @"WWANSentTraffic":WWANSentTraffic,
                    @"WWANReceivedTraffic":WWANReceivedTraffic,
                    @"WWANTotalTraffic":WWANTotalTraffic
                    };
    
    return trafficDict;
}

@end
