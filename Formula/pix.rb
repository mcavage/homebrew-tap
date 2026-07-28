class Pix < Formula
  desc "Multi-model coding agent harness for Docker Sandboxes"
  homepage "https://github.com/mcavage/pix"
  # Required because Homebrew otherwise parses the archive suffix "arm64" as
  # version "64" and installs into Cellar/pix/64.
  version "0.1.11"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/mcavage/pix/releases/download/v0.1.11/pix_0.1.11_darwin_arm64.tar.gz"
      sha256 "fcc109465bbedc4267cbd744472eaffc3142b8f5f1fc26c4b7fb9481cea644c8"
    end
    on_intel do
      url "https://github.com/mcavage/pix/releases/download/v0.1.11/pix_0.1.11_darwin_amd64.tar.gz"
      sha256 "3d58529d7aa13b93062b3c49d2dced8a95604704ea85a5f6751890a6b6b07e13"
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
