Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D8E50DB8C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbiDYIuM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Apr 2022 04:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiDYIuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:50:08 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AD8FD01
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:47:03 -0700 (PDT)
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N45th-1ns1F10VMH-0103T5 for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022
 10:47:02 +0200
Received: by mail-wr1-f53.google.com with SMTP id x18so19813877wrc.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:47:02 -0700 (PDT)
X-Gm-Message-State: AOAM531EPNo/wRYjcYcH4DaLfChOHkzLtlsOHLojhY5CNRqAL8hMOZ8D
        +aQetBk01phSR+RL6W9r8SKEPQNH8sfljoaaees=
X-Google-Smtp-Source: ABdhPJzKEEqT156hhDyoVWPV6xNfk17tfnrdOOvt8sWpxVSGvD8nGBhsFCA5w5XGLcn6JlNi5zu22qGOjh5Ye1lgt14=
X-Received: by 2002:a5d:6da5:0:b0:20a:8805:6988 with SMTP id
 u5-20020a5d6da5000000b0020a88056988mr12725077wrs.317.1650876421763; Mon, 25
 Apr 2022 01:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <YmX7z+BirkA3VAfW@zx2c4.com>
In-Reply-To: <YmX7z+BirkA3VAfW@zx2c4.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Apr 2022 10:46:45 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Af5FBx-OnedHPrf28ikX4DZK1d0ERLsV+oKyBHyCXiw@mail.gmail.com>
Message-ID: <CAK8P3a3Af5FBx-OnedHPrf28ikX4DZK1d0ERLsV+oKyBHyCXiw@mail.gmail.com>
Subject: Re: odd endianness toolchains for crosstool
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:ydqJJOb4VjUv1w7q9Z/2VUmNq/v+w0zr880hKvg6q4LL3QTnqZP
 IEElHVVivHHlbbVgrGWZjMYFT29dnU6eEl2X+Szsn6cXtiRkMK9brU1CTuslvEzIlWXdKlc
 yKQ8I8TijJmaP4NYio0Ok5cfq523KDdIUqC1JOE9xVXmw/Q2Mwqou8ThdpW/m0khRLGywz5
 6xxFacfXMDOC6+QOtAeWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QDhG2jecTcs=:ZJL+ENtu8xENYjVeGpRDi7
 eUSWlar7ZcCt2u5JTv8PFMLwVmOtuKHGf7iXlAgkZDNjzsZDWOboj7IL+M2no2Dsk0yVKKB6t
 ZA84VDvHK1hSsz7ZDKUpVjIjer7jr3nW+EB46VuWxdXQxXDB/HCstq7+UQnUSABnH5PSMv75u
 Hd+0bZQG8uMnWOt6aQUTLyrj0OQtDcUp07aRwNaSyA5mZGh+fv3qjOWlAkju6C7/f097TWbxa
 l6KjekOD+E+qIfTmrMqW+T4TEiayThhpsOlNhIq/mf1K0ZNcGGdMCZtnKnxMxfVbwa5azSHmr
 l3p91EJBeUwHzBu9ouGeaSZDmNZHOQOz/5NCv5YxgQOkBxkiuODGXHMp4tXxnT0Pq8894+UV8
 5hrPPr8EqxQvXzyVwyzEBwGqUF9vUUkENf2TGm77vwdaVWUtjFOcfBvaWOOg7/lkhfSOwlXoK
 ALgXgsDk6DBZUMAcdJL2gmWHVOdDdAa2w5oPxHRpTyGeuEVwNC5Vhr9rZZTYDQss21qtZ+GwO
 ggPHFj3eIucu5464ltXYlpKUeJ0tWYbEh7j7B2dzDtWPy7fVWBiFi6BO6HFU7E+NjU+3oUe/Q
 gFDzhojUajWRg9QsXsKRRyHKuHcREsuJHcKBPlP1ydsGTKUdR2jY8vW34wgQ0d+M8xiLlha3v
 1FmsOMmC3oTt+4THeGgGhPXzE/W91QdS17hIMe9xCaQKJpEpifXmpwsx0FajCxHiQeTklnYUa
 lwxFA1/DGUbt7ycu0HCtudEfSTt2eXs2sCsWeg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 3:39 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hey Arnd,
>
> I'm again experimenting with switching to your crosstool toolchains for
> WireGuard's CI. I've hit a few snags in the process:
>
> - For powerpc, gcc needs to be built with `--enable-secureplt
>   --with-long-double-64` in order for musl to run.
> - Need powerpc64le compiler (-mabi=elfv2).
> - Need mipsel compiler.
> - Need aarch64_be compiler.
> - Need armeb compiler.
> - Need mips64el compiler.
>
> While the existing compilers can all produce code for the wrong endian,
> they hit trouble when trying to link against libgcc. So generally a
> separate full toolchain is supplied for the less common endians.

Hi Jason,

I'm definitely interested in improving the user space testing,  and I agree
we need the powerpc64le and mipsel targets at the minimum for that.

The situation on my end is that I'm planning to migrate my main workstation
(which I'm building the compilers on) to an arm64 machine soon, and
will then need to set it all up again. I don't really want to change much before
then to avoid changing things twice.

I've added Nick to Cc, as he's experimenting with a clang based toolchain
that we can put on kernel.org along with the gcc toolchains, and that
would probably include a musl based sysroot roughly the same set of
architectures that you are testing on already. Possibly we could reuse the
same user space between clang and gcc.

> I have had success with arm, arm64, mips, x86_64, i386, m68k. If you're
> up for adding the above compilers to the collection, I'd be able to
> complete the transition, and then look into adding a few more
> architectures.

I've also looked at other projects that do qemu based testing, everyone
seems to be missing one or two architectures out of a common set,
https://tinyurl.com/linux-architectures is where I keep my data.

The most common subset of architectures that get tested as far
as I can tell is x86, arm64, powerpc, arm, riscv, mips, s390: those
are the ones that support all the important pieces (gcc, clang, musl,
glibc, qemu, debian and buildroot) and that have the most users.
The exceptions to this are I think:

* your wireguard tests are missing riscv and s390 tests, those should
  be easy to add. You do support m68k, which the others are missing
* kunit is missing mips tests, but has alpha and sparc
* tuxrun[1] adds sparc64, sh4 and armv5 (softfp), could add rv32
* Günter's linux-build-test[2] has all the above, plus microblaze,
  nios2, parisc, shbe, and xtensa

What I'd really like to see is to have the necessary information for
building and running the most common subset of these in one place
in the kernel tree where at least wireguard, kunit and tuxrun can
share the setup for qemu. One idea I had was to encode the
platform specific qemu command line options using Kconfig
dependencies in a way that "make O=obj ARCH=foo defconfig zImage;
obj/run-qemu" results in a booting kernel on a lot of the typical
defconfigs for supported architectures.

       Arnd

[1] https://gitlab.com/Linaro/tuxrun/-/blob/master/tuxrun/devices/qemu.py
[2] https://github.com/groeck/linux-build-test/tree/master/rootfs
