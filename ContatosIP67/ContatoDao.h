//
//  ContatoDao.h
//  ContatosIP67
//
//  Created by ios5436 on 29/08/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contato.h"
#import <CoreData/CoreData.h>

@interface ContatoDao : NSObject

@property (strong, readonly)  NSMutableArray *contatos;

-(void) adicionaContato:(Contato *) contato;
+(id) contatoDaoInstance;
-(Contato *) buscaContatoDaPosicao:(NSInteger)posicao;
-(void) removeContatoDaPosicao:(NSInteger)posicao;
-(NSInteger) buscaPosicaoDoContato:(Contato *)contato;
-(void)inserirDados;
-(void)carregarDados;
-(Contato *)novoContato;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
