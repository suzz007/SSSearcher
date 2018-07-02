//
//  NSString+chineseTransform.m
//  DXBussinessOff
//
//  Created by imac on 2018/7/2.
//  Copyright © 2018年 TerrySu. All rights reserved.
//

#import "NSString+chineseTransform.h"
#include "SearchCoreManager.h"

const   char   *PinYin2Code[KPyCodeNum]   =
{
    "a",   "ai",   "an",   "ang",   "ao",   "ba",   "bai",   "ban",   "bang",   "bao",
    "bei",   "ben",   "beng",   "bi",   "bian",   "biao",   "bie",   "bin",   "bing",   "bo",
    "bu",   "ca",   "cai",   "can",   "cang",   "cao",   "ce",   "ceng",   "cha",   "chai",
    "chan",   "chang",   "chao",   "che",   "chen",   "cheng",   "chi",   "chong",   "chou",   "chu",
    "chuai",   "chuan",   "chuang",   "chui",   "chun",   "chuo",   "ci",   "cong",   "cou",   "cu",
    "cuan",   "cui",   "cun",   "cuo",   "da",   "dai",   "dan",   "dang",   "dao",   "de",
    "deng",   "di",   "dian",   "diao",   "die",   "ding",   "diu",   "dong",   "dou",   "du",
    "duan",   "dui",   "dun",   "duo",   "e",   "en",   "er",   "fa",   "fan",   "fang",
    "fei",   "fen",   "feng",   "fu",   "fou",   "ga",   "gai",   "gan",   "gang",   "gao",
    "ge",   "ji",   "gen",   "geng",   "gong",   "gou",   "gu",   "gua",   "guai",   "guan",
    "guang",   "gui",   "gun",   "guo",   "ha",   "hai",   "han",   "hang",   "hao",   "he",
    "hei",   "hen",   "heng",   "hong",   "hou",   "hu",   "hua",   "huai",   "huan",   "huang",
    "hui",   "hun",   "huo",   "jia",   "jian",   "jiang",   "qiao",   "jiao",   "jie",   "jin",
    "jing",   "jiong",   "jiu",   "ju",   "juan",   "jue",   "jun",   "ka",   "kai",   "kan",
    "kang",   "kao",   "ke",   "ken",   "keng",   "kong",   "kou",   "ku",   "kua",   "kuai",
    "kuan",   "kuang",   "kui",   "kun",   "kuo",   "la",   "lai",   "lan",   "lang",   "lao",
    "le",   "lei",   "leng",   "li",   "lia",   "lian",   "liang",   "liao",   "lie",   "lin",
    "ling",   "liu",   "long",   "lou",   "lu",   "luan",   "lue",   "lun",   "luo",   "ma",
    "mai",   "man",   "mang",   "mao",   "me",   "mei",   "men",   "meng",   "mi",   "mian",
    "miao",   "mie",   "min",   "ming",   "miu",   "mo",   "mou",   "mu",   "na",   "nai",
    "nan",   "nang",   "nao",   "ne",   "nei",   "nen",   "neng",   "ni",   "nian",   "niang",
    "niao",   "nie",   "nin",   "ning",   "niu",   "nong",   "nu",   "nuan",   "nue",   "yao",
    "nuo",   "o",   "ou",   "pa",   "pai",   "pan",   "pang",   "pao",   "pei",   "pen",
    "peng",   "pi",   "pian",   "piao",   "pie",   "pin",   "ping",   "po",   "pou",   "pu",
    "qi",   "qia",   "qian",   "qiang",   "qie",   "qin",   "qing",   "qiong",   "qiu",   "qu",
    "quan",   "que",   "qun",   "ran",   "rang",   "rao",   "re",   "ren",   "reng",   "ri",
    "rong",   "rou",   "ru",   "ruan",   "rui",   "run",   "ruo",   "sa",   "sai",   "san",
    "sang",   "sao",   "se",   "sen",   "seng",   "sha",   "shai",   "shan",   "shang",   "shao",
    "she",   "shen",   "sheng",   "shi",   "shou",   "shu",   "shua",   "shuai",   "shuan",   "shuang",
    "shui",   "shun",   "shuo",   "si",   "song",   "sou",   "su",   "suan",   "sui",   "sun",
    "suo",   "ta",   "tai",   "tan",   "tang",   "tao",   "te",   "teng",   "ti",   "tian",
    "tiao",   "tie",   "ting",   "tong",   "tou",   "tu",   "tuan",   "tui",   "tun",   "tuo",
    "wa",   "wai",   "wan",   "wang",   "wei",   "wen",   "weng",   "wo",   "wu",   "xi",
    "xia",   "xian",   "xiang",   "xiao",   "xie",   "xin",   "xing",   "xiong",   "xiu",   "xu",
    "xuan",   "xue",   "xun",   "ya",   "yan",   "yang",   "ye",   "yi",   "yin",   "ying",
    "yo",   "yong",   "you",   "yu",   "yuan",   "yue",   "yun",   "za",   "zai",   "zan",
    "zang",   "zao",   "ze",   "zei",   "zen",   "zeng",   "zha",   "zhai",   "zhan",   "zhang",
    "zhao",   "zhe",   "zhen",   "zheng",   "zhi",   "zhong",   "zhou",   "zhu",   "zhua",   "zhuai",
    "zhuan",   "zhuang",   "zhui",   "zhun",   "zhuo",   "zi",   "zong",   "zou",   "zu",   "zuan",
    "zui",   "zun",   "zuo",   "",   "ei",   "m",   "n",   "dia",   "cen",   "nou",
    "jv",   "qv",   "xv",   "lv",   "nv" ,  "fo"
};


const   char   *Romechar2Index[KRomeCodeNum]   =
{
    "1","2","3","4","5","6","7","8","9","10","","","","","","",
    "1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20",
    "1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20",
    "1","2","3","4","5","6","7","8","9","10","","",
    "1","2","3","4","5","6","7","8","9","10","","",
    "1","2","3","4","5","6","7","8","9","10","11","12","",""
};

@implementation NSString (chineseTransform)

+ (NSString *)chinese_Pinyin:(NSString *)chineseString{
    
    NSMutableString * pinyinString = [NSMutableString new];
    NSUInteger strLength = chineseString.length;
    
    for (int i = 0; i < strLength; i++) {
        NSString * tmpString = [chineseString substringWithRange:NSMakeRange(i, 1)];
        u2char word = [tmpString characterAtIndex:0];
        
        const char *pyCode = NULL;
        WordCode code;
        Word2Code(word, &code);
        //        NSInteger length = u2slen(&code.Word);
        pyCode = PinYin2Code[(int)code.PyCodeIndex[i]];
        NSString * singlePYString = [NSString stringWithCString:pyCode encoding:NSUTF8StringEncoding];
        
        [pinyinString appendString:singlePYString];
    }
    
    //    NSString * pinyin = [NSString stringWithCharacters:&code.Word length:length];
    
    return pinyinString.mutableCopy;
}

+ (NSMutableAttributedString *)lightStringWithSearchResultName:(NSString *)searchResultName matchArray:(NSArray *)matchArray inputString:(NSString *)inputString lightedColor:(UIColor *)lightedColor{
    
    if (lightedColor == nil) {
        lightedColor = [UIColor colorWithRed:(70/255.0) green:(125/255.0) blue:(255/255.0) alpha:1.0];
    }
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc]initWithString:searchResultName];
    NSUInteger matchCount = matchArray.count;
    for (int i = 0; i < matchCount; i ++) {
        NSNumber * compareNum = matchArray[i];
        int j = 0;
        [self compare:&j searhRestultName:searchResultName compareNum:compareNum matchArray:matchArray];
        j = j >= 1 ? j - 1 : j;
        [attributedStr addAttribute:NSForegroundColorAttributeName value:lightedColor range:NSMakeRange(j, 1)];
    }
    
    return attributedStr;
}

+ (void)compare:(int *)i searhRestultName:(NSString *)searchResultName compareNum :(NSNumber *)compareNum  matchArray:(NSArray *)matchArray{
    
    if ((*i) > searchResultName.length) {
        *i = *i - 1;
        return;
    }
    
    if ([NSString needLightChar:[searchResultName substringWithRange:NSMakeRange(0, (*i))] compareValue:compareNum.intValue]) {
            return ;
        }else{
            *i = *(i) + 1;
            [self compare:i searhRestultName:searchResultName compareNum:compareNum matchArray :matchArray];
        }

}

+ (BOOL)needLightChar:(NSString *)string compareValue:(int)compareValue{
    
    if (![NSString isChinese:string]) {
        NSInteger lastLocale = -1;
        for(int i = 0; i < [string length]; i++)
        {
            NSString * temp = [string substringWithRange:NSMakeRange(i, 1)];
            NSString * tmpString = [NSString isChinese:temp] ? [NSString chinese_Pinyin:temp] : temp;
            lastLocale = lastLocale + tmpString.length;
        }
        if (lastLocale >= compareValue) {
            return YES;
        }else{
            return NO;
        }
    }else{ // 中文
        NSInteger lastLocale = -1;
        for(int i = 0; i < [string length]; i++)
        {
            NSString * temp = [string substringWithRange:NSMakeRange(i, 1)];
            NSString * tmpString = [NSString chinese_Pinyin:temp];
            lastLocale = lastLocale + tmpString.length;
        }
        if (lastLocale >= compareValue) {
            return YES;
        }else{
            return NO;
        }
    }
}

void FreeWord2Code(WordCode* word)
{
    if( !word )
        return;
    
    if( word->PyCodeNum > 0 )
        free(word->PyCodeIndex);
    
    free(word);
    
    return;
}

+ (BOOL)isChinese:(NSString *)string
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:string];
}

@end
