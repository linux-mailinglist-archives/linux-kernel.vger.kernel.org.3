Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8744D6BB6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 02:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiCLBnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 20:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCLBnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 20:43:02 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9AC251840
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 17:41:57 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id i1so7191176ila.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 17:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=gjrIJEvturuOkGG4WOKX2ibXNmzFS1Llju2YLJueftY=;
        b=hE4wLtAam09Akp+Wv7whDj/+Xzi9ITiKqrZQNXHGL/4nPH1UG/nk2ovpfhfA+JK6VK
         AqDV+uNl6tGiSAWaIgo0tJm+tHhGmJi5touEh0PzE96vvB/1TlTiV9uGN1r0dOXwvHW5
         TZr2P8WC1Pmgr+dZj1agP+6zEI7twc6XiK3mcoiY9iafNPM/NpQrKKGo4FAJFKQ5hp1x
         dLfgLrb15BNm8kLZfxRosU5RFpoJmZktpEUUv3Wa/by553ZvtI2H25+uVivxz1Rp0a55
         VssXOXjxjQ0M+3IoA68cA0XxGLsVwbEYYRU+Jbea9H7LE8sXU/DnT6j1TGPrCg7tkSQx
         nQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=gjrIJEvturuOkGG4WOKX2ibXNmzFS1Llju2YLJueftY=;
        b=w2K2ga7Go8rwcEmnT8jbe3bhjMKz1i0ZSYToZXjUEqMzgUxHy926/PREBKhI4p7GEn
         acWO+nlbv2nG6GHTL152WBQoI39avijCGiTIsyfjsmWkXitvjYjCOVgLW3QYsVisUQf6
         UP2TROHurOXM1nLgALnT3aZAVWj0dxmiW1tJ2fF3+qr3bnWavPgB/CUyC4nUYqYbqUjW
         4F398uu0KK2fCKd5zCAXz2gyT/l0rbrP3aRjuzTqZNGLUWFnTy+wyG8vf6BWO2TAbecX
         cVK0cPbq/oaKjYRwyWF07ldIMqv8q2ueTp0yzZpWHNUHgQbuAbN9emUXo2Zq8mhVANay
         IALg==
X-Gm-Message-State: AOAM5307aG2gB6Jvheb49+tCRpspMnNn8UbX3WHLdS78oYYWtEoAsNyI
        E53aQE1EShcG949BYIW2oRdjeQ288mk7n4K9mcs=
X-Google-Smtp-Source: ABdhPJzdWs9RYq4jlhF0C5R3JgUmRoIKLMSJY2kWO16afkcFIOKfNM3ARlm3voy0sIMG7btL1MtIIBntRTKoz4D3OUQ=
X-Received: by 2002:a05:6e02:de2:b0:2c6:f14:884a with SMTP id
 m2-20020a056e020de200b002c60f14884amr10104444ilj.100.1647049316936; Fri, 11
 Mar 2022 17:41:56 -0800 (PST)
MIME-Version: 1.0
References: <20220310061909.20166-1-sedat.dilek@gmail.com> <Yis41ykyJq1fHYSx@krava>
 <CA+icZUVzQwGSS9hcMMP-HeOAFYxrMH9oCRbxLEdcEUwEJ8Wa3Q@mail.gmail.com> <CA+icZUUZjmAmNDfVVMqo_OBWsuS=DpET27nLn3yzPHVcFhxe9A@mail.gmail.com>
In-Reply-To: <CA+icZUUZjmAmNDfVVMqo_OBWsuS=DpET27nLn3yzPHVcFhxe9A@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 12 Mar 2022 02:41:20 +0100
Message-ID: <CA+icZUWK_N67mqSv4uqGuCD5RtvyJFUo_JHsySa+RbhPXFppSg@mail.gmail.com>
Subject: Re: [PATCH] tools: feature/test-libperl.c: Sync PERL_EMBED_CCOPTS
 with perf
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Leo Yan <leo.yan@linaro.org>, John Keeping <john@metanate.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
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

On Sat, Mar 12, 2022 at 12:39 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sat, Mar 12, 2022 at 12:30 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Fri, Mar 11, 2022 at 12:56 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Thu, Mar 10, 2022 at 07:19:09AM +0100, Sedat Dilek wrote:
> > > > When trying to build perf with a LLVM/Clang toolchain people see errors
> > > > when testing for libperl feature.
> > > >
> > > > Jiri reports:
> > > >
> > > > > I'm getting some other lto related error:
> > > > >
> > > > >         $ cat test-libperl.make.output
> > > > >         clang-13: error: optimization flag '-ffat-lto-objects' is not supported [-Werror,-Wignored-optimization-argument]
> > > > >
> > > >
> > > > The reason is PERL_EMBED_CCOPTS is defined in two places:
> > > >
> > > > tools/build/feature/Makefile
> > > > tools/perf/Makefile.config
> > > >
> > > > As an result FLAGS_PERL_EMBED is set differently.
> > > >
> > > > For building perf '-ffat-lto-objects' is filtered-out:
> > > >
> > > > $ git grep ffat-lto-objects tools/perf/
> > > > tools/perf/Makefile.config:  PERL_EMBED_CCOPTS := $(filter-out -flto=auto -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
> > > >
> > > > Sync PERL_EMBED_CCOPTS in tools/build/feature/Makefile to fix this.
> > > >
> > > > For a minimal fix for Linux v5.17 this here was preferred by Arnaldo.
> > > >
> > > > Link: https://marc.info/?t=164646683300002&r=1&w=2
> > > > Reported-by: Jiri Olsa <olsajiri@gmail.com>
> > > > Reported-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> > > > Tested-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> > > > Suggested-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> > > > Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > ---
> > > >  tools/build/feature/Makefile | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> > > > index 1480910c792e..869073cf8449 100644
> > > > --- a/tools/build/feature/Makefile
> > > > +++ b/tools/build/feature/Makefile
> > > > @@ -218,6 +218,7 @@ PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
> > > >  PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
> > > >  PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
> > > >  PERL_EMBED_CCOPTS = `perl -MExtUtils::Embed -e ccopts 2>/dev/null`
> > > > +PERL_EMBED_CCOPTS := $(filter-out -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
> > >
> > > it looks like this is not enough, at least on fedora 35
> > >
> > > I had to add changes below on top of your patch, it fixed the perl
> > > feature detection and perf build itself, but I'm still getting error
> > > with perf/python.so:
> > >
> >
> > Correct. This patch simply fixes the perl feature detection.
> >
> > >         $ CC=clang make JOBS=1
> > >         ...
> > >           GEN     python/perf.so
> > >         python_ext_build/tmp/home/jolsa/kernel/linux-perf/tools/perf/util/python.o: file not recognized: file format not recognized
> > >         clang-13: error: linker command failed with exit code 1 (use -v to see invocation)
> > >         error: command 'clang' failed with exit status 1
> > >         cp: cannot stat 'python_ext_build/lib/perf*.so': No such file or directory
> > >
> > > with:
> > >
> > >         $ file python_ext_build/tmp/home/jolsa/kernel/linux-perf/tools/perf/util/python.o
> > >         python_ext_build/tmp/home/jolsa/kernel/linux-perf/tools/perf/util/python.o: LLVM IR bitcode
> > >
> > > do you get clean compile with python lang enabled?
> > >
> > > jirka
> > >
> > >
> > > ---
> > > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> > > index 869073cf8449..86df0fe11ee5 100644
> > > --- a/tools/build/feature/Makefile
> > > +++ b/tools/build/feature/Makefile
> > > @@ -217,9 +217,9 @@ strip-libs = $(filter-out -l%,$(1))
> > >  PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
> > >  PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
> > >  PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
> > > -PERL_EMBED_CCOPTS = `perl -MExtUtils::Embed -e ccopts 2>/dev/null`
> > > +PERL_EMBED_CCOPTS := $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null)
> > >  PERL_EMBED_CCOPTS := $(filter-out -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
> > > -FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
> > > +FLAGS_PERL_EMBED  := $(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS) -Wno-unused-command-line-argument -Wno-compound-token-split-by-macro
> > >
> > >  $(OUTPUT)test-libperl.bin:
> > >         $(BUILD) $(FLAGS_PERL_EMBED)
> > > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > > index 96ad944ca6a8..38b0b0e7a168 100644
> > > --- a/tools/perf/Makefile.config
> > > +++ b/tools/perf/Makefile.config
> > > @@ -778,7 +778,7 @@ else
> > >    PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
> > >    PERL_EMBED_CCOPTS = $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null)
> > >    PERL_EMBED_CCOPTS := $(filter-out -specs=%,$(PERL_EMBED_CCOPTS))
> > > -  PERL_EMBED_CCOPTS := $(filter-out -flto=auto -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
> > > +  PERL_EMBED_CCOPTS := $(filter-out -flto=auto -ffat-lto-objects, $(PERL_EMBED_CCOPTS)) -Wno-unused-command-line-argument -Wno-compound-token-split-by-macro
> > >    PERL_EMBED_LDOPTS := $(filter-out -specs=%,$(PERL_EMBED_LDOPTS))
> > >    FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
> > >
> >
> > I fixed that differently by (see [1]),
> >
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -213,7 +213,7 @@ endif
> >
> > # Treat warnings as errors unless directed not to
> > ifneq ($(WERROR),0)
> > -  CORE_CFLAGS += -Werror
> > +  CORE_CFLAGS += -Werror -Wno-compound-token-split-by-macro
> >   CXXFLAGS += -Werror
> >   HOSTCFLAGS += -Werror
> > endif
> >
> > This was sufficient here to build perf successfully.
> > And maybe ifdef-ed for clang?
> >
> > But all this is a follow-up?
> >
> > [1] https://lore.kernel.org/lkml/CA+icZUUCO+gOPLZumu_rTOJz1_v7gRRYVzzEZ+RZPOZBmkqCQg@mail.gmail.com/
> >
> > > diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> > > index 483f05004e68..cfbb03babf63 100644
> > > --- a/tools/perf/util/setup.py
> > > +++ b/tools/perf/util/setup.py
> > > @@ -43,7 +43,7 @@ class install_lib(_install_lib):
> > >
> > >  cflags = getenv('CFLAGS', '').split()
> > >  # switch off several checks (need to be at the end of cflags list)
> > > -cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls', '-DPYTHON_PERF' ]
> > > +cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls', '-Wno-ignored-optimization-argument', '-DPYTHON_PERF' ]
> > >  if not cc_is_clang:
> > >      cflags += ['-Wno-cast-function-type' ]
> > >
> >
> > Cannot say much to that.
> >
> > Do we want to fix perf building with LLVM/Clang for Linux v5.17 final or later?
> > Arnaldo?
> >
>
> Attached is the patch I use to build perf.
> ( As said in the initial report I wanted to test perf with -std=gnu11. )
> ( Cannot say much if this related to perl v5.34 only. )
>
> - Sedat -
>
> [1] https://lore.kernel.org/lkml/CA+icZUWHd4VTKNwBtuxt9-fHoiYV+Q7tQ809Cn83k8sbQ_uNHw@mail.gmail.com/

I am not familiar with your Red Hat / Fedore LLVM toolchain
environment as I use Debian/unstable AMD64.
Also, I am not a perl expert.

Again, tools/ has its own build-system and rules other than top-level Makefile.

By building with...

CC=clang ...

You simply use the clang compiler, but *GNU binutils*.

My reproducer uses clang + LLVM (bin)utils by setting also for HOSTXX:

make V=1 -j4
   HOSTCC=clang HOSTLD=ld.lld HOSTAR=llvm-ar
   CC=clang LD=ld.lld AR=llvm-ar STRIP=llvm-strip
   -C tools/perf
   PYTHON=python3.10 install-bin

I highly suggest testing this first.

Please, have a look into:

[ tools/scripts/Makefile.include ]

ifneq ($(LLVM),)
$(call allow-override,CC,clang)
$(call allow-override,AR,llvm-ar)
$(call allow-override,LD,ld.lld)
$(call allow-override,CXX,clang++)
$(call allow-override,STRIP,llvm-strip)
...
endif
...
ifneq ($(LLVM),)
HOSTAR  ?= llvm-ar
HOSTCC  ?= clang
HOSTLD  ?= ld.lld
...
endif

Furthermore, to pass unused compiler flags for clang we use in
top-level Makefile:

[ Makefile ]

ifdef CONFIG_CC_IS_CLANG
KBUILD_CPPFLAGS += -Qunused-arguments
...
endif

Again, tools/ ECO build-system is different.
No nothing -Qunused-arguments passed to any (CPP)FLAGS.

The other possibility is to do this for perf like here (as you did):

[ tools/testing/selftests/bpf/Makefile ]

ifneq ($(LLVM),)
CFLAGS += -Wno-unused-command-line-argument
endif

NOTE: Cannot say to use "ifneq ($(LLVM),)" or check for CC_NO_CLANG or
"ifeq ($(USE_CLANG), 1)" (see tools/perf/Makefile.perf).

Or even better in tools/scripts/Makefile.include.
That's sort of "tools/ top-level Make(file) include".

But I guess the problem with perf and LLVM/Clang and specific versions
of perl is the usage of -Werror.

I did:

[ tools/build/feature/Makefile ]

__BUILD = $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst
%.bin,%.c,$(@F)) $(LDFLAGS)
__BUILD = $(CC) $(CFLAGS) -MD -Wall -Werror
-Wno-compound-token-split-by-macro -o $@ $(patsubst %.bin,%.c,$(@F))
$(LDFLAGS)

[ tools/perf/Makefile.config ]

CORE_CFLAGS += -Werror
CORE_CFLAGS += -Werror -Wno-compound-token-split-by-macro

With those changes I am able to build perf with:
1. LLVM/Clang v13 and v14
2. LLVM (bin)utils v13 and v14
3. perf v5.34
4. -std=gnu11 (with some additional patches to tools/)

Might be worth testing with (UNTESTED):

[ tools/build/feature/Makefile ]
[ tools/perf/Makefile.config ]

ifneq ($(LLVM),)
CFLAGS += -Wno-unused-command-line-argument
CFLAGS += -Wno-compound-token-split-by-macro
CFLAGS += -Wno-ignored-optimization-argument
endif

The tools/ build-system is a mess and needs to be cleaned up.

And as Arnaldo pointed out:
Consolidate PERL_EMBED_XXX and XXX_PERL_EMBED in a single place.

Happy hacking!
- sed@ -
