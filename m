Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6C64695FD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243421AbhLFMzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbhLFMzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:55:47 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755B1C061746;
        Mon,  6 Dec 2021 04:52:18 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id z18so12721566iof.5;
        Mon, 06 Dec 2021 04:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kWJMdo59yTSqgJcYQGuTdjoYwCvGkhFPo9VMwlZW8Wc=;
        b=poA4Fh2eLuxpzHYdkWnPujX6m/BcXB3qWs3e/llhbBL1groISYuSuPm59BCl7UU7DG
         dBDenGke/eNaiyVOAG3VEeif1lnxPrdNoDt61HEjR8508yyw3GZCsmRYxI9c/gRWFZxm
         3FnirNabC4Lx/J8Gw33Y2T9trHssa80s4v0stAR1nGkDfOkQWaJeolnArKQkKJUd96jY
         CZ+uD0zOJpJILfdqHqcu9gzh9kPasSeKLC02KbgQ7Yh5pZLQ4dlTS217MKyKsmyVEbDL
         x5pc81JOSTVXItRYok887CdqvVUsOGOHOiUSdLzhD/4JldW00jLDWG26j3utAA5VFX2b
         vyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kWJMdo59yTSqgJcYQGuTdjoYwCvGkhFPo9VMwlZW8Wc=;
        b=I5vGZGgl+whNH91kR3kTQroK49tCgdawkklMC4yBBwWS4D+/qhZQ51bWCTjniFeMA6
         JCOR64XLYlEW3+XPXJxFBFMjbQEk+PEFLDxQWYwXNlBBzFzZ14rhus2jxH62PEh1NvoC
         qDzVidppx6FmA/4Z2ndKtv4f9YKrOr+qUh4OLDcCh9/Hse9PYswWqat/c/wceLWFqY0t
         aau/vn4OniwQXCBBcKaxIasUxsydhQkHJobALJheNbepAuKeiPOvXtkPUL/aK2Nc7Iec
         CV9KnyCgEwITCY2WuAPYgkGAR8WO6Z/98bARWv39NCi7xcHgaEoUsYoUIrAba+fFHfzS
         /XIA==
X-Gm-Message-State: AOAM531+vB5bY6XpdCYXaGnVpeeej/mFhBbPWWuGNPAbPSEH+jtQ9su6
        TAm64K0QDzKGPckqWHMaFR0Bws5ZYcyW6XyeTcg=
X-Google-Smtp-Source: ABdhPJwt3qZlkLSpxVG/nChwiA3yPio+t4NQvFW9uo5vaNbMypcBavzm9Rc8k9CZTHIPe0VQ8b3hrpeDhkr+ufQv6Sw=
X-Received: by 2002:a05:6602:1487:: with SMTP id a7mr32334878iow.57.1638795137663;
 Mon, 06 Dec 2021 04:52:17 -0800 (PST)
MIME-Version: 1.0
References: <20211202120758.41478-1-alistair@alistair23.me>
 <20211202120758.41478-9-alistair@alistair23.me> <20211205220744.18534b50@aktux>
In-Reply-To: <20211205220744.18534b50@aktux>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Mon, 6 Dec 2021 22:51:51 +1000
Message-ID: <CAKmqyKPCt0a5_6=Ezc87SK4jLWrh=-D1a2bXnyLjgd9OH3A-bg@mail.gmail.com>
Subject: Re: [PATCH v16 8/8] ARM: dts: imx7d: remarkable2: Enable lcdif
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Sascha Hauer <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-hwmon@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, rui.zhang@intel.com,
        dl-linux-imx <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>, amitk@kernel.org,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 7:07 AM Andreas Kemnade <andreas@kemnade.info> wrote:
>
> On Thu,  2 Dec 2021 22:07:58 +1000
> Alistair Francis <alistair@alistair23.me> wrote:
>
> > Connect the dispaly on the reMarkable2.
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > ---
> >  arch/arm/boot/dts/imx7d-remarkable2.dts | 73 +++++++++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
> > index b66d28b30d75..bb0c68d24583 100644
> > --- a/arch/arm/boot/dts/imx7d-remarkable2.dts
> > +++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
> [...]
>
> > @@ -187,6 +221,45 @@ MX7D_PAD_I2C4_SCL__I2C4_SCL              0x4000007f
> >               >;
> >       };
> >
> > +     pinctrl_lcdif: lcdifgrp {
> > +             fsl,pins = <
> > +                     MX7D_PAD_LCD_DATA00__LCD_DATA0          0x79
> > +                     MX7D_PAD_LCD_DATA01__LCD_DATA1          0x79
> > +                     MX7D_PAD_LCD_DATA02__LCD_DATA2          0x79
> > +                     MX7D_PAD_LCD_DATA03__LCD_DATA3          0x79
> > +                     MX7D_PAD_LCD_DATA04__LCD_DATA4          0x79
> > +                     MX7D_PAD_LCD_DATA05__LCD_DATA5          0x79
> > +                     MX7D_PAD_LCD_DATA06__LCD_DATA6          0x79
> > +                     MX7D_PAD_LCD_DATA07__LCD_DATA7          0x79
> > +                     MX7D_PAD_LCD_DATA08__LCD_DATA8          0x79
> > +                     MX7D_PAD_LCD_DATA09__LCD_DATA9          0x79
> > +                     MX7D_PAD_LCD_DATA10__LCD_DATA10         0x79
> > +                     MX7D_PAD_LCD_DATA11__LCD_DATA11         0x79
> > +                     MX7D_PAD_LCD_DATA12__LCD_DATA12         0x79
> > +                     MX7D_PAD_LCD_DATA13__LCD_DATA13         0x79
> > +                     MX7D_PAD_LCD_DATA14__LCD_DATA14         0x79
> > +                     MX7D_PAD_LCD_DATA15__LCD_DATA15         0x79
> > +
> > +                     MX7D_PAD_LCD_DATA17__LCD_DATA17         0x79
> > +                     MX7D_PAD_LCD_DATA18__LCD_DATA18         0x79
> > +                     MX7D_PAD_LCD_DATA19__LCD_DATA19         0x79
> > +                     MX7D_PAD_LCD_DATA20__LCD_DATA20         0x79
> > +                     MX7D_PAD_LCD_DATA21__LCD_DATA21         0x79
> > +
> > +                     MX7D_PAD_LCD_DATA23__LCD_DATA23         0x79
> > +                     MX7D_PAD_LCD_CLK__LCD_CLK               0x79
> > +                     MX7D_PAD_LCD_ENABLE__LCD_ENABLE         0x79
> > +                     MX7D_PAD_LCD_VSYNC__LCD_VSYNC           0x79
> > +                     MX7D_PAD_LCD_HSYNC__LCD_HSYNC           0x79
> > +                     MX7D_PAD_LCD_RESET__LCD_RESET           0x79
> > +             >;
> > +     };
>
> shouldn't this belong into the upper list:
> > +
> > +             fsl,pins = <
> > +                     MX7D_PAD_LCD_DATA22__GPIO3_IO27         0x74
> > +             >;
> > +     };
> > +
>
> probably some rebase or merge accident. If I submit non-trivial things,
> I usually apply my patches to a separate git tree and do a final
> compile, that might help to reduce some trouble.

Yeah, it was a rebase error. I split these patches out from my working tree.

Alistair

>
> Regards,
> Andreas
