Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC81B4D6B0F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiCKXcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 18:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiCKXcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 18:32:41 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044901BB72D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 15:31:33 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id d62so11861833iog.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 15:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Crfg5p3u8iOjVMjNQSoRE5tSoR+VziHj4ctmIY8Vq5Y=;
        b=OFv3TefVhiVY/87I7RmhlHM9WNvjDUVHqD2l7pOU+AOp4Eiq7vZYluTW8Z2exjLlht
         /jFRA3c/ExxJXiFVZGeDHhVa8ULbUCj1KZ6R2q6LnoUG9FbkARoZVErbKfvdo6rBiCib
         vOiwv6K5k4KSKLp18hLgwS/AW8LJspgsZY9YgJ23zF5DQHuvq9uLYQsa5eHH6wpeYeEq
         z95A6Zrr0ysM9dWENLCDlTmrzdolg0jregmDNn074G+4dJeB4v6QEKQ7ma+DFy3Pvr6W
         8t8IFr45/nOOFvKkiuu9H8ugcH7roeEGDkVx5C+ymy67xV3nAu6N7X+HNhDihzg3AANP
         6xtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Crfg5p3u8iOjVMjNQSoRE5tSoR+VziHj4ctmIY8Vq5Y=;
        b=VdaEQD2y9EfDatxkisrYxZyEAIuuk/4HDkFjsaQ22HG+nY18b6FftVKqvwoEWqyk3V
         k0LolCHUfqXkTiXYxHDd2VwqBzonZwGWahMq5bdwIIa1DhxZSkkyA/4FTXGuK9iQM2Rc
         tuo+vKYkA2mlpkxqfS+s5USrdSE0eBhcn6YsqscLtfNI+Zv5BHuc092zbeMmj0QJcaZo
         hscw/G082tNLsoK3p5zyq8huloMRMUBhAgNfXy2gLVRt3I2DiWXaVn7vTIFR+I9fSJv8
         Yzhu3o8G0DjmmhA3f3pJ6NPXbGG3nQS+1qqKvjrbdgg4hHg9cvoIhr95Ly844KSoAcbT
         FJcw==
X-Gm-Message-State: AOAM531Lcj5je/JuWcBM5rXOkZaUm+tKlherWeZE8GZuPf8Fe9VurS8Z
        gUZh/9nHsz5zZ526y7X3lRZ9ZIUlD/Zqx4vr+v4=
X-Google-Smtp-Source: ABdhPJw2dTC/Q+jNz8Q1iPs7I5wa9Y9NLalzPXgZnBmVEV5rYgKugqoxoH82xz+H6yi5k+S3SrapbwqsFcQkvUnj9K8=
X-Received: by 2002:a05:6638:204:b0:319:1b34:1c57 with SMTP id
 e4-20020a056638020400b003191b341c57mr10420432jaq.80.1647041492205; Fri, 11
 Mar 2022 15:31:32 -0800 (PST)
MIME-Version: 1.0
References: <20220310061909.20166-1-sedat.dilek@gmail.com> <Yis41ykyJq1fHYSx@krava>
In-Reply-To: <Yis41ykyJq1fHYSx@krava>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 12 Mar 2022 00:30:56 +0100
Message-ID: <CA+icZUVzQwGSS9hcMMP-HeOAFYxrMH9oCRbxLEdcEUwEJ8Wa3Q@mail.gmail.com>
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

On Fri, Mar 11, 2022 at 12:56 PM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Thu, Mar 10, 2022 at 07:19:09AM +0100, Sedat Dilek wrote:
> > When trying to build perf with a LLVM/Clang toolchain people see errors
> > when testing for libperl feature.
> >
> > Jiri reports:
> >
> > > I'm getting some other lto related error:
> > >
> > >         $ cat test-libperl.make.output
> > >         clang-13: error: optimization flag '-ffat-lto-objects' is not supported [-Werror,-Wignored-optimization-argument]
> > >
> >
> > The reason is PERL_EMBED_CCOPTS is defined in two places:
> >
> > tools/build/feature/Makefile
> > tools/perf/Makefile.config
> >
> > As an result FLAGS_PERL_EMBED is set differently.
> >
> > For building perf '-ffat-lto-objects' is filtered-out:
> >
> > $ git grep ffat-lto-objects tools/perf/
> > tools/perf/Makefile.config:  PERL_EMBED_CCOPTS := $(filter-out -flto=auto -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
> >
> > Sync PERL_EMBED_CCOPTS in tools/build/feature/Makefile to fix this.
> >
> > For a minimal fix for Linux v5.17 this here was preferred by Arnaldo.
> >
> > Link: https://marc.info/?t=164646683300002&r=1&w=2
> > Reported-by: Jiri Olsa <olsajiri@gmail.com>
> > Reported-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> > Tested-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> > Suggested-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> > Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
> > ---
> >  tools/build/feature/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> > index 1480910c792e..869073cf8449 100644
> > --- a/tools/build/feature/Makefile
> > +++ b/tools/build/feature/Makefile
> > @@ -218,6 +218,7 @@ PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
> >  PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
> >  PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
> >  PERL_EMBED_CCOPTS = `perl -MExtUtils::Embed -e ccopts 2>/dev/null`
> > +PERL_EMBED_CCOPTS := $(filter-out -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
>
> it looks like this is not enough, at least on fedora 35
>
> I had to add changes below on top of your patch, it fixed the perl
> feature detection and perf build itself, but I'm still getting error
> with perf/python.so:
>

Correct. This patch simply fixes the perl feature detection.

>         $ CC=clang make JOBS=1
>         ...
>           GEN     python/perf.so
>         python_ext_build/tmp/home/jolsa/kernel/linux-perf/tools/perf/util/python.o: file not recognized: file format not recognized
>         clang-13: error: linker command failed with exit code 1 (use -v to see invocation)
>         error: command 'clang' failed with exit status 1
>         cp: cannot stat 'python_ext_build/lib/perf*.so': No such file or directory
>
> with:
>
>         $ file python_ext_build/tmp/home/jolsa/kernel/linux-perf/tools/perf/util/python.o
>         python_ext_build/tmp/home/jolsa/kernel/linux-perf/tools/perf/util/python.o: LLVM IR bitcode
>
> do you get clean compile with python lang enabled?
>
> jirka
>
>
> ---
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 869073cf8449..86df0fe11ee5 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -217,9 +217,9 @@ strip-libs = $(filter-out -l%,$(1))
>  PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
>  PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
>  PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
> -PERL_EMBED_CCOPTS = `perl -MExtUtils::Embed -e ccopts 2>/dev/null`
> +PERL_EMBED_CCOPTS := $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null)
>  PERL_EMBED_CCOPTS := $(filter-out -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
> -FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
> +FLAGS_PERL_EMBED  := $(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS) -Wno-unused-command-line-argument -Wno-compound-token-split-by-macro
>
>  $(OUTPUT)test-libperl.bin:
>         $(BUILD) $(FLAGS_PERL_EMBED)
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 96ad944ca6a8..38b0b0e7a168 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -778,7 +778,7 @@ else
>    PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
>    PERL_EMBED_CCOPTS = $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null)
>    PERL_EMBED_CCOPTS := $(filter-out -specs=%,$(PERL_EMBED_CCOPTS))
> -  PERL_EMBED_CCOPTS := $(filter-out -flto=auto -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
> +  PERL_EMBED_CCOPTS := $(filter-out -flto=auto -ffat-lto-objects, $(PERL_EMBED_CCOPTS)) -Wno-unused-command-line-argument -Wno-compound-token-split-by-macro
>    PERL_EMBED_LDOPTS := $(filter-out -specs=%,$(PERL_EMBED_LDOPTS))
>    FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
>

I fixed that differently by (see [1]),

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

This was sufficient here to build perf successfully.
And maybe ifdef-ed for clang?

But all this is a follow-up?

[1] https://lore.kernel.org/lkml/CA+icZUUCO+gOPLZumu_rTOJz1_v7gRRYVzzEZ+RZPOZBmkqCQg@mail.gmail.com/

> diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> index 483f05004e68..cfbb03babf63 100644
> --- a/tools/perf/util/setup.py
> +++ b/tools/perf/util/setup.py
> @@ -43,7 +43,7 @@ class install_lib(_install_lib):
>
>  cflags = getenv('CFLAGS', '').split()
>  # switch off several checks (need to be at the end of cflags list)
> -cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls', '-DPYTHON_PERF' ]
> +cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls', '-Wno-ignored-optimization-argument', '-DPYTHON_PERF' ]
>  if not cc_is_clang:
>      cflags += ['-Wno-cast-function-type' ]
>

Cannot say much to that.

Do we want to fix perf building with LLVM/Clang for Linux v5.17 final or later?
Arnaldo?

- Sedat -
