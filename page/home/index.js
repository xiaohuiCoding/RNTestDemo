import HomePage from "./HomePage";
import HomeDetailPage from "./HomeDetailPage";
import SaveImageToPhotoAlbumPage from "./SaveImageToPhotoAlbumPage";
import TestPage from "./TestPage";

export default {
    path: 'home',
    childRoutes: [
        HomePage,
        TestPage,
        HomeDetailPage,
        SaveImageToPhotoAlbumPage
    ]
};