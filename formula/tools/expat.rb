class Expat < BuildDependency

  desc "XML 1.0 parser"
  homepage "http://expat.sourceforge.net"
  url "https://downloads.sourceforge.net/project/expat/expat/${version}/expat-${version}.tar.bz2"

  release version: '2.2.0', crystax_version: 1, sha256: { linux_x86_64:   'f9cd960399d7b842f5035ae31528255ff4cdcd503b7e811ee4f4c539eadd9423',
                                                          darwin_x86_64:  '9643910c15323695200b26d482dc8085870a5ab1229922001dc7c9aeabca5300',
                                                          windows_x86_64: 'f74b64ff4de92745418a57d23ae5a54307880b704eebd6a632c90f8348c89f1d',
                                                          windows:        '8cd07504302f8d8c4d56794386582406184fa8cb916a292d90c93dfabc9b250b'
                                                        }


  def build_for_platform(platform, release, options, _host_dep_dirs, _target_dep_dirs)
    install_dir = install_dir_for_platform(platform, release)

    args = ["--prefix=#{install_dir}",
            "--host=#{platform.configure_host}",
            "--disable-shared"
           ]

    system "#{src_dir}/configure", *args
    system 'make', '-j', num_jobs
    system 'make', 'check' if options.check? platform
    system 'make', 'install'

    # remove unneeded files before packaging
    FileUtils.cd(install_dir) { FileUtils.rm_rf ['bin', 'share', 'lib/pkgconfig'] + Dir['lib/*.la'] }
  end
end
