//
//  AbstractViewController.h
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 20/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProdutoBusiness.h"
#import "Pessoa.h"
#import "UsuarioSessao.h"
#import "PessoaBusiness.h"

@interface AbstractViewController : UIViewController

@property ProdutoBusiness *produtoBusiness;
@property UsuarioSessao *usuarioSessao;
-(void) alterarBagdeCarrinho;
-(void) addPessoaSessao:(NSString*) email;
-(Pessoa *) getPessoaSessao;


@end
