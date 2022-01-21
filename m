Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6178749624D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 16:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381675AbiAUPrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 10:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381663AbiAUPrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 10:47:09 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80677C06173B;
        Fri, 21 Jan 2022 07:47:08 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id p15so1219185ejc.7;
        Fri, 21 Jan 2022 07:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YjNd4VNm1SPx8Z+h27IGCdy9svC5DPiUJ7qUImo53mo=;
        b=e4HqiZ5ByVsud4I88V8FUvgrUMg6DuPqHxGAP/vJfBdQPJ2iyJI7k0wZn4wM/nn0GW
         qtJZvJNOHleJh8g3MLlg/3cU3xi03F5wXr1DTHnLGfCa8mJIijbtX688qf6fkOlTzSjw
         L9i1A0RB4DW05VkZ3qhfJsYwY/rmPPXUMvTj9mgwyvWlYflZQE7e8HbCamphjywtg2cZ
         QAl1qY93EQL8dDHvTZSlijFT/U1TVYludrRq3dJWxSe7FYvDjCaCMC6HO0Rf6N5WacaQ
         3KrMQFaU2aa+rYHR7HJTbBWFT66kxK4WUN9SEnw3orRC0Rz6EfLo12dqCZjSBSLfie00
         23MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YjNd4VNm1SPx8Z+h27IGCdy9svC5DPiUJ7qUImo53mo=;
        b=GLIicvcJBgZQi7TCAex4+L4NJmya4HhYZwUp0iBAvNuwTHo/LbGT1HtdRyGu3o//On
         /Z1sbKbj5qT3GmUpxihuKOHawyloZnA9cAN8BdgzTbstulkKVL1ArkS2fFH/2J9gDZE5
         ggBwHmp3Uob4uSWOdiKSIhsSNGOxCH9SSFE67DyLT7vd9BpEQjVy4xQUp5QgZMhOWuZJ
         +POXD4WvZixM71qBq0lqIo3Bt8NrvKMoKE9fTVDLslUQfLZdg3mdCKQ24thLEjmulpSz
         SQ8D2b24wxXZnfBC44ur7Wb7OwqYmqy9Yl7mXCerI872LSKih2PIEC1+f0JtkgoSxoB5
         m5TQ==
X-Gm-Message-State: AOAM530ETXIQVl+PcfROrRS9xyP/glfKVst1UkaAiq6TnB9bkB2Qg68q
        trBerXr6DF5BArKCBuqxFwgdHzoF5vl0969COzTi0NvanBZy+g==
X-Google-Smtp-Source: ABdhPJwaCZoX/K0P1/+SF9ulza6rjB4riN5smisYZGOUfqEmsIzGZcgbxQ3yBLO9zEdLpeGkOQrpbunF6pvF52NvrC8=
X-Received: by 2002:a17:907:6e0b:: with SMTP id sd11mr3879296ejc.132.1642780026878;
 Fri, 21 Jan 2022 07:47:06 -0800 (PST)
MIME-Version: 1.0
References: <20220121140150.1729-1-fe@dev.tdt.de> <20220121140150.1729-2-fe@dev.tdt.de>
In-Reply-To: <20220121140150.1729-2-fe@dev.tdt.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 21 Jan 2022 17:46:30 +0200
Message-ID: <CAHp75Vd4pwFXoF=xS5cskM2GDNb6c6RXTYo3j3FLP+nuQVoRyg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] leds: ktd20xx: Extension of the KTD20xx family of
 LED drivers from Kinetic
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Eckert.Florian@googlemail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 4:01 PM Florian Eckert <fe@dev.tdt.de> wrote:
>
> Introducing the KTD2061/58/59/60 RGB LED drivers. The difference in
> these are the address numbers on the I2C bus that the device listens to.
>
> All KT20xx units can drive up to 12 LEDs.
>
> Due to the hardware limitation, we can only set 7 colors and the color
> black (LED off) for each LED independently and not the full RGB range.
> This is because the chip only has two color registers.
>
> To control the LEDs independently, the chip has to be configured in a
> special way.
>
> Color register 0 must be loaded with the current value 0mA, and color
> register 1 must be loaded with the value 'kinetic,led-current' from the
> device tree node. If the property is omitted, the register is loaded
> with the default value (0x28 = 5mA).
>
> To select a color for an LED, a combination must be written to the color
> selection register of that LED. This range for selecting the value is 3
> bits wide (RGB). A '0' in any of the bits uses color register '0' and a
> '1' uses color register '1'.
>
> So we could choose the following combination for each LED:
> R G B
> 0 0 0 = Black (off)
> 0 0 1 = Blue
> 0 1 0 = green
> 0 1 1 = Cyan
> 1 0 0 = Red
> 1 0 1 = Magenta
> 1 1 0 = Yellow
> 1 1 1 = White

...

> +/*
> + *  LEDs driver for the Kinetic KDT20xx device
> + *
> + *  Copyright (C) 2021 TDT AG Florian Eckert <fe@dev.tdt.de>

> + *

Redundant (blank) line.

> + */

...

> +static const struct reg_default ktd20xx_reg_defs[] = {
> +       /* Color0 Configuration Registers */
> +       {KTD20XX_IRED0, 0x28},
> +       {KTD20XX_IGRN0, 0x28},
> +       {KTD20XX_IBLU0, 0x28},
> +       /* Color1 Configuration Registers */
> +       {KTD20XX_IRED1, 0x60},
> +       {KTD20XX_IGRN1, 0x60},
> +       {KTD20XX_IBLU1, 0x60},
> +       /* Selection Configuration Register */
> +       {KTD20XX_ISELA12, 0x00},
> +       {KTD20XX_ISELA34, 0x00},
> +       {KTD20XX_ISELB12, 0x00},
> +       {KTD20XX_ISELB34, 0x00},
> +       {KTD20XX_ISELC12, 0x00},

> +       {KTD20XX_ISELC34, 0x00}

+ Comma?

> +};

...

> +       struct device *dev = &chip->client->dev;
> +       int ret;
> +       unsigned int value;

Here and everywhere can you use reverse xmas tree ordering?

       struct device *dev = &chip->client->dev;
       unsigned int value;
       int ret;

...

> +       /*
> +        * If the device tree property 'kinetc,led-current' is found
> +        * then set this value into the color0 register as the max current
> +        * for all color channel LEDs. If this poperty is not set then

property

> +        * use the default value 0x28 set by the chip after a hardware reset.
> +        * The hardware default value 0x28 corresponds to 5mA.
> +        */

...


> +                       set_bit(channel, &rgb);

__set_bit() will be sufficient here (no need an atomic version)

...

> +       /*
> +        * To use the color0 registers default value after an hadware reset,

hardware

> +        * if the device tree property 'kinetc,led-current' is not set,
> +        * we have to 'invert' the rgb channel!
> +        */

...

> +unlock_out:

out_unlock is more usual, but it's up to you.


...

> +       chip->regmap = devm_regmap_init_i2c(client, &ktd20xx_regmap_config);
> +       if (IS_ERR(chip->regmap)) {

> +               dev_err_probe(dev, PTR_ERR(chip->regmap),
> +                       "Failed to allocate register map\n");
> +               goto error;

return dev_err_probe(...);

> +       }

...

> +       ret = regmap_field_read(chip->vendor, &vendor);
> +       if (ret) {

> +               dev_err_probe(dev, ret, "Failed to read vendor\n");
> +               goto error;

Ditto.

> +       }
> +
> +       ret = regmap_field_read(chip->chip_id, &chip_id);
> +       if (ret) {

> +               dev_err_probe(dev, ret, "Failed to read chip id\n");
> +               goto error;

Ditto,

> +       }
> +
> +       ret = regmap_field_read(chip->chip_rev, &chip_rev);
> +       if (ret) {
> +               dev_err_probe(dev, ret, "Failed to read chip rev\n");
> +               goto error;

Ditto.

> +       }

...

> +       dev_info(dev, "vendor: 0x%02x chip-id: 0x%02x chip-rev: 0x%02x\n",
> +                       vendor, chip_id, chip_rev);

Why on the info level?

...

> +       ret = ktd20xx_probe_dt(chip);
> +       if (ret)

return ret;

> +               goto error;
> +
> +       ret = ktd20xx_hwinit(chip);
> +       if (ret)
> +               goto error;

Ditto.

...

> +error:
> +       return ret;

Unneeded label, see above.

...

> +static struct i2c_driver ktd20xx_driver = {
> +       .driver = {
> +               .name = "ktd20xx",
> +               .dev_groups = ktd20xx_led_controller_groups,
> +               .of_match_table = of_ktd20xx_leds_match,
> +       },

> +       .probe = ktd20xx_probe,

Why not .probe_new?

> +       .remove = ktd20xx_remove,

> +       .id_table = ktd20xx_id

+ Comma.

> +};

-- 
With Best Regards,
Andy Shevchenko
