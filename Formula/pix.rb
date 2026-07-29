class Pix < Formula
  desc "Multi-model coding agent harness for Docker Sandboxes"
  homepage "https://github.com/mcavage/pix"
  # Required because Homebrew otherwise parses the archive suffix "arm64" as
  # version "64" and installs into Cellar/pix/64.
  version "0.1.14"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/mcavage/pix/releases/download/v0.1.14/pix_0.1.14_darwin_arm64.tar.gz"
      sha256 "d2f08df810bad42e63f4462af6ef336e7f090540e595d9b7803bf65feeb54786"
    end
    on_intel do
      url "https://github.com/mcavage/pix/releases/download/v0.1.14/pix_0.1.14_darwin_amd64.tar.gz"
      sha256 "9ce6fcd6648a7bb822f648b24e4a5ee4ad233cacea8d91673639b6a0463af17d"
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
