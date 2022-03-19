Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7159B4DE539
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 03:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241833AbiCSCiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 22:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241825AbiCSCh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 22:37:57 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EBC2F09F7;
        Fri, 18 Mar 2022 19:36:37 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id z7so11325322iom.1;
        Fri, 18 Mar 2022 19:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hksZ8fkTnVC+iLKSKOlUhg9nGWitwWRHnaDyhB4h4Pg=;
        b=g66+r1BJWlshRZkKYwtPULVp3mQ1VwlYXQ4D9MJwGaHowURbHjq0dOMl69kYYb7lCT
         7lxkMLsvyPf7gZVXKQhzJwflM+msbLFO3H8C+l3Drq7CamkPmBT/eO/HaNjecx4HTKrn
         YDiQj0polI1MsNHTVDIFsm9EugzKsYbam7g/bSujZM54HUZnigSwxnAoe7SGWLiKE8pO
         HecqnwqyZXRqZqF9BwgWCQU/CPvphNYkMtmovMAyPgnu7JrVqoJ7ZyiA3dVcQ+zspWWc
         Et7NPRBGgdzmkPTJJS7h3iWgAo1kD3X35t/IdNsKdoWZFDyzK6TkF2VQKFiouK05/TTR
         2Bpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hksZ8fkTnVC+iLKSKOlUhg9nGWitwWRHnaDyhB4h4Pg=;
        b=CxWX9aoGSIOW+ybnetFwpwtFmF8wnZb+yrUvxmjW7ZX40M/onwPLGo/k94E04zlVMU
         aXab9QVw6zMXWfJZ/F2aLjrt25F1XvgjYe0NR4McjBdakR++EZ884mdtUJWapCmZCWLS
         s3hsdrlceIywZ9OPx0XZu8Bs2EXV6CeW1ZEZ42Y85ozVQwY9c0tQ0KkrloMzH8fubCiG
         xReQHgbjb1zMI/rICnOEaGj4UKr+OiXUqM+zExSKkGN8dT1GKUYY0meGeLtl5qHZnR6F
         4mTOGw+m8YehQjQpUW37huXC2YEm3+ysuVkyhxQJ+bf+3qkdcmKjZcWVRj8iQW1P6A9t
         3yJQ==
X-Gm-Message-State: AOAM532N/KA3KCwesQoD9EGGyaEvr9z1h0uRKDDZRs1AXJDqGBYp/GQ9
        jVflHTh78+S+hQty/TNbMU6Uqg3H7GktJBklvUU=
X-Google-Smtp-Source: ABdhPJxpIip6zDEZ8J1RXAr5LxvqrRgvizQzejGBwtvtghdpSilJKqPD5vWbehMXS8Dwwq0PlcpkiLZQNNRRU3MUyMY=
X-Received: by 2002:a6b:d60a:0:b0:63a:be64:c652 with SMTP id
 w10-20020a6bd60a000000b0063abe64c652mr5754958ioa.27.1647657397334; Fri, 18
 Mar 2022 19:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220124121009.108649-1-alistair@alistair23.me>
 <20220124121009.108649-3-alistair@alistair23.me> <CAMuHMdVNgVQzjrdybbnfCEr+G5Q4ztjRCC29RF9HwGnhKkPn3Q@mail.gmail.com>
In-Reply-To: <CAMuHMdVNgVQzjrdybbnfCEr+G5Q4ztjRCC29RF9HwGnhKkPn3Q@mail.gmail.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Sat, 19 Mar 2022 12:36:11 +1000
Message-ID: <CAKmqyKOnezw8_dDY-c69F77KVxmb-C3t=N3H23GurKbrxWDAgg@mail.gmail.com>
Subject: Re: [PATCH v18 2/8] mfd: simple-mfd-i2c: Add a Kconfig name
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
        Shawn Guo <shawnguo@kernel.org>
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

On Tue, Mar 8, 2022 at 8:53 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Alistair,
>
> Thanks for your patch, which is now commit bae5a4acef67db88
> ("mfd: simple-mfd-i2c: Add a Kconfig name") in mfd/for-mfd-next.
>
> On Mon, Jan 24, 2022 at 1:24 PM Alistair Francis <alistair@alistair23.me> wrote:
> > Add a Kconfig name to the "Simple Multi-Functional Device support (I2C)"
> > device so that it can be enabled via menuconfig.
>
> Which still does not explain why this would be needed...
>
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1188,7 +1188,7 @@ config MFD_SI476X_CORE
> >           module will be called si476x-core.
> >
> >  config MFD_SIMPLE_MFD_I2C
> > -       tristate
> > +       tristate "Simple Multi-Functional Device support (I2C)"
> >         depends on I2C
> >         select MFD_CORE
> >         select REGMAP_I2C
>
> The help text states:
>
> | This driver creates a single register map with the intention for it
> | to be shared by all sub-devices.
>
> Yes, that's what MFD does?
>
> | Once the register map has been successfully initialised, any
> | sub-devices represented by child nodes in Device Tree will be
> | subsequently registered.
>
> OK...?
>
> Still, no clue about what this driver really does, and why and when
> it would be needed.
>
> There is one driver symbol that selects MFD_SIMPLE_MFD_I2C.
> There are no driver symbols that depend on this symbol.
>
> If you have a driver in the pipeline that can make use of this,
> can't it just select MFD_SIMPLE_MFD_I2C, so the symbol itself can
> stay invisible?

My patch "mfd: simple-mfd-i2c: Enable support for the silergy,sy7636a"
allows using this driver for the silergy,sy7636a MFD. So it's nice to
be able to enable and disable it as required.

Alistair

>
> Thanks!
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
