Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFC04F866B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346503AbiDGRpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346522AbiDGRpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:45:05 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9980622C8D0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:42:57 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id h63so7646298iof.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 10:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=SkyAkMzamOPIctFCTmOv0NCTRZwrlIMn+bWahZYrpxo=;
        b=HM9XybfUuf4K0hNKtK5AJF1Absn1z/1xmHk5WV2rE8pMjAGrog2RUTV24j1qHGz0vI
         3zwgw/nss8kPmhiMkO95gYnWRJ+2KdBa73VsCXt+f7O/kspXBwEYOuAiNQGla+F21MmP
         HuxG2e3cFNzpDZeIzOZcy0BQv0Fq00MIbk3Vind7dRvZIKHMjK0jTKoQVML76Vl4fF1F
         J3mTWlifleXtidkYRC2hQir1UMHGJTyREaAVSc0g7s5XbCNceyiDgh59rx57bVXhnBtn
         55cqvh3zmFm4UcX+W4PX4jxh6nim1m3YhKxC/WEMmVorXmcf3hD9ubSREfkYv+3Lr9Vt
         HlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=SkyAkMzamOPIctFCTmOv0NCTRZwrlIMn+bWahZYrpxo=;
        b=fN5eDPsnTbG9tLaZYbOIu4+hqLWB/EmfLsWkPb8g5pqek0VwMyl0xS5MttfTkaQ4VV
         xHs5Z+Te20FxIQYiYLO5Xy0xxVKqGZk4O5+zFlRblP0PzO3yrQnfYjmV18hcAcmS4fQF
         4IA7ZmmPKpVllmJQxM7odukUJEUSbRtzy8oFSm4DiDf7jGdjtr6rP06KLD6ygLGDPgH9
         1sJ6FNUp9j3m6I/Sn2olG4jMKeD51KwN9HqWpKU1O4025Lnu/y+g6rQOs/a15AIrJWUR
         dtVxN/kfuZ8qeSvRil1hAN+ZvVLMyElHUTr0oH/qx0wqaYcuI45lgkUn0708Hh6uw+Yo
         +F3w==
X-Gm-Message-State: AOAM532gGfTrmhNXrFJvbJe8ugAsUV4CKHu2iAekmGGePkbThHi65nTW
        Bew2s1K9ycfzWICLqOPE8O5gJqtsO2tTHiM0rLs=
X-Google-Smtp-Source: ABdhPJzB9zuPgo1nidR8m7rle6cW6xTVgGgcvmIHXRWZ8GyA4cfKtw8gTLbcFQA6BYTBMZt+5fgo8b8p+dL1/cgVyD0=
X-Received: by 2002:a05:6638:480f:b0:323:777c:8e35 with SMTP id
 cp15-20020a056638480f00b00323777c8e35mr7442741jab.199.1649353376684; Thu, 07
 Apr 2022 10:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <YktYX2OnLtyobRYD@kernel.org> <Ykto1FgmPMMCysbI@dev-arch.thelio-3990X>
 <CA+icZUVKgLLJvNF6ZU1e7Hjr_FsJO7x0gsGL6Jje1nv2ukhueA@mail.gmail.com>
 <Yk79WQQjvMyCddiO@dev-arch.thelio-3990X> <CA+icZUXwF+qs0KxSeD8AF7ufrT6PodQa0iVi1w=qvdT0WWhkrA@mail.gmail.com>
 <CA+icZUUdqQRU7XBjXnG5LHB-RrGMnknmsr-v4PhOLy4Jr2aDOA@mail.gmail.com>
In-Reply-To: <CA+icZUUdqQRU7XBjXnG5LHB-RrGMnknmsr-v4PhOLy4Jr2aDOA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 7 Apr 2022 19:42:20 +0200
Message-ID: <CA+icZUVOUXgcZc3cKxSi6d8ooNJbB8r32V-F4eMGjdoJ=wStxg@mail.gmail.com>
Subject: Re: Build perf with clang, failure with libperf
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Fangrui Song <maskray@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Keeping <john@metanate.com>, Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 7:10 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Thu, Apr 7, 2022 at 6:25 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Thu, Apr 7, 2022 at 5:03 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > On Thu, Apr 07, 2022 at 12:27:14PM +0200, Sedat Dilek wrote:
> > > > On Mon, Apr 4, 2022 at 11:53 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > > > >
> > > > > Hi Arnaldo,
> > > > >
> > > > > On Mon, Apr 04, 2022 at 05:43:11PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > > Hi,
> > > > > >
> > > > > >       Trying to apply Sedat's patch something changed in my system,
> > > > > > and that patch wasn't enough, so I had to first apply this one:
> > > > > >
> > > > > > commit 173b552663419f40bcd3cf9df4f68285cac72727
> > > > > > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > > > Date:   Mon Apr 4 17:28:48 2022 -0300
> > > > > >
> > > > > >     tools build: Use $(shell ) instead of `` to get embedded libperl's ccopts
> > > > > >
> > > > > >     Just like its done for ldopts and for both in tools/perf/Makefile.config.
> > > > > >
> > > > > >     Using `` to initialize PERL_EMBED_CCOPTS somehow precludes using:
> > > > > >
> > > > > >       $(filter-out SOMETHING_TO_FILTER,$(PERL_EMBED_CCOPTS))
> > > > > >
> > > > > >     And we need to do it to allow for building with versions of clang where
> > > > > >     some gcc options selected by distros are not available.
> > > > > >
> > > > > >     Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > > > >     Cc: Fangrui Song <maskray@google.com>
> > > > > >     Cc: Florian Fainelli <f.fainelli@gmail.com>
> > > > > >     Cc: Ian Rogers <irogers@google.com>
> > > > > >     Cc: Jiri Olsa <jolsa@kernel.org>
> > > > > >     Cc: John Keeping <john@metanate.com>
> > > > > >     Cc: Leo Yan <leo.yan@linaro.org>
> > > > > >     Cc: Michael Petlan <mpetlan@redhat.com>
> > > > > >     Cc: Namhyung Kim <namhyung@kernel.org>
> > > > > >     Cc: Nathan Chancellor <nathan@kernel.org>
> > > > > >     Cc: Nick Desaulniers <ndesaulniers@google.com>
> > > > > >     Cc: Sedat Dilek <sedat.dilek@gmail.com>
> > > > > >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > > >
> > > > > > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> > > > > > index 1480910c792e2cb3..90774b60d31b2b8e 100644
> > > > > > --- a/tools/build/feature/Makefile
> > > > > > +++ b/tools/build/feature/Makefile
> > > > > > @@ -217,7 +217,7 @@ strip-libs = $(filter-out -l%,$(1))
> > > > > >  PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
> > > > > >  PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
> > > > > >  PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
> > > > > > -PERL_EMBED_CCOPTS = `perl -MExtUtils::Embed -e ccopts 2>/dev/null`
> > > > > > +PERL_EMBED_CCOPTS = $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null)
> > > > > >  FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
> > > > > >
> > > > > >  $(OUTPUT)test-libperl.bin:
> > > > > >
> > > > > > ----------------------------------------------------- 8< -------------------
> > > > > >
> > > > > > After this I go on filtering out some of the gcc options that clang
> > > > > > doesn't grok:
> > > > > >
> > > > > > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> > > > > > index 90774b60d31b2b8e..bbc5e263e02385ed 100644
> > > > > > --- a/tools/build/feature/Makefile
> > > > > > +++ b/tools/build/feature/Makefile
> > > > > > @@ -215,9 +215,12 @@ grep-libs  = $(filter -l%,$(1))
> > > > > >  strip-libs = $(filter-out -l%,$(1))
> > > > > >
> > > > > >  PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
> > > > > > +PERL_EMBED_LDOPTS := $(filter-out -specs=%,$(PERL_EMBED_LDOPTS))
> > > > > >  PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
> > > > > >  PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
> > > > > >  PERL_EMBED_CCOPTS = $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null)
> > > > > > +PERL_EMBED_CCOPTS := $(filter-out -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
> > > > > > +PERL_EMBED_CCOPTS := $(filter-out -specs=%,$(PERL_EMBED_CCOPTS))
> > > > > >  FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
> > > > > >
> > > > > >  $(OUTPUT)test-libperl.bin:
> > > > > >
> > > > > > ----------------------------------------------------- 8< -------------------
> > > > > >
> > > > > > And then get to the problems at the end of this message, which seem
> > > > > > similar to the problem described here:
> > > > > >
> > > > > > From  Nathan Chancellor <>
> > > > > > Subject       [PATCH] mwifiex: Remove unnecessary braces from HostCmd_SET_SEQ_NO_BSS_INFO
> > > > > >
> > > > > > https://lkml.org/lkml/2020/9/1/135
> > > > > >
> > > > > > So perhaps in this case its better to disable that
> > > > > > -Werror,-Wcompound-token-split-by-macro when building with clang?
> > > > >
> > > > > Yes, I think that is probably the best solution. As far as I can tell,
> > > > > at least in this file and context, the warning appears harmless, as the
> > > > > "create a GNU C statement expression from two different macros" is very
> > > > > much intentional, based on the presence of PERL_USE_GCC_BRACE_GROUPS.
> > > > > The warning is fixed in upstream Perl by just avoiding creating GNU C
> > > > > statement expressions using STMT_START and STMT_END:
> > > > >
> > > > > https://github.com/Perl/perl5/issues/18780
> > > > > https://github.com/Perl/perl5/pull/18984
> > > > >
> > > > > If I am reading the source code correctly, an alternative to disabling
> > > > > the warning would be specifying -DPERL_GCC_BRACE_GROUPS_FORBIDDEN but it
> > > > > seems like that might end up impacting more than just this site,
> > > > > according to the issue discussion above.
> > > > >
> > > >
> > > > Thanks for the pointer Nathan.
> > > >
> > > > As said I hit the problem with Debian's perl v5.34.
> > > >
> > > > Checking perl5 Git reveals:
> > > >
> > > > "skip using gcc brace groups for STMT_START/END"
> > > > https://github.com/Perl/perl5/commit/7169efc77525df70484a824bff4ceebd1fafc760
> > >
> > > GitHub says this is in 5.35.2, so it would make sense that 5.34 still
> > > shows the issue.
> > >
> > > > "Partially Revert "skip using gcc brace groups for STMT_START/END""
> > > > https://github.com/Perl/perl5/commit/e08ee3cb66f362c4901846a46014cfdfcd60326c
> > > >
> > > > Perl v5.34.x seems not to have these changes:
> > > > https://github.com/Perl/perl5/compare/v5.34.0...v5.34.1
> > > >
>
> To summarize the diff between those 2 changes is related to perl.h only.
>
> # git diff /usr/lib/x86_64-linux-gnu/perl/5.34.0/CORE/perl.h.orig
> /usr/lib/x86_64-linux-gnu/perl/5.34.0/CORE/perl.h
> diff --git a/usr/lib/x86_64-linux-gnu/perl/5.34.0/CORE/perl.h.orig
> b/usr/lib/x86_64-linux-gnu/perl/5.34.0/CORE/perl.h
> index 17a21a1c4..bd575fe08 100644
> --- a/usr/lib/x86_64-linux-gnu/perl/5.34.0/CORE/perl.h.orig
> +++ b/usr/lib/x86_64-linux-gnu/perl/5.34.0/CORE/perl.h
> @@ -733,13 +733,8 @@ Example usage:
>  Trying to select a version that gives no warnings...
> */
> #if !(defined(STMT_START) && defined(STMT_END))
> -# ifdef PERL_USE_GCC_BRACE_GROUPS
> -#   define STMT_START  (void)( /* gcc supports "({ STATEMENTS; })" */
> -#   define STMT_END    )
> -# else
> #   define STMT_START  do
> #   define STMT_END    while (0)
> -# endif
> #endif
>
> #ifndef BYTEORDER  /* Should never happen -- byteorder is in config.h */
>
> With this applied plus removing -Wno-compound-token-split-by-macro
> from ACME's patchset ...
>
> $ git log --oneline -2
> bccc88d26f1f (HEAD -> 5.17.1-6-amd64-clang14-lto) tools build: Filter
> out options and warnings not supported by clang
> 19b1b5c6614c tools build: Use $(shell ) instead of `` to get embedded
> libperl's ccopts
>
> $ git diff tools/
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index de66e1cc0734..7e3854a07643 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -224,7 +224,6 @@ ifeq ($(CC_NO_CLANG), 0)
>   PERL_EMBED_LDOPTS := $(filter-out -specs=%,$(PERL_EMBED_LDOPTS))
>   PERL_EMBED_CCOPTS := $(filter-out -flto=auto -ffat-lto-objects,
> $(PERL_EMBED_CCOPTS))
>   PERL_EMBED_CCOPTS := $(filter-out -specs=%,$(PERL_EMBED_CCOPTS))
> -  FLAGS_PERL_EMBED += -Wno-compound-token-split-by-macro
> endif
>
> $(OUTPUT)test-libperl.bin:
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 312a7a5906ee..913bf509bd17 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -790,9 +790,6 @@ else
>     LDFLAGS += $(PERL_EMBED_LDFLAGS)
>     EXTLIBS += $(PERL_EMBED_LIBADD)
>     CFLAGS += -DHAVE_LIBPERL_SUPPORT
> -    ifeq ($(CC_NO_CLANG), 0)
> -      CFLAGS += -Wno-compound-token-split-by-macro
> -    endif
>     $(call detected,CONFIG_LIBPERL)
>   endif
> endif
>
> ...I am able to build successfully with Debian's LLVM-14 and perl-5.34.
>
> Both diffs are attached as Gmail might truncate the formatting.
>
> Might be worth writing a Debian bug-report.
>

Here we go:

libperl5.34: Upstream patches "skip using gcc brace groups for STMT_START/END"

- sed@ -

[1] https://bugs.debian.org/1009149
