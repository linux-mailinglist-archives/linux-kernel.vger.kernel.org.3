Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD384CE46B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 12:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiCELMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 06:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiCELMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 06:12:49 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD42580C3;
        Sat,  5 Mar 2022 03:11:59 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id r8so12228285ioj.9;
        Sat, 05 Mar 2022 03:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=WWytVZibtRPywRB6Mck+JDJeinanVwzEpaOU6BzFGn8=;
        b=l+2fxzK7shuiDrImoKUHu7PRWY6mYWhFu1iCCe+ocJMWzdKrPyId/X/U12cjR0BNrL
         3DrGJ266eQY2a/IuO0SIx3Fe9ub7cFsaLyxi4lJj2x5j3+YVkiKne8DWPyDn+/rXbeaX
         5hShiOHVh3wXzJ9gYgS4srACCN+kvZOeFwUH37KYrndSNo1jKV/wNRPQCQt7D9wHeZjO
         NQh+VjzR/M6ehLk8SJl7bE5wtVf16nDM8YpVoZMbZoPEflDNQc0BwiuC8JkRk/n4yLmj
         vhveo8Q6hF7fEE2/Crunb54GvEX7wDvDgwB+pvGR2HyQafBB0luQYneXroopHKQD9y5T
         TBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=WWytVZibtRPywRB6Mck+JDJeinanVwzEpaOU6BzFGn8=;
        b=Ar/0zDlkAiZ1zuDRNuDeX9QpApYwsQM2t8bUHDQIvDU9wl9boi7sr2TESYm8IuSOCH
         oyq5m2qXRyv0j8fQoi5DewBkc++pEns2+gPx/KEhmN9fOUZV6mWyfm0NVSLyKlu+aRLw
         V78JAKqmrUU0Xn/C9qsxuzS/sqJ+ciUtw13luuOhVBXwDaU/7kc/VVtj4JurE3OcLLjv
         m+2FzpEhoV2QSYeRTn11uYBLbM89UHLY82euElxEQK0vv5+DCidRAJn0DWTngvwfuXd6
         GwyD2q5ZVrusSTX/XwTgZKQl1A3UWnO6Z5rgMydfrv/NAh9dpuk69nV+rF/aQR7ngUIW
         ECkQ==
X-Gm-Message-State: AOAM533Sq/YAEmOp6PQGahR9IsRg1EhOpeItvSHXFrvGzxIj8tj1UWaa
        BWAgI+vElPyvAKDxPF2+f6WHwUby1hQsSu+OXB0=
X-Google-Smtp-Source: ABdhPJxABf3kiJ9pEGvbNV+3GgtfJjZHeN+hzyfUu+qq/TYfxPHcJRjHbj2FVOBOrYwovko5E6PFuGdgu2giztFJDQo=
X-Received: by 2002:a05:6638:3462:b0:314:199a:aad4 with SMTP id
 q34-20020a056638346200b00314199aaad4mr2580585jav.52.1646478718779; Sat, 05
 Mar 2022 03:11:58 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUWHd4VTKNwBtuxt9-fHoiYV+Q7tQ809Cn83k8sbQ_uNHw@mail.gmail.com>
 <CA+icZUW7LESaDG5gLQs9kOJp=0Anp=+jNb8L1u91iAf625m6wA@mail.gmail.com> <CA+icZUVd19avD71K1NcCogr86fxkGHxEWVeFzYW-AWuoGJ3zzA@mail.gmail.com>
In-Reply-To: <CA+icZUVd19avD71K1NcCogr86fxkGHxEWVeFzYW-AWuoGJ3zzA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 5 Mar 2022 12:11:22 +0100
Message-ID: <CA+icZUV840wd-jmYkcXVuG0iSsGRLhZ8p+pgbiEABWOmuFQcNA@mail.gmail.com>
Subject: Re: [Linux-v5.17-rc6] Building tools/perf with perl v5.34
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, Mar 5, 2022 at 9:26 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sat, Mar 5, 2022 at 8:57 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Sat, Mar 5, 2022 at 8:52 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
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
> > >
> > > Thanks.
> > >
> > > Regards,
> > > - Sedat -
> > >
> > > [1] https://unix.stackexchange.com/questions/167292/what-is-debian-equivalent-of-rpm-package-perl-extutils-embed
> >
> > My command-line:
> >
> > cd /path/to/linux.git
> >
> > $ make V=1 -j4 HOSTCC=clang HOSTCXX=clang++ HOSTLD=ld.lld
> > HOSTAR=llvm-ar CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm
> > OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump OBJSIZE=llvm-size
> > READELF=llvm-readelf STRIP=llvm-strip LLVM_IAS=1 -C tools/perf
> > PYTHON=python3.10 install-bin
> >
> > I use the -gnu-std-11 patchset plus some own:
> >
> > $ git log --oneline v5.17-rc6.. | grep 'std=gnu11'
> > 05d8e9b88918 tools: libtraceevent: Use -std=gnu11
> > ee44279e6b01 tools: libsubcmd: Use -std=gnu11
> > 411fa2d6da5c tools: libapi: Use -std=gnu11
> > 3f0092b7e1b9 tools: perf: Use -std=gnu11
> > 0cf56ddf2b41 tools: libbpf: Use -std=gnu11
> > 96a4222bdd4c Kbuild: use -std=gnu11 for KBUILD_USERCFLAGS
> > 6a7cc105b238 Kbuild: move to -std=gnu11
> >
> > If this matters...
> >
>
> [ tools/perf/Makefile.config ]
>
> ifdef NO_LIBPERL
>   CFLAGS += -DNO_LIBPERL
> else
>   PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
>   PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
>   PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
>   PERL_EMBED_CCOPTS = $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null)
>   PERL_EMBED_CCOPTS := $(filter-out -specs=%,$(PERL_EMBED_CCOPTS))
>   PERL_EMBED_CCOPTS := $(filter-out -flto=auto -ffat-lto-objects,
> $(PERL_EMBED_CCOPTS))
>   PERL_EMBED_LDOPTS := $(filter-out -specs=%,$(PERL_EMBED_LDOPTS))
>   FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
>
>   ifneq ($(feature-libperl), 1)
>     CFLAGS += -DNO_LIBPERL
>     NO_LIBPERL := 1
>     msg := $(warning Missing perl devel files. Disabling perl
> scripting support, please install perl-ExtUtils-Embed/libperl-dev);
>   else
>     LDFLAGS += $(PERL_EMBED_LDFLAGS)
>     EXTLIBS += $(PERL_EMBED_LIBADD)
>     CFLAGS += -DHAVE_LIBPERL_SUPPORT
>     $(call detected,CONFIG_LIBPERL)
>   endif
> endif
>
> $ perl -MExtUtils::Embed -e ldopts
> -Wl,-E  -fstack-protector-strong -L/usr/local/lib
> -L/usr/lib/x86_64-linux-gnu/perl/5.34/CORE -lperl -ldl -lm -lpthread
> -lc -lcrypt
>
> $ perl -MExtUtils::Embed -e ccopts
> -D_REENTRANT -D_GNU_SOURCE -DDEBIAN -fwrapv -fno-strict-aliasing -pipe
> -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64
> -I/usr/lib/x86_64-linux-gnu/perl/5.34/CORE
>

Looks like an issue when using LLVM/Clang - distro or selfmade does not matter.
With GCC I can see libperl enabled.

- Sedat -
