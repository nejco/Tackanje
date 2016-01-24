//
//  ObiskovaneSeje+CoreDataProperties.h
//  
//
//  Created by Nejc Vidrih on 23. 01. 16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ObiskovaneSeje.h"

NS_ASSUME_NONNULL_BEGIN

@interface ObiskovaneSeje (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *tema;
@property (nullable, nonatomic, retain) NSDate *datum;
@property (nullable, nonatomic, retain) ObiskovaniPredmeti *predmeti;

@end

NS_ASSUME_NONNULL_END
