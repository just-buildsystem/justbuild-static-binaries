# Justbuild Static Binaries

Reproducible Justbuild binaries can be obtained by building and *statically*
linking with the [musl libc](https://musl.libc.org/). To achieve reproducibility
that is independent of the `x86_64` Linux build host, the
[compiler toolchain](https://github.com/just-buildsystem/bootstrappable-toolchain)
is acquired via [**Bootstrappable Builds**](https://bootstrappable.org/).

## Predictable Binaries

Independent of the `x86_64` Linux build host, we can predict that for

- **Justbuild Version:** v1.3.1
- **Toolchain:** gcc-14.1.0-musl+tools

binaries with the following hashes will be produced:

- [Git blob IDs for `x86_64`](hashes/x86_64.GITBLOBIDS)
- [Git blob IDs for `arm64`](hashes/arm64.GITBLOBIDS)
- [SHA256 checksums for `x86_64`](hashes/x86_64.SHA256SUMS)
- [SHA245 checksums for `arm64`](hashes/arm64.SHA256SUMS)

## How to Build and Verify

First, install [Justbuild](https://github.com/just-buildsystem/justbuild) and
make sure to fulfill the
[toolchain requirements](https://github.com/just-buildsystem/bootstrappable-toolchain#initial-requirements).

For building, clone this repository and run:

``` sh
$ just-mr build
```

For verifying Git blob IDs, run:

``` sh
$ just-mr build --dump-artifacts - | diff hashes/x86_64.GITBLOBIDS -
```

For verifying SHA256 checksums (requires `install`), run:

``` sh
$ just-mr install -o .
$ sha256sum -c hashes/x86_64.SHA256SUMS
```

*Note that to obtain cross-compiled binaries for `arm64`, you need to specify
`-D'{"TARGET_ARCH":"arm64"}'` for building and use `arm64.GITBLOBIDS` or
`arm64.SHA256SUMS` for verification.*
