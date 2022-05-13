Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EF9525C07
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377584AbiEMG6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377535AbiEMG57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:57:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9025A606CC;
        Thu, 12 May 2022 23:57:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14F4561E67;
        Fri, 13 May 2022 06:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740DEC34117;
        Fri, 13 May 2022 06:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652425076;
        bh=bwKLLYkMHR307DmldZhVcAwohNlVK35xlfmJdyEzUzE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EQkPOKS5dT+OPPkQCzVD/qRRo/zPU9MXcsSE5zyOZfrIAstbXeUo3tWKRXeDo6iur
         7Gfxy1j+1s+cU6bPKKtH54HkHBhY0P3cTjW36/P9cbjgqUUqP5J0M778UCjB8F5TaD
         oz69ycCiUCSACkiefS1lJe/JbqYe+T6Z8jWPzN/mYfUQJmFSbUGzxTWjPbZJPsTGek
         kelwzaLxAmF6NtyFpG6X+ZzjxkAa4foHHthQhDzMQUPug9TGIdsucqy/7uAXVdYOCU
         KwHIwJwdFJBtM0nthXUyVAgQ+7/3MKj18GeNFUa19KA2uBd3VL5pae3zoBAktKayI6
         Dj8SBN20yqQyA==
Received: by mail-vs1-f43.google.com with SMTP id y74so7482741vsy.7;
        Thu, 12 May 2022 23:57:56 -0700 (PDT)
X-Gm-Message-State: AOAM533a5w089zITgfQ+ljMJ/ZP+7rQb4oFdx7Y45UKt2aIBApWd/yZ+
        q4iHj8cG8VvpdGcE6+VRWDYxTj4el0p/P+3Mdx8=
X-Google-Smtp-Source: ABdhPJw3kQe5yqOihTdRUusUoGJTLVX/iPQ/GrFPrc38Koet00mVv/IXQZ16gw5KAflUROV8E8OuToLWUndXfeSRPxQ=
X-Received: by 2002:a67:af01:0:b0:32d:3d57:cff with SMTP id
 v1-20020a67af01000000b0032d3d570cffmr1872881vsl.8.1652425075448; Thu, 12 May
 2022 23:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220512035903.2779287-1-masahiroy@kernel.org> <20220512035903.2779287-3-masahiroy@kernel.org>
In-Reply-To: <20220512035903.2779287-3-masahiroy@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 13 May 2022 14:57:44 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTWo2XGsov7HLdjj60YrrSUCVJ3xzW5=g9Xyr7Q8Tsq4A@mail.gmail.com>
Message-ID: <CAJF2gTTWo2XGsov7HLdjj60YrrSUCVJ3xzW5=g9Xyr7Q8Tsq4A@mail.gmail.com>
Subject: Re: [PATCH 3/4] csky: introduce CONFIG_CSKY_ABI_V1/2
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 12:01 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> This is useful to clean up Makefile.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/csky/Kconfig  | 11 +++++++++++
>  arch/csky/Makefile | 14 ++++++++------
>  2 files changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 75ef86605d69..da756ecf0f85 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -161,6 +161,12 @@ config ARCH_MMAP_RND_BITS_MIN
>  config ARCH_MMAP_RND_BITS_MAX
>         default 17
>
> +config CSKY_ABI_V1
> +       bool
> +
> +config CSKY_ABI_V2
> +       bool
> +
>  menu "Processor type and features"
>
>  choice
> @@ -172,15 +178,18 @@ config CPU_CK610
>         select CPU_NEED_TLBSYNC
>         select CPU_NEED_SOFTALIGN
>         select CPU_NO_USER_BKPT
> +       select CSKY_ABI_V1
>
>  config CPU_CK810
>         bool "CSKY CPU ck810"
>         select CPU_HAS_HILO
>         select CPU_NEED_TLBSYNC
> +       select CSKY_ABI_V2
>
>  config CPU_CK807
>         bool "CSKY CPU ck807"
>         select CPU_HAS_HILO
> +       select CSKY_ABI_V2
>
>  config CPU_CK860
>         bool "CSKY CPU ck860"
> @@ -188,6 +197,8 @@ config CPU_CK860
>         select CPU_HAS_CACHEV2
>         select CPU_HAS_LDSTEX
>         select CPU_HAS_FPUV2
> +       select CSKY_ABI_V2
> +
>  endchoice
>
>  choice
> diff --git a/arch/csky/Makefile b/arch/csky/Makefile
> index 4d72aca4069b..2b30525f39e1 100644
> --- a/arch/csky/Makefile
> +++ b/arch/csky/Makefile
> @@ -16,34 +16,36 @@ endif
>
>  ifdef CONFIG_CPU_CK610
>  CPUTYPE        = ck610
> -CSKYABI        = abiv1
>  endif
>
>  ifdef CONFIG_CPU_CK810
>  CPUTYPE = ck810
> -CSKYABI        = abiv2
>  endif
>
>  ifdef CONFIG_CPU_CK807
>  CPUTYPE = ck807
> -CSKYABI        = abiv2
>  endif
>
>  ifdef CONFIG_CPU_CK860
>  CPUTYPE = ck860
> +endif
> +
> +ifdef CONFIG_CSKY_ABI_V1
> +CSKYABI        = abiv1
> +endif
> +
> +ifdef CONFIG_CSKY_ABI_V2
>  CSKYABI        = abiv2
We still need CSKYABI, so I don't think adding CONFIG_CSKY_ABI_V2 is
necessary. And ck807 & ck860 have different ABI.

>  endif
>
> -ifneq ($(CSKYABI),)
>  MCPU_STR = $(CPUTYPE)$(FPUEXT)$(VDSPEXT)$(TEEEXT)
>  KBUILD_CFLAGS += -mcpu=$(CPUTYPE) -Wa,-mcpu=$(MCPU_STR)
>  KBUILD_CFLAGS += -DCSKYCPU_DEF_NAME=\"$(MCPU_STR)\"
>  KBUILD_CFLAGS += -msoft-float -mdiv
>  KBUILD_CFLAGS += -fno-tree-vectorize
> -endif
>
>  KBUILD_CFLAGS += -pipe
> -ifeq ($(CSKYABI),abiv2)
> +ifdef CONFIG_CSKY_ABI_V2
>  KBUILD_CFLAGS += -mno-stack-size
>  endif
>
> --
> 2.32.0
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
