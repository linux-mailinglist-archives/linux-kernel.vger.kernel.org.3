Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43F24CE73D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 22:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbiCEVkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 16:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiCEVk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 16:40:29 -0500
X-Greylist: delayed 538 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Mar 2022 13:39:31 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444863700A;
        Sat,  5 Mar 2022 13:39:31 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.99.106]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M4JeB-1nQKsf2rsf-000HIv; Sat, 05 Mar 2022 22:22:52 +0100
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id C33913C084; Sat,  5 Mar 2022 22:22:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1646515367; bh=VVb1CgKBX0kCKQXocnAMbSC/sePuvQMCodg6jDvav/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=plh6PCa2hEr74wCYxBGs1lg3LGj4FoG9+J0Jdv/wlFCXYl16MVkajCuOZ3x1NxSW2
         edNhy0O0afXoHtmEuy6vlPciZBmCWsn6pPiy2RXY3AbPVh9fvz8KTgXO3h8zJuHNvT
         uDbB4k9DWl8js9K3x/2+P7v16Z4SkFd0PwYNNBu8=
Date:   Sat, 5 Mar 2022 22:22:47 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Chun-Tse Shao <ctshao@google.com>
Cc:     rostedt@goodmis.org, ndesaulniers@google.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] config: Allow kernel installation packaging to
 override pkg-config
Message-ID: <YiPUp2KDmlnzv0MR@fjasle.eu>
References: <20220304041449.939308-1-ctshao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304041449.939308-1-ctshao@google.com>
X-Provags-ID: V03:K1:ZTPKmg5lMYxvmlGfvYK6oNxUamFwwjyCH+SpD50e8sJcs+Mvg7h
 oLInTiZ7wYdfo3gesvnSRum6rUHEtj0CwH1yfA6Fs7PB16yBMv8G5j2S7isHClQ5Mjj/L+h
 tqIzhHqWIDxNLYZXgDDiITfz03Zrtao7ND2a0hEXmjlkD3XZOXPG1wLM64TUCg0rxUj+BL3
 V7vweONIr2LYQKz4TlN7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YVzQ1H78vwQ=:XEbYARMzYw3Jem6ZchATg+
 v4nweGdCQqj4iriHkAP1QN1REQpNk76IO5BxebCSjf/KN4OFIDInGzJqDsNNrZCA7hPRnsIIZ
 CWbVdVTKFEokpSOX5L8uYX7FEmKQ5hT0xmFVi29j8SwHEXgptpCkRA58O1dvBU3j8vBopcrf4
 eOdHYXL5+vH4Fn/cHtBkTb883S9kdpeRKV4z9Cujhh6UCJMApuMR5VOzWHOSnC92qJAt8P53J
 fEVvIyA1NSHhzWe59Eh0YfKubjczvUPorzegukSic1OQP1POFj8eIXPBIDWEXmaQVf09d5Plr
 wC1W96LVoPOopk3GR8tYLeXj+yLiQcvREzfaq/kaLmQqLcO2gT/c6ukfDx1wGtCppwQRbJKZv
 LFduJgbzBP9g/V5JaS5tw8U2pZC292mWIMt2iiM3eufHgqDevpau7DWTOWTtqT/4N/d9S9gwt
 yrRO34gajtE6ypVmVieo4AuoVsr9V1YcB5osULKw81sim05O6f1rEmYbUd5ORMIXOM6R4klC2
 wBhgI+kAZTrK+ywtJGKu4g8yWeYDRJPuWhDyBe6mMSLwSSXCfI2KXSSZKi038VQloxzFpSuFa
 zSI2VToODjU31nwwu199ESnmHNbx/UYIP4o2bZ/mkW1008RQdwtVPfb+wYpPi5nQsxlQ52eOb
 v3t8yFTlUvrmLkVAv7lUTby9+nGLC3NMw+AEch5SiYlvyZE7RPRaww3H34lu9y6Ti0Yk=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 04:14:51AM +0000 Chun-Tse Shao wrote:
> [ Resending as a separate thread ]
> 
> Add HOSTPKG_CONFIG to allow tooling that builds the kernel to override
> what pkg-config and parameters are used.
> 
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---
> Changes from v2: https://lore.kernel.org/all/20220302193638.11034-1-ctshao@google.com/
>   - Fix more open coded instance of pkg-config in scripts and certs
>   - Tested with make allmodconfig
> 
> Changes from v1: https://lore.kernel.org/all/20220301230629.1892828-1-ctshao@google.com/
>   - Make the commit message more clearer.
> ---
> 
>  Makefile                     |  3 ++-
>  certs/Makefile               |  4 ++--
>  scripts/Makefile             |  4 ++--
>  scripts/dtc/Makefile         |  6 +++---
>  scripts/kconfig/gconf-cfg.sh | 10 +++++-----
>  scripts/kconfig/mconf-cfg.sh | 14 +++++++-------
>  scripts/kconfig/nconf-cfg.sh | 14 +++++++-------
>  scripts/kconfig/qconf-cfg.sh | 14 +++++++-------
>  tools/objtool/Makefile       |  4 ++--
>  9 files changed, 37 insertions(+), 36 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index daeb5c88b50b..f6c5bef7e141 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -430,6 +430,7 @@ else
>  HOSTCC	= gcc
>  HOSTCXX	= g++
>  endif
> +HOSTPKG_CONFIG	= pkg-config
> 
>  export KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
>  			      -O2 -fomit-frame-pointer -std=gnu89
> @@ -525,7 +526,7 @@ KBUILD_LDFLAGS_MODULE :=
>  KBUILD_LDFLAGS :=
>  CLANG_FLAGS :=
> 
> -export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE LD CC
> +export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE LD CC HOSTPKG_CONFIG
>  export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS LEX YACC AWK INSTALLKERNEL
>  export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
>  export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
> diff --git a/certs/Makefile b/certs/Makefile
> index 3ea7fe60823f..fa540d14ef2d 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -89,5 +89,5 @@ targets += x509_revocation_list
> 
>  hostprogs := extract-cert
> 
> -HOSTCFLAGS_extract-cert.o = $(shell pkg-config --cflags libcrypto 2> /dev/null)
> -HOSTLDLIBS_extract-cert = $(shell pkg-config --libs libcrypto 2> /dev/null || echo -lcrypto)
> +HOSTCFLAGS_extract-cert.o = $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2> /dev/null)
> +HOSTLDLIBS_extract-cert = $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
> diff --git a/scripts/Makefile b/scripts/Makefile
> index ce5aa9030b74..f084f08ed176 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -14,8 +14,8 @@ hostprogs-always-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE)	+= insert-sys-cert
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
> @@ -18,7 +18,7 @@ fdtoverlay-objs	:= $(libfdt) fdtoverlay.o util.o
>  # Source files need to get at the userspace version of libfdt_env.h to compile
>  HOST_EXTRACFLAGS += -I $(srctree)/$(src)/libfdt
> 
> -ifeq ($(shell pkg-config --exists yaml-0.1 2>/dev/null && echo yes),)
> +ifeq ($(shell $(HOSTPKG_CONFIG) --exists yaml-0.1 2>/dev/null && echo yes),)
>  ifneq ($(CHECK_DT_BINDING)$(CHECK_DTBS),)
>  $(error dtc needs libyaml for DT schema validation support. \
>  	Install the necessary libyaml development package.)
> @@ -27,9 +27,9 @@ HOST_EXTRACFLAGS += -DNO_YAML
>  else
>  dtc-objs	+= yamltree.o
>  # To include <yaml.h> installed in a non-default path
> -HOSTCFLAGS_yamltree.o := $(shell pkg-config --cflags yaml-0.1)
> +HOSTCFLAGS_yamltree.o := $(shell $(HOSTPKG_CONFIG) --cflags yaml-0.1)
>  # To link libyaml installed in a non-default path
> -HOSTLDLIBS_dtc	:= $(shell pkg-config yaml-0.1 --libs)
> +HOSTLDLIBS_dtc	:= $(shell $(HOSTPKG_CONFIG) yaml-0.1 --libs)
>  endif
> 
>  # Generated files need one more search path to include headers in source tree
> diff --git a/scripts/kconfig/gconf-cfg.sh b/scripts/kconfig/gconf-cfg.sh
> index 480ecd8b9f41..267ef6012203 100755
> --- a/scripts/kconfig/gconf-cfg.sh
> +++ b/scripts/kconfig/gconf-cfg.sh
> @@ -3,14 +3,14 @@
> 
>  PKG="gtk+-2.0 gmodule-2.0 libglade-2.0"
> 
> -if [ -z "$(command -v pkg-config)" ]; then
> +if [ -z "$(command -v $(HOSTPKG_CONFIG))" ]; then

Dereferencing variables in shell scripts has to be done by using "${var}" or
"$var".  "$(var)" starts a sub-shell and executes "var", which is not your
intention.  Thus, better try something like:

    if [ -z "$(command -v "${HOSTPKG_CONFIG}")" ]; then

(and all other shell script replacements in need to be revised, too.)

Kind regards,
Nicolas
