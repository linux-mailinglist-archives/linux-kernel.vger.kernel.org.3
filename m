Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C9549998E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 22:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1455718AbiAXVf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 16:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389762AbiAXUtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:49:04 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9A8C08C5C1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:58:05 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id c15so7747949ljf.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=ck5sHUPHFVmoqNszcJU+vx7vB03C0HSpAarVliSRSbI=;
        b=eKFPIcw00MO03/c1r2tB+56IRqcjqNpVqU3X8goqW6UDJPz1W4NM/3aJNan9Mtz0ih
         +eJEaDsaJoJUI+lKul7oYxUHMVrYJcrEgCcf3j332+rBrHZ+7I/0MCSiIZOLPrgFoUz2
         0EC/vNwFfhHeh2+EcFU1dgCdnm7JOEBrhxZ0vRtyCalk5vqSyReF3yWJDSE3GxdjZD8C
         e7/Hs1n6KEXSs4aSH4TtNMmlkesNzPr8bj++++MkzKx3q7xzifRbHy+YrKMxpyWSAo3g
         +n7mXddDW/w+eIF0twekEExNFcht79MIAUc6AKS7FPYIpdxsNfPaOqRPeSiAyTwTHGk8
         GBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=ck5sHUPHFVmoqNszcJU+vx7vB03C0HSpAarVliSRSbI=;
        b=H7vNncnQfN8fptb7Lbm77IcEHuxMJ5uzXiugPBo1MAdFD1d24DMfNRJyJNMIuV/OOu
         VSkOPrfH9eUgOq7zUd1deFvbvCI4rrlpmVHXytVSFFRnFSMpyxp1cooAILwwFkQEIg4v
         OXYWFvW60YMXb9BFzYXfERQdNDVbwHgHRWCqnLb615jIJJUg4AEPiUykF2sJIjVwOrfO
         ZY6mczCe0b93zTui4lLXTuLXuTGKT+yLXICiZvh9SEhhrFZ6TxfNVM+3niXqrO0TdeTX
         nejYthW4/4nDnzW9rTaMaQeI8ZEUNmVIzTxjQVlDLE8PqDxNmTZnjUc501gNST2g5yXK
         j9pg==
X-Gm-Message-State: AOAM532xs56QukuhnKZhNf8nhl4Kvp34gwtbUnuaqXCqjLVqbNoRmWOj
        s3O3npDhhS2IYOv9IuP1A2O71mL578mYFaUPwH4lFg==
X-Received: by 2002:a2e:9c03:: with SMTP id s3mt4465419lji.198.1643054283214;
 Mon, 24 Jan 2022 11:58:03 -0800 (PST)
MIME-Version: 1.0
References: <20220120054418.409817-1-masahiroy@kernel.org>
In-Reply-To: <20220120054418.409817-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Jan 2022 11:57:50 -0800
Message-ID: <CAKwvOdkoK8uZP_uutf68StKi3pZjC6_4DSstg=PFQ2onB5NrJQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: vdso: remove -nostdlib compiler flag
Cc:     patches@arm.linux.org.uk, Masahiro Yamada <masahiroy@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW, it looks like this has been submitted to RMK's queue:
https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9181/1


On Wed, Jan 19, 2022 at 9:44 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The -nostdlib option requests the compiler to not use the standard
> system startup files or libraries when linking. It is effective only
> when $(CC) is used as a linker driver.
>
> Since commit fe00e50b2db8 ("ARM: 8858/1: vdso: use $(LD) instead of
> $(CC) to link VDSO"), $(LD) is directly used, hence -nostdlib is
> unneeded.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>
> KernelVersion: 5.16
>
>  arch/arm/vdso/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
> index 7c9e395b77f7..ec52b776f926 100644
> --- a/arch/arm/vdso/Makefile
> +++ b/arch/arm/vdso/Makefile
> @@ -18,7 +18,7 @@ ccflags-y += -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO32
>
>  ldflags-$(CONFIG_CPU_ENDIAN_BE8) := --be8
>  ldflags-y := -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
> -           -z max-page-size=4096 -nostdlib -shared $(ldflags-y) \
> +           -z max-page-size=4096 -shared $(ldflags-y) \
>             --hash-style=sysv --build-id=sha1 \
>             -T
>
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
