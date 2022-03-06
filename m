Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0174CEC2E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 17:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbiCFQBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 11:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiCFQBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 11:01:51 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB3A68F8A;
        Sun,  6 Mar 2022 08:00:59 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id h7so1760045ile.1;
        Sun, 06 Mar 2022 08:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=QccD7eNSgfKU2QlS5bqdDnSgDvMBGUtw/Y8Ns4tdASM=;
        b=a2stWlRcD4yCiqlfh9dOM01Mek1hvp4gGtBEw+AFzjS4dw/aGf6xVjIQRs1RWD37Cn
         fBCQU0IkwFRXHMLUKnnynW23Iw1sscxxNilH3ca0W9f9qBw+mcE6EnjFyNcF9/gKauhy
         KQ6dMwi3u7yHRDtBg+3O+O6OqWSAXY2pShdGEAtLEozp8yuLj2DC/Zy4kP08SY6Y4H5x
         jJpjJhCgXvxeAnTa2S/MD8RRuOf1ayLBcuuaee9i25QEnje+pDuYv2mWxHJ7ubpY8cxp
         Qb8abP2z3JWK7b8bMaXd8oBjvYv1+1d3531Dt6bOtPwrwpOmKcOCSKTRIZ5NNxklmRMz
         JyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=QccD7eNSgfKU2QlS5bqdDnSgDvMBGUtw/Y8Ns4tdASM=;
        b=EAjxeYgtUcmoKftdfW/c08oTwFXk/zX0B+tnb/6edpIjegRZTP4tPVAWDwoaZGnO/Y
         /11n82aJzm62dj5pjOZLx3ZoS51BKbqa/XYJoIiaSpzjD2zsVnleMmcuGfIlD1Mmn+SL
         VITEGLCgi0fE+l3wvqyNv9Z1NwSDSaSbBXXu34OSnTKZmypZa/32k3Jcj6yJKcJMXmKY
         /QFPE2fzvONo+ouWFP2zpde6e2xt/Q6BynD8vr2XtEhor2dtUADd/uVfCVWjNvdh1Ncb
         aaJIDJY0mq+QLVWssIeIwkIlP5vVn5BvtK3tx3klD3eiGU6BWciIgx+OevN8spMh1RDC
         rxfQ==
X-Gm-Message-State: AOAM530O5WjUC4fcQ1qHECydq7CZ9h7Ua1mYLmWtVTr+dS+kcFDRhsk5
        /llALXvg5XmEsqJWbaEb+KsihstFyrMX/OAfEsw=
X-Google-Smtp-Source: ABdhPJw2O8zA14WfTk20GoYCmEGyTdGhydeLsJ3ih+XfhDC0UktCQKAVmBFbu91+TYAbyd6h87vtoqYvlycNr0GTQa0=
X-Received: by 2002:a05:6e02:de2:b0:2c6:f14:884a with SMTP id
 m2-20020a056e020de200b002c60f14884amr7908645ilj.100.1646582458668; Sun, 06
 Mar 2022 08:00:58 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUWHd4VTKNwBtuxt9-fHoiYV+Q7tQ809Cn83k8sbQ_uNHw@mail.gmail.com>
 <YiPDaiYffeK4lF+l@krava> <CA+icZUW0XyDHFTYF_j1QECpqP4kmTXqCqX_HfEVvQ4aWZecW5Q@mail.gmail.com>
 <YiTWVjKwOO/bMNz/@krava>
In-Reply-To: <YiTWVjKwOO/bMNz/@krava>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 6 Mar 2022 17:00:22 +0100
Message-ID: <CA+icZUWBFAWx1DgN-nqUkr7W9W3hjhNRChEaXrfW5unoU_Lqdw@mail.gmail.com>
Subject: Re: [Linux-v5.17-rc6] Building tools/perf with perl v5.34
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 6, 2022 at 4:42 PM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Sun, Mar 06, 2022 at 03:28:09AM +0100, Sedat Dilek wrote:
> > On Sat, Mar 5, 2022 at 9:09 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Sat, Mar 05, 2022 at 08:52:18AM +0100, Sedat Dilek wrote:
> > > > Hi,
> > > >
> > > > I am here on Debian/unstable AMD64 which switched over to perl v5.3=
4
> > > > in February 2022.
> > > >
> > > > Unfortunately, my perf does not build with this (lib)perl version:
> > > >
> > > > $ ~/bin/perf -vv
> > > > perf version 5.17-rc6
> > > >                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
> > > >    dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
> > > >                 glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
> > > >         syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
> > > >                libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
> > > >                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
> > > >               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> > > > numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> > > >               libperl: [ OFF ]  # HAVE_LIBPERL_SUPPORT
> > > >             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
> > > >              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
> > > >             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
> > > >             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
> > > >    libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
> > > >                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
> > > >                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
> > > >             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
> > > >                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
> > > >                   aio: [ on  ]  # HAVE_AIO_SUPPORT
> > > >                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
> > > >               libpfm4: [ OFF ]  # HAVE_LIBPFM
> > > >
> > > > $ grep libperl ../make-log_perf-python3.10-install_bin.txt
> > > > 9:Makefile.config:788: Missing perl devel files. Disabling perl
> > > > scripting support, please install perl-ExtUtils-Embed/libperl-dev
> > > > 22:...                       libperl: [ OFF ]
> > > >
> > > > Checking for these requirements:
> > > >
> > > > # dpkg -l | grep perl | grep 5.34 | awk '/^ii/ {print $1 " " $2 " "
> > > > $3}' | column -t
> > > > ii  libperl-dev:amd64  5.34.0-3
> > > > ii  libperl5.34:amd64  5.34.0-3
> > > > ii  perl               5.34.0-3
> > > > ii  perl-base          5.34.0-3
> > > > ii  perl-modules-5.34  5.34.0-3
> > > >
> > > > # dpkg -L perl-modules-5.34 | grep -i ExtUtils | grep -i Embed
> > > > /usr/share/perl/5.34.0/ExtUtils/Embed.pm
> > > >
> > > > Can you please comment on this?
> > >
> > > hi,
> > > is there something in tools/build/feature/test-libperl.make.output ?
> > >
> >
> > Hey jirka!
> >
> > Indeed there is such a file.
> >
> > $ LC_ALL=3DC ll tools/build/feature/test-libperl.make.output
> > -rw-r--r-- 1 dileks dileks 24K Mar  6 03:22
> > tools/build/feature/test-libperl.make.output
> >
> > Reproducer:
> >
> > make distclean
> > make -C tools/perf clean
> >
> > MAKE=3D"make"
> > MAKE_OPTS=3D"HOSTCC=3Dclang-13 HOSTCXX=3Dclang++-13 HOSTLD=3Dld.lld-13
> > HOSTAR=3Dllvm-ar-13 CC=3Dclang-13 LD=3Dld.lld-13 AR=3Dllvm-ar-13 NM=3Dl=
lvm-nm-13
> > OBJCOPY=3Dllvm-objcopy-13 OBJDUMP=3Dllvm-objdump-13 OBJSIZE=3Dllvm-size=
-13
> > READELF=3Dllvm-readelf-13 STRIP=3Dllvm-strip-13 LLVM_IAS=3D1"
> >
> > LC_ALL=3DC $MAKE V=3D1 $MAKE_OPTS -C tools/perf PYTHON=3Dpython3 instal=
l-bin
>
> yea, looks like we can't compile perl devel includes with clang,
> we use simple perl test program:
>
>         $ cd tools/build/feature/
>         $ cat test-libperl.c
>         // SPDX-License-Identifier: GPL-2.0
>         #include <EXTERN.h>
>         #include <perl.h>
>
>         int main(void)
>         {
>                 perl_alloc();
>
>                 return 0;
>         }
>
>
> and if I compile it with:
>
>         $ CC=3Dclang make test-libperl.bin
>         clang  -MD -Wall -Werror -o test-libperl.bin test-libperl.c  > te=
st-libperl.make.output 2>&1 `perl -MExtUtils::Embed -e ccopts 2>/dev/null` =
-Wl,--enable-new-dtags -Wl,-z,relro -Wl,--as-needed -Wl,-z,now -specs=3D/us=
r/lib/rpm/redhat/redhat-hardened-ld -specs=3D/usr/lib/rpm/redhat/redhat-ann=
obin-cc1  -Wl,-z,relro -Wl,--as-needed -Wl,-z,now -specs=3D/usr/lib/rpm/red=
hat/redhat-hardened-ld -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1  -fs=
tack-protector-strong -L/usr/local/lib  -L/usr/lib64/perl5/CORE -lperl -lpt=
hread -lresolv -ldl -lm -lcrypt -lutil -lc
>         make: *** [Makefile:224: test-libperl.bin] Error 1
>
>
> I'm getting some other lto related error:
>
>         $ cat test-libperl.make.output
>         clang-13: error: optimization flag '-ffat-lto-objects' is not sup=
ported [-Werror,-Wignored-optimization-argument]
>

Hehe.

I was thinking about syncing the flags for both feature test-perl and
perf/libperl-support.

tools/build/feature/Makefile
tools/perf/Makefile.config

So, I guess FLAGS_PERL_EMBED differs.

For building perf '-ffat-lto-objects'  is filtered-out...

$ git grep ffat-lto-objects tools/perf/
tools/perf/Makefile.config:  PERL_EMBED_CCOPTS :=3D $(filter-out
-flto=3Dauto -ffat-lto-objects, $(PERL_EMBED_CCOPTS))

- Sedat -

>
> with my clang version:
>
>         $ clang --version
>         clang version 13.0.0 (Fedora 13.0.0-3.fc35)
>         Target: x86_64-redhat-linux-gnu
>         Thread model: posix
>         InstalledDir: /usr/bin
>
> so you need to figure out how to compile the test program
> above first with clang
>
> jirka
