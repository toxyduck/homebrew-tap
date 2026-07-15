class Feuilleton < Formula
  desc "Terminal-native visualizations for Codex and Claude Code"
  homepage "https://github.com/toxyduck/feuilleton"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/toxyduck/feuilleton/releases/download/v0.1.0/feuilleton-bun-darwin-arm64.tar.gz"
      sha256 "9f2e037c1245ba87a9b51ee6d45a618396002fc0b209a730fd28c616efdb643c"
    else
      url "https://github.com/toxyduck/feuilleton/releases/download/v0.1.0/feuilleton-bun-darwin-x64.tar.gz"
      sha256 "040911a852d1539fb141c023c8f73ca004d3a8070530d1924a977bc944deec96"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/toxyduck/feuilleton/releases/download/v0.1.0/feuilleton-bun-linux-arm64.tar.gz"
      sha256 "27363d88a1618d2fc11a1a68547b02b2ad4bf88eab1fb8144ab660f0b4dfa2f8"
    else
      url "https://github.com/toxyduck/feuilleton/releases/download/v0.1.0/feuilleton-bun-linux-x64-baseline.tar.gz"
      sha256 "5a4a080c87fc523d33b6480134636cbb81d1247d4c0ae28f49250b7ad908e2a0"
    end
  end

  def install
    bin.install "bin/ftn", "bin/ftn-codex", "bin/ftn-plot", "bin/ftn-tree", "bin/ftn-graph"
    (share/"feuilleton").install "share/feuilleton/integrations"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ftn --version")
  end
end
