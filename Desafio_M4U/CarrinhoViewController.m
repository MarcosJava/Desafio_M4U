//
//  CarrinhoViewController.m
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 19/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import "CarrinhoViewController.h"

@interface CarrinhoViewController ()

@end

@implementation CarrinhoViewController

static NSString *tituloSheet = @"Tem certeza ?";
static NSString *mensagemSheet = @"Escolha a opção";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.produtoBusiness = [ProdutoBusiness new];
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [self popularView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)popularView {
    
    NSString *valorString = [[NSString alloc] initWithFormat:@"R$ %0.2f",[self.produtoBusiness valorTotalCarrinho]];
    self.valor.text = valorString;
    
    NSString *qtdeItemString = [[NSString alloc] initWithFormat:@"%ld",(long)[self.produtoBusiness qtdeCarrinho]];
    self.qtdeItem.text = qtdeItemString;
    
    [self.tableView reloadData];

}




- (IBAction)finalizarCompras:(id)sender {
    
    if ([self.produtoBusiness qtdeCarrinho] > 0) {
        [self ativarSheet];
    } else {
        [self exibirAlertaComTitulo:@"Atenção" eComMensagem:@"Não contém dados no carrinho !"];
    }

    
}


-(void) exibirAlertaComTitulo: (NSString *) titulo eComMensagem: (NSString *) mensagem {
    UIAlertController *alerta = [UIAlertController alertControllerWithTitle:titulo message:mensagem preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    
    [alerta addAction:ok];
    
    [self presentViewController:alerta animated:YES completion:nil];
}


-(void) ativarSheet{
    UIAlertController* sheet = [UIAlertController alertControllerWithTitle:tituloSheet
     message:mensagemSheet preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *actionSim = [UIAlertAction actionWithTitle:@"Sim"
       style:UIAlertActionStyleDefault
    handler:^(UIAlertAction * action) {
    
    
    }];
    
    UIAlertAction *actionNao = [UIAlertAction actionWithTitle:@"Não"
                                                            style:UIAlertActionStyleDestructive
                                                          handler:nil];
    
    [sheet addAction:actionSim];
    [sheet addAction:actionNao];
    
    [self presentViewController:sheet animated:YES completion:nil];
}

- (IBAction)editar:(id)sender {
    
    if ([self.editarBtn.title isEqualToString:@"Editar"]) {
        
        //Com animacao joga para o metodo de commitEditingStyle
        [self.tableView setEditing:YES animated:YES];
        self.editarBtn.title = @"Feito";
        
    } else {
        
        [self.tableView setEditing:NO animated:YES];
        self.editarBtn.title = @"Editar";
    }
    
}


#pragma mark - TableView

//Remocao
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.produtoBusiness removeCarrinhosNoIndice:indexPath.row];
    [super alterarBagdeCarrinho];
    [self popularView];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Vai excluir ?";
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger qtd = [self.produtoBusiness qtdeCarrinho];
    return qtd;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"CellCarrinho";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    Produto *produto = [self.produtoBusiness buscarCarrinhoComIndice:indexPath.row];
    
    //TODO: por o valor do item
    cell.textLabel.font = [UIFont fontWithName:@"Avenir Next" size:13];
    cell.textLabel.text = produto.nome;
    cell.imageView.layer.cornerRadius = 5.0;
    return cell;
}
@end
