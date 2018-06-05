import React, {Component} from 'react';
import {
    Platform,
    Dimensions,
    PixelRatio
} from 'react-native';

global.__IOS__ = Platform.OS === 'ios';
global.__IPHONEX__ = (Platform.OS === 'ios') && (MIN_SCREEMT === 375.00 && MAX_SCREEMT === 812.0);
global.__ANDROID__ = Platform.OS === 'android';

global.__SCREEN_WIDTH__ = Dimensions.get('window').width;
global.__SCREEN_HEIGHT__ = Dimensions.get('window').height;
global.__PIXEL__ = 1.0 / PixelRatio.get();

const MAX_SCREEMT = Math.max(Dimensions.get('window').width,Dimensions.get('window').height);
const MIN_SCREEMT = Math.min(Dimensions.get('window').width,Dimensions.get('window').height);


