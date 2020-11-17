
# Build Plugin
pushd plugin/cordova-tacs-plugin

npm run build
npm run docs

popd

# Reinstall Plugin
pushd app

cordova plugin rm cordova-tacs-plugin
cordova plugin add ../plugin/cordova-tacs-plugin

cordova prepare

popd
