class Orbit < Formula
  desc "Distribute Git-backed skills, workflows, scripts, and commands"
  homepage "https://github.com/HuangChenning/orbit-cli"
  url "https://github.com/HuangChenning/orbit-cli/releases/download/v2.0.0/orbit_2.0.0_linux_amd64.tar.gz"
  version "2.0.0"
  sha256 "0ec74ddcea809bb6930aec42c38c647bda5a93c129d9c730517b7b54252ac14b"
  license "MIT"

  uses_from_macos "git"

  on_macos do
    depends_on macos: :ventura

    on_arm do
      url "https://github.com/HuangChenning/orbit-cli/releases/download/v2.0.0/orbit_2.0.0_darwin_arm64.tar.gz"
      sha256 "7c4002cdb277d9e0f9d8d81bc3e258c4cc7e442c71716e55bd1104fc07de48d1"
    end
    on_intel do
      url "https://github.com/HuangChenning/orbit-cli/releases/download/v2.0.0/orbit_2.0.0_darwin_amd64.tar.gz"
      sha256 "fda5492b579290b50fecf965d0750a1d84c00b1d7c7f8a845d06e5f8ee9f2174"
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
