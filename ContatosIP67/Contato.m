//
//  Contato.m
//  ContatosIP67
//
//  Created by ios5436 on 29/08/15.
//  Copyright (c) 2015 Caelum. All rights reserved.
//

#import "Contato.h"

@implementation Contato

-(NSString *)description{
    return [NSString stringWithFormat: @"Nome: %@, Telefone: %@, E-mail: %@, Endereço: %@, Site: %@", self.nome, self.telefone, self.email, self.endereco, self.site ];

}

@end
