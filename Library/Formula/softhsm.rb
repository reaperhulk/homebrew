require "formula"

class Softhsm < Formula
  homepage "https://www.opendnssec.org/softhsm/"
  url "http://www.opendnssec.org/files/source/softhsm-1.3.7.tar.gz"
  sha1 "e8bf4269472f9e63d1dfeda238b1d542d6c036f2"

  depends_on 'botan'
  depends_on 'sqlite'

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--with-botan=#{Formula["botan"].opt_prefix}",
                          "--with-sqlite3=#{Formula["sqlite"].opt_prefix}"
    system "make", "install"
  end

  test do
    (testpath/'softhsm.conf').write <<-EOS.undent
      0:#{testpath}/slot0.db
    EOS
    ENV['SOFTHSM_CONF'] = "#{testpath}/softhsm.conf"
    system "#{bin}/softhsm", "--show-slots"
  end
end
