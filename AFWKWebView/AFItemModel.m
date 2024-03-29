//
//  AFItemModel.m
//  AFWKWebView
//
//  Created by Tiny on 2019/12/5.
//  Copyright © 2019 AFan. All rights reserved.
//

#import "AFItemModel.h"

@implementation AFItemModel

-(void)setTitle:(NSString *)title{
    self.width = 103;
}

-(BOOL)isEqual:(id)object{
    if (self == object) {
        return YES;
    }
    if ([object isKindOfClass:[self class]]) {
        AFItemModel *obj = (AFItemModel *)object;
        
        return self.width == obj.width &&
        [self.userImg isEqualToString:obj.userImg];
    }else{
        return NO;
    }
}

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
