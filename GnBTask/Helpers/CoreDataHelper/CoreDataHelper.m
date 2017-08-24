//
//  CoreDataHelper.m
//  GnBTask
//
//  Created by Medhat Mohamed on 8/22/17.
//  Copyright © 2017 Medhat Mohamed. All rights reserved.
//

#import "CoreDataHelper.h"

@implementation CoreDataHelper


+(BOOL) isInCart:(NSNumber *) productId
{
    AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = ad.persistentContainer.viewContext;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CDProduct" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    request.predicate = [NSPredicate predicateWithFormat:@"productId == %@",productId];
    NSError *error;
    NSArray * dataArray = [[moc executeFetchRequest:request error:&error] mutableCopy];
    if (dataArray.count > 0) {
        return true;
    }
    return false;
}

+(void) addToProduct:(NSNumber *) productId
{
    AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = ad.persistentContainer.viewContext;
    
    CDProduct *newProduct = [NSEntityDescription insertNewObjectForEntityForName:@"CDProduct" inManagedObjectContext:moc];
    newProduct.productId = [productId intValue];
    
    NSError *error;
    if (![moc save:&error]) {
        NSLog(@"Error saving new color: %@", [error localizedDescription]);
    }
    else
    {
        NSLog(@"Saved");
    }
}

+(void)deleteProduct:(NSNumber *) productId
{
    AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = ad.persistentContainer.viewContext;
    NSEntityDescription *productEntity = [NSEntityDescription entityForName:@"CDProduct" inManagedObjectContext:moc];
    NSFetchRequest *fetch=[[NSFetchRequest alloc] init];
    [fetch setEntity:productEntity];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"productId == %@", productId];
    [fetch setPredicate:predicate];
    NSError *fetchError;
    NSArray *fetchedProducts=[moc executeFetchRequest:fetch error:&fetchError];
    for (NSManagedObject *product in fetchedProducts) {
        [moc deleteObject:product];
    }
    
    NSError *error;
    if (![moc save:&error]) {
        NSLog(@"Error saving new color: %@", [error localizedDescription]);
    }
    else
    {
        NSLog(@"Deleted");
    }
}

@end
