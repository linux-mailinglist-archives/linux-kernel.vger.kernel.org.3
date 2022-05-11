Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEEC5230C8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238357AbiEKKjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239126AbiEKKi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:38:57 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA2098F63;
        Wed, 11 May 2022 03:38:23 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dk23so3128918ejb.8;
        Wed, 11 May 2022 03:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qGHv9j0c8V71tfmlaFQcyFp3f+ZWH+JBhoP8avbzoug=;
        b=nhVubC7qARrrpeceYAKhtv4b7NZJqmzIWHFuh6v/Lde+nrh6wrRWlve0I2UADLlyss
         XH+QLgL9NO4nEcG6NwP3AXO3LfSrHrOOM614swoNJdGFNluhpr0gt+BYZSyPQvEVRKc0
         BfGJBw3M9/AEX4Zhgim79i2vd+OG1RkdRXMF109JZGoycVjsuigZVSlN8aFy5u3Z+ddP
         UgBztuWuoXI2ZHwpFy95ba9iVJzQBPhpXxuQdKT0jbBkzDCbKOevXvuslyWD/Z6NEpis
         jepA7fS6SgVB7TLDI/ntHfc9ud059V9+iQPz/O55RzSqZ9aYNQPBC2kxggjcmPizaOyy
         jjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qGHv9j0c8V71tfmlaFQcyFp3f+ZWH+JBhoP8avbzoug=;
        b=EpWPNKPuPWxml5YZTVJRc1v2T6i4uHhsObSNok17ajBdSZx3PWN+yuzRT+6vlJ6Hxg
         JTpobRdKC5n4szDHDFG9W5AUNCwOM9gzMG0mUdGRgg06+hy6vZIMW9fk7nECn4a7UPu9
         YadvVsyae/cMvFErshVgbTyPh8ZTX2lBhI08Fs8h/iD51J23uMlWeSzyemGB/Ov3vDwm
         HqTbGNEiP4R4MaPBtObSXN7cOvAg8e3pTZnA4xczj8UVlkaDSvtPLU7FETi5Nu4SeDvC
         CCYRpr70kPvlxYAhmTJM1H4RkL9C0rbtA82BglUksOMKg2g+r2VHwOUbDc5/bUgxuCWZ
         baCw==
X-Gm-Message-State: AOAM530QA3RrsPbE2J/BATexam8Xt4ekkrV6HMnEjLrDaYSdoGiaAEN0
        8jINanwpFyEgL8jKjK1mSjxW0pKxFpPkDhYKNgE=
X-Google-Smtp-Source: ABdhPJxpw5GHTo4RP+D7jwBpREG5piaO3Cc5XUYt9RsTu28/AwACOgKxI7fz0K6cpNHhFfq83O0FowVcYp8GOWZ2KLw=
X-Received: by 2002:a17:906:3ce9:b0:6ef:a8aa:ab46 with SMTP id
 d9-20020a1709063ce900b006efa8aaab46mr23697429ejh.579.1652265502402; Wed, 11
 May 2022 03:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220510191549.76105-1-mosescb.dev@gmail.com>
In-Reply-To: <20220510191549.76105-1-mosescb.dev@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 11 May 2022 12:37:46 +0200
Message-ID: <CAHp75VdAyA=JkY6tjzRvHNwXZie9H4nrn6ct3qzuyUWgNeW21w@mail.gmail.com>
Subject: Re: [PATCH] drivers: gpio: zevio: drop of_gpio.h header
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

On Wed, May 11, 2022 at 12:31 AM Moses Christopher Bollavarapu
<mosescb.dev@gmail.com> wrote:

I like the idea and the patch, but a few comments below.

> remove of_gpio.h header file, replace of_* functions and structs
> with appropriate alternatives

Please respect English grammar, i.e. Capital letters at the beginning
of the sentences and period at the ends.

...

>  struct zevio_gpio {
>         spinlock_t              lock;
> -       struct of_mm_gpio_chip  chip;
> +       struct gpio_chip        chip;
> +       void __iomem            *regs;

While at it, please move the chip member to be the first one. It will
optimize container_of() in case it's being called against a zevio_gpio
object instance.

>  };

...

> +       controller->regs = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(controller->regs)) {

> +               dev_err(&pdev->dev, "failed to ioremap memory resource\n");
> +               return PTR_ERR(controller->regs);

return dev_err_probe(&pdev->dev, ...);

> +       }

...

> +       status = devm_gpiochip_add_data(&pdev->dev,
> +                                       &(controller->chip),

Too many parentheses.

> +                                       controller);

Also, combine all of them to be located on a single line.

-- 
With Best Regards,
Andy Shevchenko
