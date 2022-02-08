Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51764AD6BF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358364AbiBHL3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356443AbiBHKqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:46:49 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D87C03FEC3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 02:46:48 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id m11so36540130edi.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 02:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=svMcsljcPvXZuq090tCyPbwiQT93klPS1p7hFo1NwxU=;
        b=jaJiR87YLSg2r8NPKRNACrNKcr7iEQiUcgkw6d+7Y0ody3WwHgD37jFEgdgvciprNA
         ++0newFTrvaOE/zj9otYJiTv3cJjLwBSxXpCVp7W0KN0K4UIliBPyu1KdOHdKLv7BaUY
         oSn9zVz6KHDHZ1RHgTtA2upAG0VC4dYLBD954ZjrmwK81VkPuSOjP+Btd3uFnL8GI1wP
         cxZKaqUjKPFtRYVioGe4Z1SvokmOxsxny20MsX9V7cVYP+XAqoY0oTcyODWVC3pmkb8L
         y9sCpbMReoxCsg3/IhB6qpB2hKb9EowFMMXV9jjxb0I8qXYCyBJB3ngK5ZV2QEZz64Zw
         qH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=svMcsljcPvXZuq090tCyPbwiQT93klPS1p7hFo1NwxU=;
        b=sb1jUKNiGM9zl9qXneaC0cVfPn3qkb3/gnKmg/BFYPgdkWdy0IBcCjpPVvpCy0LNRR
         TDJDGzE8JbEm0GjMHYi47nPVgdC/Ef/rYVP3Fkaw8Zl9BdYN/RA7aEnaUeocpVABwB0A
         5X5yTTQVrKKbtQxA5wQDMOuz3WGgrNvKqzKox+If0eVnIRtR+rMhBWKgDtxhf7nd97jr
         QMPahieJPfH7GkSXgBeY1TqZhT+jfDuBHn5hXr8dlMribXJSUrZPfLKZHo+2xEb0vzNX
         /Qy51UXKo3hnUrHCe5yvxOJo3Dg7ok9r76FXGJP7OJu2qdGGfkpEcKJV+wx8FeiKvolk
         g7oA==
X-Gm-Message-State: AOAM531oNGIXbkwZhPjYQVswoihzf3QbwRD0IPEzOzJxlZYkSF7Rhk+D
        lcNnOkiHmaY08/sVslQsqaK7uyMxlNAp9IkpIp0Bng==
X-Google-Smtp-Source: ABdhPJyIh/CJWfyaIsCsHmqNruVAUcd+/I2Wu5ksso+EiWAmuFVB62j0tun9U6GaPg5Bl1HrXqlKACuF47LskGkzfVc=
X-Received: by 2002:a05:6402:143:: with SMTP id s3mr3741176edu.7.1644317206913;
 Tue, 08 Feb 2022 02:46:46 -0800 (PST)
MIME-Version: 1.0
References: <20220202104937.146827-1-brgl@bgdev.pl> <YfpomMEgiTh8kjGJ@smile.fi.intel.com>
In-Reply-To: <YfpomMEgiTh8kjGJ@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 8 Feb 2022 11:46:36 +0100
Message-ID: <CAMRc=MfjkeEkdzyPUN8h6h+0iA+wFi1tVAWLOHLEY2VvKXoi8g@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: make struct comments into real kernel docs
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 12:19 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Feb 02, 2022 at 11:49:37AM +0100, Bartosz Golaszewski wrote:
> > We have several comments that start with '/**' but don't conform to the
> > kernel doc standard. Add proper detailed descriptions for the affected
> > definitions and move the docs from the forward declarations to the
> > struct definitions where applicable.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> A few comments below.
>
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> > ---
> >  drivers/gpio/gpiolib.h        | 31 +++++++++++++++++++++++++++++++
> >  include/linux/gpio/consumer.h | 35 ++++++++++++++++-------------------
> >  2 files changed, 47 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
> > index 30bc3f80f83e..0025701b7641 100644
> > --- a/drivers/gpio/gpiolib.h
> > +++ b/drivers/gpio/gpiolib.h
> > @@ -72,6 +72,20 @@ struct gpio_device {
> >  /* gpio suffixes used for ACPI and device tree lookup */
> >  static __maybe_unused const char * const gpio_suffixes[] = { "gpios", "gpio" };
> >
> > +/**
> > + * struct gpio_array - Opaque descriptor for a structure of GPIO array attributes
>
> > + *
>
> I dunno we need these blank lines.

I think it looks better. Some docs use it some don't, there's no standard.

>
> > + * @desc:            Array of pointers to the GPIO descriptors
> > + * @size:            Number of elements in desc
>
>   in @desc
>
> or
>
>   in the array of the descriptor pointers
>
> > + * @chip:            Parent GPIO chip
> > + * @get_mask:                Get mask used in fastpath.
> > + * @set_mask:                Set mask used in fastpath.
> > + * @invert_mask:     Invert mask used in fastpath.
>
> Why some of the descriptions are with grammar period and some w/o?
>
> > + *
> > + * This structure is attached to struct gpiod_descs obtained from
> > + * gpiod_get_array() and can be passed back to get/set array functions in order
> > + * to activate fast processing path if applicable.
> > + */
> >  struct gpio_array {
> >       struct gpio_desc        **desc;
> >       unsigned int            size;
> > @@ -96,6 +110,23 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
> >  extern spinlock_t gpio_lock;
> >  extern struct list_head gpio_devices;
> >
> > +
> > +/**
> > + * struct gpio_desc - Opaque descriptor for a GPIO
> > + *
> > + * @gdev:            Pointer to the parent GPIO device
> > + * @flags:           Binary descriptor flags
> > + * @label:           Name of the consumer
> > + * @name:            Line name
> > + * @hog:             Pointer to the device node that hogs this line (if any)
> > + * @debounce_period_us:      Debounce period in microseconds
> > + *
> > + * These are obtained using gpiod_get() and are preferable to the old
> > + * integer-based handles.
> > + *
> > + * Contrary to integers, a pointer to a gpio_desc is guaranteed to be valid
>
> &struct gpio_desc
>
> > + * until the GPIO is released.
> > + */
> >  struct gpio_desc {
> >       struct gpio_device      *gdev;
> >       unsigned long           flags;
> > diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
> > index 3ad67b4a72be..3ffb054fafbd 100644
> > --- a/include/linux/gpio/consumer.h
> > +++ b/include/linux/gpio/consumer.h
> > @@ -8,27 +8,16 @@
> >  #include <linux/err.h>
> >
> >  struct device;
> > -
> > -/**
> > - * Opaque descriptor for a GPIO. These are obtained using gpiod_get() and are
> > - * preferable to the old integer-based handles.
> > - *
> > - * Contrary to integers, a pointer to a gpio_desc is guaranteed to be valid
> > - * until the GPIO is released.
> > - */
> >  struct gpio_desc;
> > -
> > -/**
> > - * Opaque descriptor for a structure of GPIO array attributes.  This structure
> > - * is attached to struct gpiod_descs obtained from gpiod_get_array() and can be
> > - * passed back to get/set array functions in order to activate fast processing
> > - * path if applicable.
> > - */
> >  struct gpio_array;
> >
> >  /**
> > - * Struct containing an array of descriptors that can be obtained using
> > - * gpiod_get_array().
> > + * struct gpio_descs - Struct containing an array of descriptors that can be
> > + *                     obtained using gpiod_get_array()
> > + *
> > + * @info:    Pointer to the opaque gpio_array structure
> > + * @ndescs:  Number of held descriptors
> > + * desc:     Array of pointers to GPIO descriptors
>
> Missed @?
>
> >   */
> >  struct gpio_descs {
> >       struct gpio_array *info;
> > @@ -43,8 +32,16 @@ struct gpio_descs {
> >  #define GPIOD_FLAGS_BIT_NONEXCLUSIVE BIT(4)
> >
> >  /**
> > - * Optional flags that can be passed to one of gpiod_* to configure direction
> > - * and output value. These values cannot be OR'd.
> > + * enum gpiod_flags - Optional flags that can be passed to one of gpiod_* to
> > + *                    configure direction and output value. These values
> > + *                    cannot be OR'd.
> > + *
> > + * @GPIOD_ASIS:                      Don't change the direction
>
> Don't change anything
>
> (Not only direction, also the output value. Some hardware allows to change
> output buffer value even if the line is configured as input).
>
> > + * @GPIOD_IN:                        Set lines to input mode
> > + * @GPIOD_OUT_LOW:           Set lines to output and drive them low
> > + * @GPIOD_OUT_HIGH:          Set lines to output and drive them high
> > + * @GPIOD_OUT_LOW_OPEN_DRAIN:        Set lines to open-drain output and drive them low
> > + * @GPIOD_OUT_HIGH_OPEN_DRAIN:       Set lines to open-drain output and drive them high
> >   */
> >  enum gpiod_flags {
> >       GPIOD_ASIS      = 0,
> > --
> > 2.30.1
> >
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Fixed the rest. Thanks!

Bart
