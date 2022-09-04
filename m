Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07A75AC5F7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 21:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbiIDTB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 15:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiIDTBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 15:01:51 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516952B27C;
        Sun,  4 Sep 2022 12:01:50 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id cr9so4919602qtb.13;
        Sun, 04 Sep 2022 12:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=jhA2At4C7gUGBD7kmr3qzQXQCJawda4OYdGrtHLP8ok=;
        b=C3eaIRj9zJvT1EDOvv5L5DlbNybYy/M/Qfd/Egb3o+on7xrHrenj3L6FKjXzIYxUl8
         RbRHQT8KThJ+uxIGHy8CIS4kQiBTJJKOC1B+MmOaessoUlyC3/8kxOA/slS0joWDOBJ7
         XTTAS+Ml4SfC+oFJmmWUQEXowbB8JcclEDKdiYkOwHC4Mry+H0uBxm3v2fRzpwa6WkDo
         idzyXB0/lOSHM3TTiP9QhSlBs/gbxiv8k1roVpS2VBmHaiEpnu4ecWHU0tqP2kz5foRo
         FmOa6lJCq1MmvFUP6HXTVCp3pkU/c1OnUd5SVc8BzEC5yLjz4UpOL9bpJjxMcnEY3ch4
         pMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=jhA2At4C7gUGBD7kmr3qzQXQCJawda4OYdGrtHLP8ok=;
        b=IwZcd9AYysv3MBH0VLyTRHaYn7qH+n9p4hXq0RSnytfBLQZ6ucSibxHgGtFM/68T/9
         ANFiNuVqmePaSQVFZszKwVdSzw5H9S6FzTIR78DeeetjHh9DKzkyS864eRyPoSgtJzJQ
         Z7jFGYKiVXKZ1SSuOuZvhK24650tcYopD3FojdspMG1tNSF1rqVT84AYGPhUj/w87dS6
         iqrJQkdM2NvYLuus6niNXREHHiMOrp4tQVGej1haLFzMf9P5vPFZaR9NMw0KwnMf/kC7
         ahtRBQqSN58+TnLhEEvb+QKTK/QL0da0lQV51vooJtK7hm0SfakvpSkUyvVtFwPUajdn
         /AqA==
X-Gm-Message-State: ACgBeo3YloWnI52/tSOifDWLlcCu+Gmnx2IutjTRRdUd8PZdUgEkeTd/
        898se6QToe+v/myGaEKpWwTj5cgTtLmAPUAxUSo=
X-Google-Smtp-Source: AA6agR4VeKdJiqnlLU3JcWBx5HlhbyUjWUEG2xUZoTO4ruVy6+ZpZ8/ZAPSeM4ftEWszMH4Qyeaoj1cLjRtYPmqO7Z4=
X-Received: by 2002:a05:622a:40a:b0:343:77ba:727f with SMTP id
 n10-20020a05622a040a00b0034377ba727fmr37215624qtx.481.1662318108713; Sun, 04
 Sep 2022 12:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <YxRDRx3oubAISIB0@google.com>
In-Reply-To: <YxRDRx3oubAISIB0@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 4 Sep 2022 22:01:12 +0300
Message-ID: <CAHp75Ve=nrqLfbj2wNEez8s4=DLJnGT1pp=VpY=U0xDoh-LV0Q@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: make fwnode_get_named_gpiod() static
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

On Sun, Sep 4, 2022 at 9:22 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> There are no external users of fwnode_get_named_gpiod() anymore, so
> let's stop exporting it and mark it as static.

Agree.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/gpio/gpiolib.c        | 132 +++++++++++++++++-----------------
>  include/linux/gpio/consumer.h |  13 ----
>  2 files changed, 66 insertions(+), 79 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index cc9c0a12259e..4756ea08894f 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -3798,6 +3798,72 @@ static int platform_gpio_count(struct device *dev, const char *con_id)
>         return count;
>  }
>
> +/**
> + * fwnode_get_named_gpiod - obtain a GPIO from firmware node
> + * @fwnode:    handle of the firmware node
> + * @propname:  name of the firmware property representing the GPIO
> + * @index:     index of the GPIO to obtain for the consumer
> + * @dflags:    GPIO initialization flags
> + * @label:     label to attach to the requested GPIO
> + *
> + * This function can be used for drivers that get their configuration
> + * from opaque firmware.
> + *
> + * The function properly finds the corresponding GPIO using whatever is the
> + * underlying firmware interface and then makes sure that the GPIO
> + * descriptor is requested before it is returned to the caller.
> + *
> + * Returns:
> + * On successful request the GPIO pin is configured in accordance with
> + * provided @dflags.
> + *
> + * In case of error an ERR_PTR() is returned.
> + */
> +static struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
> +                                               const char *propname, int index,
> +                                               enum gpiod_flags dflags,
> +                                               const char *label)
> +{
> +       unsigned long lflags = GPIO_LOOKUP_FLAGS_DEFAULT;
> +       struct gpio_desc *desc = ERR_PTR(-ENODEV);
> +       int ret;
> +
> +       if (is_of_node(fwnode)) {
> +               desc = gpiod_get_from_of_node(to_of_node(fwnode),
> +                                             propname, index,
> +                                             dflags,
> +                                             label);
> +               return desc;
> +       } else if (is_acpi_node(fwnode)) {
> +               struct acpi_gpio_info info;
> +
> +               desc = acpi_node_get_gpiod(fwnode, propname, index, &info);
> +               if (IS_ERR(desc))
> +                       return desc;
> +
> +               acpi_gpio_update_gpiod_flags(&dflags, &info);
> +               acpi_gpio_update_gpiod_lookup_flags(&lflags, &info);
> +       } else {
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       /* Currently only ACPI takes this path */
> +       ret = gpiod_request(desc, label);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       ret = gpiod_configure_flags(desc, propname, lflags, dflags);
> +       if (ret < 0) {
> +               gpiod_put(desc);
> +               return ERR_PTR(ret);
> +       }
> +
> +       blocking_notifier_call_chain(&desc->gdev->notifier,
> +                                    GPIOLINE_CHANGED_REQUESTED, desc);
> +
> +       return desc;
> +}
> +
>  /**
>   * fwnode_gpiod_get_index - obtain a GPIO from firmware node
>   * @fwnode:    handle of the firmware node
> @@ -4063,72 +4129,6 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(gpiod_get_index);
>
> -/**
> - * fwnode_get_named_gpiod - obtain a GPIO from firmware node
> - * @fwnode:    handle of the firmware node
> - * @propname:  name of the firmware property representing the GPIO
> - * @index:     index of the GPIO to obtain for the consumer
> - * @dflags:    GPIO initialization flags
> - * @label:     label to attach to the requested GPIO
> - *
> - * This function can be used for drivers that get their configuration
> - * from opaque firmware.
> - *
> - * The function properly finds the corresponding GPIO using whatever is the
> - * underlying firmware interface and then makes sure that the GPIO
> - * descriptor is requested before it is returned to the caller.
> - *
> - * Returns:
> - * On successful request the GPIO pin is configured in accordance with
> - * provided @dflags.
> - *
> - * In case of error an ERR_PTR() is returned.
> - */
> -struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
> -                                        const char *propname, int index,
> -                                        enum gpiod_flags dflags,
> -                                        const char *label)
> -{
> -       unsigned long lflags = GPIO_LOOKUP_FLAGS_DEFAULT;
> -       struct gpio_desc *desc = ERR_PTR(-ENODEV);
> -       int ret;
> -
> -       if (is_of_node(fwnode)) {
> -               desc = gpiod_get_from_of_node(to_of_node(fwnode),
> -                                             propname, index,
> -                                             dflags,
> -                                             label);
> -               return desc;
> -       } else if (is_acpi_node(fwnode)) {
> -               struct acpi_gpio_info info;
> -
> -               desc = acpi_node_get_gpiod(fwnode, propname, index, &info);
> -               if (IS_ERR(desc))
> -                       return desc;
> -
> -               acpi_gpio_update_gpiod_flags(&dflags, &info);
> -               acpi_gpio_update_gpiod_lookup_flags(&lflags, &info);
> -       } else
> -               return ERR_PTR(-EINVAL);
> -
> -       /* Currently only ACPI takes this path */
> -       ret = gpiod_request(desc, label);
> -       if (ret)
> -               return ERR_PTR(ret);
> -
> -       ret = gpiod_configure_flags(desc, propname, lflags, dflags);
> -       if (ret < 0) {
> -               gpiod_put(desc);
> -               return ERR_PTR(ret);
> -       }
> -
> -       blocking_notifier_call_chain(&desc->gdev->notifier,
> -                                    GPIOLINE_CHANGED_REQUESTED, desc);
> -
> -       return desc;
> -}
> -EXPORT_SYMBOL_GPL(fwnode_get_named_gpiod);
> -
>  /**
>   * gpiod_get_index_optional - obtain an optional GPIO from a multi-index GPIO
>   *                            function
> diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
> index 37448ee17e81..cf7d64b0ced3 100644
> --- a/include/linux/gpio/consumer.h
> +++ b/include/linux/gpio/consumer.h
> @@ -174,10 +174,6 @@ int desc_to_gpio(const struct gpio_desc *desc);
>  /* Child properties interface */
>  struct fwnode_handle;
>
> -struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
> -                                        const char *propname, int index,
> -                                        enum gpiod_flags dflags,
> -                                        const char *label);
>  struct gpio_desc *fwnode_gpiod_get_index(struct fwnode_handle *fwnode,
>                                          const char *con_id, int index,
>                                          enum gpiod_flags flags,
> @@ -553,15 +549,6 @@ static inline int desc_to_gpio(const struct gpio_desc *desc)
>  /* Child properties interface */
>  struct fwnode_handle;
>
> -static inline
> -struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
> -                                        const char *propname, int index,
> -                                        enum gpiod_flags dflags,
> -                                        const char *label)
> -{
> -       return ERR_PTR(-ENOSYS);
> -}
> -
>  static inline
>  struct gpio_desc *fwnode_gpiod_get_index(struct fwnode_handle *fwnode,
>                                          const char *con_id, int index,
> --
> 2.37.2.789.g6183377224-goog
>
>
> --
> Dmitry



-- 
With Best Regards,
Andy Shevchenko
