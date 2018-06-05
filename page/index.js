import XGNavigation from 'xgrn-navigation';

import home from './home'
import mine from './mine'

import AppPagePathConfig from './common/AppPagePathConfig';
import App from './App';

// 初始化js页面路由
XGNavigation.initializeJSRoutes([
    home,
    mine
]);

// 重置路由栈
// XGNavigation.resetRoot(AppPagePathConfig.appRootVC());
XGNavigation.resetRoot(AppPagePathConfig.appRootTabVC());

export default App;
