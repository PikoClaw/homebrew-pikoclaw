class Pikoclaw < Formula
  desc "High-performance AI agent for developers"
  homepage "https://github.com/PikoClaw/pikoclaw"
  version "1.0.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/PikoClaw/pikoclaw/releases/download/v#{version}/pikoclaw-macos-aarch64"
      sha256 "b3fef5ac44a0d2f6ac15792517e3f9e65091ecb5f5d4e4a6da9408af04bfc701"
    end
    on_intel do
      url "https://github.com/PikoClaw/pikoclaw/releases/download/v#{version}/pikoclaw-macos-x86_64"
      sha256 "76ed87fbbf73ce3eb9b831ff448058b2143a4207add3e2bb30c204b35dda6f7a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/PikoClaw/pikoclaw/releases/download/v#{version}/pikoclaw-linux-x86_64"
      sha256 "40db261417c49374c63ab91188013e47f754edc480def5b754b0f14b39e451de"
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
