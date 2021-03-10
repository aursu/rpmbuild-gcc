ARG centos=7.9.2009
FROM aursu/rpmbuild:${centos}-build

USER root
RUN yum -y install \
        /lib/libc.so.6 \
        /usr/lib/libc.so \
        /lib64/libc.so.6 \
        /usr/lib64/libc.so \
        dejagnu \
        elfutils-devel \
        elfutils-libelf-devel \
        gcc-gnat \
        gettext \
        glibc-static \
        gmp-devel \
        libgnat \
        libmpc-devel \
        mpfr-devel \
        python-sphinx \
        python2-devel \
        python3-devel \
        sharutils \
        systemtap-sdt-devel \
        texinfo \
        texinfo-tex \
        zlib-devel \
    && yum clean all && rm -rf /var/cache/yum

RUN yum -y --enablerepo bintray-custom install \
        isl-devel \
    && yum clean all && rm -rf /var/cache/yum

COPY SOURCES ${BUILD_TOPDIR}/SOURCES
COPY SPECS ${BUILD_TOPDIR}/SPECS

RUN chown -R $BUILD_USER ${BUILD_TOPDIR}/{SOURCES,SPECS}

USER $BUILD_USER
ENTRYPOINT ["/usr/bin/rpmbuild", "gcc.spec"]
CMD ["-ba"]
