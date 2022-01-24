Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220BE499721
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 22:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446845AbiAXVJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 16:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390642AbiAXUp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:45:59 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D671C061340
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:55:57 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id e17so338778ljk.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CsGwBiMEkwe4bLg19ywjdJZ3/5M1hRBHlVRcQEjbGmo=;
        b=rtbY+gqfHYd5dj6xP5LOP4QpTVnE0wZG3g8n7uzpDUJ4jVInle5CceB62w4oNxWy8u
         xXN8vN7IrBOKmQcgtvQFaTfgpVvlZ1C7rg8TWBiysAfRSiqHZV5kZTrpHFseJFjMV4Od
         +Jk5BAqTQjingEkJlsAfH3x7sfC03xhNfh0ADDu2Y2dMke7fwHzLmPKHUaTG7d2OKHNx
         fysiqoVSVENsXqjTFvu/VWsdgDVMLFS6QU1EAZh0HnTGPYzaozPOI7hgaS4vbnNHE24k
         ov5CQ5YvZP7tmNZBSSD6kToX7EO1i/6HTOWafDrGLNTOSJU6Ciew4FpN1aYt0fGglLwQ
         8/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CsGwBiMEkwe4bLg19ywjdJZ3/5M1hRBHlVRcQEjbGmo=;
        b=0iNCbLh1iZBgrpmCa/BfneWnmFginOLYGf2hJRxdY1SiRwvCaArA7vlxdw5K8GOyEW
         PSKxIaHNaxYYEl/TZyFbbXTcl5zthV/Btz3HdHSKz92lPomR5gUsXDHw/HmpsvOz4pQL
         c1nVcDK758rlgMWBdez2UmbD2QBoQNFLs7lTKxPy57Vsnt8zdcraiKkP3tSXK7ShZLbI
         V7zJr54YZMydCrKRrUVfICmg44Cda0H6scSsz1+uvGGMXhWEI/HlNXf67x/pPSEPEMXY
         JgvHriXZNGTxAIfFzdWaxWsGgXkvf+86H3Y0RDp9YKxpLwvMt3pFEY8WEtvRAfA5xlVE
         KLLg==
X-Gm-Message-State: AOAM531b1EAwTokuS3HhkjsORZaeNJAWrmDtExRr7iYQ2CKaRLhr928I
        BY/v3224VR40G3tF9rPoThwmfJY20nzKgpA1HPX02g==
X-Google-Smtp-Source: ABdhPJyOtLsKZqsENjScci++5Pp4Q0kOx1naLw57dM5+mMcu04T6dj7bnpqZLaem4TA31GMKPuqL3D7+h16zW5aDmyc=
X-Received: by 2002:a2e:8283:: with SMTP id y3mr12029632ljg.128.1643054155425;
 Mon, 24 Jan 2022 11:55:55 -0800 (PST)
MIME-Version: 1.0
References: <20220120053100.408816-1-masahiroy@kernel.org>
In-Reply-To: <20220120053100.408816-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Jan 2022 11:55:43 -0800
Message-ID: <CAKwvOd=52G2J2nXRbefjJ57B_ySZaZ6SD8UwwHziZMPoR6ABHQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "Makefile: Do not quote value for CONFIG_CC_IMPLICIT_FALLTHROUGH"
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>,
        carnil@debian.org, Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Salvatore, Kees, Gustavo, Nathan

On Wed, Jan 19, 2022 at 9:31 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> This reverts commit cd8c917a56f20f48748dd43d9ae3caff51d5b987.
>
> Commit 129ab0d2d9f3 ("kbuild: do not quote string values in
> include/config/auto.conf") provided the final solution.
>
> Now reverting the temporary workaround.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 3f07f0f04475..c94559a97dca 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -778,7 +778,7 @@ stackp-flags-$(CONFIG_STACKPROTECTOR_STRONG)      := -fstack-protector-strong
>  KBUILD_CFLAGS += $(stackp-flags-y)
>
>  KBUILD_CFLAGS-$(CONFIG_WERROR) += -Werror
> -KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH:"%"=%)
> +KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
>
>  ifdef CONFIG_CC_IS_CLANG
>  KBUILD_CPPFLAGS += -Qunused-arguments
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
