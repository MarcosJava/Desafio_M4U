//
//  CarrinhoViewController.h
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 19/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProdutoBusiness.h"
#import "AbstractViewController.h"

@interface CarrinhoViewController : AbstractViewController<UITableViewDataSource, UITableViewDelegate>

//PROPRIEDADE VIEW
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *qtdeItem;
@property (weak, nonatomic) IBOutlet UILabel *valor;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editarBtn;
- (IBAction)finalizarCompras:(id)sender;
- (IBAction)editar:(id)sender;



//PROPRIEDADE CLASSE
@property(strong, nonatomic) ProdutoBusiness *produtoBusiness;
@end
