//
//  XMLReader.h
//
//

#import <Foundation/Foundation.h>


@interface XMLReader : NSDictionary <NSXMLParserDelegate>
{
    
    NSMutableArray *dictionaryStack;
    NSMutableString *textInProgress;
//    NSError **errorPointer;
}

+ (NSDictionary *)dictionaryForXMLData:(NSData *)data error:(NSError **)errorPointer;
+ (NSDictionary *)dictionaryForXMLString:(NSString *)string error:(NSError **)errorPointer;

@end
