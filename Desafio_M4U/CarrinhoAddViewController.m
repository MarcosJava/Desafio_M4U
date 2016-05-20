//
//  CarrinhoAddViewController.m
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 19/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import "CarrinhoAddViewController.h"

@interface CarrinhoAddViewController ()

@end

@implementation CarrinhoAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self popularView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (IBAction)addCarrinho:(id)sender {
    [self colocarNoCarrinho:YES];
}

- (IBAction)cancelar:(id)sender {
    [self colocarNoCarrinho:NO];
}



-(void) popularView {
    if (_produto) {
        self.nomeArte.text = _produto.nome;
        NSString *valor = [[NSString alloc] initWithFormat:@"VALOR: R$ %0.2f", _produto.valor];
        self.valorArte.text = valor ;
        self.imagemArte.image = _imagemCarregada;
    }
    
}

-(void) colocarNoCarrinho:(BOOL) coloca {
    
    if(self.delegate) {
        [self.delegate adicionadoAoCarrinho:coloca oProduto:_produto];
    }
    [self.navigationController popViewControllerAnimated:YES]; //Atualiza a view
    
}
@end
