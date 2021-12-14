Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B14474274
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbhLNMZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbhLNMZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:25:38 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022C8C06173F;
        Tue, 14 Dec 2021 04:25:38 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id f9so45750326ybq.10;
        Tue, 14 Dec 2021 04:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=70ZpaJ3uo3igzKMIt1y9JPalUaB8ti9cw7hSBNZ1J7U=;
        b=Gyzwa0v8wxz9jWlKX7+iVKGnsGbFmzgzc0C+17ffhE36858qFiNgKlXo/4adfIK81V
         UMBoTjjB6CnGp3Rb1okXF1SUxduz7ExssOKZd5lryE5RMNV5sGSEkiRU6HhNToPPjRwo
         MVcj/4e4x+3wLJwY4bkCFqdkQk/CJd+P0WGI/X5znVvkceKBu5QhxA9ufL4MeVSKDSWr
         eT85VzgnjuyHZaUNrtv4WcYFFuiHE2doclV3DM+OhJeuNr4RGrl6Z0f9KatLnQjaqF7T
         rDmX6irH803fnyGqz0AIfK6+xYaqHN2StQPsGZTHaCWJPgrfXRMu83esN4ETq5ZV2/Ku
         ZS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=70ZpaJ3uo3igzKMIt1y9JPalUaB8ti9cw7hSBNZ1J7U=;
        b=luUngNRO9uJtBB+mDir7FiuuRwb9x+4hZvVEYJaW2oYaR9q83jwQ8/UoB9HG0hx8oW
         aCIHB0bRwfnzltvoRD+R4U4wGPqVVYpbyI8YJfOZleVHOU2OszVzQzEoEyqNFQUtRAdZ
         AlX88FxCMZeBNgVTbQ4BEwSzUgvc9pOUsq/V2oLrM2clHhqnAuzv+k6D9QVkkFd+KbKt
         bcoygFFcwy1aBo0cXuYKImq5TBvEufeJjA94R+83Z1zBhiZ4Zhr2Uro9i4zKHdnWFQr9
         0yiAt13Htd1vhwLwMqhsaiojUmCG3Zz4XywYEZgGuVIsKGIgS7GGVSUByJIo6EHFDVFh
         4PqQ==
X-Gm-Message-State: AOAM533ZL5Db3v5s1G+6tURJJUCMX6MhhFiyrbvvpMjrPT+AzkRjwNES
        noOL18AUE4FGzGQvwId7N0LP200qgKG8W9pkhkA=
X-Google-Smtp-Source: ABdhPJz+4V+tcLba303QzieS/yi2HpD3kWyd6W3ZqI+OTfrwA3EfIuCCEhaE9jk3B3hQ+zZzBCRPYa6wpqKdPc2r730=
X-Received: by 2002:a25:cad5:: with SMTP id a204mr5608187ybg.234.1639484737157;
 Tue, 14 Dec 2021 04:25:37 -0800 (PST)
MIME-Version: 1.0
References: <20211213111642.11317-1-lukas.bulwahn@gmail.com>
 <20211213111642.11317-2-lukas.bulwahn@gmail.com> <cd01c62484faa9a5b364020c5c8985e3ea7fa643.camel@svanheule.net>
In-Reply-To: <cd01c62484faa9a5b364020c5c8985e3ea7fa643.camel@svanheule.net>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 14 Dec 2021 13:25:26 +0100
Message-ID: <CAKXUXMxQ_rCt0CQxKm7ym44vuMTT1cgnzSCdZZQN--DPwayG6Q@mail.gmail.com>
Subject: Re: [PATCH 1/9] mips: drop selecting the non-existing config SYS_HAS_EARLY_PRINTK_8250
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Bert Vermeulen <bert@biot.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 7:52 PM Sander Vanheule <sander@svanheule.net> wrote:
>
> Hi Lukas,
>
> Thanks for the patch!
>
> On Mon, 2021-12-13 at 12:16 +0100, Lukas Bulwahn wrote:
> > Commit 4042147a0cc6 ("MIPS: Add Realtek RTL838x/RTL839x support as generic
> > MIPS system") introduces config MACH_REALTEK_RTL, which selects the
> > non-existing config SYS_HAS_EARLY_PRINTK_8250.
> >
> > As the MACH_REALTEK_RTL config also selects SYS_HAS_EARLY_PRINTK and
> > USE_GENERIC_EARLY_PRINTK_8250, an early printk with 8250 should be covered.
> > Probably SYS_HAS_EARLY_PRINTK_8250 is just some left-over from an early
> > draft version of this commit.
> >
> > Drop selecting the non-existing config SYS_HAS_EARLY_PRINTK_8250.
> >
> > Fixes: 4042147a0cc6 ("MIPS: Add Realtek RTL838x/RTL839x support as generic MIPS system")
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> >  arch/mips/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index 00951bfdbab0..c89ce68d9580 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -640,7 +640,6 @@ config MACH_REALTEK_RTL
> >         select SYS_SUPPORTS_MULTITHREADING
> >         select SYS_SUPPORTS_VPE_LOADER
> >         select SYS_HAS_EARLY_PRINTK
> > -       select SYS_HAS_EARLY_PRINTK_8250
> >         select USE_GENERIC_EARLY_PRINTK_8250
> >         select BOOT_RAW
> >         select PINCTRL
>
> MACH_REALTEK_RTL doesn't actually call setup_8250_early_printk_port(). That means
> USE_GENERIC_EARLY_PRINTK_8250 is also not needed. Being MIPS_GENERIC, that additionaly
> means SYS_HAS_EARLY_PRINTK doesn't need to be selected.
>
> I only recently found the MIPS_GENERIC "early" console therefore doesn't actually work,
> but we use the "ns16550a" earlycon console instead. So feel free to also drop the other
> two other EARLY_PRINTK symbols, if you think this is in-scope for this patch. Otherwise I
> can submit a separate patch later.
>
> In any case:
> Acked-by: Sander Vanheule <sander@svanheule.net>
>

I am fine either way. Thomas, also feel free to just drop this patch
in the series and take the full clean-up patch from Sander.

Lukas
