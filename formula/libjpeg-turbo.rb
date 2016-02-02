class LibjpegTurbo < Package

  desc "JPEG image codec that aids compression and decompression"
  homepage "http://www.libjpeg-turbo.org/"
  url "https://downloads.sourceforge.net/project/libjpeg-turbo/${version}/libjpeg-turbo-${version}.tar.gz"

  release version: '1.4.2', crystax_version: 1, sha256: '30d8b801c59e22ee530805ffeb03f8cc5331bf83968897acf4178a9222b5f022'

  build_libs 'libturbojpeg', 'libjpeg'
  build_copy 'LICENSE.txt'
  build_options sysroot_in_cflags: false

  def build_for_abi(abi, _toolchain, _release, _dep_dirs)
    args =  [ "--prefix=#{install_dir_for_abi(abi)}",
              "--host=#{host_for_abi(abi)}",
              "--enable-shared",
              "--enable-static",
              "--with-pic",
              "--disable-ld-version-script"
            ]
    args << '--without-simd' if abi == 'mips'

    build_env['CFLAGS'] << ' -mthumb' if abi =~ /^armeabi/

    system './configure', *args
    system 'make', '-j', num_jobs
    system 'make', 'install'
  end
end
