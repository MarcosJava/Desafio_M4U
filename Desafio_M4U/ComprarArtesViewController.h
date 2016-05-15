//
//  ComprarArtesViewController.h
//  Desafio_M4U
//
//  Created by Marcos Felipe Souza on 12/05/16.
//  Copyright © 2016 Marcos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellCompraArte.h"

@interface ComprarArtesViewController : UITableViewController

//Apenas as imagens
@property (retain, nonatomic) NSMutableArray *imagens;

//Elementos do Rest
@property (retain, nonatomic) NSArray *elementos;


@end
