class Pix < Formula
  desc "Multi-model coding agent harness for Docker Sandboxes"
  homepage "https://github.com/mcavage/pix"
  # Required because Homebrew otherwise parses the archive suffix "arm64" as
  # version "64" and installs into Cellar/pix/64.
  version "0.1.16"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/mcavage/pix/releases/download/v0.1.16/pix_0.1.16_darwin_arm64.tar.gz"
      sha256 "fec995c62808220d827425a45123dc0530c4283de5c6ba88e3f4424a94d178b1"
    end
    on_intel do
      url "https://github.com/mcavage/pix/releases/download/v0.1.16/pix_0.1.16_darwin_amd64.tar.gz"
      sha256 "305590be1e40ba84f813044ecb08e48ca639a0bd5b69f78111d2b0275d0b6038"
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
