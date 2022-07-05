Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E329356760A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbiGERzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiGERzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:55:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D4E1B794;
        Tue,  5 Jul 2022 10:55:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0057E618E2;
        Tue,  5 Jul 2022 17:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15B1C341C7;
        Tue,  5 Jul 2022 17:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657043699;
        bh=ss/FWSfpRhPy761O/GOGlxFQc7q8ILJU6ePmGBd1zuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ajkxm9aFdQ+4eDM5fM2/xY0Lfllfb+NOSRNA+Fec2jr2dkPKpuTAewpiKAzK05+MS
         WJOdFB/mlYY2/yUgX6Z5FlscEyk3Vxn/u42630GotVSszHd7JrkudM53X/+ca1yI2r
         nqlAZRgTFTDXJ3XvdE9Lxzy0d9NoTF5ktZCAJqy3frtkQo1N2QQHaKnizuNtWOZ2rx
         dd6Fxqq1xygEPY0/CpdajqKBecBdd6mayrg/gQq3dxKA9lIQshGPbkQNUnBHA4sBcm
         wcPgb7z/s/imXIstgCtDino2OqK91FOGWtQdoMARcI+btTUbs/82e+eJcZ05LbVAFq
         D5rl4BuEO1HeA==
Date:   Tue, 5 Jul 2022 12:54:53 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add a general "kernel hardening" section
Message-ID: <YsR67UJTZvON/6LG@work>
References: <20220702004638.2486003-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220702004638.2486003-1-keescook@chromium.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 05:46:38PM -0700, Kees Cook wrote:
> While many large subsystems related to kernel hardening have their own
> distinct MAINTAINERS entries, there are some smaller collections that
> don't, but are maintained/reviewed by linux-hardening@vger.kernel.org.
> Add a section to capture these, add (or replace defunct) trees that are
> now all carried in the hardening tree.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  MAINTAINERS | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3cf9842d9233..2702b29e922f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4873,7 +4873,7 @@ R:	Nick Desaulniers <ndesaulniers@google.com>
>  L:	llvm@lists.linux.dev
>  S:	Supported
>  B:	https://github.com/ClangBuiltLinux/linux/issues
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/clang/features
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
>  F:	include/linux/cfi.h
>  F:	kernel/cfi.c
>  
> @@ -7783,6 +7783,7 @@ FORTIFY_SOURCE
>  M:	Kees Cook <keescook@chromium.org>
>  L:	linux-hardening@vger.kernel.org
>  S:	Supported
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
>  F:	include/linux/fortify-string.h
>  F:	lib/test_fortify/*
>  F:	scripts/test_fortify.sh
> @@ -8225,6 +8226,7 @@ GCC PLUGINS
>  M:	Kees Cook <keescook@chromium.org>
>  L:	linux-hardening@vger.kernel.org
>  S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
>  F:	Documentation/kbuild/gcc-plugins.rst
>  F:	scripts/Makefile.gcc-plugins
>  F:	scripts/gcc-plugins/
> @@ -10742,6 +10744,17 @@ F:	scripts/mk*
>  F:	scripts/mod/
>  F:	scripts/package/
>  
> +KERNEL HARDENING (not covered by other areas)
> +M:	Kees Cook <keescook@chromium.org>
> +L:	linux-hardening@vger.kernel.org
> +S:	Supported
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
> +F:	include/linux/overflow.h
> +F:	include/linux/randomize_kstack.h
> +F:	mm/usercopy.c
> +K:	\b(add|choose)_random_kstack_offset\b
> +K:	\b__check_(object_size|heap_object)\b
> +
>  KERNEL JANITORS
>  L:	kernel-janitors@vger.kernel.org
>  S:	Odd Fixes
> @@ -11542,7 +11555,7 @@ F:	drivers/media/usb/dvb-usb-v2/lmedm04*
>  LOADPIN SECURITY MODULE
>  M:	Kees Cook <keescook@chromium.org>
>  S:	Supported
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git lsm/loadpin
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
>  F:	Documentation/admin-guide/LSM/LoadPin.rst
>  F:	security/loadpin/
>  
> @@ -17857,7 +17870,7 @@ M:	Kees Cook <keescook@chromium.org>
>  R:	Andy Lutomirski <luto@amacapital.net>
>  R:	Will Drewry <wad@chromium.org>
>  S:	Supported
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git seccomp
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/seccomp
>  F:	Documentation/userspace-api/seccomp_filter.rst
>  F:	include/linux/seccomp.h
>  F:	include/uapi/linux/seccomp.h
> @@ -21993,7 +22006,7 @@ F:	include/linux/yam.h
>  YAMA SECURITY MODULE
>  M:	Kees Cook <keescook@chromium.org>
>  S:	Supported
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git yama/tip
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
>  F:	Documentation/admin-guide/LSM/Yama.rst
>  F:	security/yama/
>  
> -- 
> 2.32.0
> 
