# Homebrew cask for Transfer Pro — rendered by .github/workflows/build.yml on a v* tag and
# pushed to the tap repo (Casks/transfer-pro.rb). 1.2.5, 65a2ede9019202cd5ef07f414f241aa3fae73b2e934eae8796557b1b12b5d427 and celsjunior/transfer-pro-releases
# are substituted there; do not edit the rendered file in the tap by hand, it is overwritten.
cask "transfer-pro" do
  version "1.2.5"
  sha256 "65a2ede9019202cd5ef07f414f241aa3fae73b2e934eae8796557b1b12b5d427"

  url "https://github.com/celsjunior/transfer-pro-releases/releases/download/v#{version}/Transfer-Pro-#{version}.zip",
      verified: "github.com/celsjunior/transfer-pro-releases/"
  name "Transfer Pro"
  desc "Copia, verifica e organiza cartões de câmera"
  homepage "https://github.com/celsjunior/transfer-pro-releases"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app is universal and targets macOS 14; the bundle refuses to launch below that.
  depends_on macos: ">= :sonoma"

  app "Transfer Pro.app"

  # Transfer Pro is signed ad-hoc (docs/BUILD.md, "Signing and distribution"), so the quarantine
  # flag Homebrew sets on the download would make macOS refuse to open it. Clearing it here is
  # what makes a plain `brew install --cask` work without `--no-quarantine`.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Transfer Pro.app"],
                   sudo: false
  end

  uninstall quit: "br.com.studiotakeo.transferpro"

  # Profiles, known cards and settings only go away with `brew uninstall --zap`.
  zap trash: [
    "~/Library/Application Support/Transfer Pro",
    "~/Library/Preferences/br.com.studiotakeo.transferpro.plist",
    "~/Library/Saved Application State/br.com.studiotakeo.transferpro.savedState",
  ]
end
