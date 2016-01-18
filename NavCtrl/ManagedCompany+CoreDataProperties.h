//
//  ManagedCompany+CoreDataProperties.h
//  NavCtrl
//
//  Created by Tamar on 1/14/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ManagedCompany.h"

NS_ASSUME_NONNULL_BEGIN

@interface ManagedCompany (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *companyLogo;
@property (nullable, nonatomic, retain) NSString *companyName;
@property (nullable, nonatomic, retain) NSString *companyStockCode;
@property (nullable, nonatomic, retain) NSSet<ManagedProduct *> *managedCompanyProducts;

@end

@interface ManagedCompany (CoreDataGeneratedAccessors)

- (void)addManagedCompanyProductsObject:(ManagedProduct *)value;
- (void)removeManagedCompanyProductsObject:(ManagedProduct *)value;
- (void)addManagedCompanyProducts:(NSSet<ManagedProduct *> *)values;
- (void)removeManagedCompanyProducts:(NSSet<ManagedProduct *> *)values;

@end

NS_ASSUME_NONNULL_END
