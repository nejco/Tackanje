//
//  Obiskovalci+CoreDataProperties.h
//  
//
//  Created by Nejc Vidrih on 23. 01. 16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Obiskovalci.h"

NS_ASSUME_NONNULL_BEGIN

@interface Obiskovalci (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *priimek;
@property (nullable, nonatomic, retain) NSString *ime;
@property (nullable, nonatomic, retain) GostovaneSeje *seja;

@end

NS_ASSUME_NONNULL_END
