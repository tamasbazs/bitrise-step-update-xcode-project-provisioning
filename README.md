# Update Xcode Project Provisioning

Updates Xcode's project file signing config to use a specific certificate and provisioning profile

## How to use this Step

Add the **Update Xcode Project Provisioning** step into your workflow before the **Xcode Archive & Export for iOS** step.

Fill up the required values:

- Xcode project.xcodeproj Path
- Project Target
- Code Sign Style
- Development Team
- Code Sign Identity
- Provisioning Profile Specifier

### Automatic Signing

- Code Sign Style use `Automatic`.
- Fill **Code Sign Identity** with `iPhone Developer`.
- Specify **Development Team**
- Leave **Provisioning Profile Specifier** empty.

### Manual Signing

Specify all the values.

```yaml
CODE_SIGN_STYLE: Manual
DEVELOPMENT_TEAM: ABCDEFGHIJ
CODE_SIGN_IDENTITY: iPhone Developer
PROVISIONING_PROFILE_SPECIFIER: MyAwesomeProjectDEV_Development
```

## Demo

Here is part result of `bitrise run test` command with the [bitrise CLI](https://github.com/bitrise-io/bitrise).

```yaml
# Original Settings:
-----------------------------
Target: MyAwesomeProjectDEV

Build Configuration: Debug
CODE_SIGN_STYLE: Automatic
DEVELOPMENT_TEAM: XXXXXXXXXX
CODE_SIGN_IDENTITY: iPhone Developer
PROVISIONING_PROFILE_SPECIFIER:

Build Configuration: Release
CODE_SIGN_STYLE: Automatic
DEVELOPMENT_TEAM: XXXXXXXXXX
CODE_SIGN_IDENTITY: iPhone Developer
PROVISIONING_PROFILE_SPECIFIER:
-----------------------------

# Changed Settings:
-----------------------------
Target: MyAwesomeProjectDEV

Build Configuration: Debug
CODE_SIGN_STYLE: Manual
DEVELOPMENT_TEAM: ABCDEFGHIJ
CODE_SIGN_IDENTITY: iPhone Developer
PROVISIONING_PROFILE_SPECIFIER: MyAwesomeProjectDEV_Development

Build Configuration: Release
CODE_SIGN_STYLE: Manual
DEVELOPMENT_TEAM: FGHIJABCDE
CODE_SIGN_IDENTITY: iPhone Distribution
PROVISIONING_PROFILE_SPECIFIER: MyAwesomeProjectDEV_store
-----------------------------
```

## Contribution

Can be run directly with the [bitrise CLI](https://github.com/bitrise-io/bitrise),
just `git clone` this repository, `cd` into it's folder in your Terminal/Command Line
and call `bitrise run test`.

*Check the `bitrise.yml` file for required inputs which have to be
added to your `.bitrise.secrets.yml` file!*

Step by step:

1. Open up your Terminal / Command Line
2. `git clone` the repository
3. `cd` into the directory of the step (the one you just `git clone`)
4. Once you have all the required secret parameters in your `.bitrise.secrets.yml` you can just run this step with the [bitrise CLI](https://github.com/bitrise-io/bitrise): `bitrise run test`

Pull Request is welcome.

## Credits

Forked from

https://github.com/j796160836/bitrise-step-code-signing-setting-patch

Updated to fit a more generic configuration pattern that does not require to have specific configuration names. Instead works with all and any configurations.

## Inspired by

https://github.com/fastlane/fastlane/blob/master/fastlane/lib/fastlane/actions/update_project_provisioning.rb