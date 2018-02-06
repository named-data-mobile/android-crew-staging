class Libffi < Package

  desc 'A portable foreign-function interface library'
  homepage 'https://github.com/libffi/libffi'
  url 'https://github.com/libffi/libffi/archive/v${version}.tar.gz'

  release version: '3.2.1', crystax_version: 1

  build_copy 'LICENSE'
  # build_libs 'libgmp', 'libgmpxx'
  # build_options use_cxx:              true,
  #               ldflags_in_c_wrapper: true

  def build_for_abi(abi, _toolchain, release, _host_dep_dirs, _target_dep_dirs, _options)
    install_dir = install_dir_for_abi(abi)
    args =  [ "--prefix=#{install_dir}",
              "--host=#{host_for_abi(abi)}",
              "--disable-silent-rules",
              "--enable-shared",
              "--enable-static",
              "--with-sysroot",
              "--includedir=#{install_dir}/include"
            ]

    system './autogen.sh'
    system './configure', *args
    system 'make', '-j', num_jobs
    system 'make', 'install'

    # todo: move to Package.build
    clean_install_dir abi, :lib, :share
  end
end
