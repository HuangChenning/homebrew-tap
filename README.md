# Homebrew tap

Install [Orbit CLI](https://github.com/HuangChenning/orbit-cli) from its published, SHA256-verified release archives:

```sh
brew install HuangChenning/tap/orbit
orbit --version
orbit init
```

Supports macOS 13+ on Apple Silicon and Intel, and Linux amd64. Go and Python are not required. Git is provided by macOS or installed as a dependency on Linux. Configuration and assets default to `~/.orbit`; installing or uninstalling this formula does not change those files.

Upgrade using Homebrew so its version tracking stays accurate:

```sh
brew update
brew upgrade HuangChenning/tap/orbit
```

Use these commands instead of `orbit update` for the Brew installation. `orbit update check` remains available to check the latest stable release.

If a manual installation appears first in PATH, `command -v orbit` identifies it. Run `"$(brew --prefix orbit)/bin/orbit" --version` to check the Brew copy directly, then adjust PATH to select the desired installation.

## Maintaining Orbit

After publishing a stable Orbit release:

1. Create a branch and update `Formula/orbit.rb`: version, the three release archive URLs, and their complete SHA256 values from the release's `SHA256SUMS`. Never replace an archive for an existing version.
2. Install the changed formula with `brew install HuangChenning/tap/orbit` (or `brew reinstall` if already installed). Then run `brew readall --os=all --arch=all HuangChenning/tap` and `brew test HuangChenning/tap/orbit`.
3. Open a pull request. The installation workflow tests the PR's formula on macOS arm64, macOS amd64, and Linux amd64. Merge after review and successful checks. Users receive the updated formula through `brew update`.

For a local checkout, first register it with `brew tap HuangChenning/tap /absolute/path/to/homebrew-tap`. Existing taps can use `brew tap --custom-remote HuangChenning/tap /absolute/path/to/homebrew-tap` in a disposable test environment. Restore the public remote before normal upgrades.

This tap installs upstream release binaries, rather than building Homebrew bottles. Publishing an Orbit release alone does not update this tap; its formula update must also be reviewed and merged.
