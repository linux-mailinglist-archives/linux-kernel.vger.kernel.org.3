Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E27573F7A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237220AbiGMWPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiGMWPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:15:04 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE3C2A265;
        Wed, 13 Jul 2022 15:15:02 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-31c89111f23so423227b3.0;
        Wed, 13 Jul 2022 15:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lX7k/axtDRxzgIi4P0RLXUpMp7jh1OeNazvCuzYxTm8=;
        b=buxyNclJkzDaDQmBMmX+cdNC2uQlC/SYJrbRkk5OpDiJ3b1RT91rskkzWprVhaerfD
         DXLUl8w1Ga1h6x2iGYBgSKkRd2BfyEaWnHbyc0+NSsPu+c+nJh3Mc7VkME174OkIqsiW
         R0UF3SB8R2nQVUsagBJWJJMOvG79Zj0B3F1eJmpqGEXWzN/9lY93xQJd324DoYY6XL8F
         hypWXuBcTjLhRFSers4+b/cMJ21FfqBCitzmUDMQGq5VNxSE8fBOH8pLPE/N/Nf9Bmt7
         7BDeZzR5VVsgaJyi16/YNQ5CPCPDq0rPTsUdFRCM9SBgN3EbQwVVrnfAYUs/FWeT/3qA
         Pp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lX7k/axtDRxzgIi4P0RLXUpMp7jh1OeNazvCuzYxTm8=;
        b=sceZQT4NXbEiHv8wPg+8iNAULHEWwMpwEUl+S8R38u1PdqQW6lGxrS4HNXnqTNCk66
         uKenqv04Kk4kmYdXUOSoKcQj/NKxQcKFpHjhF47LJf51TiXxwAwaBFCyvQTF9w09BEIW
         QjkdQhSt/to1h7hiaxdZD9q9T/VHbZNqtYZBm9oCDFHNMHrcizj1mlrr2uJ01URWLQpc
         Lu8V/pdmbNdAmJBUleUIPKDvwksKkFuWX16YbWZ78m8Bc7MZ9jE65kCBDENcXaD5HQ4X
         DNBu1Z6/5+lwqIss+j8V+dfzLwKHSXimZ9TkXJFjOUZHQs6AC4ujQIeAYJK9mkz1HKNS
         mMyw==
X-Gm-Message-State: AJIora8X9ubXtleFmTAOltMesChsBYIpC4Z3pSzg360ICV9QZRbvg+ZH
        ute+sSNq03VaJsqei/55ZKnB0/mTS4qUmE5m660=
X-Google-Smtp-Source: AGRyM1vd//RCXP39iX9dVoexAOOcjKn30pTDRU1fUa0SdZOmCe9lU/VCLrmBrclJF0+8dMBysQ845jMQ2WSn2YvEZgg=
X-Received: by 2002:a81:72c4:0:b0:31c:b309:c4e8 with SMTP id
 n187-20020a8172c4000000b0031cb309c4e8mr6692569ywc.520.1657750501924; Wed, 13
 Jul 2022 15:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220713105910.931983-1-lewis.hanly@microchip.com>
 <20220713105910.931983-2-lewis.hanly@microchip.com> <CAHp75VfGTd02jKYsFq94BF_Gqro2trk3iyyALBatS1Bps3HYhw@mail.gmail.com>
 <abdf389cfd049f60b951447c047bbd186fa19469.camel@microchip.com>
In-Reply-To: <abdf389cfd049f60b951447c047bbd186fa19469.camel@microchip.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Jul 2022 00:14:25 +0200
Message-ID: <CAHp75VeX8p4m7Bi=9Zvk5=MRTOb=BTmcuDbtW1ZUOr_-1mHvyQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpio: mpfs: add polarfire soc gpio support
To:     Lewis.Hanly@microchip.com
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Conor.Dooley@microchip.com, Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daire.McNamara@microchip.com
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

On Wed, Jul 13, 2022 at 10:44 PM <Lewis.Hanly@microchip.com> wrote:
> On Wed, 2022-07-13 at 13:59 +0200, Andy Shevchenko wrote:
> > On Wed, Jul 13, 2022 at 1:00 PM <lewis.hanly@microchip.com> wrote:

...

> > > +config GPIO_POLARFIRE_SOC
> > > +       bool "Microchip FPGA GPIO support"
> >
> > Why not tristate?
> OK.

(1)

...

> > > +       help
> > > +         Say yes here to support the GPIO device on Microchip
> > > FPGAs.
> >
> > When allowing it to be a module, add a text that tells how the driver
> > will be called.
> Not loading as a module.

I didn't get this. Together with (1) it makes nonsense. What did you
mean by (1) _or_ by this?

...

> > Also don't forget mod_devicetable.h.
> Can't see why I need this header.

Because you are using data types from it.

...

> > > +       if (gpio_cfg & MPFS_GPIO_EN_IN)
> > > +               return 1;
> > > +
> > > +       return 0;
> >
> > Don't we have specific definitions for the directions?
> No defines in file.

We have. Please, check again.

...

> > > +       mpfs_gpio_assign_bit(mpfs_gpio->base + (gpio_index *
> > > BYTE_BOUNDARY),
> > > +                            MPFS_GPIO_EN_INT, 1);
> >
> > Too many parentheses.
> I do think it makes reading easier.

You can multiply inside mpfs_gpio_assign_bit(), no?

...

> > > +       mpfs_gpio_assign_bit(mpfs_gpio->base + (gpio_index *
> > > BYTE_BOUNDARY),
> > > +                            MPFS_GPIO_EN_INT, 0);

Ditto.

...

> > > +static int mpfs_gpio_irq_set_affinity(struct irq_data *data,
> > > +                                     const struct cpumask *dest,
> > > +                                     bool force)
> > > +{
> > > +       if (data->parent_data)
> > > +               return irq_chip_set_affinity_parent(data, dest,
> > > force);
> > > +
> > > +       return -EINVAL;
> > > +}
> >
> > Why do you need this? Isn't it taken care of by the IRQ chip core?
> Yes I believe we do/should, data->parent_data is used in
> irq_chip_set_affinity_parent(..) without checking so hence checked
> before calling.

I mean the entire function. Isn't it the default in the IRQ chip core?
Or can it be made as a default with some flags set?

...

> > > +       struct device_node *node = pdev->dev.of_node;
> > > +       struct device_node *irq_parent;
> >
> > Why do you need these?
> Yes they are needed. Both of the same type but used in different
> places. I don't think I can reuse.

This is related to the pattern of how you are enumerating IRQs. If the
pattern is changed, it would be not needed anymore.

...

> > > +       if (ngpio > NUM_GPIO) {
> > > +               dev_err(dev, "Too many GPIO interrupts (max=%d)\n",
> > > +                       NUM_GPIO);
> > > +               ret = -ENXIO;
> > > +               goto cleanup_clock;
> >
> > return dev_err_probe(...);
> I need to cleanup clock before returning, will use dev_err_probe.

Have you read what I wrote above?
I wrote that you need to wrap the clk_disable_unprepare() into devm,
so you may use as I pointed out, i.e. return dev_err_probe()
everywhere in the ->probe().

> > > +       }

...

> > Why do you need all these? Seems a copy'n'paste from gpio-sifive,
> > which is the only GPIO driver using this pattern.
> Yes I believe we do need all this information. Yes it is similiar
> implementation to sifive. Not the only driver using this pattern, check
> gpio-ixp4xxx.c

My question: why do you need this? What is so special about this driver?

...

> > > +               mpfs_gpio_assign_bit(mpfs_gpio->base + (i *
> > > BYTE_BOUNDARY),
> > > +                                    MPFS_GPIO_EN_INT, 0);
> >
> > Too many parentheses.

As per above.

...

> > > +       dev_info(dev, "Microchip MPFS GPIO registered, ngpio=%d\n",
> > > ngpio);
> >
> > Noise.
> Maybe, but useful information to know the ngpio.

Nope. Use sysfs / debugfs / etc. No need to noise the log.

-- 
With Best Regards,
Andy Shevchenko
