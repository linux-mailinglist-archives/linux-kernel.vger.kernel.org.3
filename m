Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89EC4FC307
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 19:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348806AbiDKRSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 13:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348798AbiDKRSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 13:18:16 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A483B14020;
        Mon, 11 Apr 2022 10:16:01 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id p15so32261748ejc.7;
        Mon, 11 Apr 2022 10:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MgmtuCS+l8Bi3E1PJDVdWqIzu5rnK5V3tfK8fyveRSg=;
        b=ebuctbaF3T2FTs1D6kyfR64/XsbMoCuPbtD1GOBE7cnaF+jScRtJcMmITRb4YI43X9
         zVA+d677MwnwqhyOHok8i/C+lB9wy3lcns2ft69SAH3YlOhqEmOnwDq4f0yRM3LjkhJB
         /Oyd6xezp1RHv979WiW07c2wjRky60Jdgb9yKaXWYckR4ELZVujJ4wWzPQp3EpvS5Trc
         wcH7VCNphOa01sAwWt87YU4AsJt6T0OJjWP8S6//N6qjmJmSFM8w+bgPO1pthWIlwzm/
         YZbbeHVsX4k4fwl3/mpcHKncYGoouXWU/9PuV7A0iXr4GNO5hmdGttJgAckgSK/80Lpo
         zY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MgmtuCS+l8Bi3E1PJDVdWqIzu5rnK5V3tfK8fyveRSg=;
        b=JPUlw9UYfXK8OuVmSMB7AK1R/NjatO0RL6IYB8AVPjAkhdn2fDDgFkV+9BGKyWJOVq
         +6/unRPW83tMILnXfAtezWPQVayacNcantzqk/M5Pai9gfl4qCDJbSUFmofL/xIE0dcb
         rHDus1/3c0oUFzuTOQGhvEMYMfPJQ3WZ/2xqpxvSz5PEuQr33z6ENpP9KDXYjTwTx2Gb
         RoPmvKr/iz1fHFTKur2XBATFjuTJQrkr4yuTBnG2iOpVuWh6flwEPH0j5Z2zGnDzhflD
         IXv2jqRp8ZLP420wfjEPPFfT0W9v7GoKGi7St0kRdDe6H/yepinj6HQQiWVRDeX+0Y2/
         rtbg==
X-Gm-Message-State: AOAM532HQMOljppCxHuOfIU2bk36xWHKqLegFTyARdKG2U+lMDXDGJjr
        xjRD19igs720G4PVXxfRF6Yryh2twKRjo0Uxc70Bee3RBNZ6yg==
X-Google-Smtp-Source: ABdhPJzyrjtZIk8+uXRkc4UER+ZPViI5yBFCuez7IxKote8FkKICp1HUnFGTpzCJtpp8o8cnSOitoQgi7jnGXY+LDr0=
X-Received: by 2002:a17:907:8a05:b0:6e8:441c:358d with SMTP id
 sc5-20020a1709078a0500b006e8441c358dmr17841941ejc.77.1649697360160; Mon, 11
 Apr 2022 10:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220408184104.13665-1-markuss.broks@gmail.com> <20220408184104.13665-3-markuss.broks@gmail.com>
In-Reply-To: <20220408184104.13665-3-markuss.broks@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Apr 2022 20:11:46 +0300
Message-ID: <CAHp75VfgSphDN9TVgeiPGdcDVqutcGnTURqu6r143sjJDsPXUA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] leds: ktd2692: Make aux-gpios optional
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy
        Shevchenko <andy.shevchenko@gmail.com>," 
        <~postmarketos/upstreaming@lists.sr.ht>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
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

On Sat, Apr 9, 2022 at 8:14 AM Markuss Broks <markuss.broks@gmail.com> wrote:
>
> Make the AUX pin optional, since it isn't a core part of functionality,
> and the device is designed to be operational with only one CTRL pin.
>
> Also pick up maintenance for the LED driver and the yaml bindings.

It's polite to Cc reviewers of your previous versions of the series.

While this patch is fine to me,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
one comment below.

> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  MAINTAINERS                       | 6 ++++++
>  drivers/leds/flash/leds-ktd2692.c | 6 +++---
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2db49ea7ae55..8ef5667a1d98 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10479,6 +10479,12 @@ S:     Maintained
>  F:     Documentation/devicetree/bindings/leds/backlight/kinetic,ktd253.yaml
>  F:     drivers/video/backlight/ktd253-backlight.c
>
> +KTD2692 FLASH LED DRIVER
> +M:     Markuss Broks <markuss.broks@gmail.com>
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/leds/backlight/kinetic,ktd2692.yaml
> +F:     drivers/leds/flash/leds-ktd2692.yaml
> +
>  KTEST
>  M:     Steven Rostedt <rostedt@goodmis.org>
>  M:     John Hawley <warthog9@eaglescrag.net>
> diff --git a/drivers/leds/flash/leds-ktd2692.c b/drivers/leds/flash/leds-ktd2692.c
> index f341da1503a4..01ceea83af67 100644
> --- a/drivers/leds/flash/leds-ktd2692.c
> +++ b/drivers/leds/flash/leds-ktd2692.c
> @@ -284,9 +284,9 @@ static int ktd2692_parse_dt(struct ktd2692_context *led, struct device *dev,
>                 return ret;
>         }
>
> -       led->aux_gpio = devm_gpiod_get(dev, "aux", GPIOD_ASIS);
> -       ret = PTR_ERR_OR_ZERO(led->aux_gpio);
> -       if (ret) {
> +       led->aux_gpio = devm_gpiod_get_optional(dev, "aux", GPIOD_ASIS);
> +       if (IS_ERR(led->aux_gpio)) {
> +               ret = PTR_ERR(led->aux_gpio);
>                 dev_err(dev, "cannot get aux-gpios %d\n", ret);
>                 return ret;

Now you may consider switching to dev_err_probe() in a separate patch:

       if (IS_ERR(led->aux_gpio))
               return dev_err_probe(dev, PTR_ERR(led->aux_gpio),
"cannot get aux-gpios\n");

>         }

-- 
With Best Regards,
Andy Shevchenko
