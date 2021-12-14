Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D221474E76
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 00:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238164AbhLNXPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 18:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhLNXPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 18:15:20 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E56AC061574;
        Tue, 14 Dec 2021 15:15:19 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id t5so68198332edd.0;
        Tue, 14 Dec 2021 15:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MsmojqC+U1XwlNmFVcA+R6uBBWOUFwdUyMbQfvqIj9M=;
        b=Twseny7cGfI6LiwPtItK1nqxVVhSycN4Pd8LFFgFeOha0SpCjagNdMM9mDU0KLgJKp
         ydd7mE/sr5CaXmzPqlboOl8rZwxYlsjzcOeaK/h173ZoAmc+/8kPANQlKSuxO/idrvMM
         Q3SFWLjrlNCoYpSdEDmQwTWM4XOKJvFHDhIpmeW/WA0Brz0CBxyngw6KWRKJ4E1RKYm4
         BUhzThfquT8ZGmVVhrzRlv9mh41BW9gohkgsOrAGb8E9diuAvzh38rEqRxAyorMRBk42
         WggNVw5vp1K4eRCYrt7Hbk00RA4LbHGmH8fFgguaiu0E13ra6oa+EZ5kQeHoNPxJDmvO
         YutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MsmojqC+U1XwlNmFVcA+R6uBBWOUFwdUyMbQfvqIj9M=;
        b=1Xw7BVlZr+2yk/A7pifBiFdYfezhEvkcLPv9n2aGz4Vy1NIrVn89tJx4HDaqHBctEr
         X8kp2ABBlu5p+DmBPB07P7k6QDnZyODpSWWzAswweSh8L/wDyT6RUPz9vSEtadQ3BVGJ
         YFmieoVTCrXc3pVDySbgby0f8rgFuBpR/JuqxGpdJ349R3mD9Pb8+wEkbjOw2i4r3I3I
         Eopj2aIH2TSwWsaA7jqqw/YILQAe37Rfxich+1tChX/RxcHLRZeIP8iSYgghxnVxkjyL
         2Y1H96t1Xfh5YHJ4zzF6ri58+m6YolEMF1Xfdy9CCTAYnI1NwInlGA9M8s60m8DHwDeK
         LShw==
X-Gm-Message-State: AOAM5309t9BmMAOZgs5eoty+JVxBVyG5gIEytoh38aXMrRd3Wa8btQME
        tJdC42UMSm4OvQcx2tOyO7G6ZbgJtJ8X5SzJFowZkaUX68fGcaHU
X-Google-Smtp-Source: ABdhPJyTDZUZILqMaQ99xcaAfTOUClT+hJorHRc9gc6SMIjYh2ZXMVRwzNe8rViBcWD/wporcFm8M2VBwAp5VpFg8cQ=
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr764522ejj.636.1639523718050;
 Tue, 14 Dec 2021 15:15:18 -0800 (PST)
MIME-Version: 1.0
References: <1639479189-6693-1-git-send-email-wellslutw@gmail.com> <1639479189-6693-3-git-send-email-wellslutw@gmail.com>
In-Reply-To: <1639479189-6693-3-git-send-email-wellslutw@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Dec 2021 01:14:41 +0200
Message-ID: <CAHp75VcnkZmzZE5C5z+kyrJoGRx8t60e_vDrw4HXOocY=Mjqsw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] pinctrl: Add driver for Sunplus SP7021
To:     Wells Lu <wellslutw@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        dvorkin@tibbo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 5:08 PM Wells Lu <wellslutw@gmail.com> wrote:
>
> Add driver for Sunplus SP7021 SoC.

It needs much more work, my comments below.

...

> +/* SP7021 Pin Controller Driver.
> + * Copyright (C) Sunplus Tech/Tibbo Tech.
> + */

This is wrong style for multi-line comments. Fix it everywhere accordingly.

...

> +#include <linux/platform_device.h>
> +#include <linux/pinctrl/pinmux.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/module.h>
> +#include <linux/bitfield.h>

Keep them in order. Besides that it seems missed a few headers, such as of.h.

> +
> +#include <dt-bindings/pinctrl/sppctl-sp7021.h>

+ blank line

> +#include "../pinctrl-utils.h"
> +#include "../core.h"

+ blank line

> +#include "sppctl.h"

...

> +       mask = GENMASK(bit_off + SPPCTL_GROUP_PINMUX_MASK_SHIFT + bit_sz - 1,
> +                      bit_off + SPPCTL_GROUP_PINMUX_MASK_SHIFT);

GENMASK() with non-const arguments may be not a good choice and see, even

       mask = GENMASK(bit_sz - 1, 0) << (bit_off +
SPPCTL_GROUP_PINMUX_MASK_SHIFT);

is way much better.

...

> +       val = (reg & BIT(bit_off)) ? 1 : 0;

!!(...) may also work, but it's rather style preference.

...

> +       reg = readl(spp_gchip->gpioxt_base + SPPCTL_GPIO_OFF_MASTER + reg_off);

I noticed a potentially big issue with this driver. Are you sure it's
brave enough to do I/O without any synchronisation? Did I miss a lock?

...

> +       reg = readl(spp_gchip->gpioxt2_base + SPPCTL_GPIO_OFF_OD + reg_off);

You may create an I/O wrappers to achieve a much better to read code
(no repetition of this arithmetics, etc).

...

> +       for (i = 0; i < chip->ngpio; i++) {
> +               label = gpiochip_is_requested(chip, i);
> +               if (!label)
> +                       label = "";

Perhaps to show only requested ones? In such case you may use
for_each_requested_gpio() macro.

> +               seq_printf(s, " gpio-%03d (%-16.16s | %-16.16s)", i + chip->base,
> +                          chip->names[i], label);
> +               seq_printf(s, " %c", sppctl_gpio_get_direction(chip, i) == 0 ? 'O' : 'I');
> +               seq_printf(s, ":%d", sppctl_gpio_get(chip, i));
> +               seq_printf(s, " %s", (sppctl_first_get(chip, i) ? "gpi" : "mux"));
> +               seq_printf(s, " %s", (sppctl_master_get(chip, i) ? "gpi" : "iop"));
> +               seq_printf(s, " %s", (sppctl_gpio_inv_get(chip, i) ? "inv" : "   "));
> +               seq_printf(s, " %s", (sppctl_gpio_output_od_get(chip, i) ? "oDr" : ""));

Too many parentheses in a few of above lines.

> +               seq_puts(s, "\n");
> +       }

...

> +               dev_err_probe(&pdev->dev, -EINVAL, "Not a gpio-controller!\n");
> +               return -EINVAL;

Unite them in one return statement.
Ditto for zillion similar cases in this driver.

...

> +       gchip->parent =            &pdev->dev;

> +       gchip->of_node =           pdev->dev.of_node;

Drop this dup. GPIO library already does it for you.

...

> +       int i = 0;

What for this assingment?

> +       dev_dbg(pctldev->dev, "%s(%d, %ld, %d)\n", __func__, pin, *configs, num_configs);

Noise. Better to consider to add necessary tracepoints to pin control core.

> +       /* Special handling for IOP */
> +       if (configs[i] == 0xFF) {

Why out of a sudden capitilazed hex value?

> +               sppctl_first_master_set(&pctl->spp_gchip->chip, pin, mux_f_gpio, mux_m_iop);
> +               return 0;
> +       }

...

> +       dev_dbg(pctldev->dev, "%s(%d)\n", __func__, offset);

Noise. And so on, so on...

...

> +       dev_dbg(pctldev->dev, "%s(%d), f_idx: %d, g_idx: %d, freg: %d\n",
> +               __func__, selector, g2fpm.f_idx, g2fpm.g_idx, f->freg);

No need to use __func__, and especially in case of _dbg / _debug. It
can be enabled at run-time with help of Dynamic Debug.

...

> +       seq_printf(s, "%s", dev_name(pctldev->dev));

Isn't it printed by core?

...

> +static int sppctl_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node *np_config,
> +                                struct pinctrl_map **map, unsigned int *num_maps)
> +{

Looking into this rather quite big function why you can't use what pin
control core provides?

> +}

...

> +       /* Fill up unique group names array. */
> +       sppctl->unq_grps = devm_kzalloc(&pdev->dev, (sppctl->unq_grps_sz + 1) *
> +                                       sizeof(char *), GFP_KERNEL);

You need to use devm_kcalloc() variant for arrays.

> +       if (!sppctl->unq_grps)
> +               return -ENOMEM;

> +       sppctl->g2fp_maps = devm_kzalloc(&pdev->dev, (sppctl->unq_grps_sz + 1) *
> +                                        sizeof(struct grp2fp_map), GFP_KERNEL);

Ditto, besides the fact of better use of sizeof() of the type of
variable, done by sizeof(*..._maps).

> +       if (!sppctl->g2fp_maps)
> +               return -ENOMEM;
> +
> +       sppctl->groups_name = devm_kzalloc(&pdev->dev, sppctl_list_funcs_sz *
> +                                          SPPCTL_MAX_GROUPS * sizeof(char *), GFP_KERNEL);

Ditto. And check some interesting macros in overflow.h.

> +       if (!sppctl->groups_name)
> +               return -ENOMEM;

...

> +       /* gpio */

GPIO, but either way seems not so valueable comment.

...

> +       err = devm_pinctrl_register_and_init(&pdev->dev, &sppctl->pctl_desc,
> +                                            sppctl, &sppctl->pctl_dev);
> +       if (err) {

> +               dev_err_probe(&pdev->dev, err, "Failed to register pinctrl!\n");
> +               of_node_put(np);

Swap them and use the form of
return dev_err_probe();

> +               return err;
> +       }

...

> +       /* MOON2 registers */
> +       rp = platform_get_resource_byname(pdev, IORESOURCE_MEM, "moon2");
> +       sppctl->moon2_base = devm_ioremap_resource(&pdev->dev, rp);

We have an API that provides two in one.

> +       if (IS_ERR(sppctl->moon2_base)) {
> +               ret = PTR_ERR(sppctl->moon2_base);

> +               goto ioremap_failed;

What is this for? Use return dev_err_probe() directly.

> +       }

> +       dev_dbg(&pdev->dev, "MOON2:   %pr\n", rp);

This cryptic noise has to be removed.

Above comments are applicable to all similar cases.

...

> +ioremap_failed:
> +       dev_err_probe(&pdev->dev, ret, "ioremap failed!\n");

This doesn't bring any value, besides the fact that API you have used
already prints a message.

...

> +       pdev->dev.platform_data = sppctl;

Don't we have special setter for this field?

...

> +       dev_info(&pdev->dev, "SP7021 PinCtrl by Sunplus/Tibbo Tech. (c)");

No value.

...

> +       { /* zero */ }

Comment with no value.

> +};

...

> +               .owner          = THIS_MODULE,

It's probably 5+ years that we don't need this (it's applied implicitly).

...

> +#ifndef __SPPCTL_H__
> +#define __SPPCTL_H__

This header misses the inclusions such as bits.h.
And I belive more than that.

...

> +/* FIRST register:
> + *   0: MUX
> + *   1: GPIO/IOP
> + *   2: No change
> + */

For all comments starting from here and for similar cases elsewhere:
 - why it is not in kernel doc?
 - what the value that add?
(Some of them so cryptic or so obvious)

...

> +static const struct sppctl_grp sp7021grps_spif[] = {
> +       EGRP("SPI_FLASH1", 1, pins_spif1),
> +       EGRP("SPI_FLASH2", 2, pins_spif2)

Here and everywhere else, leave a comma if it's not a terminator entry.

> +};

-- 
With Best Regards,
Andy Shevchenko
