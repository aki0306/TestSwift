//
//  AFHTTPRequestOperationManager.m
//  AlamofireSample
//
//  Created by アキ on 2024/09/21.
//

#import "AFHTTPRequestOperationManager.h"

@implementation AFHTTPRequestOperationManager

+ (AFHTTPRequestOperationManager *)createAFHTTPRequestOperationManagerWithRequestEncoding:(NSStringEncoding)requestEncoding andReponseEncoding:(NSStringEncoding)responseEncoding
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    [requestSerializer setValue:@"" forHTTPHeaderField:@""];
    requestSerializer.stringEncoding = NSShiftJISStringEncoding;
    [manager setRequestSerializer:requestSerializer];

    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
//    responseSerializer.stringEncoding = responseEncoding;
    [manager setResponseSerializer:responseSerializer];
    
    return manager;
}

@end
