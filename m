Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389275718A0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiGLLeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGLLd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:33:57 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19784F64A;
        Tue, 12 Jul 2022 04:33:55 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id t1so9903767lft.8;
        Tue, 12 Jul 2022 04:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mFS8JB0UQ6xgQkj9Rzj42NMAdqopVPu680nzosVGwF8=;
        b=B94TP6/5NYcsh1kjS6L0IQ2Cs09IyR4Fq71YX87aWaquDjhBOEIfiyqgCM3UhSmZGz
         sqwD0fQqdvgazjO18tTdQ2lJVB53oNBTdNljnhnabTc4R4bevlcj33/9wKdiSmvf+Q5u
         7FKsBFDVzOSlOJN0OSP/vQOq0HNYcn83s+xc0WazlKE4U+iGTIdI9P8Jp7/048MtG2O1
         UpVm7qC8jH7XntHlNQWmmZ5N4WZHKvaOhwMLgKgqejfh45oZ1ZIbgN8LPhd8+bfg+DJM
         j5LfIYYCzb6GTNllziEQOiqE+d33hUQ6oIZfbEIF5jDP9JLw+sXm2BMB6SDgupNqRYnB
         UiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mFS8JB0UQ6xgQkj9Rzj42NMAdqopVPu680nzosVGwF8=;
        b=uidMTXVQGAxtV/9tPOUi/IIuz2hJrlH/vDG346XEQ5Qte2Mr4hvpBtZdmhRJqwYbpl
         LS4VcPi90sHK23W0/2QXoqTKoxYojty5SzrhtEP+Sl10epjRcPUuV0C0ecpnu6E2h3MU
         9fzFY1IxAJ+8FH89UPes9CZWF2M5zRYCrwFRgoRzdP9lnKWSo9pedJLGoFs9F9ozawfl
         BK1Zsxf8SdkD6w5ljHI2mqknHAr3nYNbUJgylSpGYkMPHBxQS1si08/e8Gzwsh2LqSRP
         l8Y3eJrRFEC1Ce7wVXW3n01oImcEqAiEfSRQjYLrxKXWLE3r6dGCBi/vi8l/XXgo6eQI
         T/hQ==
X-Gm-Message-State: AJIora8XIP8csTAyD/3FAct/Rvdz+SGo2aJOVnyIlq92/WSL/ER3T5Sy
        yo9RpcJFHTqxYXhcbMS/932j+kY781pa2znpx8A=
X-Google-Smtp-Source: AGRyM1tc0SELbn9X0+KPLJzY1o8LJcXQepVQgHClsuGUcgfWG7CUoznbetwz39UD40tGDfz4VaHBvGKJHVpFokzIJmw=
X-Received: by 2002:a05:6512:3103:b0:489:cdd7:b360 with SMTP id
 n3-20020a056512310300b00489cdd7b360mr11087202lfb.111.1657625633985; Tue, 12
 Jul 2022 04:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220710102110.39748-1-tmaimon77@gmail.com> <20220710102110.39748-3-tmaimon77@gmail.com>
 <CAHp75VdaT8WjoHYgmUY+mKVaUivLGGeaRJAkwfRjHspPAmw_XQ@mail.gmail.com>
In-Reply-To: <CAHp75VdaT8WjoHYgmUY+mKVaUivLGGeaRJAkwfRjHspPAmw_XQ@mail.gmail.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 12 Jul 2022 14:33:42 +0300
Message-ID: <CAP6Zq1iQL2R67dbdQiXW_JUWrGne9xp-9yQ97vQOb4RveQE7Yw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] pinctrl: nuvoton: add NPCM8XX pinctrl and GPIO driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks for your comments

On Sun, 10 Jul 2022 at 22:36, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Sun, Jul 10, 2022 at 12:44 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
> >
> > Add pinctrl and GPIO controller driver support to Arbel BMC NPCM8XX SoC.
> >
> > Arbel BMC NPCM8XX pinctrl driver based on Poleg NPCM7XX, except the
> > pin mux mapping difference the NPCM8XX GPIO supports adjust debounce
> > period time.
>
> Below my comments from a very brief review.
>
> ...
>
> Looking at the length of it, and noticing some debug prints I believe
> you may reduce the LoC amount by ~5-10% easily, starting from removing
> debug prints (like in IRQ set type callback). Also some lines look
> split by two where it's fine to have at one (with container_of() in
> them, for example). Besides that read the latest examples on how to
> provide constant IRQ chip description and what the proper IRQ data
> accessors should be used.
> Additionally pay attention to the headers the driver uses, for example
> it misses bits.h (or bitops.h depending on the code, I haven't looked
> deeply).
I will try to reduce lines as possible
>
> ...
>
> > +#define DRIVE_STRENGTH_MASK            0x0000FF00
>
> Why not GENMASK()?
>
> ...
>
> > +#define DSLO(x)                (((x) >> DRIVE_STRENGTH_LO_SHIFT) & 0xF)
> > +#define DSHI(x)                (((x) >> DRIVE_STRENGTH_HI_SHIFT) & 0xF)
>
> Ditto.
>
> ...
>
> > +#define GPI            0x1 /* Not GPO */
> > +#define GPO            0x2 /* Not GPI */
> > +#define SLEW           0x4 /* Has Slew Control, NPCM8XX_GP_N_OSRC */
> > +#define SLEWLPC                0x8 /* Has Slew Control, SRCNT.3 */
>
> Why not BIT(x) for them?
>
> ...
>
> > +                               regmap_update_bits(gcr_regmap, cfg->reg0,
> > +                                                  BIT(cfg->bit0),
> > +                                                  !!(cfg->fn0 == mode) ?
> > +                                                  BIT(cfg->bit0) : 0);
>
> What the purpose of '!!(x)' in all similar lines? Why wouldn't 'x' simply work?
taken by mistake, 'x' will work.
>
> ...
>
> > +       if (pincfg[pin].flag & SLEWLPC) {
> > +               switch (arg) {
> > +               case 0:
> > +                       regmap_update_bits(gcr_regmap, NPCM8XX_GCR_SRCNT,
> > +                                          SRCNT_ESPI, 0);
> > +                       return 0;
> > +               case 1:
> > +                       regmap_update_bits(gcr_regmap, NPCM8XX_GCR_SRCNT,
> > +                                          SRCNT_ESPI, SRCNT_ESPI);
> > +                       return 0;
> > +               default:
> > +                       return -EINVAL;
> > +               }
> > +       }
> > +
> > +       return -EINVAL;
>
> Why not to use usual pattern, i.e.
>
>   if (error_condition)
>     return -EINVAL;
What do you mean? like if (arg>1) return -EINVAL? It just seems more readable.
>
> here and everywhere in the similar cases?
can you point me to which more cases you mean?
>
> ...
>
> > +               val = ioread32(bank->base + NPCM8XX_GP_N_ODSC)
> > +               & pinmask;
>
> What was happened to indentation? Check entire file for indentation to be okay.
Sorry, I didn't understand, could you explain the comment again?
>
> ...
>
> > +       int v;
> > +       struct npcm8xx_gpio *bank =
> > +               &npcm->gpio_bank[pin / NPCM8XX_GPIO_PER_BANK];
> > +       int gpio = BIT(pin % bank->gc.ngpio);
>
> Keep it ordered in reversed xmas tree manner.
O.K.
>
> ...
>
> > +       if (DSLO(v) == nval) {
> > +               dev_dbg(bank->gc.parent,
> > +                       "setting pin %d to low strength [%d]\n", pin, nval);
> > +               npcm_gpio_clr(&bank->gc, bank->base + NPCM8XX_GP_N_ODSC, gpio);
> > +               return 0;
> > +       } else if (DSHI(v) == nval) {
>
> Redundant 'else'. Check entire file for the similar pattern and drop redundancy.
O.K.
>
> > +               dev_dbg(bank->gc.parent,
> > +                       "setting pin %d to high strength [%d]\n", pin, nval);
> > +               npcm_gpio_set(&bank->gc, bank->base + NPCM8XX_GP_N_ODSC, gpio);
> > +               return 0;
> > +       }
>
> ...
>
> > +static void npcm8xx_pin_dbg_show(struct pinctrl_dev *pctldev,
> > +                                struct seq_file *s, unsigned int offset)
> > +{
> > +       seq_printf(s, "pinctrl_ops.dbg: %d", offset);
> > +}
>
> Not sure it brings any additional information to what pin control core
> issues on debug.
>
> ...
>
> > +       dev_dbg(npcm->dev, "group size: %d\n", (int)ARRAY_SIZE(npcm8xx_groups));
>
> Drop this noise. It's production. Or not? If not, why bother with
> submitting not yet ready material?
>
> ...
>
> > +                       } else if ((nanosecs > 1640) && (nanosecs <= 2280)) {
> > +                               iowrite32(0x20, bank->base + NPCM8XX_GP_N_DBNCP0 + (i * 4));
> > +                       } else if ((nanosecs > 2280) && (nanosecs <= 2700)) {
> > +                               iowrite32(0x30, bank->base + NPCM8XX_GP_N_DBNCP0 + (i * 4));
> > +                       } else if ((nanosecs > 2700) && (nanosecs <= 2856)) {
> > +                               iowrite32(0x40, bank->base + NPCM8XX_GP_N_DBNCP0 + (i * 4));
> > +                       } else if ((nanosecs > 2856) && (nanosecs <= 3496)) {
> > +                               iowrite32(0x50, bank->base + NPCM8XX_GP_N_DBNCP0 + (i * 4));
> > +                       } else if ((nanosecs > 3496) && (nanosecs <= 4136)) {
> > +                               iowrite32(0x60, bank->base + NPCM8XX_GP_N_DBNCP0 + (i * 4));
> > +                       } else if ((nanosecs > 4136) && (nanosecs <= 5025)) {
> > +                               iowrite32(0x70, bank->base + NPCM8XX_GP_N_DBNCP0 + (i * 4));
>
> With switch-case with ranges it will be much more visible what's going
> on. Also think about it, maybe you can use some formula instead? Or
> table (array of integers) approach where index will show the lowest
> range value.
There it can be described in a formula. Will be done with switch-case


>
> ...
>
> > +               struct device_node *np = to_of_node(child);
>
> Why?!
Will remove and replaced with fwnode functions.
>
> > +               ret = of_address_to_resource(np, 0, &res);
> > +               if (ret < 0) {
> > +                       dev_err(dev, "Resource fail for GPIO bank %u\n", id);
> > +                       return ret;
> > +               }
> > +
> > +               pctrl->gpio_bank[id].base = ioremap(res.start, resource_size(&res));
>
> fwnode_iomap()
>
> ...
>
> > +               if (ret) {
> > +                       dev_err(dev, "bgpio_init() failed\n");
> > +                       return ret;
> > +               }
>
> Use
>
>   return dev_err_probe(...)
Why it is better to use dev_err_probe?
I am not sure that the error will be EPROBE_DEFER, all the failure
cases the driver returned the
error in the code.
>
> In ->probe() and satellite functions.
>
> ...
>
> > +               ret = irq_of_parse_and_map(np, 0);
>
> fwnode_irq_get()
>
> > +               if (!ret) {
> > +                       dev_err(dev, "No IRQ for GPIO bank %u\n", id);
> > +                       return -EINVAL;
> > +               }
>
> ...
>
> > +               girq->num_parents = 1;
> > +               girq->parents = devm_kcalloc(pctrl->dev, 1,
>
> Replace 1 with girq->num_parents
>
> > +                                            sizeof(*girq->parents),
> > +                                            GFP_KERNEL);
> > +               if (!girq->parents) {
> > +                       ret = -ENOMEM;
> > +                       goto err_register;
> > +               }
>
> ...
>
> > +               ret = gpiochip_add_pin_range(&pctrl->gpio_bank[id].gc,
> > +                                            dev_name(pctrl->dev),
> > +                                            pctrl->gpio_bank[id].pinctrl_id,
> > +                                            pctrl->gpio_bank[id].gc.base,
> > +                                            pctrl->gpio_bank[id].gc.ngpio);
> > +               if (ret < 0) {
> > +                       dev_err(pctrl->dev, "Failed to add GPIO bank %u\n", id);
> > +                       gpiochip_remove(&pctrl->gpio_bank[id].gc);
> > +                       goto err_register;
> > +               }
> > +       }
>
> We have a callback for ranges, can you use it?
Yes,
>
> ...
>
> > +err_register:
> > +       for (; id > 0; id--)
>
> while(id--)
>
> > +               gpiochip_remove(&pctrl->gpio_bank[id - 1].gc);
>
> But why not devm_gpiochip_add_... in the first place?
using, devm_gpiochip_add_data, will remove gpiochip_remove.
>
> ...
>
> > +       dev_set_drvdata(&pdev->dev, pctrl);
>
> platform_set_drv_data() ?
O.K.
>
> ...
>
> > +static const struct of_device_id npcm8xx_pinctrl_match[] = {
> > +       { .compatible = "nuvoton,npcm845-pinctrl" },
> > +       { },
>
> No comma for terminator entry.
O.K.
>
> > +};
>
> --
> With Best Regards,
> Andy Shevchenko

Best regards,

Tomer
