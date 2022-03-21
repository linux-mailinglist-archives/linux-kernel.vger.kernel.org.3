Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B65A4E2172
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 08:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344977AbiCUHh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 03:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344958AbiCUHhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 03:37:22 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA2526102;
        Mon, 21 Mar 2022 00:35:57 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id l18so15803951ioj.2;
        Mon, 21 Mar 2022 00:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2C1RpUiaL1vxBujg7Ap4jwKIx1sYBZVVayjRXFtUjW8=;
        b=h0x23kDJVoNipENf2uxRroNJjO3bRCExeHMpIyb0k8GlXVUocGo1v7QRTy3S7wqKQe
         F14hgQzl3fhQgvpytDD7IVj0yYtQhfU3BD3nSPDawzJyvZ/0FLHbjnqzlQLYt5oGiZCV
         BKThdOte++FVPf8br9RtUBani1fyrWFYiAoIblQwkzVpMptFgRxFLr0ciWgKZvxPlw6T
         xxQ4dVFgCNQ0VUTKT2nowk/pWvs1OSCeYISudA0z+jdimAmDiXVrZMvO7DmrFUizERtw
         pByPvG2+KgSp+vGH/2iKWccO71+mFL8sq6b6JVH7GapqTpn3Z7T8CfvYrT1nwOd/DWZh
         n6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2C1RpUiaL1vxBujg7Ap4jwKIx1sYBZVVayjRXFtUjW8=;
        b=o6bbqC3DABcuvlgEEnJTevQG4Nzi4dq/rq9Q6hSGxgCBVWVGCn5KKg43sXuzxdKnY4
         6S06okTYA9/UeGJDCp1k4XIN416UyoFK3jePhguwbwjhVawTVZLCa/rPtKRq08t9doBs
         pKgvXLs+t979WAE3APj2NyyYTVUUS3MQtpdf8GvhhqeOfv5o6JBA+DeYhttHzGYPEg9X
         FFvrQGYUa1GlaDIZyKtpj2tQq32INyaWNOXzoOGrTmexAIwZUsrYMhVWbq4ImvVbrZPP
         Mii81w1l9i4+Xg2eFhRlu5R+oU/kDYue47TW71N9Q/L3R6A1EX3UxB/N/ZZZeE8VUUT0
         d5MA==
X-Gm-Message-State: AOAM5311wFoT2U+/SjzEZ0/S2RAACpokEcQRXYVOIq71ikU/9bOiV5MI
        DnlHs143OAbfu3LSUJs/lvdXhQWerOlrVH/2uNQ=
X-Google-Smtp-Source: ABdhPJyqls2NFpxeM30XnCiTx/a14dnQbjvulBh2ylQ4W+yALmNT8s1MyOmauqboODswFHXJyBr2/nja9BfbQjnkx5Y=
X-Received: by 2002:a05:6638:1495:b0:31d:f416:150 with SMTP id
 j21-20020a056638149500b0031df4160150mr5563972jak.68.1647848156450; Mon, 21
 Mar 2022 00:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220124121009.108649-1-alistair@alistair23.me>
 <20220124121009.108649-6-alistair@alistair23.me> <CAMuHMdUe-z-6_=W5AFtWMug-cqTZKJhd-iLbdoRnSKoXwm27Uw@mail.gmail.com>
In-Reply-To: <CAMuHMdUe-z-6_=W5AFtWMug-cqTZKJhd-iLbdoRnSKoXwm27Uw@mail.gmail.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Mon, 21 Mar 2022 17:34:00 +1000
Message-ID: <CAKmqyKNtE8=Jna78+L2a8BwsgM+LZVPi4ppg8Z0RGJ-21RqPtw@mail.gmail.com>
Subject: Re: [PATCH v18 5/8] hwmon: sy7636a: Add temperature driver for sy7636a
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-hwmon@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 9:21 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Alistair,
>
> On Mon, Jan 24, 2022 at 1:25 PM Alistair Francis <alistair@alistair23.me> wrote:
> > This is a multi-function device to interface with the sy7636a
> > EPD PMIC chip from Silergy.
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > Acked-by: Guenter Roeck <linux@roeck-us.net>
>
> Thanks for your patch, which is now commit de34a40532507814 ("hwmon:
> sy7636a: Add temperature driver for sy7636a") in mfd/for-mfd-next.
>
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1672,6 +1672,15 @@ config SENSORS_SIS5595
> >           This driver can also be built as a module. If so, the module
> >           will be called sis5595.
> >
> > +config SENSORS_SY7636A
> > +       tristate "Silergy SY7636A"
> > +       help
> > +         If you say yes here you get support for the thermistor readout of
> > +         the Silergy SY7636A PMIC.
>
> As this is an i2c mfd device, you do need a dependency on MFD and I2C,
> or some other symbol, unless compile-testing?

It doesn't depend on either to build though. It can be built independently.

Alistair

>
> > +
> > +         This driver can also be built as a module.  If so, the module
> > +         will be called sy7636a-hwmon.
> > +
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
