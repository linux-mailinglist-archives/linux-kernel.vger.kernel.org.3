Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64464CE876
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 04:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiCFDUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 22:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbiCFDUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 22:20:34 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771DE57B35;
        Sat,  5 Mar 2022 19:19:36 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id d62so13546775iog.13;
        Sat, 05 Mar 2022 19:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ZITXdt/8LIdBAYW+kwAAqKHdh3MHm06/0AwdlQzCFG8=;
        b=WG2JNoQHfNI9CWi3N4XBjW/3oaAJch7P7Ydx/w25iQIGVAsXZbOMQp196RUBNpMdTK
         o+2YxrO69qrn9L89nt26U2Sgza5adCVZoe7o91cZfnwzxmC8sHQNNidRXZc9ZF4+ng7E
         SySlcvRjZLlslAfNJ9JH0s5dw7oVY6Gh7S90VeJ32mDJfpoQbsJoGeRvp5fAWSvgAL6L
         Asoonzd7rRytSEueNQ2BuzH0EbUqn8lEN7feeXxpSm5Gdulgg6ZZqierZbA1cpIsv55N
         /KLMDRAlw9iE6Adpwq6+yZcbB9LbDN1cB5m01N0NTkJ/8kSkwAKBA6Yt5yZYWI+3sWS2
         EPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ZITXdt/8LIdBAYW+kwAAqKHdh3MHm06/0AwdlQzCFG8=;
        b=kXCFym8FQWXieHm++sJO+YZc0AE3xbLp34qhia7/5Bg3do5D0DTd8NbJdj2EVICdg7
         6H0MvY8O0ULtCfKXgASza38Lye2lO60eyp9NAzN+2+4KKRn0dJflYxsOxK2/bSh/q+eC
         WWWpX2iyBMKzvyWcNqJUD4MSPgDpdRlJvWiD/1YfnOXWPc8shkyZ/CYoFJ3BXs74lxKD
         0sBtVF3PQSkI/nNIVyD+SjA1k1VwUUJnF75mAS+9csrAql84s859TyiGGLSvhsftFkNs
         VPVbV0yayrYGMYp70uFh6xsi1jwKISkeVf5S6Ol5e7pckcSQjGK7vuvarIIm1q5N3zJf
         i5Dg==
X-Gm-Message-State: AOAM532e9EWiF3CCFpPlkDtl7V5Yp0rOzDJEjaOKifsA67Ki7YS88BD+
        NLHnBq1QX7zlm5xuBrStuceZ9QDjO71piuJKh1c=
X-Google-Smtp-Source: ABdhPJxeDSKiJBdLvgonJlBDLZpYT2eMdj9sLybI1U1R9RFgEFtu5ezS8cmN+7EDsuKJZmw0RC0sAdtarCRDOcuOdB4=
X-Received: by 2002:a05:6602:3ca:b0:63d:dfc8:fa66 with SMTP id
 g10-20020a05660203ca00b0063ddfc8fa66mr5086708iov.128.1646536775596; Sat, 05
 Mar 2022 19:19:35 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUWHd4VTKNwBtuxt9-fHoiYV+Q7tQ809Cn83k8sbQ_uNHw@mail.gmail.com>
 <YiPDaiYffeK4lF+l@krava> <CA+icZUW0XyDHFTYF_j1QECpqP4kmTXqCqX_HfEVvQ4aWZecW5Q@mail.gmail.com>
In-Reply-To: <CA+icZUW0XyDHFTYF_j1QECpqP4kmTXqCqX_HfEVvQ4aWZecW5Q@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 6 Mar 2022 04:18:59 +0100
Message-ID: <CA+icZUUCO+gOPLZumu_rTOJz1_v7gRRYVzzEZ+RZPOZBmkqCQg@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 6, 2022 at 3:28 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sat, Mar 5, 2022 at 9:09 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Sat, Mar 05, 2022 at 08:52:18AM +0100, Sedat Dilek wrote:
> > > Hi,
> > >
> > > I am here on Debian/unstable AMD64 which switched over to perl v5.34
> > > in February 2022.
> > >
> > > Unfortunately, my perf does not build with this (lib)perl version:
> > >
> > > $ ~/bin/perf -vv
> > > perf version 5.17-rc6
> > >                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
> > >    dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
> > >                 glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
> > >         syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
> > >                libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
> > >                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
> > >               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> > > numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> > >               libperl: [ OFF ]  # HAVE_LIBPERL_SUPPORT
> > >             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
> > >              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
> > >             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
> > >             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
> > >    libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
> > >                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
> > >                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
> > >             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
> > >                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
> > >                   aio: [ on  ]  # HAVE_AIO_SUPPORT
> > >                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
> > >               libpfm4: [ OFF ]  # HAVE_LIBPFM
> > >
> > > $ grep libperl ../make-log_perf-python3.10-install_bin.txt
> > > 9:Makefile.config:788: Missing perl devel files. Disabling perl
> > > scripting support, please install perl-ExtUtils-Embed/libperl-dev
> > > 22:...                       libperl: [ OFF ]
> > >
> > > Checking for these requirements:
> > >
> > > # dpkg -l | grep perl | grep 5.34 | awk '/^ii/ {print $1 " " $2 " "
> > > $3}' | column -t
> > > ii  libperl-dev:amd64  5.34.0-3
> > > ii  libperl5.34:amd64  5.34.0-3
> > > ii  perl               5.34.0-3
> > > ii  perl-base          5.34.0-3
> > > ii  perl-modules-5.34  5.34.0-3
> > >
> > > # dpkg -L perl-modules-5.34 | grep -i ExtUtils | grep -i Embed
> > > /usr/share/perl/5.34.0/ExtUtils/Embed.pm
> > >
> > > Can you please comment on this?
> >
> > hi,
> > is there something in tools/build/feature/test-libperl.make.output ?
> >
>
> Hey jirka!
>
> Indeed there is such a file.
>
> $ LC_ALL=C ll tools/build/feature/test-libperl.make.output
> -rw-r--r-- 1 dileks dileks 24K Mar  6 03:22
> tools/build/feature/test-libperl.make.output
>
> Reproducer:
>
> make distclean
> make -C tools/perf clean
>
> MAKE="make"
> MAKE_OPTS="HOSTCC=clang-13 HOSTCXX=clang++-13 HOSTLD=ld.lld-13
> HOSTAR=llvm-ar-13 CC=clang-13 LD=ld.lld-13 AR=llvm-ar-13 NM=llvm-nm-13
> OBJCOPY=llvm-objcopy-13 OBJDUMP=llvm-objdump-13 OBJSIZE=llvm-size-13
> READELF=llvm-readelf-13 STRIP=llvm-strip-13 LLVM_IAS=1"
>
> LC_ALL=C $MAKE V=1 $MAKE_OPTS -C tools/perf PYTHON=python3 install-bin
>
> - Sedat -

With this diff:

$ git diff
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 1480910c792e..ef9b37c5c652 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -81,7 +81,7 @@ PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config

all: $(FILES)

-__BUILD = $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst
%.bin,%.c,$(@F)) $(LDFLAGS)
+__BUILD = $(CC) $(CFLAGS) -MD -Wall -Werror
-Wno-compound-token-split-by-macro -o $@ $(patsubst %.bin,%.c,$(@F))
$(LDFLAGS)
  BUILD = $(__BUILD) > $(@:.bin=.make.output) 2>&1

__BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst
%.bin,%.cpp,$(@F)) $(LDFLAGS)
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 913bf509bd17..c3e5bcf5264a 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -213,7 +213,7 @@ endif

# Treat warnings as errors unless directed not to
ifneq ($(WERROR),0)
-  CORE_CFLAGS += -Werror
+  CORE_CFLAGS += -Werror -Wno-compound-token-split-by-macro
  CXXFLAGS += -Werror
  HOSTCFLAGS += -Werror
endif

I am able to build with libperl support:

$ ~/bin/perf -vv
perf version 5.17-rc6
                dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
   dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
        syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
               libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
               libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
              libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
              libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
            libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
             libslang: [ on  ]  # HAVE_SLANG_SUPPORT
            libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
            libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
   libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                 zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                 lzma: [ on  ]  # HAVE_LZMA_SUPPORT
            get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                  bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                  aio: [ on  ]  # HAVE_AIO_SUPPORT
                 zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
              libpfm4: [ OFF ]  # HAVE_LIBPFM

Dunno if I need  "-Werror -Wno-compound-token-split-by-macro" for any
HOSTCXX/CXX flags.

- Sedat -
