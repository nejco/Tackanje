//
//  GostovaneSeje+CoreDataProperties.h
//  
//
//  Created by Nejc Vidrih on 23. 01. 16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "GostovaneSeje.h"

NS_ASSUME_NONNULL_BEGIN

@interface GostovaneSeje (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *tema;
@property (nullable, nonatomic, retain) NSDate *datum;
@property (nullable, nonatomic, retain) GostovaniPredmeti *predmet;
@property (nullable, nonatomic, retain) NSSet<Obiskovalci *> *obiskovalci;

@end

@interface GostovaneSeje (CoreDataGeneratedAccessors)

- (void)addObiskovalciObject:(Obiskovalci *)value;
- (void)removeObiskovalciObject:(Obiskovalci *)value;
- (void)addObiskovalci:(NSSet<Obiskovalci *> *)values;
- (void)removeObiskovalci:(NSSet<Obiskovalci *> *)values;

@end

NS_ASSUME_NONNULL_END
