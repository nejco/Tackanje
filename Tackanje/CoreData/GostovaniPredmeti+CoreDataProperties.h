//
//  GostovaniPredmeti+CoreDataProperties.h
//  
//
//  Created by Nejc Vidrih on 23. 01. 16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "GostovaniPredmeti.h"

NS_ASSUME_NONNULL_BEGIN

@interface GostovaniPredmeti (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *imePredmeta;
@property (nullable, nonatomic, retain) NSString *dodatneInformacije;
@property (nullable, nonatomic, retain) NSString *povezava;
@property (nullable, nonatomic, retain) NSSet<GostovaneSeje *> *seja;

@end

@interface GostovaniPredmeti (CoreDataGeneratedAccessors)

- (void)addSejaObject:(GostovaneSeje *)value;
- (void)removeSejaObject:(GostovaneSeje *)value;
- (void)addSeja:(NSSet<GostovaneSeje *> *)values;
- (void)removeSeja:(NSSet<GostovaneSeje *> *)values;

@end

NS_ASSUME_NONNULL_END
