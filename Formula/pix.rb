class Pix < Formula
  desc "Multi-model coding agent harness for Docker Sandboxes"
  homepage "https://github.com/mcavage/pix"
  version "0.1.8"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/mcavage/pix/releases/download/v0.1.8/pix_0.1.8_darwin_arm64.tar.gz"
      sha256 "2f03a904ea396a8f8542fcbc8c3ba900a85df5e5b5a2d89aa2fa5a846da00289"
    end
    on_intel do
      url "https://github.com/mcavage/pix/releases/download/v0.1.8/pix_0.1.8_darwin_amd64.tar.gz"
      sha256 "51683f12f3e6d9132f6235e8521463ed2622fd02ff4cd5ac8a92c2a29d583e20"
    end
  end

  def install
    bin.install "pix", "pix-host"
    man1.install "pix.1"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/pix version").strip
    assert_equal version.to_s, shell_output("#{bin}/pix-host version").strip
  end
end
