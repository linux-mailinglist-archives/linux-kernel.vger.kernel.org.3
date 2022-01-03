Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CDB4831B7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 15:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbiACONT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 09:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiACONS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 09:13:18 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4D8C061761;
        Mon,  3 Jan 2022 06:13:17 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id o63so57962869uao.5;
        Mon, 03 Jan 2022 06:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iPVzylUVRpeAcfXNQppU6FqeZrAVxB1sR63Dt2iVLwU=;
        b=iUd6OgjQIQOJ+2STZhjzuYn99Wa6bykJ3/NRtPlLiiIdh8UkMnXIvX6mbzPrfX1x7o
         kSktM1Con9Ybym6MGjt8Rvr0iNeZoI1FeLvr8lYLXCU0Nmue/wqZlevwTq/H6Kw8ZsFW
         +V8lrWU2bcAbuaBRMMWMxhTYpRdHnO0IREJyDa+CP0QuYKTHgghvmNlEOS/qbxFv30Rq
         wz4//V8mlBkfFA2SnQgn61Usy9YtxJF16JWOmIJCWZc/Vw3c1oMT/hxsNr5tXXzhP2xV
         ZP7YXAf/DxJ+ZcJUzo4OkwkSdCABIYvb9HvKppySgy8XfGbUkqEKo/ZMbZ52I+/Xj7UY
         OhfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iPVzylUVRpeAcfXNQppU6FqeZrAVxB1sR63Dt2iVLwU=;
        b=I/J2iKV+NKF2R+NP7LX6R2R1HVZ32YS47I33eV5TjhCw0+SkpwQpmn/KN+PYtKwwMf
         K5e3Xdj84jgS6YaDQ4mrRJbRz3eIPRIkgcMiwrpHxscxTEAQX57HQud/x799O+znJR4K
         morw7yI4LLZXWU0u9yFGWGA1StZYeoFZoyk7j3IpZ/VQN0AGQ0P5mBu1nkkjIVtIxb+J
         Lpul4+HbPG576Jmf+rVXkpWVG3wDIx87vArtpCTVe9kI5lQHinzTYciXfAa1eESNNJhf
         45VsVhaFwzCnhbaRKSLBPog6neN2B5kpJE3xiLmHfoxiqNqqwNdhqW79RVAIPeBPl2IP
         QRjg==
X-Gm-Message-State: AOAM5339T2DAJkSknsmMOdLnidlvV75wYAXw1NtTpkeMW0FG0ibGU6gz
        iWyseVXFizZQYejP/z/cEHAOPLF/rv9hauw2Bxg=
X-Google-Smtp-Source: ABdhPJw6vTeLy4HHkOD0cRJ66G1hNoZL4n6P2HY1spPFAU24qh9JshJb35crTY48+wIUAzkztf1JWDIur+aALh9+ueY=
X-Received: by 2002:a05:6102:1613:: with SMTP id cu19mr13217645vsb.39.1641219196826;
 Mon, 03 Jan 2022 06:13:16 -0800 (PST)
MIME-Version: 1.0
References: <20211230044027.2739732-1-daniel@0x0f.com>
In-Reply-To: <20211230044027.2739732-1-daniel@0x0f.com>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Mon, 3 Jan 2022 15:13:05 +0100
Message-ID: <CABgxDoKMNcYzPH6mcO0yfJhpK2kRZR5BK=p5H1YvVqJGjbynDg@mail.gmail.com>
Subject: Re: [PATCH] rtc: msc313: Select by default on MSTARV7
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le jeu. 30 d=C3=A9c. 2021 =C3=A0 05:40, Daniel Palmer <daniel@0x0f.com> a =
=C3=A9crit :
>
> All of the ARCH_MSTARV7 chips have this RTC so it's more likey
> ARCH_MSTARV7 wants it than doesn't.
>
> At the same time fix up the indent on the depends on line that looks
> like it got converted from a tab to spaces at some point.
>
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  drivers/rtc/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 058e56a10ab8..9acd4ea267df 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1924,7 +1924,8 @@ config RTC_DRV_WILCO_EC
>
>  config RTC_DRV_MSC313
>         tristate "MStar MSC313 RTC"
> -        depends on ARCH_MSTARV7 || COMPILE_TEST
> +       depends on ARCH_MSTARV7 || COMPILE_TEST
> +       default ARCH_MSTARV7

You still depend on ARCH_MSTARV7 so "default y" is enough. It
will only work if the dependencies are satisfied and, when it is the
case, the value can be overridden by the user.

Cheers,
Romain
