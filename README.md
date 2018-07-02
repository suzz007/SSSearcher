# SSSearcher
轻度集成,侵入性低,配合searchcore引擎一句代码集成显示文字高亮效果,匹配文字显示高亮逻辑参考微信,满足大多数社交搜索检索需求
除此外,api中还集成中文转拼音,原理是基于unicode编码值转对应数据中的拼音.
自定义的searchView,类似微信的搜索动画和UI,耦合度低
NSMutableAttributedString * attributedString = [NSString lightStringWithSearchResultName:model.name matchArray:matchPos inputString:text lightedColor:COLOR_HEX(0x467dff)];
匹配高亮的计算代码哪儿没有来得及打注释,但实现逻辑其实不难,应该都能看懂,提供的上条接口API高亮匹配的需求,也不用管具体如何实现的
