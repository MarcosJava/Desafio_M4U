//
//  Pessoa.h
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 09/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Pessoa : NSManagedObject

@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *senha;

@end
