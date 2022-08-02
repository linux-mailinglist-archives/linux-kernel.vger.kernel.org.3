Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC95587C96
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 14:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbiHBMnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 08:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbiHBMna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:43:30 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A819E37FB9;
        Tue,  2 Aug 2022 05:43:29 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q7-20020a17090a7a8700b001f300db8677so15183687pjf.5;
        Tue, 02 Aug 2022 05:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=U9m3FQ39/4mYFptI4g6gXxTyAr9soFCJ8+yoeDOFuYE=;
        b=i2Q8AEq1KNHeon8oovOfgQZVLe3KS3nqoU7VPppGG0qPugDAUwSenRTDP59HL+JmAc
         POppR8p9f8SEZP/itNPUPvW1gb/7AyizvM7ycr9ukE6NXZRw3rMQJhd4097jNG8+gqFt
         VKbG6SlXdmjPVoTA8fTjPk33Bu7/gFAkhZuQ/bKzeiit7n1l5ctyO73Mwex4wjbZ5zOv
         d/McmwavwIO049aXxV7GBfF+3n0mzGNuKLulvO3JnoMoAeo359wjQhVlJMIv+ca3BdxM
         hf2/Jk8oqWOzrWRyHunRbSC48OQx3yCFOw0dJROA92vx4u4W8JQMBay5swmGhXRu3geT
         kaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=U9m3FQ39/4mYFptI4g6gXxTyAr9soFCJ8+yoeDOFuYE=;
        b=tK3sr2/gkovMAtaCj7BX55DZbakriam2nBbdCqbDlrMeN5hUYscooAEPO+XOhMa4Jd
         fSY5+EZhSIpBh5IAXJGsU1o85NNJ30qEDFKg9zFVTMXsCu/pgnjtqpWGW3M+vp6I8zpf
         xn0Z8se+pVTM9RO4/QpAJguGGXQu1smNHjyg3T4PFxdm5ZqJ4cRAUyufHxgfm2db3UGZ
         s8if+S+WsD6b8+L60O+wR2jQKE9OW4ccOL8WfcysHYUJOFjvbwvLddQbCl+QFY2Vu3CV
         TarXB5+fnR06Cw0Ob+RuD0YCzTNB6kNt8aVf77sXwe48siSxg0XoWjTQK+81ssqO9EHz
         c22Q==
X-Gm-Message-State: ACgBeo3/kZNt2sl0xwCdLVt31PzI7mHhK3dh4xyztxsPqV5XD2+aIroX
        YiBr4mOSePK0qh7Cg1MVAtk3c8sX6SMQGq32jQM=
X-Google-Smtp-Source: AA6agR43XCpLPTV1z8GO6mF5EYSfHI1FBFdyJ9uqiH9/FXtU0W+zqQqUBcZB+xxQvTIjrrBh2aUEIqE7in1fYQiNu9Q=
X-Received: by 2002:a17:902:d4c2:b0:16d:c317:ee9d with SMTP id
 o2-20020a170902d4c200b0016dc317ee9dmr19985383plg.25.1659444209092; Tue, 02
 Aug 2022 05:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220525115554.430971-1-alistair@alistair23.me>
 <20220525115554.430971-5-alistair@alistair23.me> <ea5e1659-5842-6685-52eb-f77ac4247a2d@sholland.org>
In-Reply-To: <ea5e1659-5842-6685-52eb-f77ac4247a2d@sholland.org>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Tue, 2 Aug 2022 22:43:02 +1000
Message-ID: <CAKmqyKPLanGCWkofWh7rEiAhpTFF865BGQNg1q-8avpObJ+J3A@mail.gmail.com>
Subject: Re: [PATCH v21 4/4] ARM: dts: imx7d-remarkable2: Enable lcdif
To:     Samuel Holland <samuel@sholland.org>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Amit Kucheria <amitk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-hwmon@vger.kernel.org, dl-linux-imx <linux-imx@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Zhang Rui <rui.zhang@intel.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2022 at 4:20 AM Samuel Holland <samuel@sholland.org> wrote:
>
> Hi Alistair,
>
> On 5/25/22 6:55 AM, Alistair Francis wrote:
> > Connect the dispaly on the reMarkable2.
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > ---
> >  arch/arm/boot/dts/imx7d-remarkable2.dts | 74 +++++++++++++++++++++++++
> >  1 file changed, 74 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
> > index 99ac0d242936..03a4029e1e57 100644
> > --- a/arch/arm/boot/dts/imx7d-remarkable2.dts
> > +++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
> > @@ -68,6 +68,16 @@ reg_digitizer: regulator-digitizer {
> >               startup-delay-us = <100000>; /* 100 ms */
> >       };
> >
> > +     reg_sdoe: regulator-sdoe {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "SDOE";
> > +             pinctrl-names = "default", "sleep";
> > +             pinctrl-0 = <&pinctrl_sdoe_reg>;
> > +             pinctrl-1 = <&pinctrl_sdoe_reg>;
> > +             gpio = <&gpio3 27 GPIO_ACTIVE_HIGH>;
> > +             enable-active-high;
> > +     };
> > +
> >       wifi_pwrseq: wifi_pwrseq {
> >               compatible = "mmc-pwrseq-simple";
> >               pinctrl-names = "default";
> > @@ -76,6 +86,16 @@ wifi_pwrseq: wifi_pwrseq {
> >               clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
> >               clock-names = "ext_clock";
> >       };
> > +
> > +     panel {
> > +             compatible = "eink,vb3300-kca";
> > +
> > +             port {
> > +                     panel_in: endpoint {
> > +                             remote-endpoint = <&display_out>;
> > +                     };
> > +             };
> > +     };
>
> From the discussion at [1], this is not safe to merge. It exposes an
> electrophoretic display to fbcon/userspace as if it was an LCD, which it very
> much is not. Trying to write RGB pixel data to the panel could damage it.

Hey Samuel,

From what I can tell it's difficult to damage the display, but I see your point.

>
> So at the very least before hooking this up, the LCD controller has to know that
> the EPD needs special handling and that it cannot accept RGB.

Looking at [1] it seems like no decision was made about how to handle
a case like this where the EPC driving is all done in software. We
currently drive it from userspace via proprietary software. It seems
unlikely we will be able to support this in the kernel, so it would be
nice to somehow expose it to userspace.

>
> That doesn't necessarily mean there is a problem with the content of this patch
> -- the special handling may all be taken care of based on the compatible string

Ah ok. So it sounds like adding a check to the LCD controller based on
compatible string to reject RGB values would be a good start here.
That would at least block bogus values from making it to the screen

Alistair

> -- but I think it's a really bad idea to merge this with how "eink,vb3300-kca"
> is currently represented in panel-simple.
>
> Regards,
> Samuel
>
> [1]: https://lore.kernel.org/lkml/Yo5kz%2F9cSd6ewC5f@phenom.ffwll.local/
>
> >  };
> >
> >  &clks {
> > @@ -132,6 +152,20 @@ reg_epdpmic: vcom {
> >       };
> >  };
> >
> > +&lcdif {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&pinctrl_lcdif>;
> > +     lcd-supply = <&reg_epdpmic>;
> > +     lcd2-supply = <&reg_sdoe>;
> > +     status = "okay";
> > +
> > +     port {
> > +             display_out: endpoint {
> > +                     remote-endpoint = <&panel_in>;
> > +             };
> > +     };
> > +};
> > +
> >  &snvs_pwrkey {
> >       status = "okay";
> >  };
> > @@ -246,6 +280,46 @@ MX7D_PAD_I2C4_SCL__I2C4_SCL              0x4000007f
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
> > +
> > +     pinctrl_sdoe_reg: sdoereggrp {
> > +             fsl,pins = <
> > +                     MX7D_PAD_LCD_DATA22__GPIO3_IO27         0x74
> > +             >;
> > +     };
> > +
> >       pinctrl_uart1: uart1grp {
> >               fsl,pins = <
> >                       MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX    0x79
> >
>
