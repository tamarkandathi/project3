//
//  DataAccessObject.m
//  NavCtrl
//
//  Created by Tamar on 10/7/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "DataAccessObject.h"
#import "Company.h"
#import "Product.h"
#import "qcdDemoAppDelegate.h"
#import <sqlite3.h>

NSString *downloadStockPricesNotification = @"downloadStockPricesNotification";

@interface DataAccessObject ()

@end

@implementation DataAccessObject

+(instancetype)sharedDataAccessObject
{
    static dispatch_once_t cp_singleton_once_token;
    static DataAccessObject *sharedDataAccessObject;
    
    dispatch_once(&cp_singleton_once_token, ^{
        sharedDataAccessObject = [[self alloc] init];
    });
    return sharedDataAccessObject;
}

-(void) swapCompanies:(Company*) companyA :(Company*) companyB {
    Company *buffer = [[Company alloc] init];
    buffer.companyName = companyA.companyName;
    buffer.companyLogo = companyA.companyLogo;
    buffer.companyStockCode = companyA.companyStockCode;
    buffer.ID = companyA.ID;
    char *error;
    sqlite3 *companiesDB;
    const char *databasePath = [[self getDatabasePath] UTF8String];
    
    if (sqlite3_open(databasePath, &companiesDB) == SQLITE_OK) {
        NSString *updateA  = [NSString stringWithFormat:@"UPDATE companies SET company_name = '%s', company_logo = '%s', company_stockcode = '%s'  WHERE id = '%d'", [companyB.companyName UTF8String], [companyB.companyLogo UTF8String], [companyB.companyStockCode UTF8String], companyA.ID];
        const char *updateAStatement = [updateA UTF8String];
        if (sqlite3_exec(companiesDB, updateAStatement, NULL, NULL, &error) == SQLITE_OK) {
        
        }
        NSString *updateB  = [NSString stringWithFormat:@"UPDATE companies SET company_name = '%s', company_logo = '%s', company_stockcode = '%s'  WHERE id = '%d'", [buffer.companyName UTF8String], [buffer.companyLogo UTF8String], [buffer.companyStockCode UTF8String], companyB.ID];
        const char *updateBStatement = [updateB UTF8String];
        if (sqlite3_exec(companiesDB, updateBStatement, NULL, NULL, &error) == SQLITE_OK) {
        }
    
        NSString *productsA = [NSString stringWithFormat:@"UPDATE products SET company_id = '%d' WHERE company_id == '%d'",0, companyA.ID];
        const char *productsAStatement = [productsA UTF8String];
        if (sqlite3_exec(companiesDB, productsAStatement, NULL, NULL, &error) == SQLITE_OK) {
        }
        
        NSString *productsB = [NSString stringWithFormat:@"UPDATE products SET company_id = '%d' WHERE company_id == '%d'",companyA.ID, companyB.ID];
        const char *productsBStatement = [productsB UTF8String];
        if (sqlite3_exec(companiesDB, productsBStatement, NULL, NULL, &error) == SQLITE_OK) {
        }
        
        NSString *productsTemp = [NSString stringWithFormat:@"UPDATE products SET company_id == '%d' WHERE company_id == '%d'",companyB.ID, 0];
        const char *productsTempStatement = [productsTemp UTF8String];
        if (sqlite3_exec(companiesDB, productsTempStatement, NULL, NULL, &error) == SQLITE_OK) {
        }
    }
    
    sqlite3_close(companiesDB);
    [buffer release];
    
}

-(void) swapProducts:(Product*) productA :(Product*) productB {
    Product *buffer = [[Product alloc] init];
    buffer.productName = productA.productName;
    buffer.productLogo = productA.productLogo;
    buffer.productUrl = productA.productUrl;
    buffer.ID = productA.ID;
    
    char *error;
    sqlite3 *companiesDB;
    const char *databasePath = [[self getDatabasePath] UTF8String];
    
    if (sqlite3_open(databasePath, &companiesDB) == SQLITE_OK) {
        NSString *updateA  = [NSString stringWithFormat:@"UPDATE products SET product_name = '%s', product_logo = '%s', product_url = '%s'  WHERE id = '%d'", [productB.productName UTF8String], [productB.productLogo UTF8String], [productB.productUrl UTF8String], productA.ID];
        const char *updateAStatement = [updateA UTF8String];
        if (sqlite3_exec(companiesDB, updateAStatement, NULL, NULL, &error) == SQLITE_OK) {
        }
        NSString *updateB  = [NSString stringWithFormat:@"UPDATE products SET product_name = '%s', product_logo = '%s', product_url = '%s'  WHERE id = '%d'", [buffer.productName UTF8String], [buffer.productLogo UTF8String], [buffer.productUrl UTF8String], productB.ID];
        const char *updateBStatement = [updateB UTF8String];
        if (sqlite3_exec(companiesDB, updateBStatement, NULL, NULL, &error) == SQLITE_OK) {
        }
    }
    sqlite3_close(companiesDB);
    [buffer release];
    
}

-(void) addCompany: (Company*) company{
    
    char *error;
    sqlite3 *companiesDB;
    const char *databasePath = [[self getDatabasePath] UTF8String];
    
    if (sqlite3_open(databasePath, &companiesDB) == SQLITE_OK) {
        NSString *insert = [NSString stringWithFormat:@"INSERT INTO companies (company_name, company_logo, company_stockcode) VALUES ('%s', '%s', '%s')",[company.companyName UTF8String], [company.companyLogo UTF8String], [company.companyStockCode UTF8String]];
        const char *insertStatement = [insert UTF8String];
        
        if (sqlite3_exec(companiesDB, insertStatement, NULL, NULL, &error) == SQLITE_OK) {
            company.ID = (int) sqlite3_last_insert_rowid(companiesDB);
        }
    }
    sqlite3_close(companiesDB);
    [self.companies addObject:company];
    
}

-(void) deleteCompany:(Company *) company {
    char *error;
    sqlite3 *companiesDB;
    const char *databasePath = [[self getDatabasePath] UTF8String];
    
    if (sqlite3_open(databasePath, &companiesDB) == SQLITE_OK) {
        NSString *deleteProducts = [NSString stringWithFormat:@"DELETE FROM products WHERE company_id == '%d'",company.ID];
        const char *deleteProductsStatement  = [deleteProducts UTF8String];
        if (sqlite3_exec(companiesDB, deleteProductsStatement, NULL, NULL, &error) == SQLITE_OK) {

        }
            NSString *deleteComp = [NSString stringWithFormat:@"DELETE FROM companies WHERE id == '%d'", company.ID];
            const char *deleteCompany = [deleteComp UTF8String];
            if (sqlite3_exec(companiesDB, deleteCompany, NULL, NULL, &error) == SQLITE_OK) {
            }
    }
    
    sqlite3_close(companiesDB);
    [self.companies removeObject:company];
    
}

-(void) editCompany:(Company *) company atIndex: (NSIndexPath*) indexPath {
    char *error;
    sqlite3 *companiesDB;
    const char *databasePath = [[self getDatabasePath] UTF8String];
    
    if (sqlite3_open(databasePath, &companiesDB) == SQLITE_OK) {
        NSString *updateCompany  = [NSString stringWithFormat:@"UPDATE companies SET company_name = '%s', company_logo = '%s', company_stockcode = '%s'  WHERE id = '%d'", [company.companyName UTF8String], [company.companyLogo UTF8String], [company.companyStockCode UTF8String], company.ID];
        const char *updateCompanyStatement = [updateCompany UTF8String];
        if (sqlite3_exec(companiesDB, updateCompanyStatement, NULL, NULL, &error) == SQLITE_OK) {
        }
    }

    sqlite3_close(companiesDB);
    [self.companies replaceObjectAtIndex:indexPath.row withObject:company];
    
}


-(void)addProduct:(Product *)product toCompany:(Company *)company {
    
    char *error;
    sqlite3 *companiesDB;
    const char *databasePath = [[self getDatabasePath] UTF8String];
    
    if (sqlite3_open(databasePath, &companiesDB) == SQLITE_OK) {
        NSString *insertProduct = [NSString stringWithFormat:@"INSERT INTO products (company_id, product_name, product_logo, product_url) VALUES ('%d','%s', '%s', '%s')",company.ID,[product.productName UTF8String], [product.productLogo UTF8String], [product.productUrl UTF8String]];
        const char *insertProductStatement  = [insertProduct UTF8String];
        if (sqlite3_exec(companiesDB, insertProductStatement, NULL, NULL, &error) == SQLITE_OK) {
            product.ID = (int) sqlite3_last_insert_rowid(companiesDB);
        }
    }
    sqlite3_close(companiesDB);
    [company.companyProducts addObject:product];
}


-(void) deleteProduct:(Product*) product atIndexPath:(NSIndexPath*) indexPath forCompany:(Company*) company {
    char *error;
    sqlite3 *companiesDB;
    const char *databasePath = [[self getDatabasePath] UTF8String];
    
    if (sqlite3_open(databasePath, &companiesDB) == SQLITE_OK) {
        NSString *deleteProduct = [NSString stringWithFormat:@"DELETE FROM products WHERE id == '%d'", product.ID];
        const char *deleteProductStatement  = [deleteProduct UTF8String];
        if (sqlite3_exec(companiesDB, deleteProductStatement, NULL, NULL, &error) == SQLITE_OK) {
        }
    }
    
    sqlite3_close(companiesDB);
    [company.companyProducts removeObjectAtIndex:indexPath.row];

}

-(NSMutableArray *)getAllProductsForCompany:(Company *)company {
    
    return company.companyProducts;
}

-(void)editProduct:(Product *)product atIndexPath:(NSIndexPath *)indexPath forCompany:(Company *)company {
    char *error;
    sqlite3 *companiesDB;
    const char *databasePath = [[self getDatabasePath] UTF8String];
    
    if (sqlite3_open(databasePath, &companiesDB) == SQLITE_OK) {
        NSString *updateProduct  = [NSString stringWithFormat:@"UPDATE products SET product_name = '%s', product_logo = '%s', product_url = '%s' WHERE id == '%d'", [product.productName UTF8String], [product.productLogo UTF8String], [product.productUrl UTF8String], product.ID];
        const char *updateProductCString = [updateProduct UTF8String];
        if (sqlite3_exec(companiesDB, updateProductCString, NULL, NULL, &error) == SQLITE_OK) {
        }
    }
    sqlite3_close(companiesDB);
    [company.companyProducts replaceObjectAtIndex:indexPath.row withObject:product];
    
}

-(void) downloadStockPrices {
    NSString *stockCodesURL = @"";

    for(int i = 0;i < self.companies.count;i++) {
        Company *company = [self.companies objectAtIndex:i];
        stockCodesURL = [stockCodesURL stringByAppendingString:company.companyStockCode];
        if (i != [self.companies count] - 1) {
            stockCodesURL = [stockCodesURL stringByAppendingString:@"+"];
        }
    }
    
    stockCodesURL = [NSString stringWithFormat:@"http://finance.yahoo.com/d/quotes.csv?s=%@&f=a",stockCodesURL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:stockCodesURL] completionHandler:
                                      ^(NSData *data, NSURLResponse *response, NSError *error){
                                          if (!error) {
                                              NSString *stocks = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                                              NSMutableArray *companyStockPrices = (NSMutableArray*)[stocks componentsSeparatedByString:@"\n"];
                                              [companyStockPrices removeLastObject];
                                              
                                              for (int i = 0; i < self.companies.count; i++) {
                                                  Company *company = [self.companies objectAtIndex:i];
                                                  if (companyStockPrices[i] != nil) {
                                                      company.companyStockPrice = companyStockPrices[i];
                                                  } else {
                                                      company.companyStockPrice = @"N/A";
                                                  }
                                              }
                                              [[NSNotificationCenter defaultCenter] postNotificationName:downloadStockPricesNotification object: self];
                                              [stocks release];
                                              
                                          } else {
                                              NSLog(@"%@", error.userInfo);
                                          }
                                      }];
        [dataTask resume];
}

-(NSMutableArray*)retrieveData {
    self.companies = [[[NSMutableArray alloc] init] autorelease];
    sqlite3 *companiesDB;
    const char *databasePath = [[self getDatabasePath] UTF8String];
    sqlite3_stmt *statementCompanies;
    sqlite3_stmt *statementProducts;
    
    if (sqlite3_open(databasePath, &companiesDB) == SQLITE_OK) {
        NSString *companiesQuery  = [NSString stringWithFormat:@"SELECT * FROM companies"];
        const char *companiesQueryCString = [companiesQuery UTF8String];
        
        if (sqlite3_prepare(companiesDB, companiesQueryCString, -1, &statementCompanies, NULL) == SQLITE_OK) {
    
            while (sqlite3_step(statementCompanies) == SQLITE_ROW) {
                Company *company = [[Company alloc]init];
                company.companyProducts = [[[NSMutableArray alloc]init] autorelease];
                company.companyName = [NSString stringWithUTF8String:(const char*) sqlite3_column_text(statementCompanies, 1)];
                company.companyLogo = [NSString stringWithUTF8String:(const char*) sqlite3_column_text(statementCompanies, 2)];
                company.companyStockCode = [NSString stringWithUTF8String:(const char*) sqlite3_column_text(statementCompanies,3)];
                NSString *companyIDString = [NSString stringWithUTF8String:(const char*) sqlite3_column_text(statementCompanies,0)];
                company.ID = (int)[companyIDString integerValue];
                
                NSString *productsQuery  = [NSString stringWithFormat:@"SELECT * FROM products WHERE company_id = '%d'",company.ID];
                const char *productsQueryCString = [productsQuery UTF8String];
                if (sqlite3_prepare(companiesDB, productsQueryCString, -1, &statementProducts, NULL) == SQLITE_OK) {
                    
                    while (sqlite3_step(statementProducts) == SQLITE_ROW) {
                        Product *product = [[Product alloc]init];
                        product.productName = [NSString stringWithUTF8String:(const char*) sqlite3_column_text(statementProducts, 1)];
                        product.productLogo = [NSString stringWithUTF8String:(const char*) sqlite3_column_text(statementProducts, 2)];
                        product.productUrl = [NSString stringWithUTF8String:(const char*) sqlite3_column_text(statementProducts, 3)];
                        NSString *productIDString = [NSString stringWithUTF8String:(const char*) sqlite3_column_text(statementProducts,4)];
                        product.ID = (int) [productIDString integerValue];
                        product.companyID = company.ID;
                        [company.companyProducts addObject:product];
                        [product release];
                    }
                }
                [self.companies addObject:company];
                [company release];
                sqlite3_finalize(statementProducts);
            }
            sqlite3_finalize(statementCompanies);
        }
    }
    
    sqlite3_close(companiesDB);
    return self.companies;
}

-(NSString*) getDatabasePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *destinationPath = [documentsDirectoryPath stringByAppendingPathComponent:@"NavModel.db"];
    NSError *error = nil;
    if ([fileManager fileExistsAtPath:destinationPath] == NO) {
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"NavModel.db"];
        [fileManager copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        }
    }
    NSLog(@"%@",destinationPath);
    return destinationPath;
}

@end
