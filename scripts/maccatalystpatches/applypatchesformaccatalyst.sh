echo "Removing existing release notes"
rm release-notes.txt release-notes.json
echo "Applying patch for package.json"
sed -i '' '/react-native-tor/d' ./package.json
rm -fr node_modules
echo "Re-installing node_modules"
npm i
echo "Applying patch for react-native-xcode.sh"
sed -i '' 's/--platform "$BUNDLE_PLATFORM"/--platform "ios"/g' ./node_modules/react-native/scripts/react-native-xcode.sh
echo "Applying patch for LDK Podfile"
sed -i '' 's/LDKFramework.xcframework/LDKFramework-maccatalyst.xcframework/g' ./node_modules/rn-ldk/rn-ldk.podspec
echo "Applying patch for RCTCameraManager.m"
patch node_modules/react-native-camera/ios/RCT/RCTCameraManager.m scripts/maccatalystpatches/RCTCameraManagerDiff
echo "Applying patch for RNCamera.m"
patch node_modules/react-native-camera/ios/RN/RNCamera.m scripts/maccatalystpatches/RNCamera.patch
echo "Deleting torrific.js content"
echo > blue_modules/torrific.js
echo "Updating Podfile"
cd ios && pod update && cd ..
echo ""
echo "NOTE: react-native-tor is not currently compatible with Mac Catalyst.