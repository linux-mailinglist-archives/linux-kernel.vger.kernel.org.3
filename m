Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D594F85A0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345984AbiDGROh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiDGROd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:14:33 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409B93BA41
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:12:32 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id q11so7576859iod.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 10:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=EoyQ9bKsNtE9wuzbzaPnHNnfgCU7csQtn27AF1tk618=;
        b=LNVvPO/IsIPOSNLAlGSj9hHqmf3I78cTeHuaOzOTVzMBI0Iqa/qBIMvJEnGRCTBRS4
         3vdfsf1LrlbaCIcVShhKuKX9K+Y01OHGUvEOkTsUMG6/y+x3Nd7WHo4fyrmXGOBEBP2U
         ioHcreFy4aflSl7nMZFtc4ZXY/B6BNoOT7qMMkjttUE+M4oaCQmMCqKYawyVZG+lgagP
         DxLfSK3NqE8YfxyW3/s6OxnmulAHhToBChW31LcYuGvM8OrpAGxngF2r+RzsEubUl5rW
         gONGoorsw02Vr5vtKJAowe+qFBu8I1da9Ugb5anQyLOgp0C9gwbt0oKUNQvXvH/1/uqY
         TS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=EoyQ9bKsNtE9wuzbzaPnHNnfgCU7csQtn27AF1tk618=;
        b=PF64VVA2Kba6snRpp5O6QgSm9TznPCC/vcxYcEEZQo8c7jJVKl/enkxaE0i3qGeack
         RLPL2BqYTAvgohxyjJjK2fcZZfkboKw5sNtq5iea82SJJUkMHf5ZSlRmvq/AuxoN44To
         vfFOVEnK8NBj9s2tVps8YkqQAffrCI0m05P4RgVEzocGJZdSyUXqR+F9dF2nDbUpt4NL
         qxSX/IfB/kZa0Eus95ER2Biygelxn7CmuWkt3ndrZmFaRLJ0fJsjK7G5d5+9gx4K60TU
         208rHsVHAEFQd1kJ89PcfSFmyjitGrDHU7n5kDolDXyo8HPSQZjSkX39N6z1Mm7zYxLo
         zv8A==
X-Gm-Message-State: AOAM530Pac3olssARu7hslTtszI6LPFIeFKM204f2VyCIy+V+Lyy5BW4
        wqMdHVlqzHm640mBaeYiD/SwCsxbrlCS3R1Smf8=
X-Google-Smtp-Source: ABdhPJz9cLNbjt7AxP5/5BYlzb19CZdQ06srzSawMGojOJsqBud6QaF2iXcVcRqZdEHUOpFkncfPH3jqfAQZuF057gw=
X-Received: by 2002:a02:cddd:0:b0:324:2a30:4e1e with SMTP id
 m29-20020a02cddd000000b003242a304e1emr1362536jap.126.1649351490109; Thu, 07
 Apr 2022 10:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <YktYX2OnLtyobRYD@kernel.org> <Ykto1FgmPMMCysbI@dev-arch.thelio-3990X>
 <CA+icZUVKgLLJvNF6ZU1e7Hjr_FsJO7x0gsGL6Jje1nv2ukhueA@mail.gmail.com>
 <Yk79WQQjvMyCddiO@dev-arch.thelio-3990X> <CA+icZUXwF+qs0KxSeD8AF7ufrT6PodQa0iVi1w=qvdT0WWhkrA@mail.gmail.com>
In-Reply-To: <CA+icZUXwF+qs0KxSeD8AF7ufrT6PodQa0iVi1w=qvdT0WWhkrA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 7 Apr 2022 19:10:50 +0200
Message-ID: <CA+icZUUdqQRU7XBjXnG5LHB-RrGMnknmsr-v4PhOLy4Jr2aDOA@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="000000000000ad956105dc1391d2"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000ad956105dc1391d2
Content-Type: text/plain; charset="UTF-8"

On Thu, Apr 7, 2022 at 6:25 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Thu, Apr 7, 2022 at 5:03 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Thu, Apr 07, 2022 at 12:27:14PM +0200, Sedat Dilek wrote:
> > > On Mon, Apr 4, 2022 at 11:53 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > > >
> > > > Hi Arnaldo,
> > > >
> > > > On Mon, Apr 04, 2022 at 05:43:11PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > Hi,
> > > > >
> > > > >       Trying to apply Sedat's patch something changed in my system,
> > > > > and that patch wasn't enough, so I had to first apply this one:
> > > > >
> > > > > commit 173b552663419f40bcd3cf9df4f68285cac72727
> > > > > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > > Date:   Mon Apr 4 17:28:48 2022 -0300
> > > > >
> > > > >     tools build: Use $(shell ) instead of `` to get embedded libperl's ccopts
> > > > >
> > > > >     Just like its done for ldopts and for both in tools/perf/Makefile.config.
> > > > >
> > > > >     Using `` to initialize PERL_EMBED_CCOPTS somehow precludes using:
> > > > >
> > > > >       $(filter-out SOMETHING_TO_FILTER,$(PERL_EMBED_CCOPTS))
> > > > >
> > > > >     And we need to do it to allow for building with versions of clang where
> > > > >     some gcc options selected by distros are not available.
> > > > >
> > > > >     Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > > >     Cc: Fangrui Song <maskray@google.com>
> > > > >     Cc: Florian Fainelli <f.fainelli@gmail.com>
> > > > >     Cc: Ian Rogers <irogers@google.com>
> > > > >     Cc: Jiri Olsa <jolsa@kernel.org>
> > > > >     Cc: John Keeping <john@metanate.com>
> > > > >     Cc: Leo Yan <leo.yan@linaro.org>
> > > > >     Cc: Michael Petlan <mpetlan@redhat.com>
> > > > >     Cc: Namhyung Kim <namhyung@kernel.org>
> > > > >     Cc: Nathan Chancellor <nathan@kernel.org>
> > > > >     Cc: Nick Desaulniers <ndesaulniers@google.com>
> > > > >     Cc: Sedat Dilek <sedat.dilek@gmail.com>
> > > > >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > >
> > > > > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> > > > > index 1480910c792e2cb3..90774b60d31b2b8e 100644
> > > > > --- a/tools/build/feature/Makefile
> > > > > +++ b/tools/build/feature/Makefile
> > > > > @@ -217,7 +217,7 @@ strip-libs = $(filter-out -l%,$(1))
> > > > >  PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
> > > > >  PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
> > > > >  PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
> > > > > -PERL_EMBED_CCOPTS = `perl -MExtUtils::Embed -e ccopts 2>/dev/null`
> > > > > +PERL_EMBED_CCOPTS = $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null)
> > > > >  FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
> > > > >
> > > > >  $(OUTPUT)test-libperl.bin:
> > > > >
> > > > > ----------------------------------------------------- 8< -------------------
> > > > >
> > > > > After this I go on filtering out some of the gcc options that clang
> > > > > doesn't grok:
> > > > >
> > > > > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> > > > > index 90774b60d31b2b8e..bbc5e263e02385ed 100644
> > > > > --- a/tools/build/feature/Makefile
> > > > > +++ b/tools/build/feature/Makefile
> > > > > @@ -215,9 +215,12 @@ grep-libs  = $(filter -l%,$(1))
> > > > >  strip-libs = $(filter-out -l%,$(1))
> > > > >
> > > > >  PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
> > > > > +PERL_EMBED_LDOPTS := $(filter-out -specs=%,$(PERL_EMBED_LDOPTS))
> > > > >  PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
> > > > >  PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
> > > > >  PERL_EMBED_CCOPTS = $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null)
> > > > > +PERL_EMBED_CCOPTS := $(filter-out -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
> > > > > +PERL_EMBED_CCOPTS := $(filter-out -specs=%,$(PERL_EMBED_CCOPTS))
> > > > >  FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
> > > > >
> > > > >  $(OUTPUT)test-libperl.bin:
> > > > >
> > > > > ----------------------------------------------------- 8< -------------------
> > > > >
> > > > > And then get to the problems at the end of this message, which seem
> > > > > similar to the problem described here:
> > > > >
> > > > > From  Nathan Chancellor <>
> > > > > Subject       [PATCH] mwifiex: Remove unnecessary braces from HostCmd_SET_SEQ_NO_BSS_INFO
> > > > >
> > > > > https://lkml.org/lkml/2020/9/1/135
> > > > >
> > > > > So perhaps in this case its better to disable that
> > > > > -Werror,-Wcompound-token-split-by-macro when building with clang?
> > > >
> > > > Yes, I think that is probably the best solution. As far as I can tell,
> > > > at least in this file and context, the warning appears harmless, as the
> > > > "create a GNU C statement expression from two different macros" is very
> > > > much intentional, based on the presence of PERL_USE_GCC_BRACE_GROUPS.
> > > > The warning is fixed in upstream Perl by just avoiding creating GNU C
> > > > statement expressions using STMT_START and STMT_END:
> > > >
> > > > https://github.com/Perl/perl5/issues/18780
> > > > https://github.com/Perl/perl5/pull/18984
> > > >
> > > > If I am reading the source code correctly, an alternative to disabling
> > > > the warning would be specifying -DPERL_GCC_BRACE_GROUPS_FORBIDDEN but it
> > > > seems like that might end up impacting more than just this site,
> > > > according to the issue discussion above.
> > > >
> > >
> > > Thanks for the pointer Nathan.
> > >
> > > As said I hit the problem with Debian's perl v5.34.
> > >
> > > Checking perl5 Git reveals:
> > >
> > > "skip using gcc brace groups for STMT_START/END"
> > > https://github.com/Perl/perl5/commit/7169efc77525df70484a824bff4ceebd1fafc760
> >
> > GitHub says this is in 5.35.2, so it would make sense that 5.34 still
> > shows the issue.
> >
> > > "Partially Revert "skip using gcc brace groups for STMT_START/END""
> > > https://github.com/Perl/perl5/commit/e08ee3cb66f362c4901846a46014cfdfcd60326c
> > >
> > > Perl v5.34.x seems not to have these changes:
> > > https://github.com/Perl/perl5/compare/v5.34.0...v5.34.1
> > >

To summarize the diff between those 2 changes is related to perl.h only.

# git diff /usr/lib/x86_64-linux-gnu/perl/5.34.0/CORE/perl.h.orig
/usr/lib/x86_64-linux-gnu/perl/5.34.0/CORE/perl.h
diff --git a/usr/lib/x86_64-linux-gnu/perl/5.34.0/CORE/perl.h.orig
b/usr/lib/x86_64-linux-gnu/perl/5.34.0/CORE/perl.h
index 17a21a1c4..bd575fe08 100644
--- a/usr/lib/x86_64-linux-gnu/perl/5.34.0/CORE/perl.h.orig
+++ b/usr/lib/x86_64-linux-gnu/perl/5.34.0/CORE/perl.h
@@ -733,13 +733,8 @@ Example usage:
 Trying to select a version that gives no warnings...
*/
#if !(defined(STMT_START) && defined(STMT_END))
-# ifdef PERL_USE_GCC_BRACE_GROUPS
-#   define STMT_START  (void)( /* gcc supports "({ STATEMENTS; })" */
-#   define STMT_END    )
-# else
#   define STMT_START  do
#   define STMT_END    while (0)
-# endif
#endif

#ifndef BYTEORDER  /* Should never happen -- byteorder is in config.h */

With this applied plus removing -Wno-compound-token-split-by-macro
from ACME's patchset ...

$ git log --oneline -2
bccc88d26f1f (HEAD -> 5.17.1-6-amd64-clang14-lto) tools build: Filter
out options and warnings not supported by clang
19b1b5c6614c tools build: Use $(shell ) instead of `` to get embedded
libperl's ccopts

$ git diff tools/
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index de66e1cc0734..7e3854a07643 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -224,7 +224,6 @@ ifeq ($(CC_NO_CLANG), 0)
  PERL_EMBED_LDOPTS := $(filter-out -specs=%,$(PERL_EMBED_LDOPTS))
  PERL_EMBED_CCOPTS := $(filter-out -flto=auto -ffat-lto-objects,
$(PERL_EMBED_CCOPTS))
  PERL_EMBED_CCOPTS := $(filter-out -specs=%,$(PERL_EMBED_CCOPTS))
-  FLAGS_PERL_EMBED += -Wno-compound-token-split-by-macro
endif

$(OUTPUT)test-libperl.bin:
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 312a7a5906ee..913bf509bd17 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -790,9 +790,6 @@ else
    LDFLAGS += $(PERL_EMBED_LDFLAGS)
    EXTLIBS += $(PERL_EMBED_LIBADD)
    CFLAGS += -DHAVE_LIBPERL_SUPPORT
-    ifeq ($(CC_NO_CLANG), 0)
-      CFLAGS += -Wno-compound-token-split-by-macro
-    endif
    $(call detected,CONFIG_LIBPERL)
  endif
endif

...I am able to build successfully with Debian's LLVM-14 and perl-5.34.

Both diffs are attached as Gmail might truncate the formatting.

Might be worth writing a Debian bug-report.

- Sedat -

--000000000000ad956105dc1391d2
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="debian-perl534-PERL_USE_GCC_BRACE_GROUPS.diff"
Content-Disposition: attachment; 
	filename="debian-perl534-PERL_USE_GCC_BRACE_GROUPS.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l1p9757e0>
X-Attachment-Id: f_l1p9757e0

ZGlmZiAtLWdpdCBhL3Vzci9saWIveDg2XzY0LWxpbnV4LWdudS9wZXJsLzUuMzQuMC9DT1JFL3Bl
cmwuaC5vcmlnIGIvdXNyL2xpYi94ODZfNjQtbGludXgtZ251L3BlcmwvNS4zNC4wL0NPUkUvcGVy
bC5oCmluZGV4IDE3YTIxYTFjNC4uYmQ1NzVmZTA4IDEwMDY0NAotLS0gYS91c3IvbGliL3g4Nl82
NC1saW51eC1nbnUvcGVybC81LjM0LjAvQ09SRS9wZXJsLmgub3JpZworKysgYi91c3IvbGliL3g4
Nl82NC1saW51eC1nbnUvcGVybC81LjM0LjAvQ09SRS9wZXJsLmgKQEAgLTczMywxMyArNzMzLDgg
QEAgRXhhbXBsZSB1c2FnZToKICBUcnlpbmcgdG8gc2VsZWN0IGEgdmVyc2lvbiB0aGF0IGdpdmVz
IG5vIHdhcm5pbmdzLi4uCiAqLwogI2lmICEoZGVmaW5lZChTVE1UX1NUQVJUKSAmJiBkZWZpbmVk
KFNUTVRfRU5EKSkKLSMgaWZkZWYgUEVSTF9VU0VfR0NDX0JSQUNFX0dST1VQUwotIyAgIGRlZmlu
ZSBTVE1UX1NUQVJUCSh2b2lkKSgJLyogZ2NjIHN1cHBvcnRzICIoeyBTVEFURU1FTlRTOyB9KSIg
Ki8KLSMgICBkZWZpbmUgU1RNVF9FTkQJKQotIyBlbHNlCiAjICAgZGVmaW5lIFNUTVRfU1RBUlQJ
ZG8KICMgICBkZWZpbmUgU1RNVF9FTkQJd2hpbGUgKDApCi0jIGVuZGlmCiAjZW5kaWYKIAogI2lm
bmRlZiBCWVRFT1JERVIgIC8qIFNob3VsZCBuZXZlciBoYXBwZW4gLS0gYnl0ZW9yZGVyIGlzIGlu
IGNvbmZpZy5oICovCg==
--000000000000ad956105dc1391d2
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="tools-perl534-Wno-compound-token-split-by-macro.diff"
Content-Disposition: attachment; 
	filename="tools-perl534-Wno-compound-token-split-by-macro.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l1p978u11>
X-Attachment-Id: f_l1p978u11

ZGlmZiAtLWdpdCBhL3Rvb2xzL2J1aWxkL2ZlYXR1cmUvTWFrZWZpbGUgYi90b29scy9idWlsZC9m
ZWF0dXJlL01ha2VmaWxlCmluZGV4IGRlNjZlMWNjMDczNC4uN2UzODU0YTA3NjQzIDEwMDY0NAot
LS0gYS90b29scy9idWlsZC9mZWF0dXJlL01ha2VmaWxlCisrKyBiL3Rvb2xzL2J1aWxkL2ZlYXR1
cmUvTWFrZWZpbGUKQEAgLTIyNCw3ICsyMjQsNiBAQCBpZmVxICgkKENDX05PX0NMQU5HKSwgMCkK
ICAgUEVSTF9FTUJFRF9MRE9QVFMgOj0gJChmaWx0ZXItb3V0IC1zcGVjcz0lLCQoUEVSTF9FTUJF
RF9MRE9QVFMpKQogICBQRVJMX0VNQkVEX0NDT1BUUyA6PSAkKGZpbHRlci1vdXQgLWZsdG89YXV0
byAtZmZhdC1sdG8tb2JqZWN0cywgJChQRVJMX0VNQkVEX0NDT1BUUykpCiAgIFBFUkxfRU1CRURf
Q0NPUFRTIDo9ICQoZmlsdGVyLW91dCAtc3BlY3M9JSwkKFBFUkxfRU1CRURfQ0NPUFRTKSkKLSAg
RkxBR1NfUEVSTF9FTUJFRCArPSAtV25vLWNvbXBvdW5kLXRva2VuLXNwbGl0LWJ5LW1hY3JvCiBl
bmRpZgogCiAkKE9VVFBVVCl0ZXN0LWxpYnBlcmwuYmluOgpkaWZmIC0tZ2l0IGEvdG9vbHMvcGVy
Zi9NYWtlZmlsZS5jb25maWcgYi90b29scy9wZXJmL01ha2VmaWxlLmNvbmZpZwppbmRleCAzMTJh
N2E1OTA2ZWUuLjkxM2JmNTA5YmQxNyAxMDA2NDQKLS0tIGEvdG9vbHMvcGVyZi9NYWtlZmlsZS5j
b25maWcKKysrIGIvdG9vbHMvcGVyZi9NYWtlZmlsZS5jb25maWcKQEAgLTc5MCw5ICs3OTAsNiBA
QCBlbHNlCiAgICAgTERGTEFHUyArPSAkKFBFUkxfRU1CRURfTERGTEFHUykKICAgICBFWFRMSUJT
ICs9ICQoUEVSTF9FTUJFRF9MSUJBREQpCiAgICAgQ0ZMQUdTICs9IC1ESEFWRV9MSUJQRVJMX1NV
UFBPUlQKLSAgICBpZmVxICgkKENDX05PX0NMQU5HKSwgMCkKLSAgICAgIENGTEFHUyArPSAtV25v
LWNvbXBvdW5kLXRva2VuLXNwbGl0LWJ5LW1hY3JvCi0gICAgZW5kaWYKICAgICAkKGNhbGwgZGV0
ZWN0ZWQsQ09ORklHX0xJQlBFUkwpCiAgIGVuZGlmCiBlbmRpZgo=
--000000000000ad956105dc1391d2--
