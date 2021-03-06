require 'formula'

class Kdelibs < Formula
  homepage 'http://www.kde.org/'
  url 'ftp://www.mirrorservice.org/sites/ftp.kde.org/pub/kde/stable/4.6.0/src/kdelibs-4.6.0.tar.bz2'
  sha1 '6ea3fc69f98fa91c5159ccd743d4d548e801c7bc'

  depends_on 'cmake' => :build
  depends_on 'automoc4' => :build
  depends_on 'gettext'
  depends_on 'pcre'
  depends_on 'jpeg'
  depends_on 'giflib'
  depends_on 'strigi'
  depends_on 'soprano'
  depends_on 'shared-desktop-ontologies'
  depends_on 'shared-mime-info'
  depends_on 'attica'
  depends_on 'docbook'
  depends_on 'd-bus'
  depends_on 'qt'
  depends_on 'libdbusmenu-qt'

  def patches
    # To fix https://bugs.kde.org/show_bug.cgi?id=209903. Committed upstream.
    "https://projects.kde.org/projects/kde/kdelibs/repository/revisions/f04c3a64885c652ab3dfb6f5dd2106409b027360/diff.diff"
    "https://projects.kde.org/projects/kde/kdelibs/repository/revisions/19f4bf0c212a28e79ef9b8d0cb35068951e58a85/diff.diff"
  end

  def install
    ENV.x11
    gettext_prefix = Formula.factory('gettext').prefix
    docbook_prefix = Formula.factory('docbook').prefix
    docbook_dtd = "#{docbook_prefix}/docbook/xml/4.5"
    docbook_xsl = Dir.glob("#{docbook_prefix}/docbook/xsl/*").first
    mkdir 'build' do
      system "cmake #{std_cmake_parameters} -DCMAKE_PREFIX_PATH=#{gettext_prefix} -DDOCBOOKXML_CURRENTDTD_DIR=#{docbook_dtd} -DDOCBOOKXSL_DIR=#{docbook_xsl} -DBUILD_doc=FALSE -DBUNDLE_INSTALL_DIR=#{bin} .."
      system "make install"
    end
  end
end
