Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84594CE396
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 09:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiCEI1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 03:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiCEI1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 03:27:41 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82B223DE9B;
        Sat,  5 Mar 2022 00:26:51 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id r11so7304274ioh.10;
        Sat, 05 Mar 2022 00:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=N3jszANDmQZb7r8aK3P3yVdAGaQPSTJ02JYEy2KHSAA=;
        b=HQBmYXXLNzBEafcE4+NaQuLIveaRglkhC0IilGHutfbgxUn6pojISyU2rqGDGdP4Sf
         sRppPzeXMOcVWmP5SPFVMyVNuM6Xl4eZCR4i7Kwzqs0hyoAFECuopLTek0gtu8l6Xt2u
         HNlA5ekScYGoaZF8ZIkm4ZSP1Y72D1MuO2gnRTUdSIHa9Ex+OR+M7M45gv9gkPAtox7/
         dB4TEOXQfNWu6Im247UeHE99Tbh4CJ0SGvIY5KOGd4cPrRX+bZcdlUrp8VhIKDv8krd0
         AMU1UBkxrKGQ0lwS8ytqeiK1ZBOhAkLbnWQWJQqsEyMhUPP9w2lVsxriU7bRGteNgMgd
         PCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=N3jszANDmQZb7r8aK3P3yVdAGaQPSTJ02JYEy2KHSAA=;
        b=N0CbpseHuV0zWuEOCYbwjkzid2FSWHI9FOdG+rmqYE6YmImuKWVtZaQPW/9mBWQh6w
         bsoVi6b4ImBlpphLn0inlI3UCz97DUS9YX7Xs2lCikp4puQldmnQuJaCrzy5+gqcdlum
         4VbOMiAiT2304e7dGLrqO3IltCnjp9A35Nbg5aynx2p5OSNPr+xkoe0y2eiZQaeaR5Is
         YQXRfQWM607lWUFf/JcRADnrWN99VnTWuEHyL9E7TM7MmlEYgjUCSEOdKARTut7PC/Dd
         GU9LLCctoZKb6z6ApUoOFziyOluEx9wAh9LNfaWXNRP8/ihsi7DY0dKPRMj/cLp9ZPRT
         iZag==
X-Gm-Message-State: AOAM530qGrLwoivK/mOo85Oli9Tj0fLnDQbFtaoK8ABluV4wuPoQK7zr
        6R1QKa6+za5OA0P4LgiBNX+GeZRYtogsaAzOug2ru2Jg3grjrQ==
X-Google-Smtp-Source: ABdhPJxJcRfEtngRc3JCaV9Phg3XF4GTLXJ/OXmlOhY5CuWMptNstyKWhmvvtE63xfJJ4TFLMRWelFzK3TWFxBaeU/8=
X-Received: by 2002:a6b:c98f:0:b0:637:fd11:42a0 with SMTP id
 z137-20020a6bc98f000000b00637fd1142a0mr2240722iof.48.1646468810813; Sat, 05
 Mar 2022 00:26:50 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUWHd4VTKNwBtuxt9-fHoiYV+Q7tQ809Cn83k8sbQ_uNHw@mail.gmail.com>
 <CA+icZUW7LESaDG5gLQs9kOJp=0Anp=+jNb8L1u91iAf625m6wA@mail.gmail.com>
In-Reply-To: <CA+icZUW7LESaDG5gLQs9kOJp=0Anp=+jNb8L1u91iAf625m6wA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 5 Mar 2022 09:26:14 +0100
Message-ID: <CA+icZUVd19avD71K1NcCogr86fxkGHxEWVeFzYW-AWuoGJ3zzA@mail.gmail.com>
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

On Sat, Mar 5, 2022 at 8:57 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sat, Mar 5, 2022 at 8:52 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > Hi,
> >
> > I am here on Debian/unstable AMD64 which switched over to perl v5.34
> > in February 2022.
> >
> > Unfortunately, my perf does not build with this (lib)perl version:
> >
> > $ ~/bin/perf -vv
> > perf version 5.17-rc6
> >                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
> >    dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
> >                 glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
> >         syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
> >                libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
> >                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
> >               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> > numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> >               libperl: [ OFF ]  # HAVE_LIBPERL_SUPPORT
> >             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
> >              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
> >             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
> >             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
> >    libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
> >                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
> >                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
> >             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
> >                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
> >                   aio: [ on  ]  # HAVE_AIO_SUPPORT
> >                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
> >               libpfm4: [ OFF ]  # HAVE_LIBPFM
> >
> > $ grep libperl ../make-log_perf-python3.10-install_bin.txt
> > 9:Makefile.config:788: Missing perl devel files. Disabling perl
> > scripting support, please install perl-ExtUtils-Embed/libperl-dev
> > 22:...                       libperl: [ OFF ]
> >
> > Checking for these requirements:
> >
> > # dpkg -l | grep perl | grep 5.34 | awk '/^ii/ {print $1 " " $2 " "
> > $3}' | column -t
> > ii  libperl-dev:amd64  5.34.0-3
> > ii  libperl5.34:amd64  5.34.0-3
> > ii  perl               5.34.0-3
> > ii  perl-base          5.34.0-3
> > ii  perl-modules-5.34  5.34.0-3
> >
> > # dpkg -L perl-modules-5.34 | grep -i ExtUtils | grep -i Embed
> > /usr/share/perl/5.34.0/ExtUtils/Embed.pm
> >
> > Can you please comment on this?
> >
> > Thanks.
> >
> > Regards,
> > - Sedat -
> >
> > [1] https://unix.stackexchange.com/questions/167292/what-is-debian-equivalent-of-rpm-package-perl-extutils-embed
>
> My command-line:
>
> cd /path/to/linux.git
>
> $ make V=1 -j4 HOSTCC=clang HOSTCXX=clang++ HOSTLD=ld.lld
> HOSTAR=llvm-ar CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm
> OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump OBJSIZE=llvm-size
> READELF=llvm-readelf STRIP=llvm-strip LLVM_IAS=1 -C tools/perf
> PYTHON=python3.10 install-bin
>
> I use the -gnu-std-11 patchset plus some own:
>
> $ git log --oneline v5.17-rc6.. | grep 'std=gnu11'
> 05d8e9b88918 tools: libtraceevent: Use -std=gnu11
> ee44279e6b01 tools: libsubcmd: Use -std=gnu11
> 411fa2d6da5c tools: libapi: Use -std=gnu11
> 3f0092b7e1b9 tools: perf: Use -std=gnu11
> 0cf56ddf2b41 tools: libbpf: Use -std=gnu11
> 96a4222bdd4c Kbuild: use -std=gnu11 for KBUILD_USERCFLAGS
> 6a7cc105b238 Kbuild: move to -std=gnu11
>
> If this matters...
>

[ tools/perf/Makefile.config ]

ifdef NO_LIBPERL
  CFLAGS += -DNO_LIBPERL
else
  PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
  PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
  PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
  PERL_EMBED_CCOPTS = $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null)
  PERL_EMBED_CCOPTS := $(filter-out -specs=%,$(PERL_EMBED_CCOPTS))
  PERL_EMBED_CCOPTS := $(filter-out -flto=auto -ffat-lto-objects,
$(PERL_EMBED_CCOPTS))
  PERL_EMBED_LDOPTS := $(filter-out -specs=%,$(PERL_EMBED_LDOPTS))
  FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)

  ifneq ($(feature-libperl), 1)
    CFLAGS += -DNO_LIBPERL
    NO_LIBPERL := 1
    msg := $(warning Missing perl devel files. Disabling perl
scripting support, please install perl-ExtUtils-Embed/libperl-dev);
  else
    LDFLAGS += $(PERL_EMBED_LDFLAGS)
    EXTLIBS += $(PERL_EMBED_LIBADD)
    CFLAGS += -DHAVE_LIBPERL_SUPPORT
    $(call detected,CONFIG_LIBPERL)
  endif
endif

$ perl -MExtUtils::Embed -e ldopts
-Wl,-E  -fstack-protector-strong -L/usr/local/lib
-L/usr/lib/x86_64-linux-gnu/perl/5.34/CORE -lperl -ldl -lm -lpthread
-lc -lcrypt

$ perl -MExtUtils::Embed -e ccopts
-D_REENTRANT -D_GNU_SOURCE -DDEBIAN -fwrapv -fno-strict-aliasing -pipe
-I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64
-I/usr/lib/x86_64-linux-gnu/perl/5.34/CORE

- Sedat -
