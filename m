Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299724F6CAE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbiDFVak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbiDFVaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:30:25 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C5C92D25
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 13:33:24 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id m17so2752548ilj.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 13:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=KtW+sM5NnJfNOanOk9+Ab+u9RMXXGzY4yvVmGRBLu8M=;
        b=pcxyO+zGL1obdCg8Jo2S/z6XFYa0npgTCXvDHHL8C/fgSeoXdLFfuyIVfZO0pvbbwV
         vdj3GtirXyEI+w+/57mPMrgRY1TKU6qq9oJsYO2iy/XmQ7U2v5T68HibseR6uGbVAAdA
         MXk/VBIWjGLT/qPpNi1a8Ea1b6mZwh8H6CXHndPICFCffOPtzsHnrNyiyj8AAmRuNK+H
         paF1TmnfKYKtqf9ujS5B+QIY2TH8j4BVl3bXzXyiZQafZ8Xb3P9NDsuSqTxXDKi9EeUt
         QdrKC+NZd37ZhQveHDNHKS+8LR29byzrfdCKujspTUzeq4ph4c7wSzfLxxjCPBxsuHWO
         W3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=KtW+sM5NnJfNOanOk9+Ab+u9RMXXGzY4yvVmGRBLu8M=;
        b=ytLEPJ/M/Oneq8SXrjhE/ZOtbQ0eA/7scJRuDUz3yYjj+eXM/wY2KbhUhV31rouxNm
         KMXVt0KtIp+gPoFiZ/0I2HvnKmw3KtkUPXXrBidJ2n9TYl1Br91MDrdjJZh+vEpzd6PW
         pmXsXefqR0mngRu5qd7DRzITSI5ChvIqSH6hEQFe9MnBOdP3W0JidMm3qG5/77y+7yxB
         xJe0D/XWpBFi5kxObsv5mJfkZdja3qTbijUCYmeTX/PM6EOT8KEdaVYyDVd2zZmBSr3Y
         6k+fB6111J8GbF/EF14x6OLvR9Op6PaY2Owxk7W/hXmnvmj0t/5EpXuUyTf5OUanLdDt
         eg7w==
X-Gm-Message-State: AOAM530xcr/wUQwg6KAff6+L1184PLV0k/5evVfVKGM0x46minUyRPtd
        7EJVybu+Ah5LgWN0t3ErRU/HoczwV1pJwgi0IO4/6vuYhuJZK8sG
X-Google-Smtp-Source: ABdhPJzJRBPmtKsK4N3eZcGYGHiI2f1jzK0SFc6Q5zP3FHj/FCQ3BIPY/FirIXLHaNNWcu4gl/ZIQ1UnlSwfjlcd1Eo=
X-Received: by 2002:a05:6e02:1a0f:b0:2c9:a83b:b69e with SMTP id
 s15-20020a056e021a0f00b002c9a83bb69emr5113804ild.4.1649277202944; Wed, 06 Apr
 2022 13:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <YktYX2OnLtyobRYD@kernel.org> <Ykto1FgmPMMCysbI@dev-arch.thelio-3990X>
 <YkxWcYzph5pC1EK8@kernel.org> <CA+icZUVMtrqRA-a3k8N0fVcszm=Sn2Jb9nMfF8mXqvSTu2HUhw@mail.gmail.com>
 <Ykyfzn6Z8Wkf1Ccl@kernel.org>
In-Reply-To: <Ykyfzn6Z8Wkf1Ccl@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 6 Apr 2022 22:32:46 +0200
Message-ID: <CA+icZUUH3zcM=esQTP5P4oCFaCyZumDQu+3d3Ov_mOr-q_b65Q@mail.gmail.com>
Subject: Re: Build perf with clang, failure with libperf
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Fangrui Song <maskray@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Keeping <john@metanate.com>, Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000d2108405dc024564"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,OBFU_TEXT_ATTACH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_SPAMMY_FILENAME,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000d2108405dc024564
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 5, 2022 at 10:00 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Tue, Apr 05, 2022 at 05:46:00PM +0200, Sedat Dilek escreveu:
> > On Tue, Apr 5, 2022 at 4:47 PM Arnaldo Carvalho de Melo <arnaldo.melo@g=
mail.com> wrote:
> > > Em Mon, Apr 04, 2022 at 02:53:24PM -0700, Nathan Chancellor escreveu:
>
> > > +++ b/tools/build/feature/Makefile
> > > @@ -220,6 +220,13 @@ PERL_EMBED_LIBADD =3D $(call grep-libs,$(PERL_EM=
BED_LDOPTS))
> > >  PERL_EMBED_CCOPTS =3D $(shell perl -MExtUtils::Embed -e ccopts 2>/de=
v/null)
> > >  FLAGS_PERL_EMBED=3D$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
> > >
> > > +ifeq ($(CC_NO_CLANG), 0)
> > > +  PERL_EMBED_LDOPTS :=3D $(filter-out -specs=3D%,$(PERL_EMBED_LDOPTS=
))
> > > +  PERL_EMBED_CCOPTS :=3D $(filter-out -flto=3Dauto -ffat-lto-objects=
, $(PERL_EMBED_CCOPTS))
> >
> > ^^ This affects CONFIG_LTO_CLANG=3Dy only, so check for it?
>
> Well, at this point when trying to build with CC=3Dclang one won't get
> libperf detected, so the priority is to make it work, i.e. filter out
> the options that prevent this type of build to complete.
>
> And looking at kernel config options is something we try not to do
>
> > > +  PERL_EMBED_CCOPTS :=3D $(filter-out -specs=3D%,$(PERL_EMBED_CCOPTS=
))
> > > +  FLAGS_PERL_EMBED +=3D -Wno-compound-token-split-by-macro
> >
> > ^^ Maybe add a comment here or in the commit message that this occurs
> > with perl v5.34.
> > Together with the links Nathan pointing to the perl BTS?
>
> Ok, I'll add these notes to the commit log message.
>
> > > +endif
> > > +
> > >  $(OUTPUT)test-libperl.bin:
> > >         $(BUILD) $(FLAGS_PERL_EMBED)
>
> > > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > > index 96ad944ca6a885cd..5b5ba475a5c00c0f 100644
> > > --- a/tools/perf/Makefile.config
> > > +++ b/tools/perf/Makefile.config
> > > @@ -790,6 +790,9 @@ else
> > >      LDFLAGS +=3D $(PERL_EMBED_LDFLAGS)
> > >      EXTLIBS +=3D $(PERL_EMBED_LIBADD)
> > >      CFLAGS +=3D -DHAVE_LIBPERL_SUPPORT
> > > +    ifeq ($(CC_NO_CLANG), 0)
> > > +      CFLAGS +=3D -Wno-compound-token-split-by-macro
> > > +    endif
> > >      $(call detected,CONFIG_LIBPERL)
> > >    endif
> > >  endif
>
> > ( I am here on Linux v5.17 + kbuild-gnu11-v5.18 and kbuild-v5.18 fixes.=
 )
> > ( My goal was to build perf with LLVM/Clang v13/v14 and -std=3Dgnu11. )
> > ( Debian/unstable switched to perl v5.34 in February. )
> > ( That is the background I hit these issues. )
>
> > Link: https://marc.info/?t=3D164646683300002&r=3D1&w=3D2
> > Link: https://marc.info/?t=3D164689324800001&r=3D1&w=3D2
>
> > Unsure what your base is.
>
> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tmp.perf/urg=
ent
>
> > When I recall correctly we have CLANG_FLAGS exported in the top-level M=
akefile?
> > Oh no, now it is here.
>
> CLANG_FLAGS?
>
> =E2=AC=A2[acme@toolbox perf]$ grep -r CLANG_FLAGS tools/
> tools/testing/selftests/rseq/Makefile:CLANG_FLAGS +=3D -no-integrated-as
> tools/testing/selftests/rseq/Makefile:    $(CLANG_FLAGS)
> tools/testing/selftests/tc-testing/Makefile:CLANG_FLAGS =3D -I. -I$(APIDI=
R) \
> tools/testing/selftests/tc-testing/Makefile:    $(CLANG) $(CLANG_FLAGS) \
> tools/testing/selftests/sched/Makefile:CLANG_FLAGS +=3D -no-integrated-as
> tools/testing/selftests/sched/Makefile:   $(CLANG_FLAGS)
> =E2=AC=A2[acme@toolbox perf]$
>
> That is not used in perf or tools/build/
>
> > $ git grep CLANG_FLAGS scripts/Makefile.clang
> > scripts/Makefile.clang:CLANG_FLAGS      +=3D --target=3D$(CLANG_TARGET_=
FLAGS)
> > scripts/Makefile.clang:CLANG_FLAGS      +=3D --target=3D$(notdir
> > $(CROSS_COMPILE:%-=3D%))
> > scripts/Makefile.clang:CLANG_FLAGS      +=3D -fno-integrated-as
> > scripts/Makefile.clang:CLANG_FLAGS      +=3D
> > --prefix=3D$(GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_COMPILE))
> > scripts/Makefile.clang:CLANG_FLAGS      +=3D -fintegrated-as
> > scripts/Makefile.clang:CLANG_FLAGS      +=3D -Werror=3Dunknown-warning-=
option
> > scripts/Makefile.clang:CLANG_FLAGS      +=3D -Werror=3Dignored-optimiza=
tion-argument
> > scripts/Makefile.clang:KBUILD_CFLAGS    +=3D $(CLANG_FLAGS)
> > scripts/Makefile.clang:KBUILD_AFLAGS    +=3D $(CLANG_FLAGS)
> > scripts/Makefile.clang:export CLANG_FLAGS
> >
> > So, are all these CLANG_FLAGS "inherited" to tools/ build ECO systems?
>
> Not really
>
> > I think no - it has its own rules :-(.
>
> yes
>
> > So, we should include scripts/Makefile.clang or enhance
> > tools/scripts/Makefile.include where LLVM/Clang stuff is defined (and
> > can be overridden).
>
> > Jiri pointed out he needed two options (when I recall correctly):
> >
> > [1] -Wno-unused-command-line-argument
> >
> > Example:
> > tools/testing/selftests/bpf/Makefile-# Silence some warnings when
> > compiled with clang
> > tools/testing/selftests/bpf/Makefile-ifneq ($(LLVM),)
> > tools/testing/selftests/bpf/Makefile:CFLAGS +=3D -Wno-unused-command-li=
ne-argument
> > tools/testing/selftests/bpf/Makefile-endif
> >
> > ^^ Here you see it is checked for LLVM.
> > Again, put that stuff in one single place - tools/scripts/Makefile.incl=
ude
> >
> > [2] -Wno-ignored-optimization-argument
> >
> > Both [1] and [2] were not needed in my case.
> >
> > [1] is always good to have - not only for perf.
> >
> > AFAICS, you wanted to consolidate PERL_EMBED_XXX and FLAGS_PERL_EMBED
> > at a single place.
> > 1. tools/build/feature/Makefile
> > 2. tools/perf/Makefile.config
>
> Yeah, at some point I'll do it, probably in the 5.19 window.
>
> > Can not say where we all need perl check/requirement - maybe put that
> > stuff to the place where we define/check for toolchain/compiler (see
> > above)?
> >
> > Again, all these issues happen because of -Werror is strictly set.
> >
> > I put my patches around that area (see 2nd patch) - without checking
> > if the LLVM/Clang toolchain is used or not.
> > Both patches are attached.
>
> I saw those patches, even added a:
>
> Based-on-a-patch-by: Sedat Dilek <sedat.dilek@gmail.com>
>
> > $ git show -1 for-5.17/tools-feature_detect_libperl-clang-dileks-v3
> > commit 72ba634c9b39547197900d8b64ff36134af3ed08
> > (for-5.17/tools-feature_detect_libperl-clang-dileks-v3)
> > Author: Sedat Dilek <sedat.dilek@gmail.com>
> > Date:   Sun Mar 13 12:37:06 2022 +0100
> >
> >    tools: feature-detect: libperl: Sync PERL_EMBED_CCOPTS with perf
> >
> > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefil=
e
> > index 1480910c792e..fa6be127f483 100644
> > --- a/tools/build/feature/Makefile
> > +++ b/tools/build/feature/Makefile
> > @@ -217,7 +217,8 @@ strip-libs =3D $(filter-out -l%,$(1))
> > PERL_EMBED_LDOPTS =3D $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/n=
ull)
> > PERL_EMBED_LDFLAGS =3D $(call strip-libs,$(PERL_EMBED_LDOPTS))
> > PERL_EMBED_LIBADD =3D $(call grep-libs,$(PERL_EMBED_LDOPTS))
> > -PERL_EMBED_CCOPTS =3D `perl -MExtUtils::Embed -e ccopts 2>/dev/null`
> > +PERL_EMBED_CCOPTS =3D $(perl -MExtUtils::Embed -e ccopts 2>/dev/null)
> > +PERL_EMBED_CCOPTS :=3D $(filter-out -ffat-lto-objects, $(PERL_EMBED_CC=
OPTS))
> > FLAGS_PERL_EMBED=3D$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
> >
> > $(OUTPUT)test-libperl.bin:
> >
> > $ git show -1 for-5.17/perf-libperl_support-clang-dileks
> > commit 316a1917ec05772ab0f99dad534fabdd74547865
> > (for-5.17/perf-libperl_support-clang-dileks)
> > Author: Sedat Dilek <sedat.dilek@gmail.com>
> > Date:   Sun Mar 6 11:29:50 2022 +0100
> >
> >    perf: Fix libperl support with clang and perl v5.34
> >
> > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefil=
e
> > index 1480910c792e..ef9b37c5c652 100644
> > --- a/tools/build/feature/Makefile
> > +++ b/tools/build/feature/Makefile
> > @@ -81,7 +81,7 @@ PKG_CONFIG ?=3D $(CROSS_COMPILE)pkg-config
> >
> > all: $(FILES)
> >
> > -__BUILD =3D $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst
> > %.bin,%.c,$(@F)) $(LDFLAGS)
> > +__BUILD =3D $(CC) $(CFLAGS) -MD -Wall -Werror
> > -Wno-compound-token-split-by-macro -o $@ $(patsubst %.bin,%.c,$(@F))
> > $(LDFLAGS)
> >   BUILD =3D $(__BUILD) > $(@:.bin=3D.make.output) 2>&1
> >
> > __BUILDXX =3D $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst
> > %.bin,%.cpp,$(@F)) $(LDFLAGS)
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 96ad944ca6a8..acc987daf56e 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -213,7 +213,7 @@ endif
> >
> > # Treat warnings as errors unless directed not to
> > ifneq ($(WERROR),0)
> > -  CORE_CFLAGS +=3D -Werror
> > +  CORE_CFLAGS +=3D -Werror -Wno-compound-token-split-by-macro
>
> Ok, you added it right after -Werror, which is equivalent, in the
> feature test case, to what I did.
>
> I'll take that into account when working on having all this in a single
> place, next merge window.
>
> >   CXXFLAGS +=3D -Werror
> >   HOSTCFLAGS +=3D -Werror
> > endif
> >
> > With both patches I am able to build perf-5.17 with LLVM/Clang v14 and
> > -std=3Dgnu11 and perl v5.34.
> >
> > It's good when Jiri tests on his system.
>
> Right, I'll test on these containers, with many gcc and clang versions:
>
>    1 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red H=
at 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93=
159d6c)
>    2 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0 , clan=
g version 3.8.0 (tags/RELEASE_380/final)
>    3 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 201608=
22 , clang version 3.8.1 (tags/RELEASE_381/final)
>    4 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0 , clan=
g version 4.0.0 (tags/RELEASE_400/final)
>    5 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpi=
ne clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
>    6 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpi=
ne clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
>    7 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpi=
ne clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
>    8 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpi=
ne clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
>    9 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpi=
ne clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5=
843401a9a702029556492689) (based on LLVM 9.0.0)
>   10 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpi=
ne clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7=
445adce501f8473efdb93b17b5eaf2f1445ed4c)
>   11 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1=
 20201203 , Alpine clang version 10.0.1
>   12 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424)=
 10.3.1 20210424 , Alpine clang version 11.1.0
>   13 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027)=
 10.3.1 20211027 , Alpine clang version 12.0.1
>   14 alpine:edge                   : Ok   gcc (Alpine 11.2.1_git20220219)=
 11.2.1 20220219 , Alpine clang version 13.0.1
>   15 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.=
1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_3=
80/final)
>   16 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.=
1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0
>   17 alt:p10                       : Ok   x86_64-alt-linux-gcc (GCC) 10.3=
.1 20210703 (ALT Sisyphus 10.3.1-alt2) , clang version 11.0.1
>   18 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 11.2=
.1 20211202 (ALT Sisyphus 11.2.1-alt2) , ALT Linux Team clang version 12.0.=
1
>   19 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red H=
at 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
>   20 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red H=
at 7.3.1-13) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
>   21 amazonlinux:devel             : Ok   gcc (GCC) 11.2.1 20210728 (Red =
Hat 11.2.1-2) , clang version 12.0.1 (Fedora 12.0.1-1.amzn2022)
>   22 archlinux:base                : FAIL clang version 13.0.1
>   23 centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red H=
at 8.4.1-1) , clang version 11.0.1 (Red Hat 11.0.1-1.module_el8.4.0+966+299=
5ef20)
>   24 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red H=
at 8.5.0-10) , clang version 13.0.0 (Red Hat 13.0.0-3.module_el8.6.0+1074+3=
80cef3f)
>   25 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel A=
rchitecture) 11.2.1 20220322 releases/gcc-11.2.0-884-gf45603f39b , clang ve=
rsion 13.0.0
>   26 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.=
3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
>   27 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , De=
bian clang version 11.0.1-2~deb10u1
>   28 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20=
210110 , Debian clang version 11.0.1-2
>   29 debian:experimental           : Ok   gcc (Debian 11.2.0-19) 11.2.0 ,=
 Debian clang version 13.0.1-3+b2
>   30 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 1=
1.2.0-18) 11.2.0
>   31 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 11.2=
.0-18) 11.2.0
>   32 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debi=
an 10.2.1-6) 10.2.1 20210110
>   33 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 11=
.2.0-18) 11.2.0
>   34 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red H=
at 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
>   35 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red H=
at 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
>   36 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red H=
at 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
>   37 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Li=
nux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
>   38 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red H=
at 6.4.1-1) , clang version 3.9.1 (tags/RELEASE_391/final)
>   39 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red H=
at 7.3.1-2) , clang version 4.0.1 (tags/RELEASE_401/final)
>   40 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red H=
at 7.3.1-6) , clang version 5.0.2 (tags/RELEASE_502/final)
>   41 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red H=
at 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
>   42 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red H=
at 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
>   43 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red H=
at 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
>   44 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red H=
at 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
>   45 fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red =
Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
>   46 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red =
Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
>   47 fedora:34                     : Ok   gcc (GCC) 11.2.1 20220127 (Red =
Hat 11.2.1-9) , clang version 12.0.1 (Fedora 12.0.1-1.fc34)
>   48 fedora:34-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux=
 glibc toolchain 2019.03-rc1) 8.3.1 20190225
>   49 fedora:34-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux =
uClibc toolchain 2019.03-rc1) 8.3.1 20190225
>   50 fedora:35                     : Ok   gcc (GCC) 11.2.1 20220127 (Red =
Hat 11.2.1-9) , clang version 13.0.0 (Fedora 13.0.0-3.fc35)
>   51 fedora:36                     : FAIL gcc version 12.0.1 20220308 (Re=
d Hat 12.0.1-0) (GCC)
>   52 fedora:rawhide                : Ok   gcc (GCC) 12.0.1 20220308 (Red =
Hat 12.0.1-0) , clang version 13.0.1 (Fedora 13.0.1-1.fc37)
>   53 gentoo-stage3:latest          : Ok   gcc (Gentoo 11.2.0 p1) 11.2.0 ,=
 clang version 13.0.0
>   54 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0=
 , clang version 3.9.1 (tags/RELEASE_391/final)
>   55 mageia:7                      : FAIL clang version 8.0.0 (Mageia 8.0=
.0-1.mga7)
>   56 manjaro:base                  : Ok   gcc (GCC) 11.1.0 , clang versio=
n 13.0.0
>   57 openmandriva:4.2              : FAIL gcc version 11.2.0 20210728 (Op=
enMandriva) (GCC)
>   58 openmandriva:cooker           : FAIL gcc version 11.2.0 20210728 (Op=
enMandriva) (GCC)
>   59 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905=
 [gcc-7-branch revision 275407] , clang version 5.0.1 (tags/RELEASE_501/fin=
al 312548)
>   60 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 , clang =
version 7.0.1 (tags/RELEASE_701/final 349238)
>   61 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang =
version 9.0.1
>   62 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang =
version 11.0.1
>   63 opensuse:15.4                 : Ok   gcc (SUSE Linux) 7.5.0 , clang =
version 11.0.1
>   64 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 11.2.1 2021112=
4 [revision 7510c23c1ec53aa4a62705f0384079661342ff7b] , clang version 13.0.=
0
>   65 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 20210514 (Red H=
at 8.5.0-4.0.1) , clang version 12.0.1 (Red Hat 12.0.1-4.0.1.module+el8.5.0=
+20428+2b4ecd47)
>   66 rockylinux:8                  : Ok   gcc (GCC) 8.5.0 20210514 (Red H=
at 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module+el8.5.0+715+58f=
51d49)
>   67 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.0=
4.12) 5.4.0 20160609 , clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final=
)
>   68 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu=
/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   69 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/L=
inaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   70 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5=
.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   71 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu=
/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   72 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubun=
tu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   73 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4=
.0-6ubuntu1~16.04.9) 5.4.0 20160609
>   74 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.0=
4) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
>   75 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu=
/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0
>   76 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/L=
inaro 7.5.0-3ubuntu1~18.04) 7.5.0
>   77 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.=
0-3ubuntu1~18.04) 7.5.0
>   78 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7=
.5.0-3ubuntu1~18.04) 7.5.0
>   79 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu=
 7.5.0-3ubuntu1~18.04) 7.5.0
>   80 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubun=
tu 7.5.0-3ubuntu1~18.04) 7.5.0
>   81 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7=
.5.0-3ubuntu1~18.04) 7.5.0
>   82 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5=
.0-3ubuntu1~18.04) 7.5.0
>   83 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0=
-3ubuntu1~18.04) 7.5.0
>   84 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7=
.5.0-3ubuntu1~18.04) 7.5.0
>   85 ubuntu:20.04                  : FAIL clang version 10.0.0-4ubuntu1
>   86 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubun=
tu 10.3.0-1ubuntu1~20.04) 10.3.0
>   87 ubuntu:20.10                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1~20.=
10) 10.3.0 , Ubuntu clang version 11.0.0-2
>   88 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1) 10=
.3.0 , Ubuntu clang version 12.0.0-3ubuntu1~21.04.2
>   89 ubuntu:21.10                  : Ok   gcc (Ubuntu 11.2.0-7ubuntu2) 11=
.2.0 , Ubuntu clang version 13.0.0-2
>   90 ubuntu:22.04                  : FAIL gcc version 11.2.0 (Ubuntu 11.2=
.0-18ubuntu1)
>
> > I can test your patch with my next kernel-build, but can not promise.
> > Do you have it somewhere in a Git repo/branch or a (LORE) link for
> > easy application?
>
> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tmp.perf/urg=
ent
>
> > Did not check if b4 tool is able to extract it as patch out of your
> > original email.
> >
> > - Sedat -
>
> > From 72ba634c9b39547197900d8b64ff36134af3ed08 Mon Sep 17 00:00:00 2001
> > From: Sedat Dilek <sedat.dilek@gmail.com>
> > Date: Sun, 13 Mar 2022 12:37:06 +0100
> > Subject: [PATCH] tools: feature-detect: libperl: Sync PERL_EMBED_CCOPTS=
 with
> >  perf
> >
> > ---
> >  tools/build/feature/Makefile | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefil=
e
> > index 1480910c792e..fa6be127f483 100644
> > --- a/tools/build/feature/Makefile
> > +++ b/tools/build/feature/Makefile
> > @@ -217,7 +217,8 @@ strip-libs =3D $(filter-out -l%,$(1))
> >  PERL_EMBED_LDOPTS =3D $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/=
null)
> >  PERL_EMBED_LDFLAGS =3D $(call strip-libs,$(PERL_EMBED_LDOPTS))
> >  PERL_EMBED_LIBADD =3D $(call grep-libs,$(PERL_EMBED_LDOPTS))
> > -PERL_EMBED_CCOPTS =3D `perl -MExtUtils::Embed -e ccopts 2>/dev/null`
> > +PERL_EMBED_CCOPTS =3D $(perl -MExtUtils::Embed -e ccopts 2>/dev/null)
> > +PERL_EMBED_CCOPTS :=3D $(filter-out -ffat-lto-objects, $(PERL_EMBED_CC=
OPTS))
> >  FLAGS_PERL_EMBED=3D$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
> >
> >  $(OUTPUT)test-libperl.bin:
> > --
> > 2.35.1
> >
>
> > From 316a1917ec05772ab0f99dad534fabdd74547865 Mon Sep 17 00:00:00 2001
> > From: Sedat Dilek <sedat.dilek@gmail.com>
> > Date: Sun, 6 Mar 2022 11:29:50 +0100
> > Subject: [PATCH] perf: Fix libperl support with clang and perl v5.34
> >
> > ---
> >  tools/build/feature/Makefile | 2 +-
> >  tools/perf/Makefile.config   | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefil=
e
> > index 1480910c792e..ef9b37c5c652 100644
> > --- a/tools/build/feature/Makefile
> > +++ b/tools/build/feature/Makefile
> > @@ -81,7 +81,7 @@ PKG_CONFIG ?=3D $(CROSS_COMPILE)pkg-config
> >
> >  all: $(FILES)
> >
> > -__BUILD =3D $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%=
.c,$(@F)) $(LDFLAGS)
> > +__BUILD =3D $(CC) $(CFLAGS) -MD -Wall -Werror -Wno-compound-token-spli=
t-by-macro -o $@ $(patsubst %.bin,%.c,$(@F)) $(LDFLAGS)
> >    BUILD =3D $(__BUILD) > $(@:.bin=3D.make.output) 2>&1
> >
> >  __BUILDXX =3D $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.=
bin,%.cpp,$(@F)) $(LDFLAGS)
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 96ad944ca6a8..acc987daf56e 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -213,7 +213,7 @@ endif
> >
> >  # Treat warnings as errors unless directed not to
> >  ifneq ($(WERROR),0)
> > -  CORE_CFLAGS +=3D -Werror
> > +  CORE_CFLAGS +=3D -Werror -Wno-compound-token-split-by-macro
> >    CXXFLAGS +=3D -Werror
> >    HOSTCFLAGS +=3D -Werror
> >  endif
> > --
> > 2.35.1
> >
>
>
> - Arnaldo

Hi Arnaldo,

Thanks for your patches.

I tested with Debian's latest LLVM-14 and my selfmade LLVM-14 toolchains.

$ /usr/lib/llvm-14/bin/clang -v
Debian clang version 14.0.0-2
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/lib/llvm-14/bin
Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/10
Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/11
Selected GCC installation: /usr/lib/gcc/x86_64-linux-gnu/11
Candidate multilib: .;@m64
Candidate multilib: 32;@m32
Candidate multilib: x32;@mx32
Selected multilib: .;@m64

$ /opt/llvm-toolchain/bin/clang -v
dileks clang version 14.0.1 (https://github.com/llvm/llvm-project.git
99c0f85ef992e9aa6465f27a8b05601667412bc7)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /opt/llvm-toolchain/bin
Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/10
Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/11
Selected GCC installation: /usr/lib/gcc/x86_64-linux-gnu/11
Candidate multilib: .;@m64
Candidate multilib: 32;@m32
Candidate multilib: x32;@mx32
Selected multilib: .;@m64

I reverted my patches and applied yours:

$ git log --oneline -4
bccc88d26f1f (HEAD -> 5.17.1-6-amd64-clang14-lto) tools build: Filter
out options and warnings not supported by clang
19b1b5c6614c tools build: Use $(shell ) instead of `` to get embedded
libperl's ccopts
c655b9fbcfd2 Revert "perf: Fix libperl support with clang and perl v5.34"
99ea736f45f7 Revert "tools: feature-detect: libperl: Sync
PERL_EMBED_CCOPTS with perf"

[ debian LLVM-14 ]

 1019  2022-04-06 22:03:11 LLVM_MVER=3D"14"
 1020  2022-04-06 22:03:11 LLVM_TOOLCHAIN_PATH=3D"/usr/lib/llvm-${LLVM_MVER=
}/bin"
 1021  2022-04-06 22:03:11 ##LLVM_TOOLCHAIN_PATH=3D"/opt/llvm-toolchain/bin=
"
 1022  2022-04-06 22:03:11 if [ -d ${LLVM_TOOLCHAIN_PATH} ]; then
export PATH=3D"${LLVM_TOOLCHAIN_PATH}:${PATH}"; fi
 1023  2022-04-06 22:03:11 echo $PATH
 1024  2022-04-06 22:03:11 PYTHON_VER=3D"3.10"
 1025  2022-04-06 22:03:11 MAKE=3D"make"
 1026  2022-04-06 22:03:11 MAKE_OPTS=3D"V=3D1 -j4 HOSTCC=3Dclang
HOSTLD=3Dld.lld HOSTAR=3Dllvm-ar CC=3Dclang LD=3Dld.lld AR=3Dllvm-ar
STRIP=3Dllvm-strip"
 1027  2022-04-06 22:03:11 echo $PYTHON_VER $MAKE $MAKE_OPTS
 1028  2022-04-06 22:03:46 LC_ALL=3DC $MAKE $MAKE_OPTS -C tools/perf
clean 2>&1 | tee ../make-log_perf-clean.txt
 1029  2022-04-06 22:04:21 LC_ALL=3DC $MAKE $MAKE_OPTS -C tools/perf
PYTHON=3Dpython${PYTHON_VER} install-bin 2>&1 | tee
../make-log_perf-python${PYTHON_VER}-install_bin_debian-llvm14.txt

 [ dileks LLVM-14 ]

 1004  2022-04-06 22:14:23 LLVM_MVER=3D"14"
 1005  2022-04-06 22:14:35 LLVM_TOOLCHAIN_PATH=3D"/opt/llvm-toolchain/bin"
 1006  2022-04-06 22:14:35 if [ -d ${LLVM_TOOLCHAIN_PATH} ]; then
export PATH=3D"${LLVM_TOOLCHAIN_PATH}:${PATH}"; fi
 1007  2022-04-06 22:14:35 echo $PATH
 1008  2022-04-06 22:14:35 PYTHON_VER=3D"3.10"
 1009  2022-04-06 22:14:35 MAKE=3D"make"
 1010  2022-04-06 22:14:35 MAKE_OPTS=3D"V=3D1 -j4 HOSTCC=3Dclang
HOSTLD=3Dld.lld HOSTAR=3Dllvm-ar CC=3Dclang LD=3Dld.lld AR=3Dllvm-ar
STRIP=3Dllvm-strip"
 1011  2022-04-06 22:14:35 echo $PYTHON_VER $MAKE $MAKE_OPTS
 1012  2022-04-06 22:14:41 echo $PATH
 1013  2022-04-06 22:14:51 LC_ALL=3DC $MAKE $MAKE_OPTS -C tools/perf
clean 2>&1 | tee ../make-log_perf-clean.txt
 1014  2022-04-06 22:14:56 cd git/
 1015  2022-04-06 22:14:57 LC_ALL=3DC $MAKE $MAKE_OPTS -C tools/perf
clean 2>&1 | tee ../make-log_perf-clean.txt
 1016  2022-04-06 22:15:14 LC_ALL=3DC $MAKE $MAKE_OPTS -C tools/perf
PYTHON=3Dpython${PYTHON_VER} install-bin 2>&1 | tee
../make-log_perf-python${PYTHON_VER}-install_bin_dileks-llvm14.txt

[ PERF ]

$ ~/bin/perf -vv
perf version 5.17.1
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

For details see attached instructions and build-logs.

Feel free to add my credits:

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # Debian/Selfmade
LLVM-14 (x86-64)

Personally, I would like to see your patches for Linux v5.18 (do not
wait v5.19).

- Sedat -

--000000000000d2108405dc024564
Content-Type: text/plain; charset="US-ASCII"; name="TESTING-PERF-URGENT-ACME-20220406.txt"
Content-Disposition: attachment; 
	filename="TESTING-PERF-URGENT-ACME-20220406.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_l1o0vtsf0>
X-Attachment-Id: f_l1o0vtsf0

WyBQUkVQUyBdCgogMTAwNiAgMjAyMi0wNC0wNiAyMTo1Nzo1MCBnaXQgbG9nIC0tb25lbGluZSB2
NS4xNy4xLi4gfCBncmVwIHBlcmwKIDEwMDcgIDIwMjItMDQtMDYgMjE6NTg6MzMgZ2l0IHJldmVy
dCAtLW5vLWVkaXQgNzJiYTYzNGM5YjM5CiAxMDA4ICAyMDIyLTA0LTA2IDIyOjAwOjI4IGdpdCBy
ZXZlcnQgLS1uby1lZGl0IDMxNmExOTE3ZWMwNQogMTAwOSAgMjAyMi0wNC0wNiAyMjowMDozMSBj
ZCAuLgogMTAxMCAgMjAyMi0wNC0wNiAyMjowMToxMyB3Z2V0IC1PIDEtcGVyZi11cmdlbnQtYWNt
ZS5wYXRjaCAiaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
YWNtZS9saW51eC5naXQvcGF0Y2gvP2lkPWM5MDk0ZmNhOTMyNzJlMGJkYzU4MGFmNjk1Y2M2OWU3
MzdiOGNhYjMiCiAxMDExICAyMDIyLTA0LTA2IDIyOjAxOjM0IHdnZXQgLU8gMi1wZXJmLXVyZ2Vu
dC1hY21lLnBhdGNoICJodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC9hY21lL2xpbnV4LmdpdC9wYXRjaC8/aWQ9MzUwN2NhZWRjMTAxOWU2NWVhN2I5Yjg3YTE5
YmE4YTAzYTg0ZjJhOSIKIDEwMTIgIDIwMjItMDQtMDYgMjI6MDE6MzYgY2QgZ2l0LwogMTAxMyAg
MjAyMi0wNC0wNiAyMjowMTo0MCBnaXQgYnJhbmNoIC0tc2hvdy1jdXJyZW50CiAxMDE0ICAyMDIy
LTA0LTA2IDIyOjAxOjQ5IGdpdCBhcHBseSAtLWNoZWNrIC0tdmVyYm9zZSAuLi8xLXBlcmYtdXJn
ZW50LWFjbWUucGF0Y2gKIDEwMTUgIDIwMjItMDQtMDYgMjI6MDE6NTYgZ2l0IGFtIC4uLzEtcGVy
Zi11cmdlbnQtYWNtZS5wYXRjaAogMTAxNiAgMjAyMi0wNC0wNiAyMjowMjowMyBnaXQgYXBwbHkg
LS1jaGVjayAtLXZlcmJvc2UgLi4vMi1wZXJmLXVyZ2VudC1hY21lLnBhdGNoCiAxMDE3ICAyMDIy
LTA0LTA2IDIyOjAyOjA5IGdpdCBhbSAuLi8yLXBlcmYtdXJnZW50LWFjbWUucGF0Y2gKIDEwMTgg
IDIwMjItMDQtMDYgMjI6MDI6NDcgcGxvY2F0ZSBob3d0b3MgfCBncmVwIHBlcmYKClsgZGViaWFu
IExMVk0tMTQgXQoKIDEwMTkgIDIwMjItMDQtMDYgMjI6MDM6MTEgTExWTV9NVkVSPSIxNCIKIDEw
MjAgIDIwMjItMDQtMDYgMjI6MDM6MTEgTExWTV9UT09MQ0hBSU5fUEFUSD0iL3Vzci9saWIvbGx2
bS0ke0xMVk1fTVZFUn0vYmluIgogMTAyMSAgMjAyMi0wNC0wNiAyMjowMzoxMSAjI0xMVk1fVE9P
TENIQUlOX1BBVEg9Ii9vcHQvbGx2bS10b29sY2hhaW4vYmluIgogMTAyMiAgMjAyMi0wNC0wNiAy
MjowMzoxMSBpZiBbIC1kICR7TExWTV9UT09MQ0hBSU5fUEFUSH0gXTsgdGhlbiAgICBleHBvcnQg
UEFUSD0iJHtMTFZNX1RPT0xDSEFJTl9QQVRIfToke1BBVEh9IjsgZmkKIDEwMjMgIDIwMjItMDQt
MDYgMjI6MDM6MTEgZWNobyAkUEFUSAogMTAyNCAgMjAyMi0wNC0wNiAyMjowMzoxMSBQWVRIT05f
VkVSPSIzLjEwIgogMTAyNSAgMjAyMi0wNC0wNiAyMjowMzoxMSBNQUtFPSJtYWtlIgogMTAyNiAg
MjAyMi0wNC0wNiAyMjowMzoxMSBNQUtFX09QVFM9IlY9MSAtajQgSE9TVENDPWNsYW5nIEhPU1RM
RD1sZC5sbGQgSE9TVEFSPWxsdm0tYXIgQ0M9Y2xhbmcgTEQ9bGQubGxkIEFSPWxsdm0tYXIgU1RS
SVA9bGx2bS1zdHJpcCIKIDEwMjcgIDIwMjItMDQtMDYgMjI6MDM6MTEgZWNobyAkUFlUSE9OX1ZF
UiAkTUFLRSAkTUFLRV9PUFRTCiAxMDI4ICAyMDIyLTA0LTA2IDIyOjAzOjQ2IExDX0FMTD1DICRN
QUtFICRNQUtFX09QVFMgLUMgdG9vbHMvcGVyZiBjbGVhbiAyPiYxIHwgdGVlIC4uL21ha2UtbG9n
X3BlcmYtY2xlYW4udHh0CiAxMDI5ICAyMDIyLTA0LTA2IDIyOjA0OjIxIExDX0FMTD1DICRNQUtF
ICRNQUtFX09QVFMgLUMgdG9vbHMvcGVyZiBQWVRIT049cHl0aG9uJHtQWVRIT05fVkVSfSBpbnN0
YWxsLWJpbiAyPiYxIHwgdGVlIC4uL21ha2UtbG9nX3BlcmYtcHl0aG9uJHtQWVRIT05fVkVSfS1p
bnN0YWxsX2Jpbl9kZWJpYW4tbGx2bTE0LnR4dAoKIFsgZGlsZWtzIExMVk0tMTQgXQoKIDEwMDIg
IDIwMjItMDQtMDYgMjI6MTQ6MTMgY2Qgc3JjLwogMTAwMyAgMjAyMi0wNC0wNiAyMjoxNDoxNSBj
ZCBsaW51eC1rZXJuZWwvCiAxMDA0ICAyMDIyLTA0LTA2IDIyOjE0OjIzIExMVk1fTVZFUj0iMTQi
CiAxMDA1ICAyMDIyLTA0LTA2IDIyOjE0OjM1IExMVk1fVE9PTENIQUlOX1BBVEg9Ii9vcHQvbGx2
bS10b29sY2hhaW4vYmluIgogMTAwNiAgMjAyMi0wNC0wNiAyMjoxNDozNSBpZiBbIC1kICR7TExW
TV9UT09MQ0hBSU5fUEFUSH0gXTsgdGhlbiAgICBleHBvcnQgUEFUSD0iJHtMTFZNX1RPT0xDSEFJ
Tl9QQVRIfToke1BBVEh9IjsgZmkKIDEwMDcgIDIwMjItMDQtMDYgMjI6MTQ6MzUgZWNobyAkUEFU
SAogMTAwOCAgMjAyMi0wNC0wNiAyMjoxNDozNSBQWVRIT05fVkVSPSIzLjEwIgogMTAwOSAgMjAy
Mi0wNC0wNiAyMjoxNDozNSBNQUtFPSJtYWtlIgogMTAxMCAgMjAyMi0wNC0wNiAyMjoxNDozNSBN
QUtFX09QVFM9IlY9MSAtajQgSE9TVENDPWNsYW5nIEhPU1RMRD1sZC5sbGQgSE9TVEFSPWxsdm0t
YXIgQ0M9Y2xhbmcgTEQ9bGQubGxkIEFSPWxsdm0tYXIgU1RSSVA9bGx2bS1zdHJpcCIKIDEwMTEg
IDIwMjItMDQtMDYgMjI6MTQ6MzUgZWNobyAkUFlUSE9OX1ZFUiAkTUFLRSAkTUFLRV9PUFRTCiAx
MDEyICAyMDIyLTA0LTA2IDIyOjE0OjQxIGVjaG8gJFBBVEgKIDEwMTMgIDIwMjItMDQtMDYgMjI6
MTQ6NTEgTENfQUxMPUMgJE1BS0UgJE1BS0VfT1BUUyAtQyB0b29scy9wZXJmIGNsZWFuIDI+JjEg
fCB0ZWUgLi4vbWFrZS1sb2dfcGVyZi1jbGVhbi50eHQKIDEwMTQgIDIwMjItMDQtMDYgMjI6MTQ6
NTYgY2QgZ2l0LwogMTAxNSAgMjAyMi0wNC0wNiAyMjoxNDo1NyBMQ19BTEw9QyAkTUFLRSAkTUFL
RV9PUFRTIC1DIHRvb2xzL3BlcmYgY2xlYW4gMj4mMSB8IHRlZSAuLi9tYWtlLWxvZ19wZXJmLWNs
ZWFuLnR4dAogMTAxNiAgMjAyMi0wNC0wNiAyMjoxNToxNCBMQ19BTEw9QyAkTUFLRSAkTUFLRV9P
UFRTIC1DIHRvb2xzL3BlcmYgUFlUSE9OPXB5dGhvbiR7UFlUSE9OX1ZFUn0gaW5zdGFsbC1iaW4g
Mj4mMSB8IHRlZSAuLi9tYWtlLWxvZ19wZXJmLXB5dGhvbiR7UFlUSE9OX1ZFUn0taW5zdGFsbF9i
aW5fZGlsZWtzLWxsdm0xNC50eAogMTAxNyAgMjAyMi0wNC0wNiAyMjoxNjo0MSB+L2Jpbi9wZXJm
IC12dgoKJCB+L2Jpbi9wZXJmIC12dgpwZXJmIHZlcnNpb24gNS4xNy4xCiAgICAgICAgICAgICAg
ICAgZHdhcmY6IFsgb24gIF0gICMgSEFWRV9EV0FSRl9TVVBQT1JUCiAgICBkd2FyZl9nZXRsb2Nh
dGlvbnM6IFsgb24gIF0gICMgSEFWRV9EV0FSRl9HRVRMT0NBVElPTlNfU1VQUE9SVAogICAgICAg
ICAgICAgICAgIGdsaWJjOiBbIG9uICBdICAjIEhBVkVfR0xJQkNfU1VQUE9SVAogICAgICAgICBz
eXNjYWxsX3RhYmxlOiBbIG9uICBdICAjIEhBVkVfU1lTQ0FMTF9UQUJMRV9TVVBQT1JUCiAgICAg
ICAgICAgICAgICBsaWJiZmQ6IFsgb24gIF0gICMgSEFWRV9MSUJCRkRfU1VQUE9SVAogICAgICAg
ICAgICAgICAgbGliZWxmOiBbIG9uICBdICAjIEhBVkVfTElCRUxGX1NVUFBPUlQKICAgICAgICAg
ICAgICAgbGlibnVtYTogWyBvbiAgXSAgIyBIQVZFX0xJQk5VTUFfU1VQUE9SVApudW1hX251bV9w
b3NzaWJsZV9jcHVzOiBbIG9uICBdICAjIEhBVkVfTElCTlVNQV9TVVBQT1JUCiAgICAgICAgICAg
ICAgIGxpYnBlcmw6IFsgb24gIF0gICMgSEFWRV9MSUJQRVJMX1NVUFBPUlQKICAgICAgICAgICAg
IGxpYnB5dGhvbjogWyBvbiAgXSAgIyBIQVZFX0xJQlBZVEhPTl9TVVBQT1JUCiAgICAgICAgICAg
ICAgbGlic2xhbmc6IFsgb24gIF0gICMgSEFWRV9TTEFOR19TVVBQT1JUCiAgICAgICAgICAgICBs
aWJjcnlwdG86IFsgb24gIF0gICMgSEFWRV9MSUJDUllQVE9fU1VQUE9SVAogICAgICAgICAgICAg
bGlidW53aW5kOiBbIG9uICBdICAjIEhBVkVfTElCVU5XSU5EX1NVUFBPUlQKICAgIGxpYmR3LWR3
YXJmLXVud2luZDogWyBvbiAgXSAgIyBIQVZFX0RXQVJGX1NVUFBPUlQKICAgICAgICAgICAgICAg
ICAgemxpYjogWyBvbiAgXSAgIyBIQVZFX1pMSUJfU1VQUE9SVAogICAgICAgICAgICAgICAgICBs
em1hOiBbIG9uICBdICAjIEhBVkVfTFpNQV9TVVBQT1JUCiAgICAgICAgICAgICBnZXRfY3B1aWQ6
IFsgb24gIF0gICMgSEFWRV9BVVhUUkFDRV9TVVBQT1JUCiAgICAgICAgICAgICAgICAgICBicGY6
IFsgb24gIF0gICMgSEFWRV9MSUJCUEZfU1VQUE9SVAogICAgICAgICAgICAgICAgICAgYWlvOiBb
IG9uICBdICAjIEhBVkVfQUlPX1NVUFBPUlQKICAgICAgICAgICAgICAgICAgenN0ZDogWyBvbiAg
XSAgIyBIQVZFX1pTVERfU1VQUE9SVAogICAgICAgICAgICAgICBsaWJwZm00OiBbIE9GRiBdICAj
IEhBVkVfTElCUEZNCgotIGRpbGVrcyAvLyAwNi1BcHItMjAyMgoK
--000000000000d2108405dc024564
Content-Type: application/zstd; 
	name="make-log_perf-python3.10-install_bin_debian-llvm14.txt.zst"
Content-Disposition: attachment; 
	filename="make-log_perf-python3.10-install_bin_debian-llvm14.txt.zst"
Content-Transfer-Encoding: base64
Content-ID: <f_l1o0vyb11>
X-Attachment-Id: f_l1o0vyb11

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
iROx8tDC8LbKF+4YWIKEpBAEFPCd0iYoyihWYw==
--000000000000d2108405dc024564
Content-Type: application/octet-stream; 
	name="make-log_perf-python3.10-install_bin_debian-llvm14.txt.zst.sha256"
Content-Disposition: attachment; 
	filename="make-log_perf-python3.10-install_bin_debian-llvm14.txt.zst.sha256"
Content-Transfer-Encoding: base64
Content-ID: <f_l1o0w2gh2>
X-Attachment-Id: f_l1o0w2gh2

MzFlYTE3MTBkMzkxM2RmYzJhY2ZkMzVhYTYxZGUzN2EwNzdjNjkzMzI5NDE0MzFiN2NmMzQ4NmM4
M2QxZjFmYyAgbWFrZS1sb2dfcGVyZi1weXRob24zLjEwLWluc3RhbGxfYmluX2RlYmlhbi1sbHZt
MTQudHh0LnpzdAo=
--000000000000d2108405dc024564
Content-Type: application/zstd; 
	name="make-log_perf-python3.10-install_bin_dileks-llvm14.txt.zst"
Content-Disposition: attachment; 
	filename="make-log_perf-python3.10-install_bin_dileks-llvm14.txt.zst"
Content-Transfer-Encoding: base64
Content-ID: <f_l1o0w60s3>
X-Attachment-Id: f_l1o0w60s3

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
--000000000000d2108405dc024564
Content-Type: application/octet-stream; 
	name="make-log_perf-python3.10-install_bin_dileks-llvm14.txt.zst.sha256"
Content-Disposition: attachment; 
	filename="make-log_perf-python3.10-install_bin_dileks-llvm14.txt.zst.sha256"
Content-Transfer-Encoding: base64
Content-ID: <f_l1o0w9og4>
X-Attachment-Id: f_l1o0w9og4

YmMzZWFjNzI5MTVlYzliZTZmNzE3ZTU2ZjYxMTlhYTk4ZWZlNDQzMzhiNzUwOTk3NjE0MzQ1Y2Qy
NWY4MmZhZSAgbWFrZS1sb2dfcGVyZi1weXRob24zLjEwLWluc3RhbGxfYmluX2RpbGVrcy1sbHZt
MTQudHh0LnpzdAo=
--000000000000d2108405dc024564--
