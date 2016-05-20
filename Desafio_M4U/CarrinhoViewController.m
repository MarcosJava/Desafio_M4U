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
    
    NSString *valorString = [[NSString alloc] initWithFormat:@"R$ %0.2f",[_produtoBusiness valorTotalCarrinho]];
    self.valor.text = valorString;
    
    NSString *qtdeItemString = [[NSString alloc] initWithFormat:@"%ld",(long)[self.produtoBusiness qtdeCarrinho]];
    self.qtdeItem.text = qtdeItemString;
    
    [self.tableView reloadData];

}




- (IBAction)finalizarCompras:(id)sender {
    
    //TODO: Sheet tem certeza ?
    //TODO: Salvar a entidade de relacoes onde 1 pessoa e N produtos
    
    
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
    Produto *produto = [_produtoBusiness buscarCarrinhoComIndice:indexPath.row];
    
    //TODO: por o valor do item
    cell.textLabel.text = produto.nome;
    cell.imageView.layer.cornerRadius = 5.0;
    return cell;
}
@end
