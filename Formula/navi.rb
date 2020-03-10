class Navi < Formula
  desc "Interactive cheatsheet tool for the command-line"
  homepage "https://github.com/denisidoro/navi"
  url "https://github.com/denisidoro/navi/archive/v2.0.2.tar.gz"
  sha256 "f32cb110c1255d3b8f17a59fccc51aa92e842ff731c004c2cecf66234c1a8c3d"

  bottle do
    cellar :any_skip_relocation
    sha256 "64b6dac7d4c689ab6aa5c88ef58369249af2d9a6ac44f56769685569a673dd56" => :catalina
    sha256 "64b6dac7d4c689ab6aa5c88ef58369249af2d9a6ac44f56769685569a673dd56" => :mojave
    sha256 "64b6dac7d4c689ab6aa5c88ef58369249af2d9a6ac44f56769685569a673dd56" => :high_sierra
  end

  depends_on "rust" => :build
  depends_on "fzf"

  def install
    (libexec/"cheats").install Dir["cheats/*"]
    (libexec/"shell").install Dir["shell/*"]
    system "cargo", "install", "--locked", "--root", prefix, "--path", "."
  end

  test do
    assert_match "navi " + version, shell_output("#{bin}/navi --version")
    (testpath/"cheats/test.cheat").write "% test\n\n# foo\necho bar\n\n# lorem\necho ipsum\n"
    assert_match "bar", shell_output("export RUST_BACKTRACE=1; #{bin}/navi --path #{testpath}/cheats best foo")
  end
end
