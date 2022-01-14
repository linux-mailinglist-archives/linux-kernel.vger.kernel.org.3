Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A9048ED1D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242177AbiANPZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:25:45 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40338
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243498AbiANPZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:25:32 -0500
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EFDA83F1E4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 15:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642173930;
        bh=1r53LGbRrCdIDFkdFatBJl+cYRNX8emZDBqZeKrVhA0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=WF6xMjWZ8ZBKCWeqPYriEsqqlXaD86sZgG2N67dKGDFAUgpOLSirTy0YOCFFbmsGZ
         Ym3Q5to0NGs+xPjASooHN3MYHYvtXa0TUJnigDJWd+4ckkLoeWupU0mPBWK7Q+hheD
         2s1EuGEdb5sl6DesBuhzRuqTy5xh3hJ3Q+Pk06PKk8Lt/BQrrOeqbtCZXm5n6bC13p
         3sqnkQowhifIsHslyWD88lOWScswL/QM9s56PRv58RGu+7zHYxcjaUv0j5QklluvqX
         YJeZMpNN5JW23A8PGNL4a+znkSfVE1qoOt1Fex5DxVyGa2NfW0e5jawDpIqwaTUBM8
         S6spDvXhC9rXw==
Received: by mail-oi1-f197.google.com with SMTP id v72-20020acaac4b000000b002c8dd559f44so6202412oie.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:25:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1r53LGbRrCdIDFkdFatBJl+cYRNX8emZDBqZeKrVhA0=;
        b=qQKrI3xAas0l9MR3N79sSPnYyBXT7yZV3r7RZiMlDHIgGiC85o84Lam66vwUZw2/r8
         xNPWgiSrVg7zPGA5ZayyYjYuztaPCh1tdBCrYEr0T84yi/rTVoiQXTNm1O0MFtrCwuj7
         ngS4Tnx467d7dCT58e8gmgM3h9aISF30Glj913+2HtGfxeYa4+AhOnz0tHbbSAyvmwc8
         x1oeUhBtiV3ZanSut3LZTC9+IPTjVCIhiLzZimru8Q/ZR4sa4LW91LcUiWD11DUOOpXD
         0zkRtHuIKUWIltH/3dMHURBeobT/x2aD6IzU/ZXbW7dGiPLEB90x/tM12MTXHP5OOIiw
         r7SA==
X-Gm-Message-State: AOAM533Sc0O4mah3ivtLziRc46AidHVZOsNMw5sEPLtZRGNGB+V4olSf
        raOdq58ffdaf21KT6LeQXOPpAfBbQmQCjX3SHhowm9AcJaMexyE2L1Nt2c5HCLErP6RU8vcD2D6
        iEOVUahOESjqvGazNmGcceXtWVeBsusRTdmhIZNi6tppA5hKQiJ3L7GpCww==
X-Received: by 2002:a05:6808:199a:: with SMTP id bj26mr13097381oib.98.1642173929766;
        Fri, 14 Jan 2022 07:25:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwjc8OhFrl0+4UKcBWR0AvxTCF+lZaB9wkXprPPao3yjX3bM54hzP09Hoph4ybKCG+Gsz+cmAnQZkDe5pkkoW8=
X-Received: by 2002:a05:6808:199a:: with SMTP id bj26mr13097353oib.98.1642173929496;
 Fri, 14 Jan 2022 07:25:29 -0800 (PST)
MIME-Version: 1.0
References: <20220114040755.1314349-1-kai.heng.feng@canonical.com>
 <20220114040755.1314349-2-kai.heng.feng@canonical.com> <YeF4kbsqag+kZ7ji@lunn.ch>
In-Reply-To: <YeF4kbsqag+kZ7ji@lunn.ch>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 14 Jan 2022 23:25:17 +0800
Message-ID: <CAAd53p4P9STxTUsZ2fXNqOnmwLMfOBXpYR5hvcJHk5-0V7MPgA@mail.gmail.com>
Subject: Re: [PATCH 2/2] stmmac: intel: Honor phy LED set by system firmware
 on a Dell hardware
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 9:20 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> >  static void marvell_config_led(struct phy_device *phydev)
> >  {
> > -     u16 def_config;
> > +     struct marvell_priv *priv = phydev->priv;
> >       int err;
> >
> > -     switch (MARVELL_PHY_FAMILY_ID(phydev->phy_id)) {
> > -     /* Default PHY LED config: LED[0] .. Link, LED[1] .. Activity */
> > -     case MARVELL_PHY_FAMILY_ID(MARVELL_PHY_ID_88E1121R):
> > -     case MARVELL_PHY_FAMILY_ID(MARVELL_PHY_ID_88E1318S):
> > -             def_config = MII_88E1121_PHY_LED_DEF;
> > -             break;
> > -     /* Default PHY LED config:
> > -      * LED[0] .. 1000Mbps Link
> > -      * LED[1] .. 100Mbps Link
> > -      * LED[2] .. Blink, Activity
> > -      */
> > -     case MARVELL_PHY_FAMILY_ID(MARVELL_PHY_ID_88E1510):
> > -             if (phydev->dev_flags & MARVELL_PHY_LED0_LINK_LED1_ACTIVE)
> > -                     def_config = MII_88E1510_PHY_LED0_LINK_LED1_ACTIVE;
> > -             else
> > -                     def_config = MII_88E1510_PHY_LED_DEF;
> > -             break;
> > -     default:
> > +     if (priv->led_def_config == -1)
> >               return;
> > +
> > +     if (priv->led_def_config)
> > +             goto write;
>
> Really?
>
> Please restructure this code. Take it apart into helpers. You need:
>
> A function to set the actual LED configuration.
> A function to decide what, if any, configuration to set
> A function to store the current configuration on suspend.
> A function to restore the current configuration on resume.
>
> Lots of little functions will make it much easier to understand, and
> avoid 1980s BASIC style.

Sure, will turn these into helper functions.

>
> I'm also surprised you need to deal with suspend/resume. Why does the
> BIOS not set the LED mode on resume, same as it does on power up?

I was told this is a BIOS limitation. I'll ask vendor _why_ the LED
can't be restored by BIOS.

Kai-Heng

>
>       Andrew
