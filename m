Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA09C47F3A3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 16:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhLYPdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 10:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbhLYPdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 10:33:16 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1AEC061401;
        Sat, 25 Dec 2021 07:33:15 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b13so43896806edd.8;
        Sat, 25 Dec 2021 07:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qudLBstqdxL8F/wlhAxRGZGVJahZKW4QfZRolHZD3k0=;
        b=BwEMHP4QgnTsWqJtEyu8JgfeXvgtvq0pPQQ5arh9KNR/eFLQ/4N3YXVDvlWVmMqLFe
         BQyuj3uzMHEztuVK1D9+sDLBMuXnyy7it5t3kMoaLtDYuU3TMjEzMYdzY74OfUJPlHKd
         iAHJvSRbtiuyoNy+jaReIAFdEqdvguIQd+KAnUUaSujnXxjeN0H7dOkCUgLLviajZcWi
         +XVaeSExih++V1eef0kIvI/BPlC8dGDTqOPawWfeCAtlblq3xyz83vwxilFt8fW751rL
         fQQwa/E1+bHFx4TMXSi+82z2ufSIjVvq+2XQFv/zBtDvFHpH27fqJwdomjVLSG52p+0g
         8IyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qudLBstqdxL8F/wlhAxRGZGVJahZKW4QfZRolHZD3k0=;
        b=tlvZ9H4sO2nDZiMSwOo4NlHHAdBl/lq5VyDIc54R3ZWEXBhXfn/Tk89au4kNgaHk2O
         zmi6NYyXDukcl/4cU6EW+cREmyYHNNDTQL6cCdXOAfzl4t3WuHN15+xLFCpr6MJC6DAN
         DyyB+H+0i2Hm3opT/kQ9j1/WWw7nJA4qPQ7WxoFX1HoOKAJW0uPUVA3NLprnZvPVT/cs
         LITW49xcK8jqlH7Rltcd9/6e+tnXbOy2WcnN6XDTn6XzvRjRWy0M0xWSlnaxV/ylUM9y
         Gg4i/3VbyVzxtq5S8PeGsSrZY/SYX3oloYttVNYvCCu/XTd1tHJamC7Y5R3kwIcZAIqQ
         CgrQ==
X-Gm-Message-State: AOAM533lePIuMlsCVWmZuEwUakcC+//eXyi2E4V+OHEbQ7kETcAnzk/j
        gHLT//rNG/E8tQiJfKW1u1HWcBhDHefMcjFB3Js=
X-Google-Smtp-Source: ABdhPJxVpbjOqAvBQrrcgmvjIPz2DQ7a56ITyGL7h64hsqBtl8zaPW+C/bcitGsWazSu5Rr0Bl88tS9AB45xfThXUA4=
X-Received: by 2002:a05:6402:518a:: with SMTP id q10mr7571835edd.29.1640446393737;
 Sat, 25 Dec 2021 07:33:13 -0800 (PST)
MIME-Version: 1.0
References: <1640331779-18277-1-git-send-email-wellslutw@gmail.com> <1640331779-18277-3-git-send-email-wellslutw@gmail.com>
In-Reply-To: <1640331779-18277-3-git-send-email-wellslutw@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Dec 2021 17:32:37 +0200
Message-ID: <CAHp75Vd3iMM+NteJXP_mMAyw5momk3xzp1Y2GX-YJZfFSAwo9A@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] pinctrl: Add driver for Sunplus SP7021
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

On Sat, Dec 25, 2021 at 3:44 AM Wells Lu <wellslutw@gmail.com> wrote:
>
> Add driver for Sunplus SP7021 SoC.

Thanks for an update, my comments below.

...

> +config PINCTRL_SPPCTL
> +       bool "Sunplus SP7021 PinMux and GPIO driver"

Why bool and not tristate?

> +       depends on SOC_SP7021
> +       depends on OF && HAS_IOMEM

...

> +#include <linux/of.h>
> +#include <linux/of_device.h>

> +#include <linux/pinctrl/pinconf.h>
> +#include <linux/pinctrl/pinconf-generic.h>
> +#include <linux/pinctrl/pinmux.h>

Can you move this group...

> +#include <linux/platform_device.h>
> +#include <linux/seq_file.h>
> +#include <linux/slab.h>

...to be somewhere here?

> +#include <dt-bindings/pinctrl/sppctl-sp7021.h>

...

> +/* inline functions */

Useless.

...

> +       mask = GENMASK(bit_sz - 1, 0) << (bit_off + SPPCTL_GROUP_PINMUX_MASK_SHIFT);
> +       reg = mask | (val << bit_off);

Now you may do one step forward:

       mask = GENMASK(bit_sz - 1, 0) << SPPCTL_GROUP_PINMUX_MASK_SHIFT;
       reg = (val | mask) << bit_off;

...

> +static void sppctl_first_master_set(struct gpio_chip *chip, unsigned int offset,
> +                                   enum mux_first_reg first, enum mux_master_reg master)
> +{
> +       struct sppctl_gpio_chip *spp_gchip = gpiochip_get_data(chip);
> +       u32 reg_off, bit_off, reg;
> +       int val;
> +
> +       /* FIRST register */
> +       if (first != mux_f_keep) {
> +               /*
> +                * Refer to descriptions of function sppctl_first_get()
> +                * for usage of FIRST registers.
> +                */
> +               reg_off = (offset / 32) * 4;
> +               bit_off = offset % 32;
> +
> +               reg = sppctl_first_readl(spp_gchip, reg_off);
> +               val = (reg & BIT(bit_off)) ? 1 : 0;

> +               if (first != val) {

first is enum, val is int, are you sure it's good to compare like this?

> +                       if (first == mux_f_gpio)
> +                               reg |= BIT(bit_off);
> +                       else
> +                               reg &= ~BIT(bit_off);


Since you operate against enums it's better to use switch-case.

> +                       sppctl_first_writel(spp_gchip, reg, reg_off);
> +               }
> +       }
> +
> +       /* MASTER register */
> +       if (master != mux_m_keep) {
> +               /*
> +                * Refer to descriptions of function sppctl_master_get()
> +                * for usage of MASTER registers.
> +                */
> +               reg_off = (offset / 16) * 4;
> +               bit_off = offset % 16;
> +
> +               reg = BIT(bit_off) << SPPCTL_MASTER_MASK_SHIFT;
> +               if (master == mux_m_gpio)
> +                       reg |= BIT(bit_off);
> +               sppctl_gpio_master_writel(spp_gchip, reg, reg_off);
> +       }
> +}

...

> +       reg = BIT(bit_off + SPPCTL_GPIO_MASK_SHIFT) | BIT(bit_off);

> +       reg = BIT(bit_off + SPPCTL_GPIO_MASK_SHIFT) | BIT(bit_off);

Perhaps a macro with definitive name?

...

> +       reg = BIT(bit_off + SPPCTL_GPIO_MASK_SHIFT);
> +       if (val)
> +               reg |= BIT(bit_off);

You can use it even here:

if (val)
  reg = MY_MACRO(bit_off)
else
  reg = BIT(...) // perhaps another macro

...

> +       reg = BIT(bit_off + SPPCTL_GPIO_MASK_SHIFT);

Ditto.

...

> +       reg = BIT(bit_off + SPPCTL_GPIO_MASK_SHIFT) | BIT(bit_off);

Ditto.

...

> +       reg = BIT(bit_off + SPPCTL_GPIO_MASK_SHIFT);
> +       if (val)
> +               reg |= BIT(bit_off);

Ditto.

...

> +       reg = BIT(bit_off + SPPCTL_GPIO_MASK_SHIFT);
> +       if (val)
> +               reg |= BIT(bit_off);

Ditto.

And looking into repetition, you may even have a helper which does
this conditional

static inline u32 sppctl_...()
{
  ...
  return reg;
}

...

> +       int ret = 0;

Redudant variable, return directly.

> +       switch (param) {
> +       case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> +               /*
> +                * Upper 16-bit word is mask. Lower 16-bit word is value.
> +                * Refer to descriptions of function sppctl_master_get().
> +                */
> +               reg_off = (offset / 16) * 4;
> +               bit_off = offset % 16;
> +               reg = BIT(bit_off + SPPCTL_GPIO_MASK_SHIFT) | BIT(bit_off);

As I commented above use helper function which takes offset as input
and returns you reg and reg_off.

> +               sppctl_gpio_od_writel(spp_gchip, reg, reg_off);
> +               break;
> +
> +       case PIN_CONFIG_INPUT_ENABLE:
> +               break;
> +
> +       case PIN_CONFIG_OUTPUT:
> +               ret = sppctl_gpio_direction_output(chip, offset, 0);
> +               break;
> +
> +       case PIN_CONFIG_PERSIST_STATE:
> +               ret = -ENOTSUPP;
> +               break;
> +
> +       default:
> +               ret = -EINVAL;
> +               break;
> +       }
> +
> +       return ret;
> +}

...

> +       if (!of_find_property(pdev->dev.of_node, "gpio-controller", NULL))
> +               return dev_err_probe(&pdev->dev, -EINVAL, "Not a gpio-controller!\n");

Why do you need this check for?

...

> +       gchip->can_sleep        = 0;

Besides that it's already cleared, the type here is boolean.

...

> +/* pinconf operations */

Any value of this comment?

> +static int sppctl_pin_config_get(struct pinctrl_dev *pctldev, unsigned int pin,
> +                                unsigned long *config)
> +{
> +       struct sppctl_pdata *pctl = pinctrl_dev_get_drvdata(pctldev);
> +       unsigned int param = pinconf_to_config_param(*config);

> +       unsigned int arg = 0;

Move assignment to where it actually makes sense.

> +       switch (param) {
> +       case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> +               if (!sppctl_gpio_output_od_get(&pctl->spp_gchip->chip, pin))
> +                       return -EINVAL;
> +               break;
> +
> +       case PIN_CONFIG_OUTPUT:
> +               if (!sppctl_first_get(&pctl->spp_gchip->chip, pin))
> +                       return -EINVAL;
> +               if (!sppctl_master_get(&pctl->spp_gchip->chip, pin))
> +                       return -EINVAL;
> +               if (sppctl_gpio_get_direction(&pctl->spp_gchip->chip, pin))
> +                       return -EINVAL;
> +               arg = sppctl_gpio_get(&pctl->spp_gchip->chip, pin);
> +               break;
> +
> +       default:
> +               return -EOPNOTSUPP;
> +       }
> +       *config = pinconf_to_config_packed(param, arg);
> +
> +       return 0;
> +}

...

> +       switch (f->type) {
> +       case pinmux_type_fpmx:  /* fully-pinmux */

Why do you need these comments?
Shouldn't you rather to kernel doc your enum entries?

> +               *num_groups = sppctl_pmux_list_sz;
> +               *groups = sppctl_pmux_list_s;
> +               break;
> +
> +       case pinmux_type_grp:   /* group-pinmux */
> +               if (!f->grps)
> +                       break;
> +
> +               *num_groups = f->gnum;
> +               for (i = 0; i < pctl->unq_grps_sz; i++)
> +                       if (pctl->g2fp_maps[i].f_idx == selector)
> +                               break;
> +               *groups = &pctl->unq_grps[i];
> +               break;

> +       }

> +/** sppctl_fully_pinmux_conv - Convert GPIO# to fully-pinmux control-field setting
> + *
> + * Each fully-pinmux function can be mapped to any of GPIO 8 ~ 71 by
> + * settings its control-field. Refer to following table:
> + *
> + * control-field |  GPIO
> + * --------------+--------
> + *        0      |  No map
> + *        1      |    8
> + *        2      |    9
> + *        3      |   10
> + *        :      |    :
> + *       65      |   71
> + */
> +static inline int sppctl_fully_pinmux_conv(unsigned int offset)
> +{
> +       return (offset < 8) ? 0 : offset - 7;
> +}

...

> +static const struct pinmux_ops sppctl_pinmux_ops = {
> +       .get_functions_count = sppctl_get_functions_count,
> +       .get_function_name   = sppctl_get_function_name,
> +       .get_function_groups = sppctl_get_function_groups,
> +       .set_mux             = sppctl_set_mux,
> +       .gpio_request_enable = sppctl_gpio_request_enable,

> +       .strict              = true

+ Comma.

> +};

...

> +static int sppctl_dt_node_to_map(struct pinctrl_dev *pctldev, struct device_node *np_config,
> +                                struct pinctrl_map **map, unsigned int *num_maps)
> +{
> +       struct sppctl_pdata *pctl = pinctrl_dev_get_drvdata(pctldev);
> +       int nmG = of_property_count_strings(np_config, "groups");
> +       const struct sppctl_func *f = NULL;
> +       u8 pin_num, pin_type, pin_func;
> +       struct device_node *parent;
> +       unsigned long *configs;
> +       struct property *prop;
> +       const char *s_f, *s_g;
> +
> +       const __be32 *list;
> +       u32 dt_pin, dt_fun;
> +       int i, size = 0;
> +
> +       list = of_get_property(np_config, "sunplus,pins", &size);
> +
> +       if (nmG <= 0)
> +               nmG = 0;
> +
> +       parent = of_get_parent(np_config);
> +       *num_maps = size / sizeof(*list);
> +
> +       /*
> +        * Process property:
> +        *     sunplus,pins = < u32 u32 u32 ... >;
> +        *
> +        * Each 32-bit integer defines a individual pin in which:
> +        *
> +        *   Bit 32~24: defines GPIO pin number. Its range is 0 ~ 98.
> +        *   Bit 23~16: defines types: (1) fully-pinmux pins
> +        *                             (2) IO processor pins
> +        *                             (3) digital GPIO pins
> +        *   Bit 15~8:  defines pins of peripherals (which are defined in
> +        *              'include/dt-binging/pinctrl/sppctl.h').
> +        *   Bit 7~0:   defines types or initial-state of digital GPIO pins.
> +        */
> +       for (i = 0; i < (*num_maps); i++) {
> +               dt_pin = be32_to_cpu(list[i]);
> +               pin_num = FIELD_GET(GENMASK(31, 24), dt_pin);
> +
> +               /* Check if out of range? */
> +               if (pin_num >= sppctl_pins_all_sz) {
> +                       dev_err(pctldev->dev, "Invalid pin property at index %d (0x%08x)\n",
> +                               i, dt_pin);
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       *map = kcalloc(*num_maps + nmG, sizeof(**map), GFP_KERNEL);
> +       for (i = 0; i < (*num_maps); i++) {
> +               dt_pin = be32_to_cpu(list[i]);
> +               pin_num = FIELD_GET(GENMASK(31, 24), dt_pin);
> +               pin_type = FIELD_GET(GENMASK(23, 16), dt_pin);
> +               pin_func = FIELD_GET(GENMASK(15, 8), dt_pin);
> +               (*map)[i].name = parent->name;
> +
> +               if (pin_type == SPPCTL_PCTL_G_GPIO) {
> +                       /* A digital GPIO pin */
> +                       (*map)[i].type = PIN_MAP_TYPE_CONFIGS_PIN;
> +                       (*map)[i].data.configs.num_configs = 1;
> +                       (*map)[i].data.configs.group_or_pin = pin_get_name(pctldev, pin_num);
> +                       configs = kmalloc(sizeof(*configs), GFP_KERNEL);
> +                       *configs = FIELD_GET(GENMASK(7, 0), dt_pin);
> +                       (*map)[i].data.configs.configs = configs;
> +
> +                       dev_dbg(pctldev->dev, "%s: GPIO (%s)\n",
> +                               (*map)[i].data.configs.group_or_pin,
> +                               (*configs & (SPPCTL_PCTL_L_OUT | SPPCTL_PCTL_L_OU1)) ?
> +                               "OUT" : "IN");
> +               } else if (pin_type == SPPCTL_PCTL_G_IOPP) {
> +                       /* A IO Processor (IOP) pin */
> +                       (*map)[i].type = PIN_MAP_TYPE_CONFIGS_PIN;
> +                       (*map)[i].data.configs.num_configs = 1;
> +                       (*map)[i].data.configs.group_or_pin = pin_get_name(pctldev, pin_num);
> +                       configs = kmalloc(sizeof(*configs), GFP_KERNEL);
> +                       *configs = SPPCTL_IOP_CONFIGS;
> +                       (*map)[i].data.configs.configs = configs;
> +
> +                       dev_dbg(pctldev->dev, "%s: IOP\n",
> +                               (*map)[i].data.configs.group_or_pin);
> +               } else {
> +                       /* A fully-pinmux pin */
> +                       (*map)[i].type = PIN_MAP_TYPE_MUX_GROUP;
> +                       (*map)[i].data.mux.function = sppctl_list_funcs[pin_func].name;
> +                       (*map)[i].data.mux.group = pin_get_name(pctldev, pin_num);
> +
> +                       dev_dbg(pctldev->dev, "%s: %s\n", (*map)[i].data.mux.group,
> +                               (*map)[i].data.mux.function);
> +               }
> +       }
> +
> +       /*
> +        * Process properties:
> +        *     function = "xxx";
> +        *     groups = "yyy";
> +        */
> +       if (nmG > 0 && of_property_read_string(np_config, "function", &s_f) == 0) {
> +               of_property_for_each_string(np_config, "groups", prop, s_g) {
> +                       (*map)[*num_maps].type = PIN_MAP_TYPE_MUX_GROUP;
> +                       (*map)[*num_maps].data.mux.function = s_f;
> +                       (*map)[*num_maps].data.mux.group = s_g;
> +                       (*num_maps)++;
> +
> +                       dev_dbg(pctldev->dev, "%s: %s\n", s_f, s_g);
> +               }
> +       }
> +
> +       /*
> +        * Process property:
> +        *     sunplus,zero_func = < u32 u32 u32 ...>
> +        */
> +       list = of_get_property(np_config, "sunplus,zero_func", &size);
> +       if (list) {
> +               for (i = 0; i < (size / sizeof(*list)); i++) {
> +                       dt_fun = be32_to_cpu(list[i]);
> +                       if (dt_fun >= sppctl_list_funcs_sz) {
> +                               dev_err(pctldev->dev, "Zero-func %d out of range!\n",
> +                                       dt_fun);
> +                               continue;
> +                       }
> +
> +                       f = &sppctl_list_funcs[dt_fun];
> +                       switch (f->type) {
> +                       case pinmux_type_fpmx:
> +                               sppctl_func_set(pctl, dt_fun, 0);
> +                               dev_dbg(pctldev->dev, "%s: No map\n", f->name);
> +                               break;
> +
> +                       case pinmux_type_grp:
> +                               sppctl_gmx_set(pctl, f->roff, f->boff, f->blen, 0);
> +                               dev_dbg(pctldev->dev, "%s: No map\n", f->name);
> +                               break;
> +
> +                       default:
> +                               dev_err(pctldev->dev, "Wrong zero-group: %d (%s)\n",
> +                                       dt_fun, f->name);
> +                               break;
> +                       }
> +               }
> +       }
> +
> +       of_node_put(parent);
> +       dev_dbg(pctldev->dev, "%d pins mapped\n", *num_maps);
> +       return 0;
> +}

...

> +       sppctl->g2fp_maps = devm_kcalloc(&pdev->dev, sppctl->unq_grps_sz + 1,
> +                                        sizeof(*sppctl->g2fp_maps), GFP_KERNEL);
> +       if (!sppctl->g2fp_maps)
> +               return -ENOMEM;

> +       /*
> +        * Check only product of n and size of the second devm_kcalloc()
> +        * because its size is the largest of the two.
> +        */
> +       if (unlikely(check_mul_overflow(sppctl->unq_grps_sz + 1,
> +                                       sizeof(*sppctl->g2fp_maps), &prod)))
> +               return -EINVAL;

What the point to check it after? What the point to use it with
kcalloc()? Please, do your homework, i.e. read the code which
implements that.

...

> +       struct device_node *np = of_node_get(pdev->dev.of_node);

What's the role of of_node_get()?

...

> +       /* Initialize pctl_desc */

Useless. Drop all useless comments like this from the code.

...

> +       dev_info(&pdev->dev, "SP7021 PinCtrl by Sunplus/Tibbo Tech.");

Is it useful?

...

> +#ifndef __SPPCTL_H__
> +#define __SPPCTL_H__
> +
> +#include <linux/bits.h>
> +#include <linux/gpio/driver.h>

> +#include <linux/kernel.h>
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/spinlock.h>

types.h is missed.

...

> +/** enum mux_first_reg - define modes of FIRST register accesses

Fix the multi-line comment style. You mentioned you fixed, but seems
not (not in all places).

> + *    - mux_f_mux:  Select the pin to a fully-pinmux pin
> + *    - mux_f_gpio: Select the pin to a GPIO or IOP pin
> + *    - mux_f_keep: Don't change (keep intact)
> + */
> +enum mux_first_reg {
> +       mux_f_mux = 0,          /* select fully-pinmux       */
> +       mux_f_gpio = 1,         /* select GPIO or IOP pinmux */
> +       mux_f_keep = 2,         /* keep no change            */
> +};


> +struct sppctl_gpio_chip {
> +       void __iomem *gpioxt_base;      /* MASTER, OE, OUT, IN, I_INV, O_INV, OD */
> +       void __iomem *first_base;       /* GPIO_FIRST                            */
> +
> +       struct gpio_chip chip;
> +       spinlock_t lock;                /* lock for accessing OE register        */
> +};

Why is this in the header?

...

> +/* SP7021 Pin Controller Driver.
> + * Copyright (C) Sunplus Tech / Tibbo Tech.
> + */

Multi-line comments.

I stopped here, please read my comments for previous versions and here
and try your best.

-- 
With Best Regards,
Andy Shevchenko
