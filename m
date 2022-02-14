Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4BF4B406C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 04:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240041AbiBNDkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 22:40:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiBNDkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 22:40:46 -0500
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248C655BCF;
        Sun, 13 Feb 2022 19:40:38 -0800 (PST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 21E3ePq2011948;
        Mon, 14 Feb 2022 12:40:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 21E3ePq2011948
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644810026;
        bh=likkbI32KUP4QKr0r0C6lCvDJ2nx7Oe2xwup8Xv5o/o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rslNdmgMye/1tg5az57WQ5ctlKiiDkzELPIEnO/+M12ZPeyjevucmbhyFEDduRJ1H
         Ktk8f6JsofqoKmKIsXLok7zNssA/QIh8bx5Wgrx2Pd2KzCuL9l7C7zOtJ9SQBoVDWE
         jjfysx9d1QR+iW4bOIu33nPgLglqXKnyl20teDV/j0wYjqfpw3VQF8pNHK2kQjp8zm
         6kqsVXGFF4Hf6+sDPwV7g7oDNuqCPgMTIJI3+HaAb7xrIbJtm/HnlO4PHG3Wq9Etm6
         tXUg+SXw5SE5Isj8fhWwU2u62QHRSt9D5WU8Az2xxYmWVUB0PbYtgnQRGeqSoxLJ0/
         PLyW6LPafE+KA==
X-Nifty-SrcIP: [209.85.214.182]
Received: by mail-pl1-f182.google.com with SMTP id i10so1891632plr.2;
        Sun, 13 Feb 2022 19:40:25 -0800 (PST)
X-Gm-Message-State: AOAM533hygyib1EzaS2G+B6SnTC+UT+pBFEl0jdIguN3f6hrrqZkfRAr
        dQPHsYMOp7rw8kiQlbr9ZxuSxZPocqCk5BJcndg=
X-Google-Smtp-Source: ABdhPJx53Gi2fLt9NRW0vkQD6LRMmwtESbaXgM2HiW93fwdUJpN6sF6HmoA3wFEbp0di11KLeuLbUa117M8PO47a7TM=
X-Received: by 2002:a17:90b:4f87:: with SMTP id qe7mr6208754pjb.77.1644810025067;
 Sun, 13 Feb 2022 19:40:25 -0800 (PST)
MIME-Version: 1.0
References: <20220214033724.2409951-1-masahiroy@kernel.org>
In-Reply-To: <20220214033724.2409951-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 14 Feb 2022 12:39:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQsgoBCmCOZ0ynjZc35XN4qr=NBhutC9RZbmD5srcvcAw@mail.gmail.com>
Message-ID: <CAK7LNAQsgoBCmCOZ0ynjZc35XN4qr=NBhutC9RZbmD5srcvcAw@mail.gmail.com>
Subject: Re: [PATCH] nds32: move core-y in arch/nds32/Makefile to arch/nds32/Kbuild
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greentime Hu <green.hu@gmail.com>,
        Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will apply this to linux-kbuild to avoid
the pain of Stephen Rothwell:

https://lore.kernel.org/lkml/20211025093813.2ebe9212@canb.auug.org.au/t/

The nds32 tree seems unmaintained.






On Mon, Feb 14, 2022 at 12:38 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Use obj-y to clean up Makefile.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/nds32/Kbuild   | 3 +++
>  arch/nds32/Makefile | 3 ---
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/nds32/Kbuild b/arch/nds32/Kbuild
> index 4e39f7abdeb6..ac127371afa4 100644
> --- a/arch/nds32/Kbuild
> +++ b/arch/nds32/Kbuild
> @@ -1,4 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +obj-y                  += kernel/ mm/
> +obj-$(CONFIG_FPU)      += math-emu/
> +obj-y                  += boot/dts/
>
>  # for cleaning
>  subdir- += boot
> diff --git a/arch/nds32/Makefile b/arch/nds32/Makefile
> index b33d5d81b6ae..7be31e3d7f2d 100644
> --- a/arch/nds32/Makefile
> +++ b/arch/nds32/Makefile
> @@ -27,8 +27,6 @@ export        TEXTADDR
>
>
>  # If we have a machine-specific directory, then include it in the build.
> -core-y                         += arch/nds32/kernel/ arch/nds32/mm/
> -core-$(CONFIG_FPU)              += arch/nds32/math-emu/
>  libs-y                         += arch/nds32/lib/
>
>  ifdef CONFIG_CPU_LITTLE_ENDIAN
> @@ -44,7 +42,6 @@ CHECKFLAGS      += -D__NDS32_EB__
>  endif
>
>  boot := arch/nds32/boot
> -core-y += $(boot)/dts/
>
>  Image: vmlinux
>         $(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
> --
> 2.32.0
>


-- 
Best Regards
Masahiro Yamada
