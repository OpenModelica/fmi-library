FROM almalinux:10

USER root

# Install development tools and the system libraries used with
# FMILIB_EXTERNAL_LIBS=ON. minizip-ng-compat-devel (from EPEL) provides the
# minizip 1.x compatible unzip.h/zip.h headers.
# (curl is used by some VSCode extensions)
RUN dnf install -y epel-release && \
    dnf config-manager --set-enabled crb && \
    dnf install -y                                   \
        vim          tmux        doxygen             \
        cmake        gcc-c++     glibc-langpack-sv   \
        git          curl        valgrind            \
        ninja-build  sudo        make                \
        zlib-ng-compat-devel     expat-devel         \
        minizip-ng-compat-devel && \
    dnf clean all

# Give baseuser appropriate permissions
RUN useradd baseuser; \
    passwd  -d "baseuser"; \
    passwd  -d "root"; \
    usermod -a -G wheel baseuser

# Switch to baseuser
USER baseuser
