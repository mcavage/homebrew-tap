class Pix < Formula
  desc "Multi-model coding agent harness for Docker Sandboxes"
  homepage "https://github.com/mcavage/pix"
  # Required because Homebrew otherwise parses the archive suffix "arm64" as
  # version "64" and installs into Cellar/pix/64.
  version "0.1.15"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/mcavage/pix/releases/download/v0.1.15/pix_0.1.15_darwin_arm64.tar.gz"
      sha256 "b0fe6b0dbb61ff612433252d26736c83502350102617c6ee0dc0b4f09f25f02b"
    end
    on_intel do
      url "https://github.com/mcavage/pix/releases/download/v0.1.15/pix_0.1.15_darwin_amd64.tar.gz"
      sha256 "fc78b043a449491b94aee2c32f710b0b558b02629daf4f5a4280389d893c0d2d"
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
