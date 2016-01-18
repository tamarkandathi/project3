//
//  ManagedProduct+CoreDataProperties.h
//  NavCtrl
//
//  Created by Tamar on 1/14/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ManagedProduct.h"

NS_ASSUME_NONNULL_BEGIN

@interface ManagedProduct (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *productLogo;
@property (nullable, nonatomic, retain) NSString *productName;
@property (nullable, nonatomic, retain) NSString *productUrl;
@property (nullable, nonatomic, retain) ManagedCompany *managedCompany;

@end

NS_ASSUME_NONNULL_END
