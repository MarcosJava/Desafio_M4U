//
//  CarrinhoAddViewController.h
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 19/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Produto.h"

@protocol CarrinhoAddViewControllerDelegate <NSObject>
@required
- (void) adicionadoAoCarrinho:(BOOL) adicionado oProduto:(Produto*) produto;
@end

@interface CarrinhoAddViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imagemArte;
@property (weak, nonatomic) IBOutlet UILabel *nomeArte;
@property (weak, nonatomic) IBOutlet UILabel *valorArte;

- (IBAction)addCarrinho:(id)sender;

- (IBAction)cancelar:(id)sender;


//DELEGATE
@property (weak) id<CarrinhoAddViewControllerDelegate> delegate;



//PROPRIEDADE DA CLASSE
@property (strong) Produto *produto;
@property (strong) UIImage *imagemCarregada;


@end
