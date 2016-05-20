//
//  Produto.h
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 15/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Produto : NSManagedObject

@property(nonatomic,retain) NSString *nome;
@property float valor;

-(id) initComNome: (NSString *)nome eComValor: (float) valor;

@end
