Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287DF4F47FD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353488AbiDEVYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457458AbiDEQDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:15 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAA9B69
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:46:37 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id 14so9476338ily.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 08:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=F5MzDAphZgNmnpXLLJClAHN2Dlf9X0NXVb4HVYhNrEI=;
        b=bl/iYvAelqCJnr1Qul9X1kwBZTrZWpq99qIhwqI+p8qaQeG2+ykXwTxvEkf9T53yVs
         Pmp5MNDGIv3HK7GbnY/x6+Jkk39rwlf72TPmYbOGlWHMNd1cXDnLr5XlvGoNNdaSQUd+
         ulL52KHF+J9NMeH9Z9zwE0zLNAhZzhYwCe+W11HiJYZyrfaEvcBl3XsHiv5E8EXsu5Cl
         7RoXWIaKtbVyHyKbvyk75VSpWwkP4UCgI+sjDcWtyd/VTXhA5pOCnQCkRxQW0oK+CBk6
         0m6IWFU4awXSs07qtBFq9rhz9UUYG1uVL+LVo3OKY+MzGJXhp91pmelsSqBZpphUVmvz
         M4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=F5MzDAphZgNmnpXLLJClAHN2Dlf9X0NXVb4HVYhNrEI=;
        b=EDihyJjCKq1XmOKH+7em03j+6QjatRtbvDIGhbNp2m3864vBQR1zzNVdH+RXQohfwa
         6+ffeKqIfS3cu0wyw6OX2ItngLK6oPa6TlVS9v8xjW0M9lKT8zjkgL9ndfq898C5H3MA
         POp6PuI7CiqAnWy6/fzLNKV9JxoHTuuytXt6W7TnGRiB5eOplBai+voK46qO3bw0KdCB
         Pr2CNq3jmqiIpKOIrdCYrbwYGTEWrAM/1aefB9XC/8N4FdMCK883spVSaX0Zt6zT9Qtw
         eyeJT4uYdzRah2y0A8kPBUZyr9sX5vdYtpDkK3PwcsdTCbOcOqJV8kruMpDyHOR2Bfhl
         MxCg==
X-Gm-Message-State: AOAM531C8URnOi63w1ikrSihfBU0uU74ug6SxM0l67uuzYxlWUIEXucY
        8EgtSyoXTQp+67n7WSwbl9gV+Xnz2GLJEKaXMEM=
X-Google-Smtp-Source: ABdhPJyNtfAXy+1+WbuWNfOaUsGB0pAM7siD7giMfDTCswxKkTCFFgojacQ10Ncq3FVuhKFn9S0SVuuPLnYpYh+PZ2g=
X-Received: by 2002:a05:6e02:587:b0:2ca:4d86:cc47 with SMTP id
 c7-20020a056e02058700b002ca4d86cc47mr2049980ils.1.1649173596515; Tue, 05 Apr
 2022 08:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <YktYX2OnLtyobRYD@kernel.org> <Ykto1FgmPMMCysbI@dev-arch.thelio-3990X>
 <YkxWcYzph5pC1EK8@kernel.org>
In-Reply-To: <YkxWcYzph5pC1EK8@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 5 Apr 2022 17:46:00 +0200
Message-ID: <CA+icZUVMtrqRA-a3k8N0fVcszm=Sn2Jb9nMfF8mXqvSTu2HUhw@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="00000000000064ffe205dbea2686"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000064ffe205dbea2686
Content-Type: text/plain; charset="UTF-8"

?

On Tue, Apr 5, 2022 at 4:47 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Mon, Apr 04, 2022 at 02:53:24PM -0700, Nathan Chancellor escreveu:
> > On Mon, Apr 04, 2022 at 05:43:11PM -0300, Arnaldo Carvalho de Melo wrote:
> > >     Trying to apply Sedat's patch something changed in my system,
> > > and that patch wasn't enough, so I had to first apply this one:
>
> <SNIP>
>
> > > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> > > index 1480910c792e2cb3..90774b60d31b2b8e 100644
> > > --- a/tools/build/feature/Makefile
> > > +++ b/tools/build/feature/Makefile
> > > @@ -217,7 +217,7 @@ strip-libs = $(filter-out -l%,$(1))
> > >  PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
> > >  PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
> > >  PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
> > > -PERL_EMBED_CCOPTS = `perl -MExtUtils::Embed -e ccopts 2>/dev/null`
> > > +PERL_EMBED_CCOPTS = $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null)
> > >  FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
> > >
> > >  $(OUTPUT)test-libperl.bin:
> > >
> > > ----------------------------------------------------- 8< -------------------
>
> <SNIP>
>
> > > So perhaps in this case its better to disable that
> > > -Werror,-Wcompound-token-split-by-macro when building with clang?
>
> > Yes, I think that is probably the best solution. As far as I can tell,
> > at least in this file and context, the warning appears harmless, as the
> > "create a GNU C statement expression from two different macros" is very
> > much intentional, based on the presence of PERL_USE_GCC_BRACE_GROUPS.
> > The warning is fixed in upstream Perl by just avoiding creating GNU C
> > statement expressions using STMT_START and STMT_END:
>
> > https://github.com/Perl/perl5/issues/18780
> > https://github.com/Perl/perl5/pull/18984
> >
> > If I am reading the source code correctly, an alternative to disabling
> > the warning would be specifying -DPERL_GCC_BRACE_GROUPS_FORBIDDEN but it
> > seems like that might end up impacting more than just this site,
> > according to the issue discussion above.
>
> Ok, so I ended up with the patch below.
>
> On the 5.19 window I'll make the tools/perf/Makefile.config filters only
> apply when clang is used and unify these settings so that we have it
> setup just in one place, shared by the main build and the feature build.
>

Hi Arnaldo,

Cool, you stepped in.
Some comments below...

> - Arnaldo
>
> commit 5b5da660aa70e2a01748f602e9bbcd18b162a176
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Tue Apr 5 10:33:21 2022 -0300
>
>     tools build: Filter out options and warnings not supported by clang
>
>     These make the feature check fail when using clang, so remove them just
>     like is done in tools/perf/Makefile.config to build perf itself.
>
>     Adding -Wno-compound-token-split-by-macro to tools/perf/Makefile.config
>     when building with clang is also necessary to avoid these warnings
>     turned into errors (-Werror):
>
>         CC      /tmp/build/perf/util/scripting-engines/trace-event-perl.o
>       In file included from util/scripting-engines/trace-event-perl.c:35:
>       In file included from /usr/lib64/perl5/CORE/perl.h:4085:
>       In file included from /usr/lib64/perl5/CORE/hv.h:659:
>       In file included from /usr/lib64/perl5/CORE/hv_func.h:34:
>       In file included from /usr/lib64/perl5/CORE/sbox32_hash.h:4:
>       /usr/lib64/perl5/CORE/zaphod32_hash.h:150:5: error: '(' and '{' tokens introducing statement expression appear in different macro expansion contexts [-Werror,-Wcompound-token-split-by-macro]
>           ZAPHOD32_SCRAMBLE32(state[0],0x9fade23b);
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       /usr/lib64/perl5/CORE/zaphod32_hash.h:80:38: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
>       #define ZAPHOD32_SCRAMBLE32(v,prime) STMT_START {  \
>                                            ^~~~~~~~~~
>       /usr/lib64/perl5/CORE/perl.h:737:29: note: expanded from macro 'STMT_START'
>       #   define STMT_START   (void)( /* gcc supports "({ STATEMENTS; })" */
>                                     ^
>       /usr/lib64/perl5/CORE/zaphod32_hash.h:150:5: note: '{' token is here
>           ZAPHOD32_SCRAMBLE32(state[0],0x9fade23b);
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       /usr/lib64/perl5/CORE/zaphod32_hash.h:80:49: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
>       #define ZAPHOD32_SCRAMBLE32(v,prime) STMT_START {  \
>                                                       ^
>       /usr/lib64/perl5/CORE/zaphod32_hash.h:150:5: error: '}' and ')' tokens terminating statement expression appear in different macro expansion contexts [-Werror,-Wcompound-token-split-by-macro]
>           ZAPHOD32_SCRAMBLE32(state[0],0x9fade23b);
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       /usr/lib64/perl5/CORE/zaphod32_hash.h:87:41: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
>           v ^= (v>>23);                       \
>                                               ^
>       /usr/lib64/perl5/CORE/zaphod32_hash.h:150:5: note: ')' token is here
>           ZAPHOD32_SCRAMBLE32(state[0],0x9fade23b);
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       /usr/lib64/perl5/CORE/zaphod32_hash.h:88:3: note: expanded from macro 'ZAPHOD32_SCRAMBLE32'
>       } STMT_END
>         ^~~~~~~~
>       /usr/lib64/perl5/CORE/perl.h:738:21: note: expanded from macro 'STMT_END'
>       #   define STMT_END     )
>                               ^
>
>     Based-on-a-patch-by: Sedat Dilek <sedat.dilek@gmail.com>
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Fangrui Song <maskray@google.com>
>     Cc: Florian Fainelli <f.fainelli@gmail.com>
>     Cc: Ian Rogers <irogers@google.com>
>     Cc: Jiri Olsa <jolsa@kernel.org>
>     Cc: John Keeping <john@metanate.com>
>     Cc: Leo Yan <leo.yan@linaro.org>
>     Cc: Michael Petlan <mpetlan@redhat.com>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Nathan Chancellor <nathan@kernel.org>
>     Cc: Nick Desaulniers <ndesaulniers@google.com>
>     Link: http://lore.kernel.org/lkml/YktYX2OnLtyobRYD@kernel.org
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 90774b60d31b2b8e..de66e1cc073481c5 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -220,6 +220,13 @@ PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
>  PERL_EMBED_CCOPTS = $(shell perl -MExtUtils::Embed -e ccopts 2>/dev/null)
>  FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
>
> +ifeq ($(CC_NO_CLANG), 0)
> +  PERL_EMBED_LDOPTS := $(filter-out -specs=%,$(PERL_EMBED_LDOPTS))
> +  PERL_EMBED_CCOPTS := $(filter-out -flto=auto -ffat-lto-objects, $(PERL_EMBED_CCOPTS))

^^ This affects CONFIG_LTO_CLANG=y only, so check for it?

> +  PERL_EMBED_CCOPTS := $(filter-out -specs=%,$(PERL_EMBED_CCOPTS))
> +  FLAGS_PERL_EMBED += -Wno-compound-token-split-by-macro

^^ Maybe add a comment here or in the commit message that this occurs
with perl v5.34.
Together with the links Nathan pointing to the perl BTS?

> +endif
> +
>  $(OUTPUT)test-libperl.bin:
>         $(BUILD) $(FLAGS_PERL_EMBED)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 96ad944ca6a885cd..5b5ba475a5c00c0f 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -790,6 +790,9 @@ else
>      LDFLAGS += $(PERL_EMBED_LDFLAGS)
>      EXTLIBS += $(PERL_EMBED_LIBADD)
>      CFLAGS += -DHAVE_LIBPERL_SUPPORT
> +    ifeq ($(CC_NO_CLANG), 0)
> +      CFLAGS += -Wno-compound-token-split-by-macro
> +    endif
>      $(call detected,CONFIG_LIBPERL)
>    endif
>  endif

( I am here on Linux v5.17 + kbuild-gnu11-v5.18 and kbuild-v5.18 fixes. )
( My goal was to build perf with LLVM/Clang v13/v14 and -std=gnu11. )
( Debian/unstable switched to perl v5.34 in February. )
( That is the background I hit these issues. )

Link: https://marc.info/?t=164646683300002&r=1&w=2
Link: https://marc.info/?t=164689324800001&r=1&w=2

Unsure what your base is.

When I recall correctly we have CLANG_FLAGS exported in the top-level Makefile?
Oh no, now it is here.

$ git grep CLANG_FLAGS scripts/Makefile.clang
scripts/Makefile.clang:CLANG_FLAGS      += --target=$(CLANG_TARGET_FLAGS)
scripts/Makefile.clang:CLANG_FLAGS      += --target=$(notdir
$(CROSS_COMPILE:%-=%))
scripts/Makefile.clang:CLANG_FLAGS      += -fno-integrated-as
scripts/Makefile.clang:CLANG_FLAGS      +=
--prefix=$(GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_COMPILE))
scripts/Makefile.clang:CLANG_FLAGS      += -fintegrated-as
scripts/Makefile.clang:CLANG_FLAGS      += -Werror=unknown-warning-option
scripts/Makefile.clang:CLANG_FLAGS      += -Werror=ignored-optimization-argument
scripts/Makefile.clang:KBUILD_CFLAGS    += $(CLANG_FLAGS)
scripts/Makefile.clang:KBUILD_AFLAGS    += $(CLANG_FLAGS)
scripts/Makefile.clang:export CLANG_FLAGS

So, are all these CLANG_FLAGS "inherited" to tools/ build ECO systems?
I think no - it has its own rules :-(.

So, we should include scripts/Makefile.clang or enhance
tools/scripts/Makefile.include where LLVM/Clang stuff is defined (and
can be overridden).

Jiri pointed out he needed two options (when I recall correctly):

[1] -Wno-unused-command-line-argument

Example:
tools/testing/selftests/bpf/Makefile-# Silence some warnings when
compiled with clang
tools/testing/selftests/bpf/Makefile-ifneq ($(LLVM),)
tools/testing/selftests/bpf/Makefile:CFLAGS += -Wno-unused-command-line-argument
tools/testing/selftests/bpf/Makefile-endif

^^ Here you see it is checked for LLVM.
Again, put that stuff in one single place - tools/scripts/Makefile.include

[2] -Wno-ignored-optimization-argument

Both [1] and [2] were not needed in my case.

[1] is always good to have - not only for perf.

AFAICS, you wanted to consolidate PERL_EMBED_XXX and FLAGS_PERL_EMBED
at a single place.
1. tools/build/feature/Makefile
2. tools/perf/Makefile.config

Can not say where we all need perl check/requirement - maybe put that
stuff to the place where we define/check for toolchain/compiler (see
above)?

Again, all these issues happen because of -Werror is strictly set.

I put my patches around that area (see 2nd patch) - without checking
if the LLVM/Clang toolchain is used or not.
Both patches are attached.

$ git show -1 for-5.17/tools-feature_detect_libperl-clang-dileks-v3
commit 72ba634c9b39547197900d8b64ff36134af3ed08
(for-5.17/tools-feature_detect_libperl-clang-dileks-v3)
Author: Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun Mar 13 12:37:06 2022 +0100

   tools: feature-detect: libperl: Sync PERL_EMBED_CCOPTS with perf

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 1480910c792e..fa6be127f483 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -217,7 +217,8 @@ strip-libs = $(filter-out -l%,$(1))
PERL_EMBED_LDOPTS = $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/null)
PERL_EMBED_LDFLAGS = $(call strip-libs,$(PERL_EMBED_LDOPTS))
PERL_EMBED_LIBADD = $(call grep-libs,$(PERL_EMBED_LDOPTS))
-PERL_EMBED_CCOPTS = `perl -MExtUtils::Embed -e ccopts 2>/dev/null`
+PERL_EMBED_CCOPTS = $(perl -MExtUtils::Embed -e ccopts 2>/dev/null)
+PERL_EMBED_CCOPTS := $(filter-out -ffat-lto-objects, $(PERL_EMBED_CCOPTS))
FLAGS_PERL_EMBED=$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)

$(OUTPUT)test-libperl.bin:

$ git show -1 for-5.17/perf-libperl_support-clang-dileks
commit 316a1917ec05772ab0f99dad534fabdd74547865
(for-5.17/perf-libperl_support-clang-dileks)
Author: Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun Mar 6 11:29:50 2022 +0100

   perf: Fix libperl support with clang and perl v5.34

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
index 96ad944ca6a8..acc987daf56e 100644
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

With both patches I am able to build perf-5.17 with LLVM/Clang v14 and
-std=gnu11 and perl v5.34.

It's good when Jiri tests on his system.

I can test your patch with my next kernel-build, but can not promise.
Do you have it somewhere in a Git repo/branch or a (LORE) link for
easy application?
Did not check if b4 tool is able to extract it as patch out of your
original email.

- Sedat -

--00000000000064ffe205dbea2686
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-tools-feature-detect-libperl-Sync-PERL_EMBED_CCOPTS-.patch"
Content-Disposition: attachment; 
	filename="0001-tools-feature-detect-libperl-Sync-PERL_EMBED_CCOPTS-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l1mb1vc30>
X-Attachment-Id: f_l1mb1vc30

RnJvbSA3MmJhNjM0YzliMzk1NDcxOTc5MDBkOGI2NGZmMzYxMzRhZjNlZDA4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZWRhdCBEaWxlayA8c2VkYXQuZGlsZWtAZ21haWwuY29tPgpE
YXRlOiBTdW4sIDEzIE1hciAyMDIyIDEyOjM3OjA2ICswMTAwClN1YmplY3Q6IFtQQVRDSF0gdG9v
bHM6IGZlYXR1cmUtZGV0ZWN0OiBsaWJwZXJsOiBTeW5jIFBFUkxfRU1CRURfQ0NPUFRTIHdpdGgK
IHBlcmYKCi0tLQogdG9vbHMvYnVpbGQvZmVhdHVyZS9NYWtlZmlsZSB8IDMgKystCiAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdG9v
bHMvYnVpbGQvZmVhdHVyZS9NYWtlZmlsZSBiL3Rvb2xzL2J1aWxkL2ZlYXR1cmUvTWFrZWZpbGUK
aW5kZXggMTQ4MDkxMGM3OTJlLi5mYTZiZTEyN2Y0ODMgMTAwNjQ0Ci0tLSBhL3Rvb2xzL2J1aWxk
L2ZlYXR1cmUvTWFrZWZpbGUKKysrIGIvdG9vbHMvYnVpbGQvZmVhdHVyZS9NYWtlZmlsZQpAQCAt
MjE3LDcgKzIxNyw4IEBAIHN0cmlwLWxpYnMgPSAkKGZpbHRlci1vdXQgLWwlLCQoMSkpCiBQRVJM
X0VNQkVEX0xET1BUUyA9ICQoc2hlbGwgcGVybCAtTUV4dFV0aWxzOjpFbWJlZCAtZSBsZG9wdHMg
Mj4vZGV2L251bGwpCiBQRVJMX0VNQkVEX0xERkxBR1MgPSAkKGNhbGwgc3RyaXAtbGlicywkKFBF
UkxfRU1CRURfTERPUFRTKSkKIFBFUkxfRU1CRURfTElCQUREID0gJChjYWxsIGdyZXAtbGlicywk
KFBFUkxfRU1CRURfTERPUFRTKSkKLVBFUkxfRU1CRURfQ0NPUFRTID0gYHBlcmwgLU1FeHRVdGls
czo6RW1iZWQgLWUgY2NvcHRzIDI+L2Rldi9udWxsYAorUEVSTF9FTUJFRF9DQ09QVFMgPSAkKHBl
cmwgLU1FeHRVdGlsczo6RW1iZWQgLWUgY2NvcHRzIDI+L2Rldi9udWxsKQorUEVSTF9FTUJFRF9D
Q09QVFMgOj0gJChmaWx0ZXItb3V0IC1mZmF0LWx0by1vYmplY3RzLCAkKFBFUkxfRU1CRURfQ0NP
UFRTKSkKIEZMQUdTX1BFUkxfRU1CRUQ9JChQRVJMX0VNQkVEX0NDT1BUUykgJChQRVJMX0VNQkVE
X0xET1BUUykKIAogJChPVVRQVVQpdGVzdC1saWJwZXJsLmJpbjoKLS0gCjIuMzUuMQoK
--00000000000064ffe205dbea2686
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-perf-Fix-libperl-support-with-clang-and-perl-v5.34.patch"
Content-Disposition: attachment; 
	filename="0001-perf-Fix-libperl-support-with-clang-and-perl-v5.34.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l1mb2p3t1>
X-Attachment-Id: f_l1mb2p3t1

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
--00000000000064ffe205dbea2686--
