//
//  PCCheatListParser.m
//  PocketCheat
//
//  Created by Daniel Rodríguez Troitiño on 21/01/09.
//  Copyright 2009 Daniel Rodríguez Troitiño. All rights reserved.
//

#import "PCCheatListParser.h"

#include "yaml.h"

@interface PCCheatListParser ()

@property(nonatomic, readwrite, retain) NSString *title;
@property(nonatomic, readwrite, retain) NSArray *elements;
@property(nonatomic, copy) NSString *yaml;

@end

@implementation PCCheatListParser

@synthesize title = title_;
@synthesize elements = elements_;
@synthesize yaml = yaml_;

- (id)initWithString:(NSString *)yaml {
  self = [super init];
  if (self) {
    self.yaml = yaml;
  }
  return self;
}

- (int)parse {
  yaml_parser_t parser;
  yaml_document_t document;
  
  int retval = 0;
  yaml_parser_initialize(&parser); // TODO: errors?
  yaml_parser_set_input_string(&parser,
                               [yaml_ UTF8String],
                               [yaml_ length]); // TODO: errors?
  
  if (!yaml_parser_load(&parser, &document)) {
    NSLog(@"yaml_parser_load failed!");
    retval = -1; // FIXME
    goto cleanup;
  }
  
  yaml_node_t *documentNode = yaml_document_get_root_node(&document);
  if (!documentNode) {
    NSLog(@"yaml_document_get_root_node returned NULL");
    retval = -1; // FIXME
    goto cleanup;
  }
  
  if (documentNode->type != YAML_MAPPING_NODE) {
    NSLog(@"documentNode is not a map");
    retval = -1; // FIXME
    goto cleanup;
  }
  
  // There is only one pair in the document_node
  yaml_node_t *titleNode = yaml_document_get_node(&document,
                                                  documentNode->data.mapping.pairs.start->key);
  yaml_node_t *listNode = yaml_document_get_node(&document,
                                                 documentNode->data.mapping.pairs.start->value);

  // Extracting the title
  if (titleNode->type != YAML_SCALAR_NODE) {
    NSLog(@"titleNode is not a scalar node");
    retval = -1; // FIXME
    goto cleanup;
  }
  self.title = [NSString stringWithCString:titleNode->data.scalar.value
                                  encoding:NSUTF8StringEncoding];
  
  // Extracting the values
  if (listNode->type != YAML_SEQUENCE_NODE) {
    NSLog(@"listNode is not a sequence node");
    retval = -1; // FIXME
    goto cleanup;
  }
  
  yaml_node_item_t *item;
  yaml_node_t *listItem;
  NSString *itemName;
  size_t numElements =
    listNode->data.sequence.items.end - listNode->data.sequence.items.start;
  NSMutableArray *elems = [NSMutableArray arrayWithCapacity:numElements];
  for (item = listNode->data.sequence.items.start;
       item < listNode->data.sequence.items.top;
       item++) {
    listItem = yaml_document_get_node(&document, *item);
    
    if (listItem->type != YAML_SCALAR_NODE) {
      NSLog(@"listItem is not a scalar node");
      retval = -1; // FIXME
      goto cleanup;
    }
    
    itemName = [[NSString alloc] initWithCString:listItem->data.scalar.value
                                        encoding:NSUTF8StringEncoding];
    [elems addObject:itemName];
    [itemName release];
  }
  
  self.elements = [NSArray arrayWithArray:elems];
  retval = numElements;
  
cleanup:
  yaml_document_delete(&document);
  yaml_parser_delete(&parser);
  
  return retval;
}

- (void)dealloc {
  self.title = nil;
  self.elements = nil;
  self.yaml = nil;
  
  [super dealloc];
}

@end
