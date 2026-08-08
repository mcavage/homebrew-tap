class Pix < Formula
  desc "Multi-model coding agent harness for Docker Sandboxes"
  homepage "https://github.com/mcavage/pix"
  # Required because Homebrew otherwise parses the archive suffix "arm64" as
  # version "64" and installs into Cellar/pix/64.
  version "0.1.28"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/mcavage/pix/releases/download/v0.1.28/pix_0.1.28_darwin_arm64.tar.gz"
      sha256 "3ef6fc3482e36f8dbc053d8449a522afcae637dc5b09d43ee408a9716d9e66e5"
    end
    on_intel do
      url "https://github.com/mcavage/pix/releases/download/v0.1.28/pix_0.1.28_darwin_amd64.tar.gz"
      sha256 "560a187cf9306143f47d9a8a4d54372611f68bce1fdee7001c0589637e3eb300"
    end
  end

  def install
    bin.install "pix", "pix-host"
    # The tarball carries the notices that legally have to travel with these
    # binaries: LICENSE for pix's own MIT s2, and NOTICE.md /
    # THIRD_PARTY_NOTICES.md / licenses/MPL-2.0.txt for the MPL-2.0
    # go-plugin/yamux code linked into pix-host (MPL-2.0 s3.1). install.sh
    # places the same four next to the binaries it installs; Homebrew must
    # not be the one channel that drops them.
    doc.install "LICENSE", "NOTICE.md", "THIRD_PARTY_NOTICES.md", "licenses"
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
