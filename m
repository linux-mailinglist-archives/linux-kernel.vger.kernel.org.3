Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D1C5AFEF7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiIGI2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiIGI2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:28:09 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F99ABF12
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:28:05 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id p18so13768010plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 01:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=JLj5qPow7L7HoGVSS5zlo0VUJ7cBbQb/GuusAMgXIEs=;
        b=e4Gp0KLnDSH+bzcUn423RMcUgLUSK6Ir9qzf5Pkrycx8s/fasN04i9krEHx25uZy/W
         x7fFHmZZFPHzZq0GoCI9JWHfWEI/YMFTrZ3qo5EpvDm05AJwwyBn/Wk1ihbmMNadIBo0
         FWKrx45l1nXitmF3DSDH5X9ee2rF4Ij68/h4eE5KZKsmWIH+qug9is4O9pRg7mWu/cuv
         Fe3ah/sBFoTPCHh37Q3RGDwxlUqhvTpq6urL8RdrIlEfL9egKkE7Elu6VXcnoLOvyqaC
         IBt/uyLAEw2A3Kglryra31hPKN47gDnhvL6XYRhpBTaCsKg7cudqXxYEBDuro6NJ8FNU
         4kNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JLj5qPow7L7HoGVSS5zlo0VUJ7cBbQb/GuusAMgXIEs=;
        b=6rMAB7O1hI1nqoMvkWYpdwHIUOCUI0VfnDjweaPlsnFuYB7yZZvpa+ks/BdNW7kaRS
         qECKSAtTnuOlmUbCOtXahNb9tEPJvX58zp0dpyAd/Z06h8nmODpTQun9SExfP98DLmbs
         IC/Dqd1KUY9eisyH5iHfZJ06MYUpRs7/mcOuqWxR81tEGHfgpGlOEVwo2vzxk/WYz8R3
         MzVabnz1gcf8M5vw70EM3mQBQ+mAZKKCtzxX4C5ukHaVP1f2Ap6U/G6VFsqD/cL4fmow
         kZ0Grhp7s4UvviXelZzQ/EUc6RyNmPbryQ9mnPj8Zw86vDCbt5EPS1fkMOY6hiFCMjWJ
         xogg==
X-Gm-Message-State: ACgBeo1c9E+kWTJtEQ7hvp2CQkzUdedtPYlNQ/PPbHtCfI8ymDJgUJW6
        Tk9wR2klxiXX/MWYMDMeZfAyKVXMJKoQ0PXSZBIGYWV65YwurPfO
X-Google-Smtp-Source: AA6agR7+TQhCi2k8Zhm9X9oOX+jk1PUF0aoqoutTX0VxYaWLBjx7vlii9JNM8wDkjorXXed7WBeHSs/FatxZBOLjxHU=
X-Received: by 2002:a17:90a:9907:b0:1f5:2318:ea6d with SMTP id
 b7-20020a17090a990700b001f52318ea6dmr2777865pjp.163.1662539284906; Wed, 07
 Sep 2022 01:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220902182650.83098-1-andriy.shevchenko@linux.intel.com> <20220902182650.83098-17-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220902182650.83098-17-andriy.shevchenko@linux.intel.com>
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
Date:   Wed, 7 Sep 2022 10:27:53 +0200
Message-ID: <CALNFmy1XOm=Csyatcj3zbL2J9roj1oH5GryXs1dda=QwXWygxQ@mail.gmail.com>
Subject: Re: [PATCH v1 17/17] pinctrl: cy8c95x0: Correct comment style
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series is

Tested-by: Patrick Rudolph <patrick.rudolph@9elements.com>

On Fri, Sep 2, 2022 at 8:32 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> In a few comments the style is not aligned with the rest.
> Correct them.
>
> While at it, drop unneeded blank lines and deduplicate 'Author'.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pinctrl/pinctrl-cy8c95x0.c | 40 +++++++++++++++---------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/pinctrl/pinctrl-cy8c95x0.c b/drivers/pinctrl/pinctrl-cy8c95x0.c
> index 57302cb0186f..fc2c54164669 100644
> --- a/drivers/pinctrl/pinctrl-cy8c95x0.c
> +++ b/drivers/pinctrl/pinctrl-cy8c95x0.c
> @@ -3,8 +3,8 @@
>   * CY8C95X0 20/40/60 pin I2C GPIO port expander with interrupt support
>   *
>   * Copyright (C) 2022 9elements GmbH
> - * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
> - * Author: Naresh Solanki <Naresh.Solanki@9elements.com>
> + * Authors: Patrick Rudolph <patrick.rudolph@9elements.com>
> + *         Naresh Solanki <Naresh.Solanki@9elements.com>
>   */
>
>  #include <linux/acpi.h>
> @@ -37,7 +37,7 @@
>
>  /* Port Select configures the port */
>  #define CY8C95X0_PORTSEL       0x18
> -/* port settings, write PORTSEL first */
> +/* Port settings, write PORTSEL first */
>  #define CY8C95X0_INTMASK       0x19
>  #define CY8C95X0_PWMSEL                0x1A
>  #define CY8C95X0_INVERT                0x1B
> @@ -72,7 +72,6 @@ static const struct of_device_id cy8c95x0_dt_ids[] = {
>         { .compatible = "cypress,cy8c9560", .data = OF_CY8C95X(60), },
>         { }
>  };
> -
>  MODULE_DEVICE_TABLE(of, cy8c95x0_dt_ids);
>
>  static const struct acpi_gpio_params cy8c95x0_irq_gpios = { 0, 0, true };
> @@ -418,7 +417,7 @@ static int cy8c95x0_write_regs_mask(struct cy8c95x0_pinctrl *chip, int reg,
>                         continue;
>
>                 switch (reg) {
> -               /* muxed registers */
> +               /* Muxed registers */
>                 case CY8C95X0_INTMASK:
>                 case CY8C95X0_PWMSEL:
>                 case CY8C95X0_INVERT:
> @@ -435,7 +434,7 @@ static int cy8c95x0_write_regs_mask(struct cy8c95x0_pinctrl *chip, int reg,
>                                 goto out;
>                         off = reg;
>                         break;
> -               /* direct access registers */
> +               /* Direct access registers */
>                 case CY8C95X0_INPUT:
>                 case CY8C95X0_OUTPUT:
>                 case CY8C95X0_INTSTATUS:
> @@ -489,7 +488,7 @@ static int cy8c95x0_read_regs_mask(struct cy8c95x0_pinctrl *chip, int reg,
>                         continue;
>
>                 switch (reg) {
> -               /* muxed registers */
> +               /* Muxed registers */
>                 case CY8C95X0_INTMASK:
>                 case CY8C95X0_PWMSEL:
>                 case CY8C95X0_INVERT:
> @@ -506,7 +505,7 @@ static int cy8c95x0_read_regs_mask(struct cy8c95x0_pinctrl *chip, int reg,
>                                 goto out;
>                         off = reg;
>                         break;
> -               /* direct access registers */
> +               /* Direct access registers */
>                 case CY8C95X0_INPUT:
>                 case CY8C95X0_OUTPUT:
>                 case CY8C95X0_INTSTATUS:
> @@ -581,18 +580,18 @@ static int cy8c95x0_gpio_direction_output(struct gpio_chip *gc,
>         u8 bit = cypress_get_pin_mask(chip, off);
>         int ret;
>
> -       /* set output level */
> +       /* Set output level */
>         ret = regmap_write_bits(chip->regmap, outreg, bit, val ? bit : 0);
>         if (ret)
>                 return ret;
>
>         mutex_lock(&chip->i2c_lock);
> -       /* select port */
> +       /* Select port... */
>         ret = regmap_write(chip->regmap, CY8C95X0_PORTSEL, port);
>         if (ret)
>                 goto out;
>
> -       /* then direction */
> +       /* ...then direction */
>         ret = regmap_write_bits(chip->regmap, CY8C95X0_DIRECTION, bit, 0);
>
>  out:
> @@ -613,7 +612,7 @@ static int cy8c95x0_gpio_get_value(struct gpio_chip *gc, unsigned int off)
>         if (ret < 0) {
>                 /*
>                  * NOTE:
> -                * diagnostic already emitted; that's all we should
> +                * Diagnostic already emitted; that's all we should
>                  * do unless gpio_*_value_cansleep() calls become different
>                  * from their nonsleeping siblings (and report faults).
>                  */
> @@ -676,7 +675,7 @@ static int cy8c95x0_gpio_get_pincfg(struct cy8c95x0_pinctrl *chip,
>
>         mutex_lock(&chip->i2c_lock);
>
> -       /* select port */
> +       /* Select port */
>         ret = regmap_write(chip->regmap, CY8C95X0_PORTSEL, port);
>         if (ret < 0)
>                 goto out;
> @@ -731,7 +730,8 @@ static int cy8c95x0_gpio_get_pincfg(struct cy8c95x0_pinctrl *chip,
>                 ret = -ENOTSUPP;
>                 goto out;
>         }
> -       /* Writing 1 to one of the drive mode registers will automatically
> +       /*
> +        * Writing 1 to one of the drive mode registers will automatically
>          * clear conflicting set bits in the other drive mode registers.
>          */
>         ret = regmap_read(chip->regmap, reg, &reg_val);
> @@ -757,7 +757,7 @@ static int cy8c95x0_gpio_set_pincfg(struct cy8c95x0_pinctrl *chip,
>
>         mutex_lock(&chip->i2c_lock);
>
> -       /* select port */
> +       /* Select port */
>         ret = regmap_write(chip->regmap, CY8C95X0_PORTSEL, port);
>         if (ret < 0)
>                 goto out;
> @@ -794,7 +794,8 @@ static int cy8c95x0_gpio_set_pincfg(struct cy8c95x0_pinctrl *chip,
>                 ret = -ENOTSUPP;
>                 goto out;
>         }
> -       /* Writing 1 to one of the drive mode registers will automatically
> +       /*
> +        * Writing 1 to one of the drive mode registers will automatically
>          * clear conflicting set bits in the other drive mode registers.
>          */
>         ret = regmap_write_bits(chip->regmap, reg, bit, bit);
> @@ -1119,7 +1120,7 @@ static int cy8c95x0_pinmux_cfg(struct cy8c95x0_pinctrl *chip,
>         u8 bit = cypress_get_pin_mask(chip, off);
>         int ret;
>
> -       /* select port */
> +       /* Select port */
>         ret = regmap_write(chip->regmap, CY8C95X0_PORTSEL, port);
>         if (ret < 0)
>                 return ret;
> @@ -1236,11 +1237,12 @@ static int cy8c95x0_setup_pinctrl(struct cy8c95x0_pinctrl *chip)
>         pd->pins = cy8c9560_pins;
>         pd->npins = chip->tpin;
>         pd->owner = THIS_MODULE;
> -       chip->pctldev = devm_pinctrl_register(chip->dev, pd, chip);
>
> +       chip->pctldev = devm_pinctrl_register(chip->dev, pd, chip);
>         if (IS_ERR(chip->pctldev))
>                 return dev_err_probe(chip->dev, PTR_ERR(chip->pctldev),
>                         "can't register controller\n");
> +
>         return 0;
>  }
>
> @@ -1293,7 +1295,6 @@ static int cy8c95x0_probe(struct i2c_client *client)
>         chip->driver_data = (unsigned long)device_get_match_data(&client->dev);
>         if (!chip->driver_data)
>                 chip->driver_data = i2c_match_id(cy8c95x0_id, client)->driver_data;
> -
>         if (!chip->driver_data)
>                 return -ENODEV;
>
> @@ -1395,7 +1396,6 @@ static struct i2c_driver cy8c95x0_driver = {
>         .id_table       = cy8c95x0_id,
>         .detect         = cy8c95x0_detect,
>  };
> -
>  module_i2c_driver(cy8c95x0_driver);
>
>  MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
> --
> 2.35.1
>
