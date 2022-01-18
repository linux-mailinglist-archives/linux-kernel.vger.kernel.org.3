Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71734923E9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 11:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbiARKmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 05:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiARKmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 05:42:09 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9425C061574;
        Tue, 18 Jan 2022 02:42:08 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 30so77503266edv.3;
        Tue, 18 Jan 2022 02:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OPCpd++6xHzuVBcX8Z+O2dCzgH3HDT5xxEHIErzXn30=;
        b=TvxY3azK3aDiAyKbgSRSqJBRC09scyg3ev419RSs6MIfOxpL32EBbkC9vaAamXi3im
         MPRGIoC3a4x1R/EMnuO5wbAP7ShbRicKS4Dt+MihYlM2NkLbYOfO40A9WcR8hNYZXY4D
         o3MQycDolWcpAKLM/tXcyIGg9dyX+RlCU1K53muzLv9N4HJAdS1WCpXtvYBhNVfivRdE
         goOi9Xc3EC+f1QPn6ybc39WNXEh35+SAMSQMa3A1HWJjQEq2OUUHZqgZMUKV5pIORh4v
         IXNeKKLBdFrlV65M1mhZPs7e+vbNJLcMp9eqqxETGsr4aLuMN03GoJL20jyK7cqC++TF
         ruRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OPCpd++6xHzuVBcX8Z+O2dCzgH3HDT5xxEHIErzXn30=;
        b=T8Cqwpcq2OEP+TbaiDtiKxsOjpG4otzLCMCskP2lw77cOdKyMKUrOp2f07HkhL/C2Q
         UbqLrpL+snG9wVxe0WEsZAFXK8ebbJOQMFyZ03yW7fTZ4AVoBiGVKY4sSSnzWfJSZdh+
         hAJGD+wpIiquUZ3Oq3WKU3L5GlPw/99+qpyOx+q8LBK/+1upa6sWx6cRDfeyLvRsqFk4
         ECMhql8f6IaJ16QCRqwNyY8cSAdTxNNbp1B/NHt+IyJZQ2Wp9Uuxirj2elcebfXnpgzt
         gJYk3nnmt8/m5ba33keQqSwQWBGMzIdPWAbFN4hREMhuLXq9eWlhlkI+v89dmU1nwOB4
         UDFg==
X-Gm-Message-State: AOAM533+Z2srbrxFGJPAKUdWZq5FB7T67ZDVOsVtbp2wCrjjW1BNLG6R
        a765+ZGI3L99fMuq1W+IFPBY9N+oDfcg+aH5el8z9GjD9ckrTA==
X-Google-Smtp-Source: ABdhPJxtiV910uI2F7NPYA6ZqHVgt5aB3keoDJj3DjQRNVzyY19ekXR/qZ8H9jP0XobskRxhLTvV8Hh6ckaQqQ7SUuI=
X-Received: by 2002:a05:6402:4c5:: with SMTP id n5mr25149816edw.122.1642502527270;
 Tue, 18 Jan 2022 02:42:07 -0800 (PST)
MIME-Version: 1.0
References: <20220117124741.7165-1-fe@dev.tdt.de> <20220117124741.7165-2-fe@dev.tdt.de>
In-Reply-To: <20220117124741.7165-2-fe@dev.tdt.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 18 Jan 2022 12:41:30 +0200
Message-ID: <CAHp75VeduFFwyJs3eni9MmjSzL=hOGLPAz2puiywLVwv62yMWw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] leds: ktd20xx: Extension of the KTD20xx family of
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

On Mon, Jan 17, 2022 at 2:47 PM Florian Eckert <fe@dev.tdt.de> wrote:
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

Thanks for an update, my comments below.

> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
>  MAINTAINERS                 |   6 +
>  drivers/leds/Kconfig        |  12 +
>  drivers/leds/Makefile       |   1 +
>  drivers/leds/leds-ktd20xx.c | 581 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 600 insertions(+)
>  create mode 100644 drivers/leds/leds-ktd20xx.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a58544f7b699..04d68985d348 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10739,6 +10739,12 @@ S:     Maintained
>  F:     Documentation/devicetree/bindings/leds/backlight/kinetic,ktd253.yaml
>  F:     drivers/video/backlight/ktd253-backlight.c
>
> +KTD20XX LED CONTROLLER DRIVER
> +M:     Florian Eckert <fe@dev.tdt.de>
> +L:     linux-leds@vger.kernel.org
> +S:     Maintained
> +F:     drivers/leds/leds-ktd20xx.c
> +
>  KTEST
>  M:     Steven Rostedt <rostedt@goodmis.org>
>  M:     John Hawley <warthog9@eaglescrag.net>
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 6090e647daee..a96e6bf7918b 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -157,6 +157,18 @@ config LEDS_EL15203000
>           To compile this driver as a module, choose M here: the module
>           will be called leds-el15203000.
>
> +config LEDS_KTD20XX
> +       tristate "LED Support for KTD2061/58/59/60 LED driver chip"
> +       depends on LEDS_CLASS && I2C
> +       depends on LEDS_CLASS_MULTICOLOR
> +       select REGMAP_I2C
> +       help
> +         If you say yes here you get support for the Kinetic
> +         KTD2061, KTD2058, KTD2059 and KTD2060 LED driver.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called leds-ktd20xx.
> +
>  config LEDS_TURRIS_OMNIA
>         tristate "LED support for CZ.NIC's Turris Omnia"
>         depends on LEDS_CLASS_MULTICOLOR
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index e58ecb36360f..5a86e72ea722 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_LEDS_IP30)                       += leds-ip30.o
>  obj-$(CONFIG_LEDS_IPAQ_MICRO)          += leds-ipaq-micro.o
>  obj-$(CONFIG_LEDS_IS31FL319X)          += leds-is31fl319x.o
>  obj-$(CONFIG_LEDS_IS31FL32XX)          += leds-is31fl32xx.o
> +obj-${CONFIG_LEDS_KTD20XX}             += leds-ktd20xx.o
>  obj-$(CONFIG_LEDS_LM3530)              += leds-lm3530.o
>  obj-$(CONFIG_LEDS_LM3532)              += leds-lm3532.o
>  obj-$(CONFIG_LEDS_LM3533)              += leds-lm3533.o
> diff --git a/drivers/leds/leds-ktd20xx.c b/drivers/leds/leds-ktd20xx.c
> new file mode 100644
> index 000000000000..1207bb453594
> --- /dev/null
> +++ b/drivers/leds/leds-ktd20xx.c
> @@ -0,0 +1,581 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + *  LEDs driver for the Kinetic KDT20xx device
> + *
> + *  Copyright (C) 2021 TDT AG

> + *       Florian Eckert <fe@dev.tdt.de>

A bit of a strange indentation. Missed Author: ?

> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/leds.h>
> +#include <linux/led-class-multicolor.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +
> +/* I2C Register Map */
> +#define KTD20XX_ID             0x00
> +#define KTD20XX_MONITOR                0x01
> +#define KTD20XX_CONTROL                0x02
> +
> +/* Color0 Configuration Registers */
> +#define KTD20XX_IRED0          0x03
> +#define KTD20XX_IGRN0          0x04
> +#define KTD20XX_IBLU0          0x05
> +
> +/* Color1 Configuration Registers */
> +#define KTD20XX_IRED1          0x06
> +#define KTD20XX_IGRN1          0x07
> +#define KTD20XX_IBLU1          0x08
> +
> +/* Selection Configuration Register */
> +#define KTD20XX_ISELA12                0x09
> +#define KTD20XX_ISELA34                0x0A
> +#define KTD20XX_ISELB12                0x0B
> +#define KTD20XX_ISELB34                0x0C
> +#define KTD20XX_ISELC12                0x0D
> +#define KTD20XX_ISELC34                0x0E
> +
> +#define KTD20XX_MAX_LEDS       12
> +#define KTD20XX_LED_CHANNELS   3
> +
> +enum ktd20xx_led_number {
> +       /* ISELA12 */
> +       RGB_A1,
> +       RGB_A2,
> +       /* ISELA34 */
> +       RGB_A3,
> +       RGB_A4,
> +       /* ISELB12 */
> +       RGB_B1,
> +       RGB_B2,
> +       /* ISELB34 */
> +       RGB_B3,
> +       RGB_B4,
> +       /* ISELC12 */
> +       RGB_C1,
> +       RGB_C2,
> +       /* ISELC34 */
> +       RGB_C3,
> +       RGB_C4,
> +};
> +
> +enum ktd20xx_control_mode {
> +       CONTROL_MODE_OFF,
> +       CONTROL_MODE_NIGHT,
> +       CONTROL_MODE_NORMAL,
> +       CONTROL_MODE_RESET,
> +};
> +
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
> +};
> +
> +/* Chip values */
> +static const struct reg_field kt20xx_control_mode = REG_FIELD(KTD20XX_CONTROL, 6, 7);
> +static const struct reg_field kt20xx_faderate = REG_FIELD(KTD20XX_CONTROL, 0, 2);
> +static const struct reg_field kt20xx_vendor = REG_FIELD(KTD20XX_ID, 5, 7);
> +static const struct reg_field kt20xx_chip_id = REG_FIELD(KTD20XX_ID, 0, 4);
> +static const struct reg_field kt20xx_chip_rev = REG_FIELD(KTD20XX_MONITOR, 4, 7);
> +
> +/* ISELA1 and ISELA2 */
> +static const struct reg_field kt20xx_a1_select = REG_FIELD(KTD20XX_ISELA12, 4, 6);
> +static const struct reg_field kt20xx_a1_enable = REG_FIELD(KTD20XX_ISELA12, 7, 7);
> +static const struct reg_field kt20xx_a2_select = REG_FIELD(KTD20XX_ISELA12, 0, 2);
> +static const struct reg_field kt20xx_a2_enable = REG_FIELD(KTD20XX_ISELA12, 3, 3);
> +
> +/* ISELA3 and ISELA4 */
> +static const struct reg_field kt20xx_a3_select = REG_FIELD(KTD20XX_ISELA34, 4, 6);
> +static const struct reg_field kt20xx_a3_enable = REG_FIELD(KTD20XX_ISELA34, 7, 7);
> +static const struct reg_field kt20xx_a4_select = REG_FIELD(KTD20XX_ISELA34, 0, 2);
> +static const struct reg_field kt20xx_a4_enable = REG_FIELD(KTD20XX_ISELA34, 3, 3);
> +
> +/* ISELB1 and ISELB2 */
> +static const struct reg_field kt20xx_b1_select = REG_FIELD(KTD20XX_ISELB12, 4, 6);
> +static const struct reg_field kt20xx_b1_enable = REG_FIELD(KTD20XX_ISELB12, 7, 7);
> +static const struct reg_field kt20xx_b2_select = REG_FIELD(KTD20XX_ISELB12, 0, 2);
> +static const struct reg_field kt20xx_b2_enable = REG_FIELD(KTD20XX_ISELB12, 3, 3);
> +
> +/* ISELB3 and ISELB4 */
> +static const struct reg_field kt20xx_b3_select = REG_FIELD(KTD20XX_ISELB34, 4, 6);
> +static const struct reg_field kt20xx_b3_enable = REG_FIELD(KTD20XX_ISELB34, 7, 7);
> +static const struct reg_field kt20xx_b4_select = REG_FIELD(KTD20XX_ISELB34, 0, 2);
> +static const struct reg_field kt20xx_b4_enable = REG_FIELD(KTD20XX_ISELB34, 3, 3);
> +
> +/* ISELC1 and ISELC2 */
> +static const struct reg_field kt20xx_c1_select = REG_FIELD(KTD20XX_ISELC12, 4, 6);
> +static const struct reg_field kt20xx_c1_enable = REG_FIELD(KTD20XX_ISELC12, 7, 7);
> +static const struct reg_field kt20xx_c2_select = REG_FIELD(KTD20XX_ISELC12, 0, 2);
> +static const struct reg_field kt20xx_c2_enable = REG_FIELD(KTD20XX_ISELC12, 3, 3);
> +
> +/* ISELC3 and ISELC4 */
> +static const struct reg_field kt20xx_c3_select = REG_FIELD(KTD20XX_ISELC34, 4, 6);
> +static const struct reg_field kt20xx_c3_enable = REG_FIELD(KTD20XX_ISELC34, 7, 7);
> +static const struct reg_field kt20xx_c4_select = REG_FIELD(KTD20XX_ISELC34, 0, 2);
> +static const struct reg_field kt20xx_c4_enable = REG_FIELD(KTD20XX_ISELC34, 3, 3);
> +
> +static const struct regmap_range ktd20xx_volatile_ranges = {
> +       .range_min = KTD20XX_ID,
> +       .range_max = KTD20XX_CONTROL,
> +};
> +
> +static const struct regmap_access_table ktd20xx_volatile_table = {
> +       .yes_ranges = &ktd20xx_volatile_ranges,
> +       .n_yes_ranges = 1,
> +};
> +
> +static const struct regmap_range ktd20xx_readable_ranges = {
> +       .range_min = KTD20XX_ID,
> +       .range_max = KTD20XX_MONITOR,
> +};
> +
> +static const struct regmap_access_table ktd20xx_readable_table = {
> +       .yes_ranges = &ktd20xx_readable_ranges,
> +       .n_yes_ranges = 1,
> +};
> +
> +static const struct regmap_config ktd20xx_regmap_config = {
> +       .name = "ktd20xx_regmap",
> +       .reg_bits = 8,
> +       .val_bits = 8,
> +
> +       .max_register = KTD20XX_ISELC34,
> +
> +       .volatile_table = &ktd20xx_volatile_table,
> +       .rd_table = &ktd20xx_readable_table,
> +
> +       .reg_defaults = ktd20xx_reg_defs,
> +       .num_reg_defaults = ARRAY_SIZE(ktd20xx_reg_defs),
> +       .cache_type = REGCACHE_FLAT,
> +};
> +
> +struct ktd20xx_led {
> +       struct led_classdev_mc mc_cdev;
> +       struct mc_subled subled_info[KTD20XX_LED_CHANNELS];
> +       int index;
> +       struct regmap_field *enable;
> +       struct regmap_field *select;
> +       struct ktd20xx *chip;
> +};
> +
> +struct ktd20xx {
> +       struct mutex lock;
> +       struct i2c_client *client;
> +       struct regmap *regmap;
> +       struct device *dev;
> +       struct regmap_field *control_mode;
> +       struct regmap_field *faderate;
> +       struct regmap_field *vendor;
> +       struct regmap_field *chip_id;
> +       struct regmap_field *chip_rev;
> +       struct ktd20xx_led leds[KTD20XX_MAX_LEDS];
> +};
> +
> +static int ktd20xx_hwinit(struct ktd20xx *chip)
> +{
> +       struct device *dev = &chip->client->dev;
> +       int ret;
> +       unsigned int value;
> +
> +       /*
> +        * If the device tree property 'kinetc,led-current' is found
> +        * then set this value into the color0 register as the max current
> +        * for all color channel LEDs. If this poperty is not set then
> +        * use the default value 0x28 set by the chip after a hardware reset.
> +        * The hardware default value 0x28 corresponds to 5mA.
> +        */
> +       ret = device_property_read_u32(dev, "kinetic,led-current", &value);
> +       if (ret == 0) {

> +               dev_info(dev, "property 'kinetic,led-current' found. Using value 0x%02x.\n",
> +                               value);

Why _info? WHo needs this noise in the logs? Perhaps you meant _dbg?

> +               regmap_write(chip->regmap, KTD20XX_IRED0, value);
> +               regmap_write(chip->regmap, KTD20XX_IGRN0, value);
> +               regmap_write(chip->regmap, KTD20XX_IBLU0, value);
> +       } else {
> +               dev_warn(dev, "property 'kinetic,led-current' not found. Using default hardware value 0x28 (5mA).\n");
> +       }

Can we use the standard pattern, please?
I.e.

if (ret) {
  ...
} else {
  ...
}

> +
> +       /* Set color1 register current value to 0x00 and therefor 0mA */
> +       regmap_write(chip->regmap, KTD20XX_IRED1, 0);
> +       regmap_write(chip->regmap, KTD20XX_IGRN1, 0);
> +       regmap_write(chip->regmap, KTD20XX_IBLU1, 0);
> +
> +       /* Enable chip to run in 'normal mode' */
> +       regmap_field_write(chip->control_mode, CONTROL_MODE_NORMAL);
> +
> +       return 0;
> +}
> +
> +static struct ktd20xx_led *mcled_cdev_to_led(struct led_classdev_mc *mc_cdev)
> +{
> +       return container_of(mc_cdev, struct ktd20xx_led, mc_cdev);
> +}
> +
> +static int ktd20xx_brightness_set(struct led_classdev *cdev,
> +               enum led_brightness brightness)
> +{
> +       struct led_classdev_mc *mc_dev = lcdev_to_mccdev(cdev);
> +       struct ktd20xx_led *led = mcled_cdev_to_led(mc_dev);
> +       struct device *dev = led->chip->dev;

> +       int ret = 0;

Redundant assignment

> +       int i = 0;

Ditto.

> +       unsigned int rgb = 0;

Move assignment closer to its first use.

> +       mutex_lock(&led->chip->lock);
> +       ret = regmap_field_write(led->enable, brightness ? 1 : 0);
> +       if (ret) {
> +               dev_err(dev, "Cannot set enable flag of LED %d error: %d\n",
> +                               led->index, ret);
> +               goto out;
> +       }
> +
> +       for (i = 0; i < led->mc_cdev.num_colors; i++) {
> +               unsigned int intensity = mc_dev->subled_info[i].intensity;
> +               unsigned int channel = mc_dev->subled_info[i].channel;
> +
> +               if (intensity > 0)

> +                       rgb += BIT(channel);

Use bit operations instead, which will make it cleaner.

> +       }
> +
> +       /*
> +        * To use the color0 registers default value after an hadware reset,
> +        * if the device tree property 'kinetc,led-current' is not set,
> +        * we have to 'invert' the rgb channel!
> +        */
> +       ret = regmap_field_write(led->select, ~rgb);
> +       if (ret) {
> +               dev_err(dev, "Can not set RGB for LED %d error: %d\n",
> +                               led->index, ret);
> +               goto out;
> +       }

> +out:

out_unlock:

> +       mutex_unlock(&led->chip->lock);
> +       return ret;
> +}
> +
> +static int ktd20xx_probe_dt(struct ktd20xx *chip)
> +{
> +       struct fwnode_handle *child = NULL;
> +       struct led_init_data init_data = {};
> +       struct led_classdev *led_cdev;
> +       struct ktd20xx_led *led;
> +       struct device *dev = &chip->client->dev;

> +       int i = 0;

Move the assignment closer to its first user.

> +       int ret = -EINVAL;

How does it work? I mean this assignment.

> +       int color;
> +
> +       device_for_each_child_node(chip->dev, child) {
> +               led = &chip->leds[i];
> +
> +               ret = fwnode_property_read_u32(child, "reg", &led->index);
> +               if (ret) {
> +                       dev_err(dev, "missing property 'reg'\n");
> +                       goto child_out;
> +               }
> +               if (led->index >= KTD20XX_MAX_LEDS) {

> +                       dev_warn(dev, "property 'reg' must contain value between '0' and '%i'\n",
> +                                       KTD20XX_MAX_LEDS);

_warn is not in alignment with the actions the code makes at this condition.

> +                       ret = -EINVAL;
> +                       goto child_out;
> +               }
> +
> +               ret = fwnode_property_read_u32(child, "color", &color);
> +               if (ret) {
> +                       dev_err(dev, "missing property 'color'\n");
> +                       goto child_out;
> +               }
> +               if (color != LED_COLOR_ID_MULTI) {

> +                       dev_warn(dev, "wrong property 'color' must be 'LED_COLOR_ID_MULTI'\n");

Ditto.

> +                       ret = -EINVAL;
> +                       goto child_out;
> +               }
> +
> +               led->subled_info[0].color_index = LED_COLOR_ID_RED;
> +               led->subled_info[0].channel = 2;
> +               led->subled_info[1].color_index = LED_COLOR_ID_GREEN;
> +               led->subled_info[1].channel = 1;
> +               led->subled_info[2].color_index = LED_COLOR_ID_BLUE;
> +               led->subled_info[2].channel = 0;
> +
> +               led->mc_cdev.subled_info = led->subled_info;
> +               led->mc_cdev.num_colors = KTD20XX_LED_CHANNELS;
> +
> +               init_data.fwnode = child;
> +
> +               led->chip = chip;
> +               led_cdev = &led->mc_cdev.led_cdev;
> +               led_cdev->brightness_set_blocking = ktd20xx_brightness_set;
> +
> +               switch (led->index) {
> +               case RGB_A1:
> +                       led->select = devm_regmap_field_alloc(chip->dev,
> +                                       chip->regmap, kt20xx_a1_select);
> +                       led->enable = devm_regmap_field_alloc(chip->dev,
> +                                       chip->regmap, kt20xx_a1_enable);
> +                       break;
> +               case RGB_A2:
> +                       led->select = devm_regmap_field_alloc(chip->dev,
> +                                       chip->regmap, kt20xx_a2_select);
> +                       led->enable = devm_regmap_field_alloc(chip->dev,
> +                                       chip->regmap, kt20xx_a2_enable);
> +                       break;
> +               case RGB_A3:
> +                       led->select = devm_regmap_field_alloc(chip->dev,
> +                                       chip->regmap, kt20xx_a3_select);
> +                       led->enable = devm_regmap_field_alloc(chip->dev,
> +                                       chip->regmap, kt20xx_a3_enable);
> +                       break;
> +               case RGB_A4:
> +                       led->select = devm_regmap_field_alloc(chip->dev,
> +                                       chip->regmap, kt20xx_a4_select);
> +                       led->enable = devm_regmap_field_alloc(chip->dev,
> +                                       chip->regmap, kt20xx_a4_enable);
> +                       break;
> +               case RGB_B1:
> +                       led->select = devm_regmap_field_alloc(chip->dev,
> +                                       chip->regmap, kt20xx_b1_select);
> +                       led->enable = devm_regmap_field_alloc(chip->dev,
> +                                       chip->regmap, kt20xx_b1_enable);
> +                       break;
> +               case RGB_B2:
> +                       led->select = devm_regmap_field_alloc(chip->dev,
> +                                       chip->regmap, kt20xx_b2_select);
> +                       led->enable = devm_regmap_field_alloc(chip->dev,
> +                                       chip->regmap, kt20xx_b2_enable);
> +                       break;
> +               case RGB_B3:
> +                       led->select = devm_regmap_field_alloc(chip->dev,
> +                                       chip->regmap, kt20xx_b3_select);
> +                       led->enable = devm_regmap_field_alloc(chip->dev,
> +                                       chip->regmap, kt20xx_b3_enable);
> +                       break;
> +               case RGB_B4:
> +                       led->select = devm_regmap_field_alloc(chip->dev,
> +                                       chip->regmap, kt20xx_b4_select);
> +                       led->enable = devm_regmap_field_alloc(chip->dev,
> +                                       chip->regmap, kt20xx_b4_enable);
> +                       break;
> +               case RGB_C1:
> +                       led->select = devm_regmap_field_alloc(chip->dev,
> +                                       chip->regmap, kt20xx_c1_select);
> +                       led->enable = devm_regmap_field_alloc(chip->dev,
> +                                       chip->regmap, kt20xx_c1_enable);
> +                       break;
> +               case RGB_C2:
> +                       led->select = devm_regmap_field_alloc(chip->dev,
> +                                       chip->regmap, kt20xx_c2_select);
> +                       led->enable = devm_regmap_field_alloc(chip->dev,
> +                                       chip->regmap, kt20xx_c2_enable);
> +                       break;
> +               case RGB_C3:
> +                       led->select = devm_regmap_field_alloc(chip->dev,
> +                                       chip->regmap, kt20xx_c3_select);
> +                       led->enable = devm_regmap_field_alloc(chip->dev,
> +                                       chip->regmap, kt20xx_c3_enable);
> +                       break;
> +               case RGB_C4:
> +                       led->select = devm_regmap_field_alloc(chip->dev,
> +                                       chip->regmap, kt20xx_c4_select);
> +                       led->enable = devm_regmap_field_alloc(chip->dev,
> +                                       chip->regmap, kt20xx_c4_enable);
> +                       break;
> +               }

> +               ret = devm_led_classdev_multicolor_register_ext(&chip->client->dev,

What's the difference between &client->dev and chip->dev? If none, why
do you have both in the structure?

> +                       &led->mc_cdev,
> +                       &init_data);
> +
> +               if (ret) {
> +                       dev_err(&chip->client->dev, "led register err: %d\n", ret);
> +                       goto child_out;
> +               }
> +
> +               i++;
> +       }
> +
> +       return 0;
> +
> +child_out:
> +       fwnode_handle_put(child);
> +       return ret;
> +}
> +
> +/*
> + * The chip also offers the option "Night Mode".
> + * All LED current settings are divided by 16 for a 0 to 1.5mA current
> + * setting range.
> + */
> +static ssize_t nightmode_show(struct device *dev, struct device_attribute *a,
> +               char *buf)
> +{
> +       struct ktd20xx *chip = dev_get_drvdata(dev);
> +       unsigned int value;
> +
> +       mutex_lock(&chip->lock);
> +       regmap_field_read(chip->control_mode, &value);
> +       mutex_unlock(&chip->lock);
> +
> +       return sysfs_emit(buf, "%d\n", value == CONTROL_MODE_NIGHT ? 1 : 0);
> +}
> +
> +static ssize_t nightmode_store(struct device *dev, struct device_attribute *a,
> +               const char *buf, size_t count)
> +{
> +       struct ktd20xx *chip = dev_get_drvdata(dev);
> +       bool value;
> +       int ret;

> +       if (kstrtobool(buf, &value))
> +               return -EINVAL;

Do not hide the returned value from kstrbool().

> +       mutex_lock(&chip->lock);
> +       ret = regmap_field_write(chip->control_mode,
> +                       value == 1 ? CONTROL_MODE_NIGHT : CONTROL_MODE_NORMAL);
> +       mutex_unlock(&chip->lock);
> +
> +       if (ret < 0)
> +               return ret;
> +
> +       return count;
> +}
> +static DEVICE_ATTR_RW(nightmode);
> +
> +static struct attribute *ktd20xx_led_controller_attrs[] = {
> +       &dev_attr_nightmode.attr,
> +       NULL
> +};
> +ATTRIBUTE_GROUPS(ktd20xx_led_controller);
> +
> +static int ktd20xx_probe(struct i2c_client *client,
> +               const struct i2c_device_id *id)
> +{
> +       struct ktd20xx *chip;
> +       unsigned int vendor;
> +       unsigned int chip_id;
> +       unsigned int chip_rev;
> +       int ret;
> +
> +       chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
> +       if (!chip)
> +               return -ENOMEM;
> +
> +       mutex_init(&chip->lock);
> +       chip->client = client;
> +       chip->dev = &client->dev;
> +       i2c_set_clientdata(client, chip);
> +
> +       chip->regmap = devm_regmap_init_i2c(client, &ktd20xx_regmap_config);
> +       if (IS_ERR(chip->regmap)) {

> +               dev_err_probe(&client->dev, PTR_ERR(chip->regmap),
> +                       "Failed to allocate register map\n");
> +               goto error;


> +       }
> +
> +       chip->control_mode = devm_regmap_field_alloc(chip->dev, chip->regmap,
> +                       kt20xx_control_mode);
> +       chip->faderate = devm_regmap_field_alloc(chip->dev, chip->regmap,
> +                       kt20xx_faderate);
> +       chip->vendor = devm_regmap_field_alloc(chip->dev, chip->regmap,
> +                       kt20xx_vendor);
> +       chip->chip_id = devm_regmap_field_alloc(chip->dev, chip->regmap,
> +                       kt20xx_chip_id);
> +       chip->chip_rev = devm_regmap_field_alloc(chip->dev, chip->regmap,
> +                       kt20xx_chip_rev);
> +
> +       /* Reset all registers to hardware device default settings */
> +       regmap_field_write(chip->control_mode, CONTROL_MODE_RESET);
> +
> +       ret = regmap_field_read(chip->vendor, &vendor);
> +       if (ret) {
> +               dev_err_probe(&client->dev, ret, "Failed to read vendor\n");
> +               goto error;
> +       }
> +
> +       ret = regmap_field_read(chip->chip_id, &chip_id);
> +       if (ret) {
> +               dev_err_probe(&client->dev, ret, "Failed to read chip id\n");
> +               goto error;
> +       }
> +
> +       ret = regmap_field_read(chip->chip_rev, &chip_rev);
> +       if (ret) {
> +               dev_err_probe(&client->dev, ret, "Failed to read chip rev\n");
> +               goto error;
> +       }
> +
> +       dev_info(&client->dev, "vendor: 0x%02x chip-id: 0x%02x chip-rev: 0x%02x\n",
> +                       vendor, chip_id, chip_rev);
> +
> +       ret = ktd20xx_hwinit(chip);
> +       if (ret)
> +               goto error;
> +
> +       ret = ktd20xx_probe_dt(chip);
> +       if (ret)
> +               goto error;
> +
> +       return 0;

> +error:

err_destroy_mutex:

But...

> +       mutex_destroy(&chip->lock);
> +       return ret;

...here...

> +}
> +
> +static int ktd20xx_remove(struct i2c_client *client)
> +{
> +       struct ktd20xx *chip = i2c_get_clientdata(client);
> +
> +       mutex_lock(&chip->lock);
> +       regmap_field_write(chip->control_mode, CONTROL_MODE_OFF);
> +       mutex_unlock(&chip->lock);

> +       mutex_destroy(&chip->lock);

...and here you have an ordering issue. You are not supposed to mix
devm with non-devm like you did. So, imagine what will happen here if
something will call regmap functions here.

> +       return 0;
> +}
> +
> +static const struct i2c_device_id ktd20xx_id[] = {
> +       { "ktd20xx", 0 },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(i2c, ktd20xx_id);
> +
> +static const struct of_device_id of_ktd20xx_leds_match[] = {
> +       { .compatible = "kinetic,ktd20xx", },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, of_ktd20xx_leds_match);
> +
> +static struct i2c_driver ktd20xx_driver = {
> +       .driver = {
> +               .name = "ktd20xx",
> +               .dev_groups = ktd20xx_led_controller_groups,
> +               .of_match_table = of_ktd20xx_leds_match,
> +       },
> +       .probe = ktd20xx_probe,
> +       .remove = ktd20xx_remove,
> +       .id_table = ktd20xx_id
> +};
> +module_i2c_driver(ktd20xx_driver);
> +
> +MODULE_DESCRIPTION("Kinetic KTD20xx LED driver");
> +MODULE_AUTHOR("Florian Eckert <fe@dev.tdt.de>");
> +MODULE_LICENSE("GPL v2");
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
