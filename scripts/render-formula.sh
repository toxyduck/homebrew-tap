#!/usr/bin/env bash
set -euo pipefail

version="$1"
repository="$2"
checksums="$3"
output="$4"

[[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]
test "$repository" = "toxyduck/feuilleton"

checksum() {
  awk -v file="$1" '$2 == file { print $1 }' "$checksums"
}

darwin_arm64="$(checksum feuilleton-bun-darwin-arm64.tar.gz)"
darwin_x64="$(checksum feuilleton-bun-darwin-x64.tar.gz)"
linux_arm64="$(checksum feuilleton-bun-linux-arm64.tar.gz)"
linux_x64="$(checksum feuilleton-bun-linux-x64-baseline.tar.gz)"

for value in "$darwin_arm64" "$darwin_x64" "$linux_arm64" "$linux_x64"
do
  [[ "$value" =~ ^[0-9a-f]{64}$ ]]
done

mkdir -p "$(dirname "$output")"
cat > "$output" <<FORMULA
class Feuilleton < Formula
  desc "Terminal-native visualizations for Codex and Claude Code"
  homepage "https://github.com/$repository"
  version "$version"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/$repository/releases/download/v$version/feuilleton-bun-darwin-arm64.tar.gz"
      sha256 "$darwin_arm64"
    else
      url "https://github.com/$repository/releases/download/v$version/feuilleton-bun-darwin-x64.tar.gz"
      sha256 "$darwin_x64"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/$repository/releases/download/v$version/feuilleton-bun-linux-arm64.tar.gz"
      sha256 "$linux_arm64"
    else
      url "https://github.com/$repository/releases/download/v$version/feuilleton-bun-linux-x64-baseline.tar.gz"
      sha256 "$linux_x64"
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
FORMULA
