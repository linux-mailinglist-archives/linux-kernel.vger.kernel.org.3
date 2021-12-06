Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6765E469A66
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346792AbhLFPHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345707AbhLFPEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:04:51 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA72C0698C6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 07:01:22 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id r11so43877577edd.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 07:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cqcfDHprQ4uU7aL7/WjRV9bJONnOkLxV2egvULjti60=;
        b=0fWZ87P6CZJWpqLZkAx3tWoR+y36lmzy+x5groU378oJY+YsBomyFsb/6qEf7peE0x
         LVhk4JN7CTX1CH2JiQ5l2bWbCFIosNHapX7KCdJgESG1PdCV5bKsub1qXbFg5GyARLFc
         uQJvH8GO+s1zbd1OZL20oCzb+XjNGZ7aL5V2halu/Moyl51OfUeGQkzTu7HKjkwt1xYy
         1T9/6q3yOFokI/LnSFe12K9xaQbjEmKIiGRB44d2ODoIbjbSLR/I+34HOUJZTsORoANp
         9/ICtkWJt0Sbzx7CGqVWsQ+C7lHYRjN05qBICFt5JSBgqFIpy4+B6wnryjn0EJZGKEZL
         szJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cqcfDHprQ4uU7aL7/WjRV9bJONnOkLxV2egvULjti60=;
        b=VtWOdaJ+HtVf67KhoRU2yGrPR6bLL+r36cEd7byq5qi+kx5QmbWpqujWxshpID5IWU
         UXhLspQmHNgSXhXj+fArXXLzlNBtS943lG5hKuqlxpp7XOlNrN6A7H7R/QIEy9A4kjEv
         xQgko8vY/HLdLvnwLaLevsN11ZFsw6X7pfoPoOhWu+v+/MWHsqK79du3GcGkYrqdfAo0
         29qQHGi1QMjrqpZmnD5X4bf3CswebrKDBf6dQG20dYsDuHgNudnCkcL8MuzUTliMOAjQ
         hHmBXZXK/ifpy+FEbi9wDwePrwYvHo+/uyrkTYhqnV9Ygk+SKWblOtcHvzQzmgZnXajJ
         sXGQ==
X-Gm-Message-State: AOAM5320qHKFTxlodBUHNeFfmCOkiXeyqrb06AzScdNONp4Z/gAO2ZJl
        lGLn9bhuC2iDORvBIEgAxs0EVF2uSfvHYVUVNi6asA==
X-Google-Smtp-Source: ABdhPJyQ4jAc5EsPxMas1Gud51cuGcTEsUHRqQnMv3uG/phRZoYlWhd7byfzl+Hir6L7anVAwzIjVkxBHvSbHFHX0cE=
X-Received: by 2002:a50:e611:: with SMTP id y17mr55990370edm.270.1638802881055;
 Mon, 06 Dec 2021 07:01:21 -0800 (PST)
MIME-Version: 1.0
References: <20211202134034.14048-1-brgl@bgdev.pl>
In-Reply-To: <20211202134034.14048-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 6 Dec 2021 16:01:10 +0100
Message-ID: <CAMRc=MeFFiD70+Pj=yDcR=SxEPTtSuMjmxjz7r2RUPfMQb=6jg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] gpiolib: improve coding style for local variables
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Johan Hovold <johan@kernel.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 2:40 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> Drop unneeded whitespaces and put the variables of the same type
> together for consistency with the rest of the code.
>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v1 -> v2:
> - no changes
>
> v2 -> v3:
> - keep initializations on separate lines
>
> v3 -> v4:
> - no changes
>
>  drivers/gpio/gpiolib.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index abfbf546d159..ede8b8a7aa18 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -594,11 +594,11 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>                                struct lock_class_key *request_key)
>  {
>         struct fwnode_handle *fwnode = gc->parent ? dev_fwnode(gc->parent) : NULL;
> -       unsigned long   flags;
> -       int             ret = 0;
> -       unsigned        i;
> -       int             base = gc->base;
>         struct gpio_device *gdev;
> +       unsigned long flags;
> +       int base = gc->base;
> +       unsigned int i;
> +       int ret = 0;
>
>         /*
>          * First: allocate and populate the internal stat container, and
> --
> 2.25.1
>

Queued for next.

Bart
