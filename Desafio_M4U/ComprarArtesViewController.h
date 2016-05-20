//
//  ComprarArtesViewController.h
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 12/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Produto.h"
#import "ProdutoBusiness.h"
#import "CarrinhoAddViewController.h"

@interface ComprarArtesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, CarrinhoAddViewControllerDelegate>

//Apenas as imagens
@property (retain, nonatomic) NSMutableArray *imagens;

//Elementos do Rest
@property (retain, nonatomic) NSArray *elementos;

@property(assign,nonatomic) BOOL semInternet;

@property (strong, nonatomic) ProdutoBusiness *produtoBusiness;
@property UIRefreshControl *refresh;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSInteger produtoSelecionado;

@end
