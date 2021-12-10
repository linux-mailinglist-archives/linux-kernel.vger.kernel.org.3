Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E514708E3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245420AbhLJShP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245441AbhLJShB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:37:01 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15576C0617A2;
        Fri, 10 Dec 2021 10:33:26 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso10444398otf.12;
        Fri, 10 Dec 2021 10:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d9uoOxSMTWDlxAEU1Us/XLZeytHBLVmaOsYhhwxo6vM=;
        b=n9PNZo84vs/grLyXMo8u5AInKdAFTqYRIczkqWbY0MUama8OyBjbmCQhYZoPcIBNUj
         ja9wsIb15N1/K3Qb0nMFHU8f73YTULQ7+3Y2VDH6DMK3ZNHoWwrJ/ei/wEwLop43T8R4
         ovRTBTJW0lcbGyM3fAdPvWM9C3Plne0+UrUVGqwtY4Oni0wF3J06WyaiiqJfWPmzamNw
         +zCX5UMPIrJakg73TELCJBh4/pGe8EshXXI+aLoN55FceJvYPvH/UZYaKDOT3DLNxZkk
         a47cSo0LzWbyvOKsZhTFZdxYejJx1+45gwteUUX4Q8wHBshLGcwDUif+s1/TyCv3TU+3
         MjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d9uoOxSMTWDlxAEU1Us/XLZeytHBLVmaOsYhhwxo6vM=;
        b=LshH5JypMxTSW9k0dTjwjzxZ7r5P7xV7SvHgu0oMBnTytWPJPgvT96EvWXWuAxIaP5
         JeIetbDSmMFYeT1NirxwIegj2jRPl4HSv41sdxbNw7fgTM2CTBfxDbEFfbAFSPRxhnYN
         US4oUXHBneR9y1U7KJp8iWs5cY31CIapZ88/IvEmliBROew83zzJi0ETc5p8afhbBceC
         1Eq0W/D0mdYkKuCyfncHVNhrFRixkMSun6adqXPgJzJZQRlhxihkknGsH3y/00I/xMMK
         tO03kpH0xmEVtvEWWZCFQMBlGcbQ7TFK+qdK5K+uuFlt2MU55RYyT99KHtju8XBRt3px
         +sDQ==
X-Gm-Message-State: AOAM530KQD2+qevf7uI+ZFoQHSXYuH8m6FFsx4xJsmeaaO7Wr0b0g23k
        slu32rBY7pU3L0p9YVzNETkEdwlSfRpUZ4k98QU=
X-Google-Smtp-Source: ABdhPJyNcVTnMJjZ2LJ7UDK3StoiPvKpe+CkcLm57790DXCYWAuOLrlY9ROMk+UhBbEVvjr9rhDZqWPVNMgzFAI1KzE=
X-Received: by 2002:a05:6830:601:: with SMTP id w1mr12156578oti.267.1639161205212;
 Fri, 10 Dec 2021 10:33:25 -0800 (PST)
MIME-Version: 1.0
References: <1638850665-9474-1-git-send-email-wellslutw@gmail.com>
 <1638850665-9474-3-git-send-email-wellslutw@gmail.com> <CACRpkdYO-hgEKsra-+qPq=apSqRBHDnzfP6YYLp6wGb++XEsNA@mail.gmail.com>
In-Reply-To: <CACRpkdYO-hgEKsra-+qPq=apSqRBHDnzfP6YYLp6wGb++XEsNA@mail.gmail.com>
From:   =?UTF-8?B?5ZGC6Iqz6aiw?= <wellslutw@gmail.com>
Date:   Sat, 11 Dec 2021 02:33:14 +0800
Message-ID: <CAFnkrsn4_asdqgrBcEtuPcWjCN0+kZD3y_zVAV9D+ZHxjFpybw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pinctrl: Add driver for Sunplus SP7021
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Wells Lu <wells.lu@sunplus.com>,
        Dvorkin Dmitry <dvorkin@tibbo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resend the email because it was rejected due to wrong format!

Hi Linus,

Thank you very much for your review.

Please see my answers below:

> Hi Wells,
>
> this is improving! Keep working on this driver. I now naturally have
> more comments :)
>
> On Tue, Dec 7, 2021 at 5:17 AM Wells Lu <wellslutw@gmail.com> wrote:
>
> > +static void sppctl_func_set(struct sppctl_pdata *pctl, u8 func, u8 val)
> > +{
> > +       u32 reg, offset;
> > +
> > +       /* Note that upper 16-bit word is mask
> > +        * and lower 16-bit word is value.
> > +        * Enable mask before write.
> > +        */
> > +       reg = 0x007f0000 | val; /* Set value and enable mask. */
>
> Define these types of masks and use them like this:
>
> #include <linux/bits.h>
>
> #define SPPCTL_FUNC_MASK GENMASK(22, 16)
>
> Also switch the order with the mask to the right please:
>
> reg = val & SPPCTL_FUNC_MASK;

Yes, I'll modify code next patch.


> > +       if (func & 1)
>
> I would write
>
> #define SSPCTL_FUNC_FLAG BIT(0)
>
> if (func & SSPCTL_FUNC_FLAG)
>
> Use the name that bit has in your documentation for the
> define so we know what is going on.

Actually, 'if (func & 1)' is not used to test bit 0,
but test 'func' is an odd number or not.
If 'func' is even number, control-field is at bit 6 ~ 0.
Its corresponding mask-field is at bit 22 ~ 16.
If 'func' is odd number, control-field is at bit 14 ~ 8.
Its corresponding mask-field is at bit 30 ~ 24.

Control and mask fields of 'func' are arranged as shown
below:

func # | register control-field  mask-field
-------+------------------------------------
   0   | reg[0]     ( 6:0)        (22 :  6)
   1   | reg[0]     (14:8)        (30 : 24)
   2   | reg[1]     ( 6:0)        (22 :  6)
   3   | reg[1]     (14:8)        (30 : 24)

> > +               reg <<= 8;
>
> Likewise
>
> #define SSPCTL_FUNC_UPPER_SHIFT 8
>
> reg <<= SSPCTL_FUNC_UPPER_SHIFT;
> Can also be a comment. The general idea is to break out as many
> of these magic numbers as possible to #defines and give them
> some names from the reference manual, so we understand them
> instead of the numbers being magic.

Yes, I'll modify codes, add defines and more comments next patch.


> > +       /* Convert function # to register offset. */
> > +       offset = func & ~1;
>
> Step 1 write:
> offset = func & GENMASK(31, 1);
>
> > +       offset <<= 1;
>
> I would write:
> offset *= 2;
> because we are dealing with an offset and not an arithmetic
> operation. It will be the same to the compiler.
>
> But the best is to just merge all this and write (if I'm not wrong):
>
> #include <linux/bitfield.h>
>
> /*
>  * Bit 1 .. 31 gives the function, index this into a 32-bit offset by
> * multiplying by four to find the register.
>  */
> offset = FIELD_GET(GENMASK(31, 1), func);
> offset *= 4;
>
> This gets pretty clear. We see that we remove BIT(0) and use the
> rest as offset index and there are four bytes per register.
>
> (Beware of bugs in my pseudo code, check it!)

Thank you for example code!
Yes, I will use BIT, GENMASK, FIELD_GET, and FIELD_PREP
macros next patch.


> > +static u8 sppctl_func_get(struct sppctl_pdata *pctl, u8 func)
> > +{
> > +       u32 reg, offset;
> > +       u8 val;
> > +
> > +       /* Convert function # to register offset. */
> > +       offset = func & ~1;
> > +       offset <<= 1;
>
> Same comments.

Yes, I got it. I'll modify codes next patch.


> > +       reg = readl(pctl->moon2_base + offset);
> > +       if (func & 1)
> > +               val = reg >> 8;
> > +       else
> > +               val = reg;
> > +       val &= 0x7f;
>
> #define SSPCTL_*_MASK for this 0x7f so we understand it.

Yes, I'll do it next patch.


> > +static void sppctl_gmx_set(struct sppctl_pdata *pctl, u8 reg_off, u8 bit_off, u8 bit_sz,
> > +                          u8 val)
> > +{
> > +       u32 mask, reg;
> > +
> > +       /* Note that upper 16-bit word is mask
> > +        * and lower 16-bit word is value.
> > +        * Enable mask before write.
> > +        */
> > +       mask = ~(~0 << bit_sz);
> > +       reg = (mask << 16) | (val & mask);
> > +       reg <<= bit_off;
>
> Please familiarize yourself with <linux/bitfield.h> and use things like
> FIELD_PREP() for this (I think, at least).

Yes, I will use BIT, GENMASK, FIELD_GET, and FIELD_PREP
macros next patch.

> > +static int sppctl_first_get(struct gpio_chip *chip, unsigned int offset)
> > +{
> > +       struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
> > +       u32 reg;
> > +
> > +       reg = readl(spp_gchip->first_base + SPPCTL_GPIO_OFF_FIRST + R32_ROF(offset));
>
> So R32_ROF() is register offset.

Yes, it converts 'offset' to register offset (w.r.t. base register)

R32_ROF() is for 32-bit width registers
R16_ROF() is for 16-bit width registers (higher 16-bit of the register is mask).


> > +
> > +       dev_dbg(chip->parent, "%s(%u): addr = %p, reg = %08x, val = %d\n",
> > +               __func__, offset, spp_gchip->first_base + SPPCTL_GPIO_OFF_FIRST +
> > +               R32_ROF(offset), reg, (int)R32_VAL(reg, R32_BOF(offset)));
> > +
> > +       return R32_VAL(reg, R32_BOF(offset));
>
> And R32_BOF is register bit offset.
>
> I think these macros just make it hard to read because the reader has to
> go to another file and look it up and then figure out what does ROF and
> BOF actually mean (no explanation given).
>
> I would just inline the stuff.
>
> u32 reg = (offset / 32) * 4;
> u32 bit = offset % 32;
>
> reg = readl(spp_gchip->first_base + SPPCTL_GPIO_OFF_FIRST + reg);
>
> // Some debug code
>
> return !!(reg & BIT(bit));

Yes, I'll modify codes to follow your suggestions next patch.


> > +static void sppctl_gpio_output_inv_set(struct gpio_chip *chip, unsigned int offset)
> > +{
> > +       struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
> > +       u32 reg;
> > +
> > +       /* Upper 16-bit word is mask. Lower 16-bit word is value. */
> > +       reg = (BIT(R16_BOF(offset)) << 16) | BIT(R16_BOF(offset));
> > +       writel(reg, spp_gchip->gpioxt2_base + SPPCTL_GPIO_OFF_OINV + R16_ROF(offset));
> > +}
>
> Same comments about the BOF and ROF.
>
> This layout with "mask and value" in registers needs to be explained
> somewhere it looks complex. I don't understand why a machine register
> contains a mask for example.

This is a hardware mechanism for protecting some important registers from
being overwritten accidentally. The corresponding mask bit should be set
first and then the control-bits or fields can be written. The design is
originally requested from car makers.


> > +static int stpctl_set_mux(struct pinctrl_dev *pctldev, unsigned int func_selector,
> > +                         unsigned int group_selector)
> > +{
> > +       const struct sppctl_func *f = &sppctl_list_funcs[func_selector];
> > +       struct sppctl_pdata *pctl = pinctrl_dev_get_drvdata(pctldev);
> > +       struct grp2fp_map g2fpm = pctl->g2fp_maps[group_selector];
> > +       int i = -1, j = -1;
>
> Please do not initialize loop variable i to -1, just declare it.

Yes, I'll remove the initialization for loop variables next patch


> > +       dev_dbg(pctldev->dev, "%s(func: %d, grp: %d)\n", __func__,
> > +               func_selector, group_selector);
> > +
> > +       switch (f->freg) {
> > +       case f_off_0:   /* GPIO. detouch from all funcs - ? */
> > +               for (i = 0; i < sppctl_list_funcs_sz; i++) {
> > +                       if (sppctl_list_funcs[i].freg != f_off_m)
> > +                               continue;
> > +                       j++;
>
> Insert a comment that j is set to -1 so this will be zero here after the first
> iteration.

Yes, I'll add comments next patch.


> > +                       if (sppctl_func_get(pctl, j) != group_selector)
> > +                               continue;
> > +                       sppctl_func_set(pctl, j, 0);
> > +               }
> > +               break;
> > +
> > +       case f_off_m:   /* Mux */
> > +               sppctl_first_master_set(&pctl->spp_gchip->chip, group_selector,
> > +                                       mux_f_mux, mux_m_keep);
> > +               sppctl_func_set(pctl, func_selector - 2, (group_selector == 0) ?
> > +                               group_selector : group_selector - 7);
>
> -2 and -7? Why? Add some comments or maybe #define these
> constants?

Yes, I'll defines and add some comments for the magic numbers
next patch.


> > +static int stpctl_gpio_request_enable(struct pinctrl_dev *pctldev,
> > +                                     struct pinctrl_gpio_range *range, unsigned int offset)
> > +{
> > +       struct sppctl_pdata *pctl = pinctrl_dev_get_drvdata(pctldev);
> > +       struct pin_desc *pdesc;
> > +       int g_f, g_m;
> > +
> > +       dev_dbg(pctldev->dev, "%s(%d)\n", __func__, offset);
> > +
> > +       g_f = sppctl_first_get(&pctl->spp_gchip->chip, offset);
> > +       g_m = sppctl_master_get(&pctl->spp_gchip->chip, offset);
> > +       if (g_f == mux_f_gpio && g_m == mux_m_gpio)
> > +               return 0;
> > +
> > +       pdesc = pin_desc_get(pctldev, offset);
> > +       if (pdesc->mux_owner)
> > +               return -EACCES;
>
> Do not reimplement the pinmux core please.
>
> What you want to achieve here is "strict pinmux", i.e. setting the field
> "strict" in struct pinmux_ops to true. Then you can just delete this
> check.

Yes, I'll remove the if-statement next patch.


> > +static const struct pinmux_ops sppctl_pinmux_ops = {
> > +       .request             = stpctl_request,
> > +       .free                = stpctl_free,
>
> These are just set to empty functions. Delete these entries
> and the empty functions.

Yes, I'll remove all 'empty' functions next patch.


> > +       .get_functions_count = stpctl_get_functions_count,
> > +       .get_function_name   = stpctl_get_function_name,
> > +       .get_function_groups = stpctl_get_function_groups,
> > +       .set_mux             = stpctl_set_mux,
> > +       .gpio_request_enable = stpctl_gpio_request_enable,
> > +       .gpio_disable_free   = stpctl_gpio_disable_free,
> > +       .gpio_set_direction  = stpctl_gpio_set_direction,
> > +       .strict              = 1
>
> Use "true" rather than 1. (And do not reimplement the check.)

Yes, I'll do it next patch.


> > +static int sppctl_remove(struct platform_device *pdev)
> > +{
> > +       struct sppctl_pdata *sppctl = pdev->dev.platform_data;
> > +
> > +       devm_pinctrl_unregister(&pdev->dev, sppctl->pctl_dev);
>
> This defies the idea with devm_* calls. Drop remove() entirely because
> devm_ allocated resources go away by themselves.

Yes, I'll remove devm_pinctrl_unregister() next patch.
Sorry for buggy code. Fortunately, pinctrl driver
will never be removed.


> > +++ b/drivers/pinctrl/sunplus/sppctl.h
> (...)
> > +/* (/16)*4 */
> > +#define R16_ROF(r)             (((r) >> 4) << 2)
> > +#define R16_BOF(r)             ((r) % 16)
> > +/* (/32)*4 */
> > +#define R32_ROF(r)             (((r) >> 5) << 2)
> > +#define R32_BOF(r)             ((r) % 32)
>
> As mentioned I prefer explicit inlined code for these.
> The bit shifting here makes it really hard to know what is going
> on, the compiler will get it right if you use the right types
> and just write (n / 32) * 4. Please do not try to help the compiler
> optimizing it just leads to code that is hard to read.
>
> > +#define R32_VAL(r, boff)       (((r) >> (boff)) & BIT(0))
>
> To check the value of a certain bit use this pattern:
>
> if (val & BIT(n))
>
> To return a boolean clamped bit (return 0/1) do this idiom:
>
> return !!(val & BIT(n));

Yes, I'll remove the four macros.
Write explicit inline code.


> Other than these things I didn't notice anything more this
> time, but I might find even more stuff, but hey it's getting there!
> Yours,
> Linus Walleij
Thanks, I'll review the whole code again and fix
the similar improper coding you pointed out.


Best regards,
Wells Lu
