class Pix < Formula
  desc "Multi-model coding agent harness for Docker Sandboxes"
  homepage "https://github.com/mcavage/pix"
  # Required because Homebrew otherwise parses the archive suffix "arm64" as
  # version "64" and installs into Cellar/pix/64.
  version "0.1.19"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/mcavage/pix/releases/download/v0.1.19/pix_0.1.19_darwin_arm64.tar.gz"
      sha256 "a8768e037b4fc223393429ff5cda9427da2cd17da3cbc6b498a267c0cd9d0bb7"
    end
    on_intel do
      url "https://github.com/mcavage/pix/releases/download/v0.1.19/pix_0.1.19_darwin_amd64.tar.gz"
      sha256 "f44b44de3b2ea5c153c48a8e085f7d8fa2b299763ea4427dd87e2b6ea7b224ed"
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
