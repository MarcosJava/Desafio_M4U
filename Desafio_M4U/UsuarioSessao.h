//
//  UsuarioSessao.h
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 20/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UsuarioSessao : NSObject

@property(strong, readonly) NSString *email;
+(id) instanciar ;
@end
