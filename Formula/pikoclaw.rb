class Pikoclaw < Formula
  desc "High-performance AI agent for developers"
  homepage "https://github.com/PikoClaw/pikoclaw"
  version "0.3.8"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/PikoClaw/pikoclaw/releases/download/v#{version}/pikoclaw-macos-aarch64"
      sha256 "223d83bea19e894039e7f2e903a5a3fc14939c9d16b177aea851c93da0212e20"
    end
    on_intel do
      url "https://github.com/PikoClaw/pikoclaw/releases/download/v#{version}/pikoclaw-macos-x86_64"
      sha256 "884062136cb2aaeb68de2afd79c3030e12eea3806fe8cddd5e332d336789ed11"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/PikoClaw/pikoclaw/releases/download/v#{version}/pikoclaw-linux-x86_64"
      sha256 "6813e5e4b711c0d9a9284a11bcee3b8e594d01880079a2d309ed52be186bf5be"
    end
  end

  def install
    if OS.mac?
      bin.install "pikoclaw-macos-aarch64" => "pikoclaw" if Hardware::CPU.arm?
      bin.install "pikoclaw-macos-x86_64" => "pikoclaw" if Hardware::CPU.intel?
    elsif OS.linux?
      bin.install "pikoclaw-linux-x86_64" => "pikoclaw"
    end
  end

  def caveats
    <<~EOS
      Set your Anthropic API key before use:
        export ANTHROPIC_API_KEY=sk-ant-...

      Add this to your shell profile (~/.zshrc or ~/.bashrc) to persist it.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pikoclaw --version")
  end
end
