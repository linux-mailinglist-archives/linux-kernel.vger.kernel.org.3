Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7525646F86D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbhLJB2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbhLJB2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:28:44 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36008C0617A2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 17:25:10 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id t23so11300910oiw.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 17:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Saab9E6pBZbyO1S7bJJtFbvA3GKfuPhNl8XZDofNXk=;
        b=wYHTqwZSOFXnBxthVui0OoJ9f745THfBjeI3a4uYZ5GDmchWnbGxNOnrCIjSy2r6rW
         NFBm9+R3AJR4EMfYUaDQoorto+ktgrolrzRkoQ6pIBREbD7oYo4TNJHFLOLqGt++rmwn
         t0zHSmMMxQ72NX/ocaKFfhEGMtgjI56/QLm8NHRdaNW6Ru/VYvFJ9AFxWDQJ21vtLQkY
         HlaBEMoGXOyjU69N7BBcnl7HLCBplQnWw2wauMC273mHr3pUFeTNYejuNtlIoJZszBC/
         gTYXXPnGXAnfeXbuOLu4KtZZQHfamSgH8UdbxtaSx8YoNdhbi7o6VRTPU4CuNIFC2ZZO
         vVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Saab9E6pBZbyO1S7bJJtFbvA3GKfuPhNl8XZDofNXk=;
        b=mrommd8O6V9V1XkE1YUKMrBbg3IlXUtZRGb8f9SugAu6+eVhs/Y6Ns3LGJicimgZhy
         ef2eInsPsenJTfmv59iKxA1Zor30cVFXgK0uxClU45VhYxoedHm+U11s4XtY9I+v/8J7
         hyb0xQ6t0PKhxALKBPwwdrZejV/DPOAy8WBTiHp2Vm2wdYvQQAbyW+x52hF9d+Gg5Uuo
         CQIw4Ocsn6wz8HFXSa3Y7Hcy2QD8TI0gQk2mSK72G4179+woGz0Rv3SDn6n9QDPrMYLC
         /3QJzE3a0wOKQnRFLiwmHSZ7b/uBSVeoq79o8/qYERkC5gNyvoyOYKHupzVNmNqlYAPp
         SibA==
X-Gm-Message-State: AOAM530SFgpuw0GMeAdANHDPDcE6+Zh+I10ueo+FZb1uzR9MXGjY0MP2
        eqhpsQ0SVHOlzZFwnqzavZm+eIRgy4AY6J73b4D8uQ==
X-Google-Smtp-Source: ABdhPJz1o7Hah+1IdxXbQYbbEyHG3lpFOMWj4uNfulfx42ZyR6c5lyHae7DWmvsLE/dZEDtZoZBwadb5yyj6UisZNok=
X-Received: by 2002:aca:120f:: with SMTP id 15mr9565253ois.132.1639099509287;
 Thu, 09 Dec 2021 17:25:09 -0800 (PST)
MIME-Version: 1.0
References: <1638850665-9474-1-git-send-email-wellslutw@gmail.com> <1638850665-9474-3-git-send-email-wellslutw@gmail.com>
In-Reply-To: <1638850665-9474-3-git-send-email-wellslutw@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Dec 2021 02:24:57 +0100
Message-ID: <CACRpkdYO-hgEKsra-+qPq=apSqRBHDnzfP6YYLp6wGb++XEsNA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pinctrl: Add driver for Sunplus SP7021
To:     Wells Lu <wellslutw@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wells.lu@sunplus.com,
        dvorkin@tibbo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wells,

this is improving! Keep working on this driver. I now naturally have
more comments :)

On Tue, Dec 7, 2021 at 5:17 AM Wells Lu <wellslutw@gmail.com> wrote:

> +static void sppctl_func_set(struct sppctl_pdata *pctl, u8 func, u8 val)
> +{
> +       u32 reg, offset;
> +
> +       /* Note that upper 16-bit word is mask
> +        * and lower 16-bit word is value.
> +        * Enable mask before write.
> +        */
> +       reg = 0x007f0000 | val; /* Set value and enable mask. */

Define these types of masks and use them like this:

#include <linux/bits.h>

#define SPPCTL_FUNC_MASK GENMASK(22, 16)

Also switch the order with the mask to the right please:

reg = val & SPPCTL_FUNC_MASK;

> +       if (func & 1)

I would write

#define SSPCTL_FUNC_FLAG BIT(0)

if (func & SSPCTL_FUNC_FLAG)

Use the name that bit has in your documentation for the
define so we know what is going on.

> +               reg <<= 8;

Likewise

#define SSPCTL_FUNC_UPPER_SHIFT 8

reg <<= SSPCTL_FUNC_UPPER_SHIFT;


Can also be a comment. The general idea is to break out as many
of these magic numbers as possible to #defines and give them
some names from the reference manual, so we understand them
instead of the numbers being magic.

> +       /* Convert function # to register offset. */
> +       offset = func & ~1;

Step 1 write:
offset = func & GENMASK(31, 1);

> +       offset <<= 1;

I would write:
offset *= 2;
because we are dealing with an offset and not an arithmetic
operation. It will be the same to the compiler.

But the best is to just merge all this and write (if I'm not wrong):

#include <linux/bitfield.h>

/*
 * Bit 1 .. 31 gives the function, index this into a 32-bit offset by
* multiplying by four to find the register.
 */
offset = FIELD_GET(GENMASK(31, 1), func);
offset *= 4;

This gets pretty clear. We see that we remove BIT(0) and use the
rest as offset index and there are four bytes per register.

(Beware of bugs in my pseudocode, check it!)

> +static u8 sppctl_func_get(struct sppctl_pdata *pctl, u8 func)
> +{
> +       u32 reg, offset;
> +       u8 val;
> +
> +       /* Convert function # to register offset. */
> +       offset = func & ~1;
> +       offset <<= 1;

Same comments.

> +       reg = readl(pctl->moon2_base + offset);
> +       if (func & 1)
> +               val = reg >> 8;
> +       else
> +               val = reg;
> +       val &= 0x7f;

#define SSPCTL_*_MASK for this 0x7f so we understand it.

> +static void sppctl_gmx_set(struct sppctl_pdata *pctl, u8 reg_off, u8 bit_off, u8 bit_sz,
> +                          u8 val)
> +{
> +       u32 mask, reg;
> +
> +       /* Note that upper 16-bit word is mask
> +        * and lower 16-bit word is value.
> +        * Enable mask before write.
> +        */
> +       mask = ~(~0 << bit_sz);
> +       reg = (mask << 16) | (val & mask);
> +       reg <<= bit_off;

Please familiarize yourself with <linux/bitfield.h> and use things like
FIELD_PREP() for this (I think, atleast).

> +static int sppctl_first_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
> +       u32 reg;
> +
> +       reg = readl(spp_gchip->first_base + SPPCTL_GPIO_OFF_FIRST + R32_ROF(offset));

So R32_ROF() is register offset.

> +
> +       dev_dbg(chip->parent, "%s(%u): addr = %p, reg = %08x, val = %d\n",
> +               __func__, offset, spp_gchip->first_base + SPPCTL_GPIO_OFF_FIRST +
> +               R32_ROF(offset), reg, (int)R32_VAL(reg, R32_BOF(offset)));
> +
> +       return R32_VAL(reg, R32_BOF(offset));

And R32_BOF is register bit offset.

I think these macros just make it hard to read because the reader has to
go to another file and look it up and then figure out what does ROF and
BOF actually mean (no explanation given).

I would just inline the stuff.

u32 reg = (offset / 32) * 4;
u32 bit = offset % 32;

reg = readl(spp_gchip->first_base + SPPCTL_GPIO_OFF_FIRST + reg);

// Some debug code

return !!(reg & BIT(bit));

> +static void sppctl_gpio_output_inv_set(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
> +       u32 reg;
> +
> +       /* Upper 16-bit word is mask. Lower 16-bit word is value. */
> +       reg = (BIT(R16_BOF(offset)) << 16) | BIT(R16_BOF(offset));
> +       writel(reg, spp_gchip->gpioxt2_base + SPPCTL_GPIO_OFF_OINV + R16_ROF(offset));
> +}

Same comments about the BOF and ROF.

This layout with "mask and value" in registers needs to be explained
somewhere it looks complex. I don't understand why a machine register
contains a mask for example.

> +static int stpctl_set_mux(struct pinctrl_dev *pctldev, unsigned int func_selector,
> +                         unsigned int group_selector)
> +{
> +       const struct sppctl_func *f = &sppctl_list_funcs[func_selector];
> +       struct sppctl_pdata *pctl = pinctrl_dev_get_drvdata(pctldev);
> +       struct grp2fp_map g2fpm = pctl->g2fp_maps[group_selector];
> +       int i = -1, j = -1;

Please do not initialize loop variable i to -1, just declare it.

> +       dev_dbg(pctldev->dev, "%s(func: %d, grp: %d)\n", __func__,
> +               func_selector, group_selector);
> +
> +       switch (f->freg) {
> +       case f_off_0:   /* GPIO. detouch from all funcs - ? */
> +               for (i = 0; i < sppctl_list_funcs_sz; i++) {
> +                       if (sppctl_list_funcs[i].freg != f_off_m)
> +                               continue;
> +                       j++;

Insert a comment that j is set to -1 so this will be zero here after the first
iteration.

> +                       if (sppctl_func_get(pctl, j) != group_selector)
> +                               continue;
> +                       sppctl_func_set(pctl, j, 0);
> +               }
> +               break;
> +
> +       case f_off_m:   /* Mux */
> +               sppctl_first_master_set(&pctl->spp_gchip->chip, group_selector,
> +                                       mux_f_mux, mux_m_keep);
> +               sppctl_func_set(pctl, func_selector - 2, (group_selector == 0) ?
> +                               group_selector : group_selector - 7);

-2 and -7? Why? Add some comments or maybe #define these
constants?

> +static int stpctl_gpio_request_enable(struct pinctrl_dev *pctldev,
> +                                     struct pinctrl_gpio_range *range, unsigned int offset)
> +{
> +       struct sppctl_pdata *pctl = pinctrl_dev_get_drvdata(pctldev);
> +       struct pin_desc *pdesc;
> +       int g_f, g_m;
> +
> +       dev_dbg(pctldev->dev, "%s(%d)\n", __func__, offset);
> +
> +       g_f = sppctl_first_get(&pctl->spp_gchip->chip, offset);
> +       g_m = sppctl_master_get(&pctl->spp_gchip->chip, offset);
> +       if (g_f == mux_f_gpio && g_m == mux_m_gpio)
> +               return 0;
> +
> +       pdesc = pin_desc_get(pctldev, offset);
> +       if (pdesc->mux_owner)
> +               return -EACCES;

Do not reimplement the pinmux core please.

What you want to achieve here is "strict pinmux", i.e. setting the field
"strict" in struct pinmux_ops to true. Then you can just delete this
check.

> +static const struct pinmux_ops sppctl_pinmux_ops = {
> +       .request             = stpctl_request,
> +       .free                = stpctl_free,

These are just set to empty functions. Delete these entries
and the empty functions.

> +       .get_functions_count = stpctl_get_functions_count,
> +       .get_function_name   = stpctl_get_function_name,
> +       .get_function_groups = stpctl_get_function_groups,
> +       .set_mux             = stpctl_set_mux,
> +       .gpio_request_enable = stpctl_gpio_request_enable,
> +       .gpio_disable_free   = stpctl_gpio_disable_free,
> +       .gpio_set_direction  = stpctl_gpio_set_direction,
> +       .strict              = 1

Use "true" rather than 1. (And do not reimplement the check.)

> +static int sppctl_remove(struct platform_device *pdev)
> +{
> +       struct sppctl_pdata *sppctl = pdev->dev.platform_data;
> +
> +       devm_pinctrl_unregister(&pdev->dev, sppctl->pctl_dev);

This defies the idea with devm_* calls. Drop remove() entirely because
devm_ allocated resources go away by themselves.

> +++ b/drivers/pinctrl/sunplus/sppctl.h
(...)
> +/* (/16)*4 */
> +#define R16_ROF(r)             (((r) >> 4) << 2)
> +#define R16_BOF(r)             ((r) % 16)
> +/* (/32)*4 */
> +#define R32_ROF(r)             (((r) >> 5) << 2)
> +#define R32_BOF(r)             ((r) % 32)

As mentioned I prefer explicit inlined code for these.
The bit shifting here makes it really hard to know what is going
on, the compiler will get it right if you use the right types
and just write (n / 32) * 4. Please do not try to help the compiler
optimizing it just leads to code that is hard to read.

> +#define R32_VAL(r, boff)       (((r) >> (boff)) & BIT(0))

To check the value of a certain bit use this pattern:

if (val & BIT(n))

To return a boolean clamped bit (return 0/1) do this idiom:

return !!(val & BIT(n));

Other than these things I didn't notice anything more this
time, but I might find even more stuff, but hey it's getting there!

Yours,
Linus Walleij
