import React, {Component} from 'react';
import {
    View,
    FlatList,
    StyleSheet
} from 'react-native';

import HomeCell from './HomeCell'

//声明局部常量
let titleStr = '首页';

export default class HomePage extends Component {

    static xgNavigationBarOptions = {
        pageName: 'HomePage',
        title: titleStr,
        leftNavItemHidden: false,
        leftNavTitle: 'js->js',
        rightNavTitle: 'js->native'
    };

    xg_NavigationBarLeftPressed = (id) => {
        const {navigation} = this.props;
        navigation.push({
            pageType: 'JSPage',
            pagePath: 'mine/MinePage',
            params: {
                name: titleStr,
                leftBarButtonItemHidden: false
            }
        })
    };

    xg_NavigationBarRightPressed = (id) => {
        const {navigation} = this.props;

        navigation.push({
            pageType: 'NativePage',
            pagePath: {
                ios: 'TestListViewController',
                android: null
            },
            params: {
                titleString: 'native list'
            }
        })
    };

    _renderListItem = ({item, index}) => {
        return (
            <HomeCell
                first = {item.first}
                second = {item.second}
                third = {item.third}
                showTestPage={this.showTestPage}
                showAlbumPage={this.showAlbumPage}
                showHomeDetailPage={this.showHomeDetailPage}
            />
        )
    };

    showTestPage = () => {
        const {navigation} = this.props;
        navigation.push({
            pageType: 'JSPage',
            pagePath: 'home/TestPage',
            params: null
        })
    };


    showAlbumPage = () => {
        const {navigation} = this.props;
        navigation.push({
            pageType: 'JSPage',
            pagePath: 'home/SaveImageToPhotoAlbumPage',
            params: null
        })
    };

    showHomeDetailPage = () => {
        const {navigation} = this.props;
        navigation.push({
            pageType: 'JSPage',
            pagePath: 'home/HomeDetailPage',
            params: null
        })
    };

    render() {
        return (
            <View style={styles.container}>
                <FlatList
                    data={
                        [
                            {
                                first: '标题1--->测试',
                                second: '子标题1--->相册操作',
                                third: '图片浏览'
                            },
                            {
                                first: '标题2--->测试',
                                second: '子标题2--->相册操作',
                                third: '图片浏览'
                            },
                            {
                                first: '标题3--->测试',
                                second: '子标题3--->相册操作',
                                third: '图片浏览'
                            }
                        ]
                    }
                    renderItem={this._renderListItem}
                />
            </View>
        )    
    };
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: 'white'
    }
});
