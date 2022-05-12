Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33A5524A6A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352646AbiELKhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240318AbiELKhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:37:48 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D324A4926F;
        Thu, 12 May 2022 03:37:45 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id be20so5639790edb.12;
        Thu, 12 May 2022 03:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=53yz/TaURZWKvsuoI8vDcDmzi2pQSFFGTCSqBdlpUS8=;
        b=FmADhyUZnAuLiyikqo1X9kbAtSwcF0zb0UUWdGEoJoP2M1pxViJgii8cE68sjPPfc4
         RGyB5tnOR1sycrCM5rYW+cL6utPq/bT8qCBW+bcpAy2i4EB+jBaBQWIE/8LXnYuy9zZw
         KGQHpFROozpw9x9ubO6glZm5/QiMlB+EKAbxq0U1TCVQXbrMtzYJBCwAiqfguudB2965
         4BhOHYX7X+wGAHUmJ/YAZO62DODomKKavW2BS+bq8naMyrAN64mlytGi7TAg/ypTTtIR
         oNtd/GU7d9FPbmE1W9F2+dHIw1/xVl20bTdXblD2OBASawvLdtrEgQZzrqQE2vrSKJoE
         BwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=53yz/TaURZWKvsuoI8vDcDmzi2pQSFFGTCSqBdlpUS8=;
        b=2no1AdOpTGwqMDRCdF/HbWX6fTKrTESpE+Ui1n6VC3pgZBVJzxJHMaPpjIIweL6k4u
         7o1z9JvcVD4GtP+E7jXXRdrQ0Y3+T00KamBVSpX9NHS+8GXT5GGdVRGmFAmMfPpWQhNY
         X79wnUwJ4sZtACUa7TI2m1IgGvSKkGgJAzlQGAx09yrSCYd9HtwqcJ2OtEGgsL1fD1Rn
         K8py5AEY4UQb7eVmIvn0/VG2Zsa8HHhvdETU1YN8LUsejyJYJ2taT7Yr//Ft2Wt3ctyx
         SXO9Cee98t/Xx/r7nNA7rIG+IqVJ1nbCJeGq9x5Y/pybovx8NUWBsdSd2ywcXyimPOV2
         M/RA==
X-Gm-Message-State: AOAM5314s3+ZW6+61pWLG3qR6p0CHFPzccq2FkZVwiYrQuasQFBvZDYG
        Pd4th4Z7VO/MmvwRz5iN94AHjCV1xpcNHY2SmbM=
X-Google-Smtp-Source: ABdhPJzq6BesbZT0RqBynhdNF2zNCf+XMMstLlSvs8nGbC2hAJA4uXL2csAMXSzpDAnYol6aN1tz0AaeQ2DEnF0qkHs=
X-Received: by 2002:a50:e696:0:b0:419:998d:5feb with SMTP id
 z22-20020a50e696000000b00419998d5febmr35064331edm.122.1652351864263; Thu, 12
 May 2022 03:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220511205959.10514-1-mosescb.dev@gmail.com> <20220512071415.2786-1-mosescb.dev@gmail.com>
In-Reply-To: <20220512071415.2786-1-mosescb.dev@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 12 May 2022 12:37:07 +0200
Message-ID: <CAHp75VcKF6CU5-MdSjw-_A+9SdLVZXh7FoJUEG5Uu7fGDDn3jA@mail.gmail.com>
Subject: Re: [PATCH v3] drivers: gpio: zevio: drop of_gpio.h header
To:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, May 12, 2022 at 9:14 AM Moses Christopher Bollavarapu
<mosescb.dev@gmail.com> wrote:
>
> Remove of_gpio.h header file, replace of_* functions and structs
> with appropriate alternatives.

LGTM,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
> ---
>  V2 -> V3: Add missing return in front of dev_error_probe
>  V1 -> V2: Move gpio_chip member to top of the struct
>            Use dev_error_probe instead of dev_err
>            Minor style fixes
>
>  drivers/gpio/gpio-zevio.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpio/gpio-zevio.c b/drivers/gpio/gpio-zevio.c
> index f6f8a541348f..ce9d1282165c 100644
> --- a/drivers/gpio/gpio-zevio.c
> +++ b/drivers/gpio/gpio-zevio.c
> @@ -11,7 +11,6 @@
>  #include <linux/bitops.h>
>  #include <linux/io.h>
>  #include <linux/of_device.h>
> -#include <linux/of_gpio.h>
>  #include <linux/slab.h>
>  #include <linux/gpio/driver.h>
>
> @@ -53,22 +52,23 @@
>  #define ZEVIO_GPIO_BIT(gpio) (gpio&7)
>
>  struct zevio_gpio {
> +       struct gpio_chip        chip;
>         spinlock_t              lock;
> -       struct of_mm_gpio_chip  chip;
> +       void __iomem            *regs;
>  };
>
>  static inline u32 zevio_gpio_port_get(struct zevio_gpio *c, unsigned pin,
>                                         unsigned port_offset)
>  {
>         unsigned section_offset = ((pin >> 3) & 3)*ZEVIO_GPIO_SECTION_SIZE;
> -       return readl(IOMEM(c->chip.regs + section_offset + port_offset));
> +       return readl(IOMEM(c->regs + section_offset + port_offset));
>  }
>
>  static inline void zevio_gpio_port_set(struct zevio_gpio *c, unsigned pin,
>                                         unsigned port_offset, u32 val)
>  {
>         unsigned section_offset = ((pin >> 3) & 3)*ZEVIO_GPIO_SECTION_SIZE;
> -       writel(val, IOMEM(c->chip.regs + section_offset + port_offset));
> +       writel(val, IOMEM(c->regs + section_offset + port_offset));
>  }
>
>  /* Functions for struct gpio_chip */
> @@ -178,12 +178,15 @@ static int zevio_gpio_probe(struct platform_device *pdev)
>         platform_set_drvdata(pdev, controller);
>
>         /* Copy our reference */
> -       controller->chip.gc = zevio_gpio_chip;
> -       controller->chip.gc.parent = &pdev->dev;
> +       controller->chip = zevio_gpio_chip;
> +       controller->chip.parent = &pdev->dev;
>
> -       status = of_mm_gpiochip_add_data(pdev->dev.of_node,
> -                                        &(controller->chip),
> -                                        controller);
> +       controller->regs = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(controller->regs))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(controller->regs),
> +                                    "failed to ioremap memory resource\n");
> +
> +       status = devm_gpiochip_add_data(&pdev->dev, &controller->chip, controller);
>         if (status) {
>                 dev_err(&pdev->dev, "failed to add gpiochip: %d\n", status);
>                 return status;
> @@ -192,10 +195,10 @@ static int zevio_gpio_probe(struct platform_device *pdev)
>         spin_lock_init(&controller->lock);
>
>         /* Disable interrupts, they only cause errors */
> -       for (i = 0; i < controller->chip.gc.ngpio; i += 8)
> +       for (i = 0; i < controller->chip.ngpio; i += 8)
>                 zevio_gpio_port_set(controller, i, ZEVIO_GPIO_INT_MASK, 0xFF);
>
> -       dev_dbg(controller->chip.gc.parent, "ZEVIO GPIO controller set up!\n");
> +       dev_dbg(controller->chip.parent, "ZEVIO GPIO controller set up!\n");
>
>         return 0;
>  }
> --
> 2.30.2
>


-- 
With Best Regards,
Andy Shevchenko
