class Pix < Formula
  desc "Multi-model coding agent harness for Docker Sandboxes"
  homepage "https://github.com/mcavage/pix"
  # Required because Homebrew otherwise parses the archive suffix "arm64" as
  # version "64" and installs into Cellar/pix/64.
  version "0.1.22"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/mcavage/pix/releases/download/v0.1.22/pix_0.1.22_darwin_arm64.tar.gz"
      sha256 "13fea1bc3e0299f581cdaddeb74e3499713a8f97ffefe60c2a90f8d84047a95a"
    end
    on_intel do
      url "https://github.com/mcavage/pix/releases/download/v0.1.22/pix_0.1.22_darwin_amd64.tar.gz"
      sha256 "e9bc7f39beccb3924fb1f142a3ae874c3e6a4eb6d998859ee458a729419eadda"
    end
  end

  def install
    bin.install "pix", "pix-host"
    man1.install "pix.1"
  end

  def caveats
    <<~EOS
      Run `pix setup` to install prerequisites and finish onboarding.

      Before uninstalling this formula, run `pix state uninstall` FIRST.
      Then run `brew uninstall mcavage/tap/pix`. Reversing that order leaves
      launchd configured with a Cellar path that fails on its next launch.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/pix version").strip
    assert_equal version.to_s, shell_output("#{bin}/pix-host version").strip
  end
end
