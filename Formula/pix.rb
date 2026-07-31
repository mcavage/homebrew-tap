class Pix < Formula
  desc "Multi-model coding agent harness for Docker Sandboxes"
  homepage "https://github.com/mcavage/pix"
  # Required because Homebrew otherwise parses the archive suffix "arm64" as
  # version "64" and installs into Cellar/pix/64.
  version "0.1.21"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/mcavage/pix/releases/download/v0.1.21/pix_0.1.21_darwin_arm64.tar.gz"
      sha256 "fe0aab64d7b8ee4e45a6395e07637b41c4921fd79405c592bdf96cd6a097e213"
    end
    on_intel do
      url "https://github.com/mcavage/pix/releases/download/v0.1.21/pix_0.1.21_darwin_amd64.tar.gz"
      sha256 "27bc0e5e380d1778c190584bc516f2808150ea35a6dae923c8d608dc43853cf5"
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
