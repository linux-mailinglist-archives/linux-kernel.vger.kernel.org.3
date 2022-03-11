Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC05C4D6B1E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiCKXlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 18:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiCKXlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 18:41:18 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E31465C5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 15:40:14 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id q11so11926131iod.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 15:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=jCFKiWmnMiPn9mYq6dvQ4yRW3pp0ufpRjx1ACgMIcp4=;
        b=hd1IiaHAmnnlD4a3ZVVY5idtVY+oknuq9ow6L9257b8HToCasTW/G/vRHEDEQJBWRo
         vW9ba3tI1K8JbbYcAOWbmThdd6NK2QRM9M5g7BamcXy/GblTmxhhLJu8eNm6umbENRmt
         M0/qSo7bAhk7hLrYinDZJ0BgqhdVbYK4Ure2Y9hgylPMXpaS5QHF/3QJUcSvSDhGA6GR
         Vz9V5yWK2397PWuVViVLUnuZLjjstmAyEZGyVjPXPhrh+qvj7qSjLeSFMP2QERvBnx1A
         EyukSuJ+Pax3psoS19rlq5mi1WgjRhna9WwzDsX3q5oHpExS9aUYqqH+K/Bc+SPTCRf7
         tE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=jCFKiWmnMiPn9mYq6dvQ4yRW3pp0ufpRjx1ACgMIcp4=;
        b=PzMt3f+AGOI4zLRpPOWmh7rqUiOMh9zsNDf7opzApMxrotZQE4rNEtSTEwe9uwRu50
         ZvIWyNRckiaOOUR5GxreYY2YMvdd9kgIWiP4CZ62cngEeLaMK1DErQqR/pEQV/BILj3W
         O80skJFykWhq1ZkUm8wzPVBOn86O8tt2J+tmHGEROy7wxxbt/L4qlcASUTMIc5qk0Ncm
         Z0n4wHs1hV0Hc+bQgVayxxBBJQPQR4LzIN1EzQFZpqOQtGMXMEgFApCCGeobnHMg1ceU
         1kFbcJSv/HCEeF/DMvjnZVRRL4/yrL5k0bZimpO40Wji9kPzOMyhIsH0xbCiBSh+YY+o
         8Wbw==
X-Gm-Message-State: AOAM531cFUUDQZ9NndgH+dMhgNU+JrPMxmhPf4BJiFvOQV+Hk3GTMVhu
        sDVZ+pJzbXfH+pFCy8CbCsR/2NQUMtU0y5ry0nE=
X-Google-Smtp-Source: ABdhPJwGfdqVC5Eh/Ct1uyuKWxgEibOkyXlCoBuRI5u+LSixIzn7MPcxdtVPjHAP9OOUzLwPSqxk5oC0q57/ciKk+xw=
X-Received: by 2002:a05:6638:204:b0:319:1b34:1c57 with SMTP id
 e4-20020a056638020400b003191b341c57mr10444220jaq.80.1647042013385; Fri, 11
 Mar 2022 15:40:13 -0800 (PST)
MIME-Version: 1.0
References: <20220310061909.20166-1-sedat.dilek@gmail.com> <Yis41ykyJq1fHYSx@krava>
 <CA+icZUVzQwGSS9hcMMP-HeOAFYxrMH9oCRbxLEdcEUwEJ8Wa3Q@mail.gmail.com>
In-Reply-To: <CA+icZUVzQwGSS9hcMMP-HeOAFYxrMH9oCRbxLEdcEUwEJ8Wa3Q@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 12 Mar 2022 00:39:37 +0100
Message-ID: <CA+icZUUZjmAmNDfVVMqo_OBWsuS=DpET27nLn3yzPHVcFhxe9A@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="00000000000023718005d9f9dade"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000023718005d9f9dade
Content-Type: text/plain; charset="UTF-8"

On Sat, Mar 12, 2022 at 12:30 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Mar 11, 2022 at 12:56 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Mar 10, 2022 at 07:19:09AM +0100, Sedat Dilek wrote:
> > > When trying to build perf with a LLVM/Clang toolchain people see errors
> > > when testing for libperl feature.
> > >
> > > Jiri reports:
> > >
> > > > I'm getting some other lto related error:
> > > >
> > > >         $ cat test-libperl.make.output
> > > >         clang-13: error: optimization flag '-ffat-lto-objects' is not supported [-Werror,-Wignored-optimization-argument]
> > > >
> > >
> > > The reason is PERL_EMBED_CCOPTS is defined in two places:
> > >
> > > tools/build/feature/Makefile
> > > tools/perf/Makefile.config
> > >
> > > As an result FLAGS_PERL_EMBED is set differently.
> > >
> > > For building perf '-ffat-lto-objects' is filtered-out:
> > >
> > > $ git grep ffat-lto-objects tools/perf/
> > > tools/perf/Makefile.config:  PERL_EMBED_CCOPTS := $(filter-out -flto=auto -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
> > >
> > > Sync PERL_EMBED_CCOPTS in tools/build/feature/Makefile to fix this.
> > >
> > > For a minimal fix for Linux v5.17 this here was preferred by Arnaldo.
> > >
> > > Link: https://marc.info/?t=164646683300002&r=1&w=2
> > > Reported-by: Jiri Olsa <olsajiri@gmail.com>
> > > Reported-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> > > Tested-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> > > Suggested-by: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> > > Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > ---
> > >  tools/build/feature/Makefile | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> > > index 1480910c792e..869073cf8449 100644
> > > --- a/tools/build/feature/Makefile
> > > +++ b/tools/build/feature/Makefile
> > > @@ -218,6 +218,7 @@ PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
> > >  PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
> > >  PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
> > >  PERL_EMBED_CCOPTS = `perl -MExtUtils::Embed -e ccopts 2>/dev/null`
> > > +PERL_EMBED_CCOPTS := $(filter-out -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
> >
> > it looks like this is not enough, at least on fedora 35
> >
> > I had to add changes below on top of your patch, it fixed the perl
> > feature detection and perf build itself, but I'm still getting error
> > with perf/python.so:
> >
>
> Correct. This patch simply fixes the perl feature detection.
>
> >         $ CC=clang make JOBS=1
> >         ...
> >           GEN     python/perf.so
> >         python_ext_build/tmp/home/jolsa/kernel/linux-perf/tools/perf/util/python.o: file not recognized: file format not recognized
> >         clang-13: error: linker command failed with exit code 1 (use -v to see invocation)
> >         error: command 'clang' failed with exit status 1
> >         cp: cannot stat 'python_ext_build/lib/perf*.so': No such file or directory
> >
> > with:
> >
> >         $ file python_ext_build/tmp/home/jolsa/kernel/linux-perf/tools/perf/util/python.o
> >         python_ext_build/tmp/home/jolsa/kernel/linux-perf/tools/perf/util/python.o: LLVM IR bitcode
> >
> > do you get clean compile with python lang enabled?
> >
> > jirka
> >
> >
> > ---
> > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> > index 869073cf8449..86df0fe11ee5 100644
> > --- a/tools/build/feature/Makefile
> > +++ b/tools/build/feature/Makefile
> > @@ -217,9 +217,9 @@ strip-libs = $(filter-out -l%,$(1))
> >  PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
> >  PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
> >  PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
> > -PERL_EMBED_CCOPTS = `perl -MExtUtils::Embed -e ccopts 2>/dev/null`
> > +PERL_EMBED_CCOPTS := $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null)
> >  PERL_EMBED_CCOPTS := $(filter-out -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
> > -FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
> > +FLAGS_PERL_EMBED  := $(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS) -Wno-unused-command-line-argument -Wno-compound-token-split-by-macro
> >
> >  $(OUTPUT)test-libperl.bin:
> >         $(BUILD) $(FLAGS_PERL_EMBED)
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 96ad944ca6a8..38b0b0e7a168 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -778,7 +778,7 @@ else
> >    PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
> >    PERL_EMBED_CCOPTS = $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null)
> >    PERL_EMBED_CCOPTS := $(filter-out -specs=%,$(PERL_EMBED_CCOPTS))
> > -  PERL_EMBED_CCOPTS := $(filter-out -flto=auto -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
> > +  PERL_EMBED_CCOPTS := $(filter-out -flto=auto -ffat-lto-objects, $(PERL_EMBED_CCOPTS)) -Wno-unused-command-line-argument -Wno-compound-token-split-by-macro
> >    PERL_EMBED_LDOPTS := $(filter-out -specs=%,$(PERL_EMBED_LDOPTS))
> >    FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
> >
>
> I fixed that differently by (see [1]),
>
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -213,7 +213,7 @@ endif
>
> # Treat warnings as errors unless directed not to
> ifneq ($(WERROR),0)
> -  CORE_CFLAGS += -Werror
> +  CORE_CFLAGS += -Werror -Wno-compound-token-split-by-macro
>   CXXFLAGS += -Werror
>   HOSTCFLAGS += -Werror
> endif
>
> This was sufficient here to build perf successfully.
> And maybe ifdef-ed for clang?
>
> But all this is a follow-up?
>
> [1] https://lore.kernel.org/lkml/CA+icZUUCO+gOPLZumu_rTOJz1_v7gRRYVzzEZ+RZPOZBmkqCQg@mail.gmail.com/
>
> > diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> > index 483f05004e68..cfbb03babf63 100644
> > --- a/tools/perf/util/setup.py
> > +++ b/tools/perf/util/setup.py
> > @@ -43,7 +43,7 @@ class install_lib(_install_lib):
> >
> >  cflags = getenv('CFLAGS', '').split()
> >  # switch off several checks (need to be at the end of cflags list)
> > -cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls', '-DPYTHON_PERF' ]
> > +cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls', '-Wno-ignored-optimization-argument', '-DPYTHON_PERF' ]
> >  if not cc_is_clang:
> >      cflags += ['-Wno-cast-function-type' ]
> >
>
> Cannot say much to that.
>
> Do we want to fix perf building with LLVM/Clang for Linux v5.17 final or later?
> Arnaldo?
>

Attached is the patch I use to build perf.
( As said in the initial report I wanted to test perf with -std=gnu11. )
( Cannot say much if this related to perl v5.34 only. )

- Sedat -

[1] https://lore.kernel.org/lkml/CA+icZUWHd4VTKNwBtuxt9-fHoiYV+Q7tQ809Cn83k8sbQ_uNHw@mail.gmail.com/

--00000000000023718005d9f9dade
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-perf-Fix-libperl-support-with-clang-and-perl-v5.34.patch"
Content-Disposition: attachment; 
	filename="0001-perf-Fix-libperl-support-with-clang-and-perl-v5.34.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l0n26qhg0>
X-Attachment-Id: f_l0n26qhg0

RnJvbSAzMTZhMTkxN2VjMDU3NzJhYjBmOTlkYWQ1MzRmYWJkZDc0NTQ3ODY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZWRhdCBEaWxlayA8c2VkYXQuZGlsZWtAZ21haWwuY29tPgpE
YXRlOiBTdW4sIDYgTWFyIDIwMjIgMTE6Mjk6NTAgKzAxMDAKU3ViamVjdDogW1BBVENIXSBwZXJm
OiBGaXggbGlicGVybCBzdXBwb3J0IHdpdGggY2xhbmcgYW5kIHBlcmwgdjUuMzQKCi0tLQogdG9v
bHMvYnVpbGQvZmVhdHVyZS9NYWtlZmlsZSB8IDIgKy0KIHRvb2xzL3BlcmYvTWFrZWZpbGUuY29u
ZmlnICAgfCAyICstCiAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS90b29scy9idWlsZC9mZWF0dXJlL01ha2VmaWxlIGIvdG9vbHMv
YnVpbGQvZmVhdHVyZS9NYWtlZmlsZQppbmRleCAxNDgwOTEwYzc5MmUuLmVmOWIzN2M1YzY1MiAx
MDA2NDQKLS0tIGEvdG9vbHMvYnVpbGQvZmVhdHVyZS9NYWtlZmlsZQorKysgYi90b29scy9idWls
ZC9mZWF0dXJlL01ha2VmaWxlCkBAIC04MSw3ICs4MSw3IEBAIFBLR19DT05GSUcgPz0gJChDUk9T
U19DT01QSUxFKXBrZy1jb25maWcKIAogYWxsOiAkKEZJTEVTKQogCi1fX0JVSUxEID0gJChDQykg
JChDRkxBR1MpIC1NRCAtV2FsbCAtV2Vycm9yIC1vICRAICQocGF0c3Vic3QgJS5iaW4sJS5jLCQo
QEYpKSAkKExERkxBR1MpCitfX0JVSUxEID0gJChDQykgJChDRkxBR1MpIC1NRCAtV2FsbCAtV2Vy
cm9yIC1Xbm8tY29tcG91bmQtdG9rZW4tc3BsaXQtYnktbWFjcm8gLW8gJEAgJChwYXRzdWJzdCAl
LmJpbiwlLmMsJChARikpICQoTERGTEFHUykKICAgQlVJTEQgPSAkKF9fQlVJTEQpID4gJChAOi5i
aW49Lm1ha2Uub3V0cHV0KSAyPiYxCiAKIF9fQlVJTERYWCA9ICQoQ1hYKSAkKENYWEZMQUdTKSAt
TUQgLVdhbGwgLVdlcnJvciAtbyAkQCAkKHBhdHN1YnN0ICUuYmluLCUuY3BwLCQoQEYpKSAkKExE
RkxBR1MpCmRpZmYgLS1naXQgYS90b29scy9wZXJmL01ha2VmaWxlLmNvbmZpZyBiL3Rvb2xzL3Bl
cmYvTWFrZWZpbGUuY29uZmlnCmluZGV4IDk2YWQ5NDRjYTZhOC4uYWNjOTg3ZGFmNTZlIDEwMDY0
NAotLS0gYS90b29scy9wZXJmL01ha2VmaWxlLmNvbmZpZworKysgYi90b29scy9wZXJmL01ha2Vm
aWxlLmNvbmZpZwpAQCAtMjEzLDcgKzIxMyw3IEBAIGVuZGlmCiAKICMgVHJlYXQgd2FybmluZ3Mg
YXMgZXJyb3JzIHVubGVzcyBkaXJlY3RlZCBub3QgdG8KIGlmbmVxICgkKFdFUlJPUiksMCkKLSAg
Q09SRV9DRkxBR1MgKz0gLVdlcnJvcgorICBDT1JFX0NGTEFHUyArPSAtV2Vycm9yIC1Xbm8tY29t
cG91bmQtdG9rZW4tc3BsaXQtYnktbWFjcm8KICAgQ1hYRkxBR1MgKz0gLVdlcnJvcgogICBIT1NU
Q0ZMQUdTICs9IC1XZXJyb3IKIGVuZGlmCi0tIAoyLjM1LjEKCg==
--00000000000023718005d9f9dade--
