Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A2748ED17
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241969AbiANPXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:23:10 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40216
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229470AbiANPXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:23:08 -0500
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AC7C33F1C8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 15:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642173786;
        bh=Ia9jCR2j/rA1cIOYRQT6jRXDjntVCpr3+k1Bg19zGmo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=NGGEQPQ6DXcJv+0lF0fm9b6XPu/oIqpT5+UDOSbramjwxe3NOW7JkGSGbI//COBye
         IHCMEB43PMIS7vkxOVLiF2a1MyHzJ5qMf33VzIHsXNGLMHrXJVETj8Kp6G7AFOdCCT
         v/05dhuQgRhxAoLt+O2vb42GymvVY1+hG8cJzQ5uAucXaDWzY8ynsD7MHRQMK6Rfvc
         LaGyQDbCj64H0SW8m0fPlcpqn+Qre3xnoiVgdH85uXuREfGSgBFTFmxfavqitr1yWR
         HHt1pOATlmz7xDo6DIR91CRvczo2XLD6rRexdj4RoHGRYeSffu9JH9Sr8bz5auS9nw
         VR8zC13W8CSig==
Received: by mail-ot1-f71.google.com with SMTP id y11-20020a056830070b00b00595da7db813so132643ots.16
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 07:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ia9jCR2j/rA1cIOYRQT6jRXDjntVCpr3+k1Bg19zGmo=;
        b=wkOe3jX7+Gn21UXKS8bWWHHqULeS6WX4lN0DqD+OcuYk85sol4McL1bGdvCVip8YJc
         F3TNCX2VNmehB8hl2+D1g91oMvniJWqW6DX3J9UA/Ha1eWsOuXOeC/lHvTEMJcFVzhy/
         qMbVaQhGvWNHXZgs/2FcitlrBTVJ3yK8AzHJs5IcIKIhVayZlQQtXtrAg10Yc1rfDpNT
         POa45E9eajeejVqVAs4OOGxfYA+q5NlUvsLp/3nM/j4gCp3VaQ3qTwDu1khRUOxhYSSX
         wo0M61Db3369oMDedy8K8+WfyzYcQ73Czg8a3vcFW8hdiY0aIgsBTZC+EmtSjXz1xP/v
         q6ew==
X-Gm-Message-State: AOAM531h05kuRrKFpOlOaGjOhbl3UtPu3AzcZQ+1ylKu4wSrhq6bHbZz
        +itlKPwWBYKaZYsV6fOomEwc0Eawhbl+cCBuv1BlQ32WnwkPxirC0oXEz6oL+Z76GSasGbzbmyT
        ATzmF/Ps0K2hexl+pRcWK7OS18Dc/dYr05elrAq0Boa7sXqSB3oSJ/Ajy1g==
X-Received: by 2002:a9d:24e4:: with SMTP id z91mr7171437ota.11.1642173785392;
        Fri, 14 Jan 2022 07:23:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1rRcmwLgU1sdJqzQCBSfOAGlb01uPOBf0ZfAZY09v0WzUQ92iIkMR8shxtN95ewZDg/NvYsXU4kg6yfRt754=
X-Received: by 2002:a9d:24e4:: with SMTP id z91mr7171417ota.11.1642173785054;
 Fri, 14 Jan 2022 07:23:05 -0800 (PST)
MIME-Version: 1.0
References: <20220114040755.1314349-1-kai.heng.feng@canonical.com>
 <20220114040755.1314349-2-kai.heng.feng@canonical.com> <YeF18mxKuO4/4G0V@lunn.ch>
In-Reply-To: <YeF18mxKuO4/4G0V@lunn.ch>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 14 Jan 2022 23:22:53 +0800
Message-ID: <CAAd53p5R2y-2JhWx3wp2=aBypJO=iV7fFS99eAgk6q7KBZMFMA@mail.gmail.com>
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

On Fri, Jan 14, 2022 at 9:09 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Jan 14, 2022 at 12:07:54PM +0800, Kai-Heng Feng wrote:
> > BIOS on Dell Edge Gateway 3200 already makes its own phy LED setting, so
> > instead of setting another value, keep it untouched and restore the saved
> > value on system resume.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 16 +++++
> >  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 +
> >  .../net/ethernet/stmicro/stmmac/stmmac_main.c |  4 ++
> >  drivers/net/phy/marvell.c                     | 58 ++++++++++++-------
> >  include/linux/marvell_phy.h                   |  1 +
> >  5 files changed, 61 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> > index 8e8778cfbbadd..f8a2879e0264a 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> > @@ -857,6 +857,16 @@ static const struct dmi_system_id quark_pci_dmi[] = {
> >       {}
> >  };
> >
> > +static const struct dmi_system_id use_preset_led[] = {
> > +     {
> > +             .matches = {
> > +                     DMI_MATCH(DMI_SYS_VENDOR, "Dell EMC"),
> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "Edge Gateway 3200"),
> > +             },
> > +     },
> > +     {}
> > +};
>
> This is a PHY property. Why is the MAC involved?

This is inspired by commit a93f7fe13454 ("net: phy: marvell: add new
default led configure for m88e151x") which passes the flag from MAC to
PHY.

>
> Please also think about how to make this generic, so any ACPI based
> system can use it, with any PHY.

ACPI property won't work because it ties to ACPI platform device or
PCI device, so the property still needs to be passed from MAC to PHY.

So the only approach I can think of is to use DMI match directly in PHY driver.

Kai-Heng

>
>      Andrew
