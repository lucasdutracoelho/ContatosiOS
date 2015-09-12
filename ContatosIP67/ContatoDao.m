//
//  ContatoDao.m
//  ContatosIP67
//
//  Created by ios5436 on 29/08/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "ContatoDao.h"


@implementation ContatoDao

static ContatoDao * defaultDao = nil;

-(void) adicionaContato:(Contato *)contato {
    [self.contatos addObject:contato];
    NSLog(@"Contato: %@", self.contatos);
}

-(id) init{
    self = [super init];
    if(self){
        _contatos = [NSMutableArray new];
    }
    return self;
}

+(id)   contatoDaoInstance{
    if(!defaultDao){
        defaultDao = [ContatoDao new];
    }
    return defaultDao;
}

-(Contato *) buscaContatoDaPosicao:(NSInteger)posicao{
    return self.contatos[posicao];
}

-(void) removeContatoDaPosicao:(NSInteger)posicao{
    [self.contatos removeObjectAtIndex:posicao];
}

-(NSInteger) buscaPosicaoDoContato:(Contato *)contato {
    return [self.contatos indexOfObject:contato];
}

@end
