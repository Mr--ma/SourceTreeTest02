//
//  ViewController.m
//  归解档
//
//  Created by mr.ma on 2018/10/26.
//  Copyright © 2018年 Marvin.ma. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self objArchiver];
    [self customContentArchive];
    
}
- (void)objArchiver
{
    //归档(序列化)
    NSArray *archiver = @[
                          @{@"name" : @"Lisan"},
                          @{@"sex" : @"M"}
                          ];
    
    NSString *filePath = [self filePathWithName:@"Objc"];
    if ([NSKeyedArchiver archiveRootObject:archiver toFile:filePath]) {
        NSLog(@"归档成功");
    }
    //解归档(反序列化)
    NSArray *unArchiver = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    NSLog(@"解归档成功");
    
    //优点：归档和解档操作步骤简单方便
    //缺点:一次只能归档一个对象，如果归档多个对象，需要分开麻烦，操作繁琐费时
    
    
}
- (void)customContentArchive
{
    //归档
    //1、使用Data存放归档数据
    NSMutableData *archiveData = [NSMutableData data];
    //2、根据Data实例创建和初始化归档对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:archiveData];
    //3、添加归档内容(添加键值对)
    [archiver encodeObject:@"name" forKey:@"ZhangSan"];
    [archiver encodeObject:@"sex" forKey:@"M"];
    //4、完成归档
    [archiver finishEncoding];
    //5、将归档的数据存到磁盘上
    NSString *filePath = [self filePathWithName:@"CustomContent"];
    if ([archiveData writeToFile:filePath atomically:YES ]) {
        NSLog(@"归档成功");
    }
    
    
    //解归档
    //1、从磁盘读取文件，生成Data对象
    NSData *unArchiveData = [NSData dataWithContentsOfFile:filePath];
    //2、根据Data实例创建和初始化归档对象
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:unArchiveData];
    //3、解归档，根据键值对访问
    NSString *name = [unArchiver decodeObjectForKey:@"name"];
    NSString *sex = [unArchiver decodeObjectForKey:@"sex"];
    NSLog(@"解归档成功\n sname = %@\n ssex = %@",name,sex);
    //4、完成解归档
    [unArchiver finishDecoding];
    
    
    
    
}
- (NSString *)filePathWithName:(NSString *)name
{
    name = [[NSString alloc] initWithFormat:@"%@.archiver",name];
    //归档后的文件是加密的，所以归档文件的扩展名可以随意取,我这里后缀用archiver
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:name];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
