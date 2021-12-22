Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7158747D174
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244776AbhLVMFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbhLVMFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:05:06 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95944C061574;
        Wed, 22 Dec 2021 04:05:05 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id f5so7765518edq.6;
        Wed, 22 Dec 2021 04:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C5DstKb3qwgFc6Y9dnMNuAHiqD0iQ2gm6zNA7e4o3gk=;
        b=SPr3wdk79tZ7YJvNb32ojoleSxkyK2x/dWtV5IwUCTfR0x3C7o4NVKY2ClHnNTAf0N
         SOEwc7h/cs4yIp1GDO6J8iov7vVAhrT46ZRc1SwMatasaViKUc6lkI8lWf0eIjVHi4Vy
         MXBeqJlim/Qke//N8Z7jJVkw0nJC9vcJ4m6/HeIHsaZSvj3IEERcFQppJ06xax1YZZEF
         C/R5lxjS1jcg6ZdknCl+mQaAEJsY0XrjXub6H+li0RvBY4fBgvFoWqg5NgQD9ewByM8C
         ZmFP5+YIgNW0YJsyWHxlaCqCGG4RO+INGMbHSx8nqAJbgs7IezWbcn24FOzI/id+vlrA
         GCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C5DstKb3qwgFc6Y9dnMNuAHiqD0iQ2gm6zNA7e4o3gk=;
        b=BctTjAyG++1FJgFoJNzHfxPdAIWmK0X4XhSTrvor2IvKa34KrMU9c/hGdzapv9Yzv2
         QGfwetZTB3ldtgOg41/lZ+Kedul/8AZjHAupcbE70QyngSQ3vd8Zage89CcJC8yEVqLx
         axeJdAyT3gyTIv+V2ucNCEbqw5FDNLGT48ok1Y0T9ZfbSslo2Qxp9BNcwhwSBb+unFGP
         NN5UjEmxvzgZEBh73UmuKfeeVMDL4A4uR13+T4W0FIE40zgcUHmOE3YxWtz4Y/OJq3F1
         U3hvH1G4n1k5bcrw6q1zkJfLO0bwgBwFihWIJe+RqzFNXGneAxB0YtR2E2YfWoFDiJnT
         QkEw==
X-Gm-Message-State: AOAM533ZD44vxe0Vbh91Kri/XbHCICWCBx3MVdH1Optv11lYRrF0nClt
        srRXS99hYtWT4TDpPd61md/26ZiTs/KzNjnTrVyvoAlK6SI=
X-Google-Smtp-Source: ABdhPJw6ar+HbOMGr2+HtbupdwrwAK0c3qZcDouEw6sctXge1TZ8f+bMKEEMq8TwXmY8YyY67NPzQDK4Wsppd+qsYBg=
X-Received: by 2002:a17:907:6d8d:: with SMTP id sb13mr2243612ejc.132.1640174703757;
 Wed, 22 Dec 2021 04:05:03 -0800 (PST)
MIME-Version: 1.0
References: <20211220211854.89452-1-nbd@nbd.name> <20211220211854.89452-14-nbd@nbd.name>
In-Reply-To: <20211220211854.89452-14-nbd@nbd.name>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Dec 2021 14:03:04 +0200
Message-ID: <CAHp75Vd48LiEDUV+otHhdLqtQuLv50aptfA1e9X_0PEpQ4BAsw@mail.gmail.com>
Subject: Re: [PATCH v8 13/14] gpio: Add support for Airoha EN7523 GPIO controller
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, john <john@phrozen.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 12:02 AM Felix Fietkau <nbd@nbd.name> wrote:
>
> From: John Crispin <john@phrozen.org>
>
> Airoha's GPIO controller on their ARM EN7523 SoCs consists of two banks of 32
> GPIOs. Each instance in DT is for a single bank.

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

A couple of minor comments and one about headers below.

> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  drivers/gpio/Kconfig       |   9 +++
>  drivers/gpio/Makefile      |   1 +
>  drivers/gpio/gpio-en7523.c | 134 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 144 insertions(+)
>  create mode 100644 drivers/gpio/gpio-en7523.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 072ed610f9c6..e4a34272504f 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -247,6 +247,15 @@ config GPIO_EM
>         help
>           Say yes here to support GPIO on Renesas Emma Mobile SoCs.
>
> +config GPIO_EN7523
> +       tristate "Airoha GPIO support"
> +       depends on ARCH_AIROHA
> +       default ARCH_AIROHA
> +       select GPIO_GENERIC
> +       select GPIOLIB_IRQCHIP
> +       help
> +         Say yes here to support the GPIO controller on Airoha EN7523.

Checkpatch nowadays wants a better description. Also add a paragraph
at the end, like many other drivers do, what the module would be if
selected as M.

>  config GPIO_EP93XX
>         def_bool y
>         depends on ARCH_EP93XX
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 71ee9fc2ff83..d2269ee0948e 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -56,6 +56,7 @@ obj-$(CONFIG_GPIO_DLN2)                       += gpio-dln2.o
>  obj-$(CONFIG_GPIO_DWAPB)               += gpio-dwapb.o
>  obj-$(CONFIG_GPIO_EIC_SPRD)            += gpio-eic-sprd.o
>  obj-$(CONFIG_GPIO_EM)                  += gpio-em.o
> +obj-$(CONFIG_GPIO_EN7523)              += gpio-en7523.o
>  obj-$(CONFIG_GPIO_EP93XX)              += gpio-ep93xx.o
>  obj-$(CONFIG_GPIO_EXAR)                        += gpio-exar.o
>  obj-$(CONFIG_GPIO_F7188X)              += gpio-f7188x.o
> diff --git a/drivers/gpio/gpio-en7523.c b/drivers/gpio/gpio-en7523.c
> new file mode 100644
> index 000000000000..67631396cd93
> --- /dev/null
> +++ b/drivers/gpio/gpio-en7523.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/gpio/driver.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>

Missed headers
types.h for _iomem, etc.
io.h for I/O accessors.
bits.h for BIT(), etc.

> +#define AIROHA_GPIO_MAX                32
> +
> +/**
> + * airoha_gpio_ctrl - Airoha GPIO driver data
> + * @gc: Associated gpio_chip instance.
> + * @data: The data register.
> + * @dir0: The direction register for the lower 16 pins.
> + * @dir1: The direction register for the higher 16 pins.
> + * @output: The output enable register.
> + */
> +struct airoha_gpio_ctrl {
> +       struct gpio_chip gc;
> +       void __iomem *data;
> +       void __iomem *dir[2];
> +       void __iomem *output;
> +};
> +
> +static struct airoha_gpio_ctrl *gc_to_ctrl(struct gpio_chip *gc)
> +{
> +       return container_of(gc, struct airoha_gpio_ctrl, gc);
> +}
> +
> +static int airoha_dir_set(struct gpio_chip *gc, unsigned int gpio,
> +                         int val, int out)
> +{
> +       struct airoha_gpio_ctrl *ctrl = gc_to_ctrl(gc);
> +       u32 dir = ioread32(ctrl->dir[gpio / 16]);
> +       u32 output = ioread32(ctrl->output);
> +       u32 mask = BIT((gpio % 16) * 2);
> +
> +       if (out) {
> +               dir |= mask;
> +               output |= BIT(gpio);
> +       } else {
> +               dir &= ~mask;
> +               output &= ~BIT(gpio);
> +       }
> +
> +       iowrite32(dir, ctrl->dir[gpio / 16]);
> +
> +       if (out)
> +               gc->set(gc, gpio, val);
> +
> +       iowrite32(output, ctrl->output);
> +
> +       return 0;
> +}
> +
> +static int airoha_dir_out(struct gpio_chip *gc, unsigned int gpio,
> +                         int val)
> +{
> +       return airoha_dir_set(gc, gpio, val, 1);
> +}
> +
> +static int airoha_dir_in(struct gpio_chip *gc, unsigned int gpio)
> +{
> +       return airoha_dir_set(gc, gpio, 0, 0);
> +}
> +
> +static int airoha_get_dir(struct gpio_chip *gc, unsigned int gpio)
> +{
> +       struct airoha_gpio_ctrl *ctrl = gc_to_ctrl(gc);
> +       u32 dir = ioread32(ctrl->dir[gpio / 16]);
> +       u32 mask = BIT((gpio % 16) * 2);
> +
> +       return (dir & mask) ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
> +}

> +static const struct of_device_id airoha_gpio_of_match[] = {
> +       { .compatible = "airoha,en7523-gpio" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, airoha_gpio_of_match);

Move this below, closer to its user.

> +static int airoha_gpio_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct airoha_gpio_ctrl *ctrl;
> +       int err;
> +
> +       ctrl = devm_kzalloc(dev, sizeof(*ctrl), GFP_KERNEL);
> +       if (!ctrl)
> +               return -ENOMEM;
> +
> +       ctrl->data = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(ctrl->data))
> +               return PTR_ERR(ctrl->data);
> +
> +       ctrl->dir[0] = devm_platform_ioremap_resource(pdev, 1);
> +       if (IS_ERR(ctrl->dir[0]))
> +               return PTR_ERR(ctrl->dir[0]);
> +
> +       ctrl->dir[1] = devm_platform_ioremap_resource(pdev, 2);
> +       if (IS_ERR(ctrl->dir[1]))
> +               return PTR_ERR(ctrl->dir[1]);
> +
> +       ctrl->output = devm_platform_ioremap_resource(pdev, 3);
> +       if (IS_ERR(ctrl->output))
> +               return PTR_ERR(ctrl->output);
> +
> +       err = bgpio_init(&ctrl->gc, dev, 4, ctrl->data, NULL,
> +                        NULL, NULL, NULL, 0);
> +       if (err)
> +               return dev_err_probe(dev, err, "unable to init generic GPIO");
> +
> +       ctrl->gc.ngpio = AIROHA_GPIO_MAX;
> +       ctrl->gc.owner = THIS_MODULE;
> +       ctrl->gc.direction_output = airoha_dir_out;
> +       ctrl->gc.direction_input = airoha_dir_in;
> +       ctrl->gc.get_direction = airoha_get_dir;
> +
> +       return devm_gpiochip_add_data(dev, &ctrl->gc, ctrl);
> +}
> +
> +static struct platform_driver airoha_gpio_driver = {
> +       .driver = {
> +               .name = "airoha-gpio",
> +               .of_match_table = airoha_gpio_of_match,
> +       },
> +       .probe = airoha_gpio_probe,
> +};
> +module_platform_driver(airoha_gpio_driver);
> +
> +MODULE_DESCRIPTION("Airoha GPIO support");
> +MODULE_AUTHOR("John Crispin <john@phrozen.org>");
> +MODULE_LICENSE("GPL v2");
> --
> 2.34.1
>


-- 
With Best Regards,
Andy Shevchenko
