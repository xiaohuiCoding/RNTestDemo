import XGNavigation from 'xgrn-navigation';

import HomeIconUnSelect from './resource/TabBar_main_black.png';
import MineIconUnSelect from './resource/TabBar_mine_black.png';

import HomeIconSelect from './resource/TabBar_main_blue.png';
import MineIconSelect from './resource/TabBar_mine_blue.png'

export default {
    
    //根视图是vc
    // appRootVC() {
    //     return {
    //         pageType: XGNavigation.pageType.JSPage,
    //         pagePath: 'home/HomePage',
    //         params: null
    //     };
    // }

    //根视图是tabvc
    appRootTabVC() {
        return {
            pageType: 'NativeTabPage',
            transitionsConfig: XGNavigation.transitionsConfig.FromBottom,
            pagePath: 'HomeTabPage',
            tabConfigs: {
                selectedIndex: 0,
                tabCount: 5,
                tintColor: '#FF758C', //选中的Icon和title的颜色，可选项
                unselectedItemTintColor: '#333', //未选中Icon和title的颜色，可选项
                barTintColor: 'grey', //tabbar的颜色，可选项
                barTranslucent: false, // tabbar半透明选项，barTintColor有值则该选项无效,效果不透明
                pages: [{
                    pageType: XGNavigation.pageType.JSPage,
                    pagePath: 'home/HomePage',
                    params: null,
                    unSelectTabBarIcon: HomeIconUnSelect,
                    selectTabBarIcon: HomeIconSelect,
                    tabBarTitle: '首页'
                }, {
                    pageType: XGNavigation.pageType.JSPage,
                    pagePath: 'mine/MinePage',
                    params: null,
                    unSelectTabBarIcon: MineIconUnSelect,
                    selectTabBarIcon: MineIconSelect,
                    tabBarTitle: '我的'
                }]
            }
        }
    }
}
