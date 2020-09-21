
# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [3.1.0] 2018-9-11
### Changed
- Httpoison update

## [3.0.3] 2018-06-05
### Fixed
- Fix dialyzer error with Request.include/2.

## [3.0.1] 2018-05-29
### Fixed
- Corrected spec for JsonApiClient.Resource and JsonApiClient.Document, which were incorrectly making `links` required.

## [3.0.1] 2018-05-10
### Fixed
- Update readme to correlate with current version
- Removed runtime dependency on Mix

## [3.0.0] 2018-03-19
### Changed
- Request service_name now only accepts atoms

## [2.1.0] 2018-03-15
### Added
- add Dialyzer and add type specs to public methods

## [2.0.3] 2018-02-01
### Fixed
- Fuse Middleware uses a request base url as a fuse name when a service name is not set to the request

## [2.0.2] 2018-01-31
### Fixed
- fixed bug in JsonApiClient.Middleware.StatsTracker

## [2.0.1] 2018-01-26
### Fixed
- `mix format` codebase
- Misc code cleanup
- fixed timeout constant inside config

## [2.0.0] 2018-01-03
### Fixed
- urls with explicit ports but no path are normalized so they don't [cause errors](https://github.com/edgurgel/httpoison/issues/300) in HTTPoison/hackney.
### Removed
- Hard dependency on fuse and sasl erlang packages. Fuse is now declared as optional.
- JsonApiClient.Config.SASLLogs log translator in favor of direct configuration of sasl.

## [1.2.0] 2017-10-27
### Changed
- Middleware call `request` parameter type is changed to `Request`.

### Added
- Added `Request.attributes`
- Added `DefaultRequestConfig` middleware
- Added `Request.new/0` method

## [1.1.0] - 2017-10-25
### Changed
- Renamed client_name to user_agent_suffix
- use Mix.Project.config[:app] as a default value for user_agent_suffix
- Use "JsonApiClient" (package name) as user agent prefix instead of "ExApiClient".

### Added
- Added `Request.header/3` method
- Added middleware architecture
- Added `Fuse` and `StatsTracker` middlewares

### Fixed
- Path generation from a now works correctly for post requests when `resource` specified

## [1.0.0] - 2017-10-17
### Added
- `Request.path/2` added

## [0.5.2] - 2017-10-17
### Fixed
- Fixed package config so that primary documentation link in hex.pm works

## [0.5.1] - 2017-10-17
### Fixed
- Removed `organization` from mix.exs so that package will be public
- Removed Unused dependencies from mix.exs

## [0.5.0] - 2017-10-17
### Added
- This CHANGELOG.md
- A good bit of docuemtnation

### Removed
- The `RequestError` struct lost the `reson` attribute. We now just use `message`


[Unreleased]: https://github.com/decisiv/json_api_client/compare/2.0.1...HEAD
[2.0.1]: https://github.com/decisiv/json_api_client/compare/2.0.0...2.0.1
[2.0.0]: https://github.com/decisiv/json_api_client/compare/1.2.0...2.0.0
[1.2.0]: https://github.com/decisiv/json_api_client/compare/1.1.0...1.2.0
[1.1.0]: https://github.com/decisiv/json_api_client/compare/1.0.0...1.1.0
[1.0.0]: https://github.com/decisiv/json_api_client/compare/0.5.2...1.0.0
[0.5.2]: https://github.com/decisiv/json_api_client/compare/0.5.1...0.5.2
[0.5.1]: https://github.com/decisiv/json_api_client/compare/0.5.0...0.5.1
[0.5.0]: https://github.com/decisiv/json_api_client/compare/0.4.0...0.5.0
