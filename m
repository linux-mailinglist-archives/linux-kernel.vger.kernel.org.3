Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E628946A8B9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349799AbhLFUov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 15:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344890AbhLFUot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:44:49 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A195C0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 12:41:20 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id v15so23391452ljc.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 12:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s+1SOzLF6hX940st6pIflWSPzDUH6LhbOw9Hhv96ULM=;
        b=hQnPxfDy0PDXKUe4s8kf5keyrZhyvWaUf9afzpwNferW4ZVtoiOrtNbdRUaiXb9mgd
         UUSXJH7KnrLZXblK+LLlfQ/vIGoTVWC66wmsbM7qVnTMMEBl2y6L5EQXOoSnDu4xfpEg
         LCsyiiWz0gEV81smoKqwYc9v3c6tTAEV427UOzRdQ2FXDAxouNx6pUT0z2LbTd1Xq6Mc
         5WMw3S0h6I+kb7JX2LrEfu8ppGDCqrEJwdgbSNaOSPL9ADmEE4c2NHBRy/X/8NvwNpFd
         GWzxuIcq9bSjpP2E1q1LrzYcU1A0J3fD+htn0TkRZObYXnI14sZHXxL8/oEqH90pDzOc
         qELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s+1SOzLF6hX940st6pIflWSPzDUH6LhbOw9Hhv96ULM=;
        b=z4axR3wrRngefWLAvCOTSA8ihJVRcREdTE7UK8CTkHW+0+Gulx1gR5UzPhHN3gzmHP
         OC7J3+7U2x20i0pDC92KR0CCBk9dpFdfJk0DT+FQHj2KTEjppwy0necppBoF1EV7T13a
         lO+HAzK96PpXQlNWPtkQtYPizDmA7OM6fLBDomvoCqhlW7ipZWUlINBReV2i09yhYJlQ
         C0HdvNSsjsQ5JNAw6g4lQych6KKT/1YY7E5gBCej6YSoHjTiAcQfadlxISNfzIdftdCX
         tB8RKDo/UFyjxG852e4vSyr94iN2Gwbr/UAdnlxbifL++MdDePsNDzWJuk3Vs0B8BG0f
         ocHg==
X-Gm-Message-State: AOAM532ZswvEjI5GTY1EFVHZiS+ol6dwnWnNVYatPNh6LLK+9U8BHnmg
        JnYw9NjPSQUxzx5m+9ziRGPNNqmFOWjl+RR4adK6cA==
X-Google-Smtp-Source: ABdhPJwcMgr6ycxrrmvYtx619D2EaNcMB5rSBdYcFWG5nfoUcZKu5Ljx3kh8iGRfaICeQCUXCEk9zuKxoWnbgCWoyIs=
X-Received: by 2002:a05:651c:1b0:: with SMTP id c16mr36573404ljn.339.1638823278242;
 Mon, 06 Dec 2021 12:41:18 -0800 (PST)
MIME-Version: 1.0
References: <20211206023507.447574-1-masahiroy@kernel.org> <20211206023507.447574-2-masahiroy@kernel.org>
In-Reply-To: <20211206023507.447574-2-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 6 Dec 2021 12:41:06 -0800
Message-ID: <CAKwvOdkLNj0xw40rPWoB9Ko_8ZVEWAr3yRm=tz-0cvVOdk85-A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kbuild: remove headers_check stub
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 5, 2021 at 6:36 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Linux 5.15 is out. Remove this stub now.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> (no changes since v1)
>
>  Makefile | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 0a6ecc8bb2d2..8d58f65e226b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1284,15 +1284,6 @@ headers: $(version_h) scripts_unifdef uapi-asm-generic archheaders archscripts
>         $(Q)$(MAKE) $(hdr-inst)=include/uapi
>         $(Q)$(MAKE) $(hdr-inst)=arch/$(SRCARCH)/include/uapi
>
> -# Deprecated. It is no-op now.
> -PHONY += headers_check
> -headers_check:
> -       @echo >&2 "=================== WARNING ==================="
> -       @echo >&2 "Since Linux 5.5, 'make headers_check' is no-op,"
> -       @echo >&2 "and will be removed after Linux 5.15 release."
> -       @echo >&2 "Please remove headers_check from your scripts."
> -       @echo >&2 "==============================================="
> -
>  ifdef CONFIG_HEADERS_INSTALL
>  prepare: headers
>  endif
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
