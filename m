Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D45756D110
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 21:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiGJTgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 15:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJTgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 15:36:09 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD19FD3F;
        Sun, 10 Jul 2022 12:36:04 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31c8a1e9e33so30991997b3.5;
        Sun, 10 Jul 2022 12:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DDlzROSP+hLdZdhIDP/G2RbiC9lg3jh16srwYs9WIwc=;
        b=kLp/sRUeoS1dUABnqCt+nmI4wO5z+ggmGJjM03c79RZSA2VAXW1rm7+uJQhRG5KZux
         W6oQR72QcF5uonSd0yFnzsbk573kcwonCocetR5AD9yxZptaAPwDpwgvInjEAw38kRNu
         8ABgYRXsYSoUVd6Gtl4dCpdH3xv8Ozz5px2d5xqv82+mApEFYxj+NatvRXfYH5T4f8zy
         Bl+PjSNvHe+gCOxbIEWa9g0inBLs9v0EBZWd1l8voewIoPS5afieT9noJgI0V5YNTlt3
         EPqT3rULNwzENfIfhgZBO2dI9NMWmReF2mEQxs1xpTw0L6R4ghuTuI63Tlk1WQu1XDUw
         HbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DDlzROSP+hLdZdhIDP/G2RbiC9lg3jh16srwYs9WIwc=;
        b=iTq6jx4jH1vTx4cjIRZ+1qf+XRG3FJpXYRTzyzHbpcbTi75m6jB08A1u+rn4p2N8JO
         A6UW2DsH8Gg5PkPkKFpnc5oQkiMZXg86spQL6rUV22aawLM3admgE23vG6Ko21LA5Tty
         yjvsNXBp3I48rPKII2nkf5ULiKxNCqnqTchxRRgT22UICR+8cRlPO8Xleu7QUarWuiGB
         tB6IkPsvMx7tXX2uErqYisB4ZTi/XU1AzQLJUrxEQhewB7n16W9c89tlbIx/1QBfQCjH
         RUUfC8UHMsVm/zuceWjR7Pw63L4xnd+W3h9bmdkvwV/QLzEl34v13Frx4SIXrYdFVcUf
         P3ng==
X-Gm-Message-State: AJIora/2my6Y51wgSkhltTO3C6qcZE+oeTKDxkAM5rq07riGnCcnzbsP
        GFI9pMpSLJS8ZoK1KyBVg2m6oYQYvfHw0gi3Tn1Xbv2pDNMhRw==
X-Google-Smtp-Source: AGRyM1v6oj0UlL14184mVGQoUuOk6eSxcVNZ7nVg6e9JAU2Rk2lhF94QaIBfk+TENEYz+rgiWvcq8OPLwRXAyEiC2HU=
X-Received: by 2002:a81:468b:0:b0:318:4cac:6576 with SMTP id
 t133-20020a81468b000000b003184cac6576mr15815355ywa.277.1657481762818; Sun, 10
 Jul 2022 12:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220710102110.39748-1-tmaimon77@gmail.com> <20220710102110.39748-3-tmaimon77@gmail.com>
In-Reply-To: <20220710102110.39748-3-tmaimon77@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 10 Jul 2022 21:35:25 +0200
Message-ID: <CAHp75VdaT8WjoHYgmUY+mKVaUivLGGeaRJAkwfRjHspPAmw_XQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] pinctrl: nuvoton: add NPCM8XX pinctrl and GPIO driver
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        zhengbin13@huawei.com, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2022 at 12:44 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Add pinctrl and GPIO controller driver support to Arbel BMC NPCM8XX SoC.
>
> Arbel BMC NPCM8XX pinctrl driver based on Poleg NPCM7XX, except the
> pin mux mapping difference the NPCM8XX GPIO supports adjust debounce
> period time.

Below my comments from a very brief review.

...

Looking at the length of it, and noticing some debug prints I believe
you may reduce the LoC amount by ~5-10% easily, starting from removing
debug prints (like in IRQ set type callback). Also some lines look
split by two where it's fine to have at one (with container_of() in
them, for example). Besides that read the latest examples on how to
provide constant IRQ chip description and what the proper IRQ data
accessors should be used.
Additionally pay attention to the headers the driver uses, for example
it misses bits.h (or bitops.h depending on the code, I haven't looked
deeply).

...

> +#define DRIVE_STRENGTH_MASK            0x0000FF00

Why not GENMASK()?

...

> +#define DSLO(x)                (((x) >> DRIVE_STRENGTH_LO_SHIFT) & 0xF)
> +#define DSHI(x)                (((x) >> DRIVE_STRENGTH_HI_SHIFT) & 0xF)

Ditto.

...

> +#define GPI            0x1 /* Not GPO */
> +#define GPO            0x2 /* Not GPI */
> +#define SLEW           0x4 /* Has Slew Control, NPCM8XX_GP_N_OSRC */
> +#define SLEWLPC                0x8 /* Has Slew Control, SRCNT.3 */

Why not BIT(x) for them?

...

> +                               regmap_update_bits(gcr_regmap, cfg->reg0,
> +                                                  BIT(cfg->bit0),
> +                                                  !!(cfg->fn0 == mode) ?
> +                                                  BIT(cfg->bit0) : 0);

What the purpose of '!!(x)' in all similar lines? Why wouldn't 'x' simply work?

...

> +       if (pincfg[pin].flag & SLEWLPC) {
> +               switch (arg) {
> +               case 0:
> +                       regmap_update_bits(gcr_regmap, NPCM8XX_GCR_SRCNT,
> +                                          SRCNT_ESPI, 0);
> +                       return 0;
> +               case 1:
> +                       regmap_update_bits(gcr_regmap, NPCM8XX_GCR_SRCNT,
> +                                          SRCNT_ESPI, SRCNT_ESPI);
> +                       return 0;
> +               default:
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       return -EINVAL;

Why not to use usual pattern, i.e.

  if (error_condition)
    return -EINVAL;

here and everywhere in the similar cases?

...

> +               val = ioread32(bank->base + NPCM8XX_GP_N_ODSC)
> +               & pinmask;

What was happened to indentation? Check entire file for indentation to be okay.

...

> +       int v;
> +       struct npcm8xx_gpio *bank =
> +               &npcm->gpio_bank[pin / NPCM8XX_GPIO_PER_BANK];
> +       int gpio = BIT(pin % bank->gc.ngpio);

Keep it ordered in reversed xmas tree manner.

...

> +       if (DSLO(v) == nval) {
> +               dev_dbg(bank->gc.parent,
> +                       "setting pin %d to low strength [%d]\n", pin, nval);
> +               npcm_gpio_clr(&bank->gc, bank->base + NPCM8XX_GP_N_ODSC, gpio);
> +               return 0;
> +       } else if (DSHI(v) == nval) {

Redundant 'else'. Check entire file for the similar pattern and drop redundancy.

> +               dev_dbg(bank->gc.parent,
> +                       "setting pin %d to high strength [%d]\n", pin, nval);
> +               npcm_gpio_set(&bank->gc, bank->base + NPCM8XX_GP_N_ODSC, gpio);
> +               return 0;
> +       }

...

> +static void npcm8xx_pin_dbg_show(struct pinctrl_dev *pctldev,
> +                                struct seq_file *s, unsigned int offset)
> +{
> +       seq_printf(s, "pinctrl_ops.dbg: %d", offset);
> +}

Not sure it brings any additional information to what pin control core
issues on debug.

...

> +       dev_dbg(npcm->dev, "group size: %d\n", (int)ARRAY_SIZE(npcm8xx_groups));

Drop this noise. It's production. Or not? If not, why bother with
submitting not yet ready material?

...

> +                       } else if ((nanosecs > 1640) && (nanosecs <= 2280)) {
> +                               iowrite32(0x20, bank->base + NPCM8XX_GP_N_DBNCP0 + (i * 4));
> +                       } else if ((nanosecs > 2280) && (nanosecs <= 2700)) {
> +                               iowrite32(0x30, bank->base + NPCM8XX_GP_N_DBNCP0 + (i * 4));
> +                       } else if ((nanosecs > 2700) && (nanosecs <= 2856)) {
> +                               iowrite32(0x40, bank->base + NPCM8XX_GP_N_DBNCP0 + (i * 4));
> +                       } else if ((nanosecs > 2856) && (nanosecs <= 3496)) {
> +                               iowrite32(0x50, bank->base + NPCM8XX_GP_N_DBNCP0 + (i * 4));
> +                       } else if ((nanosecs > 3496) && (nanosecs <= 4136)) {
> +                               iowrite32(0x60, bank->base + NPCM8XX_GP_N_DBNCP0 + (i * 4));
> +                       } else if ((nanosecs > 4136) && (nanosecs <= 5025)) {
> +                               iowrite32(0x70, bank->base + NPCM8XX_GP_N_DBNCP0 + (i * 4));

With switch-case with ranges it will be much more visible what's going
on. Also think about it, maybe you can use some formula instead? Or
table (array of integers) approach where index will show the lowest
range value.

...

> +               struct device_node *np = to_of_node(child);

Why?!

> +               ret = of_address_to_resource(np, 0, &res);
> +               if (ret < 0) {
> +                       dev_err(dev, "Resource fail for GPIO bank %u\n", id);
> +                       return ret;
> +               }
> +
> +               pctrl->gpio_bank[id].base = ioremap(res.start, resource_size(&res));

fwnode_iomap()

...

> +               if (ret) {
> +                       dev_err(dev, "bgpio_init() failed\n");
> +                       return ret;
> +               }

Use

  return dev_err_probe(...);

In ->probe() and satellite functions.

...

> +               ret = irq_of_parse_and_map(np, 0);

fwnode_irq_get()

> +               if (!ret) {
> +                       dev_err(dev, "No IRQ for GPIO bank %u\n", id);
> +                       return -EINVAL;
> +               }

...

> +               girq->num_parents = 1;
> +               girq->parents = devm_kcalloc(pctrl->dev, 1,

Replace 1 with girq->num_parents

> +                                            sizeof(*girq->parents),
> +                                            GFP_KERNEL);
> +               if (!girq->parents) {
> +                       ret = -ENOMEM;
> +                       goto err_register;
> +               }

...

> +               ret = gpiochip_add_pin_range(&pctrl->gpio_bank[id].gc,
> +                                            dev_name(pctrl->dev),
> +                                            pctrl->gpio_bank[id].pinctrl_id,
> +                                            pctrl->gpio_bank[id].gc.base,
> +                                            pctrl->gpio_bank[id].gc.ngpio);
> +               if (ret < 0) {
> +                       dev_err(pctrl->dev, "Failed to add GPIO bank %u\n", id);
> +                       gpiochip_remove(&pctrl->gpio_bank[id].gc);
> +                       goto err_register;
> +               }
> +       }

We have a callback for ranges, can you use it?

...

> +err_register:
> +       for (; id > 0; id--)

while(id--)

> +               gpiochip_remove(&pctrl->gpio_bank[id - 1].gc);

But why not devm_gpiochip_add_... in the first place?

...

> +       dev_set_drvdata(&pdev->dev, pctrl);

platform_set_drv_data() ?

...

> +static const struct of_device_id npcm8xx_pinctrl_match[] = {
> +       { .compatible = "nuvoton,npcm845-pinctrl" },
> +       { },

No comma for terminator entry.

> +};

-- 
With Best Regards,
Andy Shevchenko
