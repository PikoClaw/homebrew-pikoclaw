class Pikoclaw < Formula
  desc "High-performance AI agent for developers"
  homepage "https://github.com/PikoClaw/pikoclaw"
  version "1.0.10"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/PikoClaw/pikoclaw/releases/download/v#{version}/pikoclaw-macos-aarch64"
      sha256 "af32dae6fd68b7ab7bd64e8f89fef8e35f3fd132d9cf4e9a1dde53dda5bbd841"
    end
    on_intel do
      url "https://github.com/PikoClaw/pikoclaw/releases/download/v#{version}/pikoclaw-macos-x86_64"
      sha256 "73a1bf1cc0d32b4b3ac94e8d9f3fdd69f8bd655bae2aeecdb35dfdc54a42c54a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/PikoClaw/pikoclaw/releases/download/v#{version}/pikoclaw-linux-x86_64"
      sha256 "8f36e71453dbb48c6dd7774392c5728ca44c4978d9b747dac8cd1d83111f5370"
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
