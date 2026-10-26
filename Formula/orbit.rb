class Orbit < Formula
  desc "Distribute Git-backed skills, workflows, scripts, and commands"
  homepage "https://github.com/HuangChenning/orbit-cli"
  url "https://github.com/HuangChenning/orbit-cli/releases/download/v2.1.0/orbit_2.1.0_linux_amd64.tar.gz"
  sha256 "e6d8d39c8326be0a058c69d838765edfecc644faf78f01ebc311c79f643e45ec"
  license "MIT"

  uses_from_macos "git"

  on_macos do
    depends_on macos: :ventura

    on_arm do
      url "https://github.com/HuangChenning/orbit-cli/releases/download/v2.1.0/orbit_2.1.0_darwin_arm64.tar.gz"
      sha256 "f29adca20f5a3b681683a703daba68ff65633b928622ded37e30a822af27f5cb"
    end
    on_intel do
      url "https://github.com/HuangChenning/orbit-cli/releases/download/v2.1.0/orbit_2.1.0_darwin_amd64.tar.gz"
      sha256 "3c6baadbf97e0bd14686741781573b1fd2b0d0b70acda13484374f6ebd20fcc4"
    end
  end

  on_linux do
    depends_on arch: :x86_64
  end

  def install
    bin.install "orbit"
    doc.install "README.md", "README.zh-CN.md", "CHANGELOG.md"
  end

  def caveats
    <<~EOS
      Initialize your configuration with: orbit init
      Assets and configuration default to ~/.orbit.
      Upgrade this installation with: brew upgrade HuangChenning/tap/orbit
      Use brew upgrade instead of orbit update to keep Homebrew's version tracking accurate.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/orbit --version")
    system bin/"orbit", "init", "--path", testpath/"config"
    config = testpath/"config/orbit.yaml"
    assert_match 'version: "1.0"', config.read
    original = config.read
    shell_output("#{bin}/orbit init --path #{testpath}/config 2>&1", 1)
    assert_equal original, config.read, "Initialization must preserve existing configuration"
  end
end
