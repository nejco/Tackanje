//
//  ObiskovaniPredmeti+CoreDataProperties.h
//  
//
//  Created by Nejc Vidrih on 23. 01. 16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ObiskovaniPredmeti.h"

NS_ASSUME_NONNULL_BEGIN

@interface ObiskovaniPredmeti (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *povezava;
@property (nullable, nonatomic, retain) NSString *dodatneInformacije;
@property (nullable, nonatomic, retain) NSString *imePredmeta;
@property (nullable, nonatomic, retain) NSSet<ObiskovaneSeje *> *seje;

@end

@interface ObiskovaniPredmeti (CoreDataGeneratedAccessors)

- (void)addSejeObject:(ObiskovaneSeje *)value;
- (void)removeSejeObject:(ObiskovaneSeje *)value;
- (void)addSeje:(NSSet<ObiskovaneSeje *> *)values;
- (void)removeSeje:(NSSet<ObiskovaneSeje *> *)values;

@end

NS_ASSUME_NONNULL_END
