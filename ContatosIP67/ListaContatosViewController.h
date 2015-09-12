//
//  ListaContatosViewController.h
//  ContatosIP67
//
//  Created by ios5436 on 05/09/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ContatoDao.h"

@interface ListaContatosViewController : UITableViewController

@property ContatoDao *dao;
@property Contato *contatoSelecionado;

@end
