import React, {Component} from 'react';
import {
    View,
    Text,
    StyleSheet
} from 'react-native';

// import PropTypes from 'prop-types';

//声明全局变量
// global.aaa = true;

//声明局部变量
// var aaa = true;

export default class MinePage extends Component {

    // static propTypes = {
    //     leftBarButtonItemHidden: PropTypes.bool
    // };
    
    constructor(props) {
        super(props)
        
        // this.state = {
        //     name: '张三'
        // }

        //定时刷新state
        // setInterval(() => {
        //     this.setState({ name: '李四'})
        // }, 1000)
    };

    static xgNavigationBarOptions = {
        pageName: 'MinePage',
        title: '我的',
        leftNavItemHidden: true,
        rightNavTitle: 'movie'
    };

    componentDidMount() {
        //如果需求是不隐藏，就不隐藏
        if (this.props.leftBarButtonItemHidden === false) {
            this.xg_NavigationBarHiddenLeftItem(this.props.leftBarButtonItemHidden);
        }
    };

    // xg_NavigationBarLeftPressed = () => {
    //     const {navigation} = this.props

    //     //可以返回上一层或根页面
    //     // navigation.pop()
    //     // navigation.popToRoot()
        
    //     //无法返回指定页面
    //     // navigation.popToRoute({
    //     //     pageType: 'JSPage',
    //     //     pagePath: '../home/HomePage',
    //     //     params: null
    //     // })
    // };

    xg_NavigationBarRightPressed = (id) => {
        const {navigation} = this.props

        navigation.push({
            pageType: 'JSPage',
            pagePath: 'mine/MovieListPage',
            params: null
        })
    };

    render() {
        return (
            // <View style={styles.container}>
            //     <Text style={styles.welcome}>
            //         {this.state.name}
            //     </Text>
            // </View>

            <View style={styles.container}>
                <Text style={styles.welcome}>
                    {this.props.name}
                </Text>
            </View>
        )
    };
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: 'white'
    },
    welcome: {
        fontSize: 20,
        textAlign: 'center'
    }
});
