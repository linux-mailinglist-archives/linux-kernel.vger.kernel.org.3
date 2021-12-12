Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AAB471C7E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 20:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhLLTQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 14:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhLLTQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 14:16:51 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78749C061714;
        Sun, 12 Dec 2021 11:16:51 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x15so46494271edv.1;
        Sun, 12 Dec 2021 11:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2WtLGnn2I4yp5aHVDKh2fqrAHIX7oLu36/03NalXsP4=;
        b=EgZBIKxmVgoEz4pWNUPE2aX8oPPXZHoOSY8EO+6CNhbniwx/O46G5mPdpowpIUrWvo
         B7mDMYzQRkjB6uMAEBmKDAVw47LbbzzITbQuSj0AnuNrs6NWB09rq6QcI614Hn/CkxbW
         aMmPjwR0yo85bBg5rlQzBmt3VcqPoutKbnBVg6qzT5uwatUVbohldgmFXVZoYw4qu/h6
         WyA6yMrL+bK1wq1ut5q6VpM14Ug+dKH2TNRCh3Ph/mTCPpfzxWDnnR+CxajyQKRtgdkW
         iURuIsF+lblN0pN8iSItkvSBYj89V2WtMGnkE21RCC/R3HE/xdQSX6MXN0484BVdFsie
         lA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2WtLGnn2I4yp5aHVDKh2fqrAHIX7oLu36/03NalXsP4=;
        b=Z3oLAXcGjUJHKtlGiP3H3/J9dBlWJhwY9SG2fOmxTXtRTJaPz+perD68On+Dmusxya
         w+02wLmMW7oaI7udjrLurPyFJlq/nzrh92Y/GubYPtvtLJxtFfuYQJyzObguboYhHrZm
         yRNCuKi6+EGpUF4//WnflQX4dCJoAX3e6l851Eu7XeZGjZHl7PzCx5jZeliqRlMcWuk3
         0ZuNpm9scseTJ0VKgWuR+Pmlv8tU9JScShpfMaxorJrexA5w6xOKghwrVlG4a3LpQfm9
         DJq6U9A5SZRfqJUPoJQXVBG6zjs7QI6JMKHaUZTs3B0HeEUKc6K/oSMmlkQKQdCgwFmh
         Somg==
X-Gm-Message-State: AOAM530DjMLUbLCGFcyT3batwExO7w+brbMnGT3gnOOlgm/Vv6+IbXMh
        lahdmXs+tmGKy5Ghsii+g1j/K0swS60dOeVydII=
X-Google-Smtp-Source: ABdhPJyR3DAxvQYyrV8I1QdmEu4qeVhS2ErpqwnRgv9Sr93c4Er/VssSmMCJWq8ngXEsUiwVgkMERFE2A+VedCWPLS8=
X-Received: by 2002:a05:6402:270c:: with SMTP id y12mr57464631edd.258.1639336609873;
 Sun, 12 Dec 2021 11:16:49 -0800 (PST)
MIME-Version: 1.0
References: <20211129153330.37719-1-nbd@nbd.name> <20211129153330.37719-13-nbd@nbd.name>
In-Reply-To: <20211129153330.37719-13-nbd@nbd.name>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 12 Dec 2021 21:16:13 +0200
Message-ID: <CAHp75VeUn-a=Ob2i1Sxph3C4xa07yHMj7sg9R81R3STjQgSLiw@mail.gmail.com>
Subject: Re: [PATCH v5 12/13] gpio: Add support for Airoha EN7523 GPIO controller
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

On Tue, Nov 30, 2021 at 1:08 AM Felix Fietkau <nbd@nbd.name> wrote:
>
> From: John Crispin <john@phrozen.org>
>
> Airoha's GPIO controller on their ARM EN7523 SoCs consists of two banks of 32
> GPIOs. Each instance in DT is for an single bank.

a single

...

> +/**
> + * airoha_gpio_ctrl - Airoha GPIO driver data

> + *

Unnecessary blank line.

> + * @gc: Associated gpio_chip instance.
> + * @data: The data register.
> + * @dir0: The direction register for the lower 16 pins.
> + * @dir1: The direction register for the higher 16 pins.
> + * @output: The output enable register.
> + */

...

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
> +       iowrite32(output, ctrl->output);

> +       if (out)
> +               gc->set(gc, gpio, val);

Needs a fix or a comment to explain why it's fine that there is a
glitch possible.

> +       return 0;
> +}

...

> +       err = bgpio_init(&ctrl->gc, dev, 4, ctrl->data, NULL,
> +                        NULL, NULL, NULL, 0);
> +       if (err) {

> +               dev_err(dev, "unable to init generic GPIO");
> +               return err;

return dev_err_probe(...);

> +       }

-- 
With Best Regards,
Andy Shevchenko
