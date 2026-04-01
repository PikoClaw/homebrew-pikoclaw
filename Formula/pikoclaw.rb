class Pikoclaw < Formula
  desc "High-performance AI agent for developers"
  homepage "https://github.com/PikoClaw/pikoclaw"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/PikoClaw/pikoclaw/releases/download/v#{version}/pikoclaw-macos-aarch64"
      sha256 "bae9d13cf670da9229f3cea378d885c52d630ddd2ed5c29f2c0a5caa8bbb34fc"
    end
    on_intel do
      url "https://github.com/PikoClaw/pikoclaw/releases/download/v#{version}/pikoclaw-macos-x86_64"
      sha256 "cc521e1e764a29c40889f46faada5e8ee38d6941c6d347434bd032cf388308f0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/PikoClaw/pikoclaw/releases/download/v#{version}/pikoclaw-linux-x86_64"
      sha256 "d12228e47e3544c8e58b7ac705c41feddb44200d8ad93156cf6337e9a80665a3"
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
