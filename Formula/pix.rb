class Pix < Formula
  desc "Multi-model coding agent harness for Docker Sandboxes"
  homepage "https://github.com/mcavage/pix"
  # Required because Homebrew otherwise parses the archive suffix "arm64" as
  # version "64" and installs into Cellar/pix/64.
  version "0.1.20"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/mcavage/pix/releases/download/v0.1.20/pix_0.1.20_darwin_arm64.tar.gz"
      sha256 "c09c3d733791f2afdf3b17dd2ce421aa51bf5f05f2f8bf38ab82b29e3ffb961d"
    end
    on_intel do
      url "https://github.com/mcavage/pix/releases/download/v0.1.20/pix_0.1.20_darwin_amd64.tar.gz"
      sha256 "abe60094410970cd57d335e8049e4b5f4cb10b4a6aacecb8eddb50e31a7d7de0"
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
