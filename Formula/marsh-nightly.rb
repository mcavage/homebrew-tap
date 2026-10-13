# Homebrew formula for marsh and marsh-nightly. Rendered by
# scripts/render-formula.py by release CI and pushed to the tap
# (github.com/mcavage/homebrew-tap, Formula/marsh-nightly.rb).
# Do not edit the rendered copy; edit this template.
class MarshNightly < Formula
  desc "Bash-compatible shell whose agents and tools run in sandboxed containers (nightly build)"
  homepage "https://runmar.sh"
  url "https://github.com/mcavage/marsh/releases/download/v0.1.3-nightly.20261013074532.g6bac396/marsh-0.1.3-nightly.20261013074532.g6bac396-darwin-arm64.tar.gz"
  version "0.1.3-nightly.20261013074532.g6bac396"
  sha256 "da5919fe4024ff9722ef16817e0522593d8640b02bf4483af28c00b5c8fee416"
  license "Apache-2.0"

  conflicts_with "marsh", because: "both install marsh, msh, marshd and marsh-mcp"

  depends_on arch: :arm64
  depends_on :macos

  def install
    # marsh and marshd resolve their own symlinks to find the release tree
    # (bin/marshd and libexec/marsh), so plain links on PATH work.
    libexec.install "bin", "libexec", "share"
    %w[marsh msh marshd marsh-mcp].each do |name|
      bin.install_symlink libexec/"bin"/name
    end
    man1.install Dir[libexec/"share/man/man1/*.1"]
    prefix.install "LICENSE", "NOTICE"
  end

  # A formula cannot depend on a cask, and stock sbx ships only as the
  # docker/tap/sbx cask. The caveat below and marsh's own startup error (no
  # sbx on PATH) print the same command; keep them in step with
  # SBX_INSTALL_HINT in crates/marsh/src/client.rs.
  def caveats
    <<~EOS
      marsh needs Docker Sandboxes: brew install docker/tap/sbx; then `sbx login`
      (sbx 0.45.0 or newer). Then open a shell in a project:
        cd ~/your/project && marsh
      This is the nightly channel: every green commit on main, no stability promise.
      It shares ~/.marsh with a stable install. Stable: brew install mcavage/tap/marsh
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/marsh --version")
  end
end
