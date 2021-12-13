Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996A6472E7C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238700AbhLMOF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbhLMOF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:05:57 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF56C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 06:05:57 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id v1so52895355edx.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 06:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hKHNX1Cfkir1ZxZd9YI3NR7JZlbs+TQWYgY/r/rPi/c=;
        b=PTR6bp8qq3r9RbtwUkEH/QSvI/Tzogyzw2uBklC5EaHV4pRylFTLrra7oTv1iMF6sn
         Mi9OGpHwz4R5cmXWFnwb62VA8OhFikujPDKAQ51jVbkA40YfQ9CXXuv5caX0d18vh+xS
         fit2Am5ooNVDOHdCy31xhi0O8TYbG2G37ShSa1xVTFOoR61jDVeMa5KbagXpLSXHqaTM
         fApPP/jmxLWzuZnIZ7IBDEH+bt4xo7thTaD0fLFZJrINsQpC/L9wK2cekJFGdPbNKBcE
         YQUae1NvAVCZ0YTrTfunnFQbeXItUyjzhkVOTqozdj9NfSFu0f/wWfXF3hIVVZ1wbcpK
         2nXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hKHNX1Cfkir1ZxZd9YI3NR7JZlbs+TQWYgY/r/rPi/c=;
        b=lvO0FcsfD47sGXQ4nxBFEYyg0wYtoBHco07//Jg/KdI5R/zfjsuwG1rpe/48DVZ5O4
         F7RSaXGITvVfzPrRtGoE0JOUE7F8sh64G/cf0dDN66/TykUJb7ygQ2SuWzUqA3GDZQIx
         IpxcOWGrKYfQbHcUWthZepzaEFuwLMHz8c7ep+1Zu7MdoYdvaxBMcgScLIbBuf5pQ4VG
         PSQVoru1uwrhbyYpPQ838QJTVzgnhKdvfnnsFGdZ4zVfZNlIjXRYQaz8dsa1kvSPVwyY
         jBuhEFcdDWNLERCKUfA+idm6nSHmQZiLe1y4t5HuZUeniZLovKWlwDBHUpebeIfYTEXJ
         pchw==
X-Gm-Message-State: AOAM533xYvgilZnPBAntTlJbbedwc20asoJYZjn9cnmrzWanFZh5Xn1i
        6l8x/6Z8Sojf+Bzy2IBzxXOv0RRZoPRI+6v75hYnkg==
X-Google-Smtp-Source: ABdhPJzNmI8hBP7Z6jOOeh+Kk0ESRTIOrC1hq1TWFJNUBVAqrlTDSLs19adyGSmf6ivukugI6L2d1+VVmWKiOLYes7Y=
X-Received: by 2002:a17:907:2bd1:: with SMTP id gv17mr42989283ejc.231.1639404355487;
 Mon, 13 Dec 2021 06:05:55 -0800 (PST)
MIME-Version: 1.0
References: <20211210090315.4889-1-Richard_Hsu@asmedia.com.tw>
In-Reply-To: <20211210090315.4889-1-Richard_Hsu@asmedia.com.tw>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 13 Dec 2021 15:05:44 +0100
Message-ID: <CAMRc=Mc4roTrpXwDa+zqyr_95fMbZOS2+NVvkmnPtCGpAH88Sg@mail.gmail.com>
Subject: Re: [PATCH v4] gpio: amdpt: add new device ID and 24-pin support
To:     Yuchang Hsu <saraon640529@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Richard_Hsu@asmedia.com.tw,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yd_Tseng@asmedia.com.tw, Cindy1_Hsu@asmedia.com.tw,
        Andrew_Su@asmedia.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 10:03 AM Yuchang Hsu <saraon640529@gmail.com> wrote:
>
> From: Hsu Yuchang <Richard_Hsu@asmedia.com.tw>
>
> Add an ACPI HID(AMDIF031) and pin number in the pt_gpio_acpi_match.
>
> Signed-off-by: Yuchang Hsu <Richard_Hsu@asmedia.com.tw>
> ---
> Reposition and modify the changelog
>  drivers/gpio/gpio-amdpt.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpio-amdpt.c b/drivers/gpio/gpio-amdpt.c
> index bbf53e289141..13f4e2af3800 100644
> --- a/drivers/gpio/gpio-amdpt.c
> +++ b/drivers/gpio/gpio-amdpt.c
> @@ -14,6 +14,7 @@
>  #include <linux/platform_device.h>
>
>  #define PT_TOTAL_GPIO 8
> +#define PT_TOTAL_GPIO_EX 24
>
>  /* PCI-E MMIO register offsets */
>  #define PT_DIRECTION_REG   0x00
> @@ -103,7 +104,7 @@ static int pt_gpio_probe(struct platform_device *pdev)
>         pt_gpio->gc.owner            = THIS_MODULE;
>         pt_gpio->gc.request          = pt_gpio_request;
>         pt_gpio->gc.free             = pt_gpio_free;
> -       pt_gpio->gc.ngpio            = PT_TOTAL_GPIO;
> +       pt_gpio->gc.ngpio            = (uintptr_t)device_get_match_data(dev);
>  #if defined(CONFIG_OF_GPIO)
>         pt_gpio->gc.of_node          = dev->of_node;
>  #endif
> @@ -133,8 +134,9 @@ static int pt_gpio_remove(struct platform_device *pdev)
>  }
>
>  static const struct acpi_device_id pt_gpio_acpi_match[] = {
> -       { "AMDF030", 0 },
> -       { "AMDIF030", 0 },
> +       { "AMDF030", PT_TOTAL_GPIO },
> +       { "AMDIF030", PT_TOTAL_GPIO },
> +       { "AMDIF031", PT_TOTAL_GPIO_EX },
>         { },
>  };
>  MODULE_DEVICE_TABLE(acpi, pt_gpio_acpi_match);
> --
> 2.30.2
>

Applied, thanks!

Bart
