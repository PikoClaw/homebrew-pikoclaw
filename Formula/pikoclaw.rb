class Pikoclaw < Formula
  desc "High-performance AI agent for developers"
  homepage "https://github.com/PikoClaw/pikoclaw"
  version "0.9.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/PikoClaw/pikoclaw/releases/download/v#{version}/pikoclaw-macos-aarch64"
      sha256 "7c2e2e557a65d7dae3a68eb994ad9d249ca85c49f16160e2c31f2dd286344891"
    end
    on_intel do
      url "https://github.com/PikoClaw/pikoclaw/releases/download/v#{version}/pikoclaw-macos-x86_64"
      sha256 "e27db4c1fb79730ca03072b5a936707ba9494538ed6c327e82d58f583b7ac1ca"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/PikoClaw/pikoclaw/releases/download/v#{version}/pikoclaw-linux-x86_64"
      sha256 "46db7f7ea54f00f4b7335fc4c00046f619c3a1ba7f4eb52acaaa6aee25d1270d"
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
