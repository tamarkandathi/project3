//
//  DataAccessObject.m
//  NavCtrl
//
//  Created by Tamar on 10/7/15.
//  Copyright © 2015 Aditya Narayan. All rights reserved.
//

#import "DataAccessObject.h"


//do we need class category here?


@implementation DataAccessObject

+(instancetype)sharedInstance
{
    
    static dispatch_once_t cp_singleton_once_token;
    
    static DataAccessObject *sharedInstance;
    
    dispatch_once(&cp_singleton_once_token, ^{
        
        sharedInstance = [[self alloc] init];
        
    });
    
    return sharedInstance;
    
}

-(void)loadData {
    // Dispose of any resources that can be recreated.
    Company *apple = [[Company alloc]init];
    Company *samsung = [[Company alloc]init];
    Company *motorola = [[Company alloc]init];
    Company *htc = [[Company alloc]init];
    
    
    // Company APPLE
    
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
    iPodTouch.productLogo = @"iPodTouch.jpeg";
    iPodTouch.productUrl = @"https://www.apple.com/ipod/";
    
    iPhone.productLogo = @"iPhone.jpeg";
    iPhone.productName = @"iPhone";
    iPhone.productUrl = @"https://www.apple.com/iphone/";
    
    apple.companyProducts = [NSMutableArray arrayWithObjects:iPad,iPodTouch,iPhone, nil];
    
    
    // Company Samsung
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
    
    
    // Company MOTO
    
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
    
    
    
    // Company HTC
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
    
    self.companies = [@[apple, samsung, motorola, htc] mutableCopy];
    
}


-(void)updateStockPrices {
    
    for(int i = 0;i < [self.companies count];i++) {
        [self.companies[i] setCompanyStockPrice:self.companyStockPrices[i]];
    }
}

-(void) archiveObjects:(NSString*) filepath {
    
    
    [NSKeyedArchiver archiveRootObject:self.companies toFile:filepath];
    
}

-(NSString*) getPropertyListPath {
    NSURL *docDirectory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL *plist = [docDirectory URLByAppendingPathComponent:@"companies.plist"];
    NSLog(@"%@",plist.path);
    self.plistPath=plist.path;
    return plist.path;
    
}

-(void)save{
    [self archiveObjects:self.plistPath];
}
-(void) unarchiveSavedObjects: (NSString *)filePath {
    self.companies = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"%@",self.companies);
    for (int i = 0; i < [self.companies count]; i++) {
        NSLog(@"For Company Name = %@",[[self.companies objectAtIndex:i] companyName]);
    }
    NSLog(@"Unarchive");
}


-(void) loadCompanies {
    NSString *filePath = [self getPropertyListPath];
    NSLog(@"%@",filePath);
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [self unarchiveSavedObjects:filePath];
    }
    else {
        [self loadData];
        [self archiveObjects: filePath];
   }
}


@end
