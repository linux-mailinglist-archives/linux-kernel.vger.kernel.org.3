Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3E14CA7C8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242834AbiCBOTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiCBOTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:19:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD7B3206A;
        Wed,  2 Mar 2022 06:18:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B61D61253;
        Wed,  2 Mar 2022 14:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6CCC36AE2;
        Wed,  2 Mar 2022 14:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646230709;
        bh=gxiP6v94MXu3RljGfCE7WLcIykK9JkMBERm4BwYuGSo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cJYa3a37PvqmYgw+/cPbLTkkyX2eOBa+4jzg8/hCRWrw/BzjqAhS8Dt61YvLcjfyk
         VzxEtz72ydafRpJ3C6dErndSHZpSfRyEtSdLqTimP/1bsEfpXpuTc7OxUKhCW4f6PB
         imUoW32AK12K/YIIvyhKIWbCcn6+AVZEqq0wCO5jFiM2jEQaz262AG5UVNPdMYJTVB
         /nigVZXj3TLUYVXa+h3+ADwwPce5pYYY4+vVPigxaf+HDo6YWFqilYymKRp2hqdTq2
         1G2H4OtqLcg2TLXxN9RIs6M5Nb3iNg9MHFkGkw5nXKf/TFztHKirfdYaVQ3+aNohEU
         cSFotPCuHAfuw==
Received: by mail-ed1-f42.google.com with SMTP id x5so2445201edd.11;
        Wed, 02 Mar 2022 06:18:29 -0800 (PST)
X-Gm-Message-State: AOAM531asbL3lIkLKdTQ8+fdVQsdF+A8osOc7KTupatycJyAULCqrHI0
        Sl8rbjtPw2aRw7DG8M/rrAX+ew9Ffot5Rno1Uw==
X-Google-Smtp-Source: ABdhPJxaHUApfDByMrpHno61mSAYEpUOyHQxBICf+S5gGxCXKyAPyKzrnwBQ4Ft+3F9gaSndH7kcBnkhpHeodrOzYfE=
X-Received: by 2002:aa7:ce08:0:b0:410:a996:d6a5 with SMTP id
 d8-20020aa7ce08000000b00410a996d6a5mr29367115edv.303.1646230707611; Wed, 02
 Mar 2022 06:18:27 -0800 (PST)
MIME-Version: 1.0
References: <20220301230629.1892828-1-ctshao@google.com>
In-Reply-To: <20220301230629.1892828-1-ctshao@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 2 Mar 2022 08:18:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK59GGhYQSEWvb=HtHTwMh=LXomu2zX4dEQeo4s3A0VtQ@mail.gmail.com>
Message-ID: <CAL_JsqK59GGhYQSEWvb=HtHTwMh=LXomu2zX4dEQeo4s3A0VtQ@mail.gmail.com>
Subject: Re: [PATCH] config: Using HOSTPKG_CONFIG prefix for pkg-config
To:     Chun-Tse Shao <ctshao@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 5:07 PM Chun-Tse Shao <ctshao@google.com> wrote:
>
> In some parts, pkg-config does not use appropriate $BUILDROOT prefix.

The kernel tree knows nothing about buildroot. Please reword this in a
more generic way that you need to override the host pkg-config.

> The patch adds HOSTPKG_CONFIG prefix for pkg-config to fix the issue.
>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  Makefile               | 3 ++-
>  scripts/Makefile       | 4 ++--
>  scripts/dtc/Makefile   | 6 +++---
>  tools/objtool/Makefile | 4 ++--
>  4 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index daeb5c88b50b..f6c5bef7e141 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -430,6 +430,7 @@ else
>  HOSTCC = gcc
>  HOSTCXX        = g++
>  endif
> +HOSTPKG_CONFIG = pkg-config
>
>  export KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
>                               -O2 -fomit-frame-pointer -std=gnu89
> @@ -525,7 +526,7 @@ KBUILD_LDFLAGS_MODULE :=
>  KBUILD_LDFLAGS :=
>  CLANG_FLAGS :=
>
> -export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE LD CC
> +export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE LD CC HOSTPKG_CONFIG
>  export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS LEX YACC AWK INSTALLKERNEL
>  export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
>  export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
> diff --git a/scripts/Makefile b/scripts/Makefile
> index ce5aa9030b74..f084f08ed176 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -14,8 +14,8 @@ hostprogs-always-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE)   += insert-sys-cert
>  HOSTCFLAGS_sorttable.o = -I$(srctree)/tools/include
>  HOSTLDLIBS_sorttable = -lpthread
>  HOSTCFLAGS_asn1_compiler.o = -I$(srctree)/include
> -HOSTCFLAGS_sign-file.o = $(shell pkg-config --cflags libcrypto 2> /dev/null)
> -HOSTLDLIBS_sign-file = $(shell pkg-config --libs libcrypto 2> /dev/null || echo -lcrypto)
> +HOSTCFLAGS_sign-file.o = $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2> /dev/null)
> +HOSTLDLIBS_sign-file = $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
>
>  ifdef CONFIG_UNWINDER_ORC
>  ifeq ($(ARCH),x86_64)
> diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
> index 95aaf7431bff..743fc08827ea 100644
> --- a/scripts/dtc/Makefile
> +++ b/scripts/dtc/Makefile
> @@ -18,7 +18,7 @@ fdtoverlay-objs       := $(libfdt) fdtoverlay.o util.o
>  # Source files need to get at the userspace version of libfdt_env.h to compile
>  HOST_EXTRACFLAGS += -I $(srctree)/$(src)/libfdt
>
> -ifeq ($(shell pkg-config --exists yaml-0.1 2>/dev/null && echo yes),)
> +ifeq ($(shell $(HOSTPKG_CONFIG) --exists yaml-0.1 2>/dev/null && echo yes),)
>  ifneq ($(CHECK_DT_BINDING)$(CHECK_DTBS),)
>  $(error dtc needs libyaml for DT schema validation support. \
>         Install the necessary libyaml development package.)
> @@ -27,9 +27,9 @@ HOST_EXTRACFLAGS += -DNO_YAML
>  else
>  dtc-objs       += yamltree.o
>  # To include <yaml.h> installed in a non-default path
> -HOSTCFLAGS_yamltree.o := $(shell pkg-config --cflags yaml-0.1)
> +HOSTCFLAGS_yamltree.o := $(shell $(HOSTPKG_CONFIG) --cflags yaml-0.1)
>  # To link libyaml installed in a non-default path
> -HOSTLDLIBS_dtc := $(shell pkg-config yaml-0.1 --libs)
> +HOSTLDLIBS_dtc := $(shell $(HOSTPKG_CONFIG) yaml-0.1 --libs)
>  endif
>
>  # Generated files need one more search path to include headers in source tree
> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> index 92ce4fce7bc7..549acc5859e9 100644
> --- a/tools/objtool/Makefile
> +++ b/tools/objtool/Makefile
> @@ -19,8 +19,8 @@ LIBSUBCMD             = $(LIBSUBCMD_OUTPUT)libsubcmd.a
>  OBJTOOL    := $(OUTPUT)objtool
>  OBJTOOL_IN := $(OBJTOOL)-in.o
>
> -LIBELF_FLAGS := $(shell pkg-config libelf --cflags 2>/dev/null)
> -LIBELF_LIBS  := $(shell pkg-config libelf --libs 2>/dev/null || echo -lelf)
> +LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
> +LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
>
>  all: $(OBJTOOL)
>
> --
> 2.35.1.574.g5d30c73bfb-goog
>
