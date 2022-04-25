Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BA450E3CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242622AbiDYO65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237989AbiDYO6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:58:46 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C151F37A2D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:55:39 -0700 (PDT)
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MwQKr-1nzhfA4937-00sJlc for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022
 16:55:38 +0200
Received: by mail-wr1-f43.google.com with SMTP id t6so17816901wra.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:55:37 -0700 (PDT)
X-Gm-Message-State: AOAM531jlykXCI2DhIgUPBTmaZjlj85zzciECToGvbPyIRQeGV2B4VKZ
        WK6qxjicDQH9i6jdITYotK7Lzxgxv++9X3yKNOQ=
X-Google-Smtp-Source: ABdhPJxSd8ZyeTGZOPj78oBvP1GNKfn3p7PKESBi6v+jirKzSqx8kjeZVILhIHWlMlqwIEzjVbMrltfWr1Bdo16OtJM=
X-Received: by 2002:a5d:64a3:0:b0:20a:7931:5b84 with SMTP id
 m3-20020a5d64a3000000b0020a79315b84mr15049037wrp.407.1650898537609; Mon, 25
 Apr 2022 07:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <YmX7z+BirkA3VAfW@zx2c4.com> <CAK8P3a3Af5FBx-OnedHPrf28ikX4DZK1d0ERLsV+oKyBHyCXiw@mail.gmail.com>
 <YmaJUvg6hmekvkXE@zx2c4.com>
In-Reply-To: <YmaJUvg6hmekvkXE@zx2c4.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Apr 2022 16:55:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3FZeXzBJKyTEvmvw_DaHGQFf5rQKs=_wBW=GZ2+=rJ_Q@mail.gmail.com>
Message-ID: <CAK8P3a3FZeXzBJKyTEvmvw_DaHGQFf5rQKs=_wBW=GZ2+=rJ_Q@mail.gmail.com>
Subject: Re: odd endianness toolchains for crosstool
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:CThKNepJfnCLrWKWwSbgW6DUwvwCzaM1rGdoR0hVZiED2gwiEbJ
 UXUuLyxSRW0SEv15GCSprkO7dkQuHyMnHATL+DRqpNLrOaCO6Y4rC+DXns/kjx6nQhk8AyR
 vt61Qz4NldyFrXTG3IOH/y5Z2k4lDNoToJ6SKM1s4tjcYftvxqmVFqTxVQPk1wP255k+Pio
 gOVPlsjWy/IakSZG5ZKJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PiutwLZZgXI=:YDCFMKB/RO+hmpTDlYPeoS
 XCf/cj0cDveQAwDkXhpMIhxfee4OmPUwQnk4WhjO+G70MNookU60dk6RtfpCW++P6o+E5JrAG
 vsQqB+uYV+kE/+OpvNlGavLteH/rU0IsNZKkzon3HnpHZAV7aEVA1tJSSI0qiDUyuyRHHDIch
 Orehy3J4tD9/c2HY4ZCFZASaVWE9ypDpZ5UNpw/MSQtBOrBbuCe7u+2+KfnsLP6yaZVKKVIkQ
 9RW0YUh6QTQKzb9P4dm71hAWtdix307jqBD8Vp17L2wRB/aLafe5qisFAZ8J6tEouZ0RZ67Xw
 DL+tOBz8YNG0gc43NZLwW6DIY539D/eUBbLpjeIm37ZMyc0B0Iggx8NTAc8rcknkMUv6nXXxF
 nWzAXd+sxa3eDqxkXyyTunr+W0yxfZR3bCffwx2ipkSy3XU1vvLjIyaMbdiYjY/jeyh/jL2N9
 CC5KUKVf3MaB366F8s3SgnXGS3OtHKgyE7itfwmAGLtIQ7ucLerrVljLQ3Au36MNlkHU/sXlA
 KN+OvIPB3F5psF2/y9wLUcpKDbaAk3qG/nl01t+0CdPCvWAKOu21ePPomiaD1SB8FjQmAEp4p
 V0ZshMHxGmreCp4KDDZ6SOKFguqOsg897hKgW+hbY5FMv6qA8JFUBjrNSBpZlesO1H5OhriTP
 g7lBB/i/JxZX1qQLW+0hFvpWJyRuCKDkXES+OuRDQdQqwCnUPNFHTy8HYTjmjUsTYfBtN/yBP
 llcADMWzZfBY7Xprl+QrOPZRFsai94VZPj5Bzg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 1:43 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Mon, Apr 25, 2022 at 10:46:45AM +0200, Arnd Bergmann wrote:
> > The situation on my end is that I'm planning to migrate my main workstation
> > (which I'm building the compilers on) to an arm64 machine soon, and
> > will then need to set it all up again. I don't really want to change much before
> > then to avoid changing things twice.
>
> Ahh, okay, so probably crosstool won't be viable for me for a while. Are
> your existing scripts fairly reproducible and easy? I suppose I could
> just build my own if I can't find another project supplying light
> compilers.

The scripts are fairly solid, but the original git tree is no longer available
and my version has a couple of local changes with a bit of a dirty history
from adding support for cross-compiling the compilers themselves to
do the canadian-cross arm64 and ppc64le hosted ones.

There is another fork of the same tree on
https://github.com/nathanchance/buildall

The main issue with building distributable binaries is to actually build
them on an older rootfs to avoid linking against a newer glibc, and
to ensure the dependencies for gcc are statically linked. Without that,
the output is too distro specific.

> > I've added Nick to Cc, as he's experimenting with a clang based toolchain
> > that we can put on kernel.org along with the gcc toolchains, and that
> > would probably include a musl based sysroot roughly the same set of
> > architectures that you are testing on already. Possibly we could reuse the
> > same user space between clang and gcc.
>
> I personally have no use for compilers with user spaces. My test harness
> builds musl as part of it. It's really the quickest part of the entire
> harness to build. I also probably won't switch things over to clang;
> Google has the resources to do that themselves. Basically all I need is
> the boring nolibc compilers for a few extra platforms, and for the ppc
> one to build with the mentioned flags.

I suppose the only thing you are missing is libgcc (or libcompiler-rt)
for those platforms. I had a closer look into what is or can be included
here, and I see that my builds include multiple versions on some of
the  architectures, but not on others:

aarch64-linux/lib/gcc/aarch64-linux/11.1.0/libgcc.a
alpha-linux/lib/gcc/alpha-linux/11.1.0/libgcc.a
arc-linux/lib/gcc/arc-linux/11.1.0/libgcc.a
arc-linux/lib/gcc/arc-linux/11.1.0/hs/libgcc.a
arc-linux/lib/gcc/arc-linux/11.1.0/archs/libgcc.a
arc-linux/lib/gcc/arc-linux/11.1.0/hs38/libgcc.a
arc-linux/lib/gcc/arc-linux/11.1.0/hs38_linux/libgcc.a
arc-linux/lib/gcc/arc-linux/11.1.0/arc700/libgcc.a
arc-linux/lib/gcc/arc-linux/11.1.0/nps400/libgcc.a
arm-linux-gnueabi/lib/gcc/arm-linux-gnueabi/11.1.0/libgcc.a
...
powerpc-linux/lib/gcc/powerpc-linux/11.1.0/libgcc.a
powerpc-linux/lib/gcc/powerpc-linux/11.1.0/64/libgcc.a
powerpc-linux/lib/gcc/powerpc-linux/11.1.0/64/le/libgcc.a
powerpc-linux/lib/gcc/powerpc-linux/11.1.0/le/libgcc.a
powerpc-linux/lib/gcc/powerpc-linux/11.1.0/32/le/libgcc.a
powerpc64-linux/lib/gcc/powerpc64-linux/11.1.0/libgcc.a
powerpc64-linux/lib/gcc/powerpc64-linux/11.1.0/32/libgcc.a
powerpc64-linux/lib/gcc/powerpc64-linux/11.1.0/32/le/libgcc.a
powerpc64-linux/lib/gcc/powerpc64-linux/11.1.0/le/libgcc.a
powerpc64-linux/lib/gcc/powerpc64-linux/11.1.0/64/le/libgcc.a
mips-linux/lib/gcc/mips-linux/11.1.0/libgcc.a
mips-linux/lib/gcc/mips-linux/11.1.0/n32/libgcc.a
mips-linux/lib/gcc/mips-linux/11.1.0/64/libgcc.a
mips64-linux/lib/gcc/mips64-linux/11.1.0/libgcc.a
mips64-linux/lib/gcc/mips64-linux/11.1.0/32/libgcc.a
mips64-linux/lib/gcc/mips64-linux/11.1.0/64/libgcc.a

So on powerpc, there are already both big-endian and
little-endian binaries, but arm and mips only have one of the
two. I asked our local compiler experts, and they suggested
that one can add further multiarch-configs like the one
in gcc/config/arm/t-aprofile to allow building for a different
subset of the hundreds of possible configurations.

the t-aprofile builds libgcc for a couple of combinations of
cpu architecture level and FPU ABIs, but they are all the
same endianess. gcc/config/rs6000/t-linux64lebe is the
corresponding file for powerpc that enables all combinations
of 32/64 and be/le.

> > I've also looked at other projects that do qemu based testing, everyone
> > seems to be missing one or two architectures out of a common set,
> > https://tinyurl.com/linux-architectures is where I keep my data.
>
> If the compilers are there, and they can build a working musl, and QEMU
> will boot it, and I can work out a minimal kernel .config that doesn't
> take a long time to compile, then it'll get included in the CI. So in
> theory, I should be able to expand the portfolio of architectures I'm
> using.

Adding riscv and s390 should indeed be fairly simple to add,
and you can probably just take a look at what ktest does for them.

You have a good point about the minimal kernel config, which makes
sense for testing a single thing, but of course others generally want
to test a 'defconfig' build that is closer to what users would actually
run.

> > building and running the most common subset of these in one place
> > in the kernel tree where at least wireguard, kunit and tuxrun can
> > share the setup for qemu.
>
> I have little interest in that kind of abstraction unfortunately.

Ok, fair enough.

      Arnd
