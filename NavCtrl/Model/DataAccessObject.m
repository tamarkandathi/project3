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
@implementation DataAccessObject

+(instancetype)sharedDataAccessObject
{
    static dispatch_once_t cp_singleton_once_token;
    static DataAccessObject *sharedDataAccessObject;
    
    dispatch_once(&cp_singleton_once_token, ^{
        sharedDataAccessObject = [[self alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:sharedDataAccessObject selector:@selector(saveDataToPlist) name: UIApplicationDidEnterBackgroundNotification object:nil];
    });
    return sharedDataAccessObject;
}

-(NSMutableArray *)getAllCompaniesAndProducts {
    
    
    Company *apple = [[Company alloc]init];
    Company *samsung = [[Company alloc]init];
    Company *motorola = [[Company alloc]init];
    Company *htc = [[Company alloc]init];
    
    //APPLE
    apple.companyName = @"Apple mobile devices";
    apple.companyLogo = @"AppleLogo.png";
    apple.companyStockCode = @"AAPL";
    
    Product *iPad = [[Product alloc] init];
    Product *iPodTouch = [[Product alloc] init];
    Product *iPhone = [[Product alloc] init];
    
    iPad.productName = @"iPad";
    iPad.productLogo = @"iPad.jpeg";
    iPad.productUrl = @"https://www.apple.com/ipad/";
    
    iPodTouch.productName = @"iPod Touch";
    iPodTouch.productLogo = @"  ";
    iPodTouch.productUrl = @"https://www.apple.com/ipod/";
    
    iPhone.productName = @"iPhone";
    iPhone.productLogo = @"iPhone.jpeg";
    iPhone.productUrl = @"https://www.apple.com/iphone/";
    
    apple.companyProducts = [NSMutableArray arrayWithObjects:iPad,iPodTouch,iPhone, nil];
    
    //Samsung
    samsung.companyName = @"Samsung mobile devices";
    samsung.companyLogo = @"SamsungLogo.jpeg";
    samsung.companyStockCode = @"005930.KS";
    
    Product *galaxyS4 = [[Product alloc]init];
    Product *galaxyNote = [[Product alloc]init];
    Product *galaxyTab = [[Product alloc]init];
    
    galaxyS4.productName = @"Galaxy S4";
    galaxyS4.productLogo = @"GalaxyS4.jpeg";
    galaxyS4.productUrl = @"http://www.samsung.com/us/mobile/cell-phones/SM-G928VZDAVZW";
    
    galaxyNote.productName = @"Galaxy Note";
    galaxyNote.productLogo = @"GalaxyNote.jpeg";
    galaxyNote.productUrl = @"http://www.samsung.com/us/mobile/cell-phones/all-products?filter=galaxy-note";
    
    galaxyTab.productName = @"Galaxy Tab";
    galaxyTab.productLogo = @"GalaxyTab.jpeg";
    galaxyTab.productUrl = @"http://www.samsung.com/us/mobile/galaxy-tab/";
    
    samsung.companyProducts = [NSMutableArray arrayWithObjects:galaxyS4, galaxyNote, galaxyTab, nil];
    
    //MOTOROLA
    motorola.companyName = @"Motorola mobile devices";
    motorola.companyLogo = @"MotorolaLogo.jpeg";
    motorola.companyStockCode = @"066570.KS";
    
    Product *droidTurbo = [[Product alloc] init];
    Product *droid3 = [[Product alloc]init];
    Product *droidMax = [[Product alloc]init];
    droidTurbo.productName = @"Droid Turbo";
    droidTurbo.productLogo = @"MotorolaDroidTurbo.jpeg";
    droidTurbo.productUrl = @"https://www.motorola.com/us/smartphones/droid-turbo/droid-turbo-pdp.html";
    
    droid3.productName = @"Droid 3";
    droid3.productLogo = @"MotorolaDroid3.jpeg";
    droid3.productUrl = @"https://www.motorola.com/us/DROID-3-BY-MOTOROLA/73138.html";
    
    droidMax.productName = @"Droid MAX";
    droidMax.productLogo = @"MotorolaDroidMAX.jpeg";
    droidMax.productUrl = @"https://www.motorola.com/us/smartphones/droid-maxx/m-droid-maxx.html";
    motorola.companyProducts = [NSMutableArray arrayWithObjects:droidTurbo, droid3, droidMax, nil];
    
    //HTC
    htc.companyName = @"HTC mobile devices";
    htc.companyLogo = @"HTCLogo.jpeg";
    htc.companyStockCode = @"2498.TW";
    
    Product *droidDna =[[Product alloc]init];
    Product *oneM8 = [[Product alloc]init];
    Product *desire816 = [[Product alloc]init];
    
    droidDna.productName = @"Droid DNA";
    droidDna.productLogo = @"HTCDroidDNA.jpeg";
    droidDna.productUrl = @"https://www.htc.com/us/smartphones/droid-dna-by-htc/";
    
    oneM8.productName = @"One M8";
    oneM8.productLogo = @"HTCOneM8.jpeg";
    oneM8.productUrl = @"https://www.htc.com/us/smartphones/htc-one-m8/";
    
    desire816.productName = @"Desire 816";
    desire816.productLogo = @"HTCDesire816.jpeg";
    desire816.productUrl = @"https://www.htc.com/us/smartphones/htc-desire-816/";
    
    htc.companyProducts = [NSMutableArray arrayWithObjects:droidDna, oneM8, desire816, nil];
    
    return self.companies = [@[apple, samsung, motorola, htc] mutableCopy];
}
-(NSMutableArray *)getAllProductsFromCompany:(Company *)company {
    NSMutableArray *products = [[NSMutableArray alloc] init];
    products = company.companyProducts;
    return products;
}
-(void)editProduct:(Product *)product atIndex:(NSIndexPath *)indexPath fromCompany:(Company *)company {
    [company.companyProducts replaceObjectAtIndex:indexPath.row withObject:product];
}
-(void)addNewProduct:(Product *)productNew toCompany:(Company *)company {
    [company.companyProducts addObject:productNew];
}
-(void) getStockPrices {
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
                                              
                                              
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  for (int i = 0; i < self.companies.count; i++) {
                                                      Company *company = [self.companies objectAtIndex:i];
                                                      if (companyStockPrices[i] != nil) {
                                                          company.companyStockPrice = companyStockPrices[i];
                                                      } else {
                                                          company.companyStockPrice = @"Not Available";
                                                      }
                                                  }
                                              });
                                              
                                              
                                          } else {
                                              NSLog(@"%@", error.userInfo);
                                              //will put an alert here for the user later
                                          }
                                      }];
        [dataTask resume];
}

-(void) saveDataToPlist {
    NSData *archivedCompaniesArray = [NSKeyedArchiver archivedDataWithRootObject:self.companies];
    NSString *filePath = [self getPlistFilePath];
    [archivedCompaniesArray writeToFile:filePath atomically: YES];
}

-(NSString*) getPlistFilePath {
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSURL *directory = [fileManager URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL *plistUrl = [directory URLByAppendingPathComponent:@"companies.plist"];
    NSLog(@"%@", plistUrl.path);
    return plistUrl.path;
}

-(NSMutableArray*) retrieveDataFromPlist {
    NSLog(@"method call");
    NSString *filePath  = [self getPlistFilePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *archivedCompaniesArray = [NSData dataWithContentsOfFile:filePath];
    if ([fileManager fileExistsAtPath:filePath] == NO) {
        NSLog(@"file does not exist");
        [self getAllCompaniesAndProducts];
        [self saveDataToPlist];
    } else {
        NSLog(@"file exists");
        self.companies = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:archivedCompaniesArray]];
        NSLog(@"%@", self.companies);
    }
    return self.companies;
}
-(void)dealloc {
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
}
@end
