class Feuilleton < Formula
  desc "Terminal-native visualizations for Codex and Claude Code"
  homepage "https://github.com/toxyduck/feuilleton"
  version "0.1.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/toxyduck/feuilleton/releases/download/v0.1.1/feuilleton-bun-darwin-arm64.tar.gz"
      sha256 "c4aaf4ca27af48104f0a0a988ed737b3360692aa54adc8caaa133c49d91c930b"
    else
      url "https://github.com/toxyduck/feuilleton/releases/download/v0.1.1/feuilleton-bun-darwin-x64.tar.gz"
      sha256 "b8656bf3968ea80915b2a8366252c1c41e3d23af38581ff3cc49696d2abfbe2f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/toxyduck/feuilleton/releases/download/v0.1.1/feuilleton-bun-linux-arm64.tar.gz"
      sha256 "63dff95bdfe21b0793df1d463a0d469edf5f31d57fc46dfd2d2fef73716fd326"
    else
      url "https://github.com/toxyduck/feuilleton/releases/download/v0.1.1/feuilleton-bun-linux-x64-baseline.tar.gz"
      sha256 "4436da0e4143ada6666e06906f1d632b0168b756830c7dfbd0b6745d3834f47b"
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
