Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE80C49103C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242501AbiAQS0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242467AbiAQS0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:26:40 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6A9C061574;
        Mon, 17 Jan 2022 10:26:40 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id m6so48334641ybc.9;
        Mon, 17 Jan 2022 10:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+PTxiKHwnMOb/7S6kAcukGAROPuSn/r/3kxYgX3liRs=;
        b=hmK66Gtc7yK4wFScJdHC5uYWknCNMAsPkCus+7NJ86BN7qe3Br6hLLMXhDwdUXtCB1
         mwUeLiE9F+7FvIT6AuMOCfFBiWzWN/EC3KGC2Vgyy13jet+MwNyEkUeXHB7DRts00B/z
         Y389c1xGRueAPv5DN0Ur3BX4yvEWgotTV+sO6B2dds41COuBW9im0l/LUsXDc04Yewxw
         CeMuSVTdmqpF3/H5uza1lAEDaAJYc3q4KVtrKOVs4+jHZsm+9tNTdb+er519rX0uDDeN
         0NzO8gypPpH5oioRC/ZqKXg6gj9yYYTNbsGTWeWUTAxFwGleUGGvvUwiiFgY2As7dPzl
         SEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+PTxiKHwnMOb/7S6kAcukGAROPuSn/r/3kxYgX3liRs=;
        b=q91AJcqlL9rnWL7/3kcUZaBJBrm8StpOe6gamav5yqPX6IPMOt0acKPIEhX49wGAF0
         VacwzM+6feZHdULXgkfTGytYWz6c/W/wqjYw0b1OlPQPMiMvjmfvg+7dfwMDlAIgVIas
         bgEOvhntFXSAIpeUAOEDxzYBX3B9bWBVa5TOUnvogvs4wx08BSAGiys0SyUOz+1AR81B
         4g5ouzlQF0L7fFBJ1ME/OI967JHHO37nxtPUzvLCYt2JM7kZCgiuh0rOnQfsg8ft/oi0
         Hs+ggGW8a4NVMxwrE2LZN5ZKBOQiRJmUBra3pJMDZ4XbSd48hA5DKjNolfCCT0Wq0g5X
         2HzQ==
X-Gm-Message-State: AOAM5312UwAb/jibHul5+2bcK6lHfguKadRUAKZhDn1bsgYjAQAWR14Q
        iWjBB0cwC5BBB+tESFGwamh5yk17Ao3IkhSUldGzsCfENBo=
X-Google-Smtp-Source: ABdhPJwOMFuA6y+qeICHD6O3PywGzVyRRNiijiBg1vA1t/dhgYpQ5741rCdYeuHmg/lA3xeiaO2vfKNODALil5K3Cgs=
X-Received: by 2002:a25:6d06:: with SMTP id i6mr27850531ybc.216.1642443999684;
 Mon, 17 Jan 2022 10:26:39 -0800 (PST)
MIME-Version: 1.0
References: <20220116124911.65203-1-linux@fw-web.de> <20220116124911.65203-2-linux@fw-web.de>
 <8285bea7-559c-5834-78c7-5a062b7d8269@gmail.com> <trinity-5a2f356e-2777-4624-b921-f8f56ce282c7-1642420742957@3c-app-gmx-bap64>
In-Reply-To: <trinity-5a2f356e-2777-4624-b921-f8f56ce282c7-1642420742957@3c-app-gmx-bap64>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 17 Jan 2022 13:26:27 -0500
Message-ID: <CAMdYzYrNQCcOiLf=jUGtCTM44SU8bUpBBOac6_SGJtqX+hvUuA@mail.gmail.com>
Subject: Re: Re: [PATCH v1 1/3] dts64: rk3568: drop pclk_xpcs from gmac0
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Johan Jonker <jbx6244@gmail.com>,
        Frank Wunderlich <linux@fw-web.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 6:59 AM Frank Wunderlich
<frank-w@public-files.de> wrote:
>
> Hi
>
> > Gesendet: Montag, 17. Januar 2022 um 11:47 Uhr
> > Von: "Johan Jonker" <jbx6244@gmail.com>
> > Hi Frank,
> >
> > Despite that the DT is hosted in the kernel tree
> > DT and mainline kernel driver support are 2 separate things.
> > PCLK_XPCS might be in use elsewhere.
> >
> > Given the link below pclk_xpcs is only needed for rk3568.
> > Maybe gmac1 should have a PCLK_XPCS too, because one can select between
> > them.
> >
> > ethernet: stmicro: stmmac: Add SGMII/QSGMII support for RK3568
> > https://github.com/rockchip-linux/kernel/commit/1fc7cbfe9e227c700c692f1de3137914b3ea6ca6
> >
> > The original dtsi did have PCLK_XPCS in both nodes.
> > https://github.com/rockchip-linux/kernel/blob/develop-4.19/arch/arm64/boot/dts/rockchip/rk3568.dtsi#L2121
> > https://github.com/rockchip-linux/kernel/blob/develop-4.19/arch/arm64/boot/dts/rockchip/rk3568.dtsi#L1492
> >
> > Maybe fix the document or leave it as it is for now as long the driver
> > isn't updated and someone has tested it.
> > That's up to the DT maintainer.
> >
> > Johan
>
> as far as i understand, the PCLK_XPCS is part of the naneng combphy, which is not yet available in mainline.
> Naneng driver needs some changes and imho this should be part of it (including change documentation). That also makes it clear why this clock is added.
> But leaving an unused property with sideeffects is imho no good choice.
>
> So this was the easiest way to fix the dtbs_check. Else i got no usable result for it. Maybe adding it to Documentation is also easy, but have not yet looked into it as it currently unused from my POV.
>
> But i leave it as decision for Maintainer to drop this patch as it is not needed for my Board DTS.

As both the current submission of the combophy driver and the gmac
driver do not support xpcs, I elected to remove the clock vice adding
documentation for something which is not currently supported.
This is especially true as it only leaked through for the gmac0 port,
the gmac1 port is modeled to the current support level.

Once xpcs support is introduced, the clock can be added to the
documentation and both controllers as part of the same patch series.

Do you concur, Heiko?

>
> > ===
> >
> > XPCS is also part of PD_PIPE.
> > See Rockchip RK3568 TRM Part1 V1.0-20210111.pdf page 475.
> > Please advise if the power-domain@RK3568_PD_PIPE does need a PCLK_XPCS
> > fix or is PCLK_PIPE enough in combination with a PHY driver?
> >
> > PD_PIPE:
> >
> > BIU_PIPE
> > USB3OTG
> > PCIE20
> > PCIE30
> > SATA
> > XPCS
> >
> >
> >       power-domain@RK3568_PD_PIPE {
> >               reg = <RK3568_PD_PIPE>;
> >               clocks = <&cru PCLK_PIPE>;
> >               pm_qos = <&qos_pcie2x1>,
> >                        <&qos_pcie3x1>,
> >                        <&qos_pcie3x2>,
> >                        <&qos_sata0>,
> >                        <&qos_sata1>,
> >                        <&qos_sata2>,
> >                        <&qos_usb3_0>,
> >                        <&qos_usb3_1>;
> >               #power-domain-cells = <0>;
> >       };
>
> PD_PIPE is imho also part of Naneng. But more for usage as USB3/SATA/... phy. This is not part of Mainline too.
>
> But thanks for pointing.
>
> regards Frank
