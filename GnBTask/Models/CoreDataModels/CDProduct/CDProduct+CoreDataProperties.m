//
//  CDProduct+CoreDataProperties.m
//  GnBTask
//
//  Created by Medhat Mohamed on 8/21/17.
//  Copyright © 2017 Medhat Mohamed. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "CDProduct+CoreDataProperties.h"

@implementation CDProduct (CoreDataProperties)

+ (NSFetchRequest<CDProduct *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CDProduct"];
}

@dynamic productId;

@end
