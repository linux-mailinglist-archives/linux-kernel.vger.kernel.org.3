Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267824D6EC9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 14:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiCLNII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 08:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiCLNIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 08:08:05 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D9E235849;
        Sat, 12 Mar 2022 05:06:58 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id yy13so24607879ejb.2;
        Sat, 12 Mar 2022 05:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XbcW2OOJ7LSE1WOue0Ifdm+n2BhfLZSK5oy0hShBNp8=;
        b=i0Df7eXgu5ECZdRFO999p7sSOXO9g2T7uxD/dwZdpbmYIyEDGH0YiC8IazXIqTJWBn
         wMQ369rGT7wUPS7vgp7RvYlEiI7g3oYrwJmlqXqWnast52NdFbmpeoWQ+tvYbFR4YZMb
         fFSfFrfRXO/TiiqYle1hG1QBtuSNcwWXwK9wLN/qqORlgHeb+j9U+4EqUhEIxX/GD2lj
         TOs2cr231JZiKkUUbfFGWGDDNNUHqT3NfJ22jQvHAsyJ2D7uBVNfpln+iryVbSU3/40g
         XkhOTtUvFUT0ZzwbevUSELlVswoACPIfMUFvMhzu1H7r15CEtPwkuCnZhZNPimN929ns
         OvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XbcW2OOJ7LSE1WOue0Ifdm+n2BhfLZSK5oy0hShBNp8=;
        b=2lfCr2x/u3nWi4pRay99xGDIFRlEpqTKKoBVqsebn2TQs8bdvVFfT3873rmoNf6NZM
         AKVuagpFDSN2YVZgX9mjtij8rGKh1E+O9cVTX58PA7sXmmMu5zrMRJowststJXT+eaiA
         qbtI0vNl6Fur68WlzT10yzoir6l6wX2LAQey4LLXMPVL9jitL5/fHPF3csWMdaGY1R1r
         OIcwedaWVXGI+p2EUpBvYdMMZ9eE1UOSRpHrlfSwYJ9tDZTvJQYvoa+w6cNmptPfv9e2
         fAFWOROIFXgw1T70ePcc23Dm/0D93OlvKLkY9k1hZVSdDTzYsXb+3yuRKtPA3IDTeXus
         QN2g==
X-Gm-Message-State: AOAM531YWNNG/uffIqjFkkaERmx6+TmY3Yr4nY/8bBrn//A0i70d02RX
        Apj4sqP1OcdXHMv/N5iEs6Q0jXo0y0upHVtRidA=
X-Google-Smtp-Source: ABdhPJwqtxEcJgQom5xQ63KkbG6+LO8HbumW/l63Ii9C88UxG/hHoFSg0W5PUCIoip6Fm0apWFcRrcRlu+kaAlOLc70=
X-Received: by 2002:a17:907:6e01:b0:6d0:562c:e389 with SMTP id
 sd1-20020a1709076e0100b006d0562ce389mr12346915ejc.497.1647090416933; Sat, 12
 Mar 2022 05:06:56 -0800 (PST)
MIME-Version: 1.0
References: <20220311181958.4487-1-kris@embeddedTS.com>
In-Reply-To: <20220311181958.4487-1-kris@embeddedTS.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 12 Mar 2022 15:06:20 +0200
Message-ID: <CAHp75VfVhCa-Td+X0cg-eYPtarFyKrsF92oPB2HdraCXW2CRTg@mail.gmail.com>
Subject: Re: [PATCH] gpio: ts4900: Fix comment formatting and grammar
To:     Kris Bahnsen <kris@embeddedts.com>
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

On Fri, Mar 11, 2022 at 8:20 PM Kris Bahnsen <kris@embeddedts.com> wrote:
>
> The issues were pointed out after the prior commit was applied

Missed period in the above sentence.

Otherwise LGTM,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
> ---
>  drivers/gpio/gpio-ts4900.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpio/gpio-ts4900.c b/drivers/gpio/gpio-ts4900.c
> index d918d2df4de2..ede605b8e098 100644
> --- a/drivers/gpio/gpio-ts4900.c
> +++ b/drivers/gpio/gpio-ts4900.c
> @@ -55,8 +55,9 @@ static int ts4900_gpio_direction_input(struct gpio_chip *chip,
>  {
>         struct ts4900_gpio_priv *priv = gpiochip_get_data(chip);
>
> -       /* Only clear the OE bit here, requires a RMW. Prevents potential issue
> -        * with OE and data getting to the physical pin at different times.
> +       /*
> +        * Only clear the OE bit here, requires a RMW. Prevents a potential issue
> +        * with OE and DAT getting to the physical pin at different times.
>          */
>         return regmap_update_bits(priv->regmap, offset, TS4900_GPIO_OE, 0);
>  }
> @@ -68,9 +69,10 @@ static int ts4900_gpio_direction_output(struct gpio_chip *chip,
>         unsigned int reg;
>         int ret;
>
> -       /* If changing from an input to an output, we need to first set the
> -        * proper data bit to what is requested and then set OE bit. This
> -        * prevents a glitch that can occur on the IO line
> +       /*
> +        * If changing from an input to an output, we need to first set the
> +        * GPIO's DAT bit to what is requested and then set the OE bit. This
> +        * prevents a glitch that can occur on the IO line.
>          */
>         regmap_read(priv->regmap, offset, &reg);
>         if (!(reg & TS4900_GPIO_OE)) {
> --
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko
