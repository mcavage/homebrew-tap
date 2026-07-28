class Pix < Formula
  desc "Multi-model coding agent harness for Docker Sandboxes"
  homepage "https://github.com/mcavage/pix"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/mcavage/pix/releases/download/v0.1.10/pix_0.1.10_darwin_arm64.tar.gz"
      sha256 "bcc8a5de40ea4171b3a0a19a59210dcbd1b74b26be39bc55cb17ac5e4b435d20"
    end
    on_intel do
      url "https://github.com/mcavage/pix/releases/download/v0.1.10/pix_0.1.10_darwin_amd64.tar.gz"
      sha256 "560a818b5acd7a3d128ab041dcec607bf060824ef16da851213070b54db4098b"
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
