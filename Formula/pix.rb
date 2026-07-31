class Pix < Formula
  desc "Multi-model coding agent harness for Docker Sandboxes"
  homepage "https://github.com/mcavage/pix"
  # Required because Homebrew otherwise parses the archive suffix "arm64" as
  # version "64" and installs into Cellar/pix/64.
  version "0.1.18"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/mcavage/pix/releases/download/v0.1.18/pix_0.1.18_darwin_arm64.tar.gz"
      sha256 "4ffd67716d9fd3779f40e09743f303951a61feea0b61dee9ac5e5620c99470fa"
    end
    on_intel do
      url "https://github.com/mcavage/pix/releases/download/v0.1.18/pix_0.1.18_darwin_amd64.tar.gz"
      sha256 "ed68f8c9942c74dbe5c875e99737991521ad021a37a8617f833121cc771159fe"
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
