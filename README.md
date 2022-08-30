# top-scrobbles

[![status](https://tingle-api.spotify.net/v1/badge/tripp/top-scrobbles/status)](https://backstage.spotify.net/tingle/tripp/top-scrobbles#builds)
[![version](https://tingle-api.spotify.net/v1/badge/tripp/top-scrobbles/version)](https://backstage.spotify.net/tingle/tripp/top-scrobbles#builds)


## Description

Library for calculating top scrobbles from Last.fm and updating a top tracks playlist in Spotify

## Usage

```sh
yarn add @spotify-internal/top-scrobbles
```

## Contributing

```sh
yarn install
```

```sh
yarn commit
```


### Scripts

- `yarn build`: CommonJS Modules (`/cjs`), and ESModule (`/esm`) from the source using the [TypeScript Compiler](https://www.typescriptlang.org/docs/handbook/compiler-options.html).
- `yarn format`: Format source code files via [Prettier].
- `yarn lint`: Lint all source files via [ESLint].
- `yarn test`: Run all tests via [Jest].
- `yarn commit`: Create a commit, correctly formatted using [commitizen].
- `yarn release`: Trigger a release based on your commit messages using [semantic-release].
- `yarn docs`: Preview this project's [TechDocs] documentation.


### Continuous Integration / Publishing

CI is enabled via [build-info.yaml], using [Tingle].

[commitizen], [semantic-release], and [conventional-changelog] are all enabled by default. If you use `yarn commit` to format your commit messages, semantic-release will figure out what the next release of your library should be and will publish it to npm on every merge to master.

If you would rather directly control which versions are published on merge, you can replace the `"Release"` stage with the commented-out `"Attempt Publish"` stage within [build-info.yaml]. For more information, see the [npm-publish-if-not] action container.

---

_This project is based on the template [web/web-library-skeleton](https://ghe.spotify.net/web/web-library-skeleton)_

[build-info.yaml]: ./build-info.yaml
[commitizen]: https://github.com/commitizen/cz-cli
[conventional-changelog]: https://github.com/conventional-changelog/conventional-changelog
[ESLint]: https://eslint.org/
[Jest]: http://jestjs.io/
[npm-publish-if-not]: https://ghe.spotify.net/action-containers/npm-publish-if-not
[Prettier]: https://prettier.io/
[semantic-release]: https://github.com/semantic-release/semantic-release
[Tingle]: https://confluence.spotify.net/display/PIPE/Tingle
[TechDocs]: https://backstage.spotify.net/docs/docs/
