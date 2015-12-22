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
        [[NSNotificationCenter defaultCenter] addObserver:sharedDataAccessObject selector:@selector(saveData) name: UIApplicationDidEnterBackgroundNotification object:nil];
    });
    return sharedDataAccessObject;
}

-(NSMutableArray *)getAllProductsForCompany:(Company *)company {
    NSMutableArray *products = [[NSMutableArray alloc] init];
    products = company.companyProducts;
    return products;
}

-(void)editProduct:(Product *)product atIndex:(NSIndexPath *)indexPath fromCompany:(Company *)company {
    [company.companyProducts replaceObjectAtIndex:indexPath.row withObject:product];
}
-(void)addNewProduct:(Product *)product toCompany:(Company *)company {
    [company.companyProducts addObject:product];
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
                                              
                                          } else {
                                              NSLog(@"%@", error.userInfo);
                                              //display an alert here
                                          }
                                      }];
        [dataTask resume];
}

-(NSMutableArray*)retrieveData {
    self.companies = [[NSMutableArray alloc] init];
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
                company.companyProducts = [[NSMutableArray alloc]init];
                company.companyName = [NSString stringWithUTF8String:(const char*) sqlite3_column_text(statementCompanies, 1)];
                company.companyLogo = [NSString stringWithUTF8String:(const char*) sqlite3_column_text(statementCompanies, 2)];
                company.companyStockCode = [NSString stringWithUTF8String:(const char*) sqlite3_column_text(statementCompanies,3)];
                NSString *companyIdString = [NSString stringWithUTF8String:(const char*) sqlite3_column_text(statementCompanies,0)];
                int company_id = (int)[companyIdString integerValue];
                
                NSString *productsQuery  = [NSString stringWithFormat:@"SELECT * FROM products WHERE company_id = %d",company_id];
                const char *productsQueryCString = [productsQuery UTF8String];
                
                if (sqlite3_prepare(companiesDB, productsQueryCString, -1, &statementProducts, NULL) == SQLITE_OK) {
                    
                    while (sqlite3_step(statementProducts) == SQLITE_ROW) {
                        Product *product = [[Product alloc]init];
                        product.productName = [NSString stringWithUTF8String:(const char*) sqlite3_column_text(statementProducts, 1)];
                        product.productLogo = [NSString stringWithUTF8String:(const char*) sqlite3_column_text(statementProducts, 2)];
                        product.productUrl = [NSString stringWithUTF8String:(const char*) sqlite3_column_text(statementProducts, 3)];
                        [company.companyProducts addObject:product];
                    }
                }
                [self.companies addObject:company];
            }
        }
    }
    sqlite3_close(companiesDB);
    return self.companies;
}

-(void) saveData {
    NSLog(@"%@", self.companies);
    char *error;
    sqlite3 *companiesDB;
    const char *databasePath = [[self getDatabasePath] UTF8String];
    if (sqlite3_open(databasePath, &companiesDB) == SQLITE_OK) {
        NSString *companyString = [NSString stringWithFormat:@"DELETE FROM companies"];
        NSString *productString = [NSString stringWithFormat:@"DELETE FROM products"];
        const char *deleteCompaniesStatement = [companyString UTF8String];
        const char *deleteProductsStatement = [productString UTF8String];
        
        if (sqlite3_exec(companiesDB, deleteCompaniesStatement, NULL, NULL, &error) == SQLITE_OK) {
            if (sqlite3_exec(companiesDB, deleteProductsStatement, NULL, NULL, &error) == SQLITE_OK) {
                for (int i = 0; i < self.companies.count; i++) {
                    Company *company = [self.companies objectAtIndex:i];
                    companyString = [NSString stringWithFormat:@"INSERT INTO companies (company_name, company_logo, company_stockcode) VALUES ('%@', '%@', '%@')", company.companyName, company.companyLogo, company.companyStockCode];
                    const char *insertCompanyStatement = [companyString UTF8String];
                    if (sqlite3_exec(companiesDB, insertCompanyStatement, NULL, NULL, &error) == SQLITE_OK) {
                        for (int j = 0; j < company.companyProducts.count; j++) {
                            Product *product = [company.companyProducts objectAtIndex:j];
                            productString = [NSString stringWithFormat:@"INSERT INTO products (company_id, product_name, product_logo, product_url) VALUES (%d, '%@', '%@', '%@')",(i+1), product.productName, product.productLogo, product.productUrl];
                            const char *insertProductStatement = [productString UTF8String];
                            if (sqlite3_exec(companiesDB, insertProductStatement, NULL, NULL, &error) == SQLITE_OK) {
                            }
                        }
                    }
                }
            }
        }
    }
    sqlite3_close(companiesDB);
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
    return destinationPath;
}
-(void)dealloc {
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];

}
@end
