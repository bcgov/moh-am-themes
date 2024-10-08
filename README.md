# Overview

This directory consists of multiple themes which are used to style the **moh_applications** Keycloak realm. These themes are based on Keycloak 22.0.4. JAR file contains account theme, login-themes folder contains different versions of a login theme.

## moh-app-realm

This theme extends the Login page. The Login theme has been designed to only show a list of identity providers and explicitly excludes any IDPs that start with "bcsc".

CSS has been updated to better align with Ministry of Health Standards.

### Login Theme Notes

The top level heading (Ministry of Health) is set by the Realm HTML Display Name which can be configured in the Keycloak Admin console.

The second level heading (application name) is pulled from the Client Name which can be configured in the Keycloak Admin Console.

The identity providers shown are dynamically configured by setting url query parameters. By default, all IDPs will show in the list, except for those that start with "bcsc". In order to only show specific IDPs, the user browser redirect from the client application should include `idps_to_show=` as a query parameter with a comma seperated of idp-alias names as values (e.g. `idps_to_show=moh_idp,idir` will only show Keycloak and IDIR).

When this parameter is set any idp-alias not in the list will be hidden.

## moh-app-realm-account

This theme extends the Account page. The moh-app-realm-account theme is built on top of a React application, based on this [Keycloak example](https://github.com/keycloak/keycloak-quickstarts/tree/latest/extension/extend-account-console) The Account page removes the options for users to view and manage password, authentication, and applications.

## moh-app-realm-bcsc-idp

This theme package is a copy of the moh-app-realm theme above with the one change being that it does not explicitly exclude any IDPs that start with "bcsc". It can be applied on a per client basis for those clients that require BCSC integration but do not have a custom login page (e.g. HCIMWeb).

## Other themes in `login-themes` directory

Other themes are a copy of the moh-app-realm theme, with a fixed list of Identity Providers that are displayed. They were created to customize login screen of those applications that cannot develop a page on their own or pass "idps_to_show/ kc_idp_hint" parameters inside authentication request.

# How to Customize

## Account Theme

Please refer to this README for more detailed information on how to build the JAR and edit the themes contained inside.

## Login Theme

Please refer to official [Keycloak Documentation](https://www.keycloak.org/docs/latest/server_development/#_themes)

# How to Deploy

In order to add the themes to a Keycloak installation:

1. Copy the JAR file to the "providers" directory in your Keycloak installation.
2. Copy the folders from "login-themes" to the "themes" directory in your Keycloak installation.
3. Restart Keycloak.

Please note that steps 1 and 2 are independent of each other. There is no need to update the 'login-themes' folder if you only want to update the account theme.

The theme will be available for selection in the Keycloak Admin Console.

The settings to apply the account theme, or a login theme for the whole realm, are found at:
`Realm Settings -> Themes -> Login Theme or Account Theme`

The settings to apply the the login theme only to a specific client are found at:
`Client -> Client Name -> Settings -> Login Theme.`

## Clearing Theme Cache

During a deploy, some theme resource files such as scripts may remain cached after restarting Keycloak. This cache can be cleared with the following:

As the `gfadmin` user, remove the cache folder for a specific theme found under `/data/gfadmin/software/keycloak/data/tmp/kc-gzip-cache/?????/login/moh-app-realm/` (where `?????` can be found from inspecting a theme resource file from your browser's **Developer Tools -> Network** tab).

> **Note:** Dev `?????=ng78f`, Test `?????=472zi`, and Prod `?????=on1k1` but this could change in the future.

e.g. To clear the cache for the moh-app-realm login theme in Keycloak Dev, run the following command as `gfadmin`:

```
rm -rf /data/gfadmin/software/keycloak/data/tmp/kc-gzip-cache/ng78f/login/moh-app-realm/
```

## Automated Build

This repository contains a [Build AccountTheme](https://github.com/bcgov/moh-am-themes/actions/workflows/build-account-theme.yml) GitHub workflow that automates the build process. The workflow is executed when a PR against the `main` branch is opened. It can also be executed manually.
When executing manually developer needs to select a branch/tag from where the workflow will run. The output of the workflow is a zipped file that contains the account-theme.jar file as well as the custom login themes. The artifacts generated by the workflow run are stored for one day.

## Release Process

Before deploying to development or test environments, create a draft release. Upload the artifact generated by the [Build AccountTheme](https://github.com/bcgov/moh-am-themes/actions/workflows/build-account-theme.yml), triggered by a pull request.

For production deployments, manually trigger the workflow that builds the artifacts from the main branch. Ensure that the release is finalized with the appropriate version tag and release notes.

# Tested on

- Keycloak 22.0.4

# References

- Keycloak Documentation: [Creating, Updating, and Configuring Themes](https://www.keycloak.org/docs/latest/server_development/#_themes). [Configuring Providers](https://www.keycloak.org/server/configuration-provider).
