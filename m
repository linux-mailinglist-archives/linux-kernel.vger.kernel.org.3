Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79228475B41
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhLOO72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhLOO71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:59:27 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021F2C061401
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 06:59:27 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id a11so19636966ilj.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 06:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=FGUzSktIeEIDsFM8vyYCPEieWo/StazW6rU1WrCQ4Sc=;
        b=X0s1Sl8WfdAvOXQqlGhOh24HfvJJ3OSaVj96SkWh09YHVwiKfY/yPCVVOJF26OBdFg
         QtIR98y2KTv+W/cC6cxX0RZKWgxSJ88ScuWnb4+HzFeR8uBrOtHCeVeX/w6iXQGgUf8f
         IaI8NhsxEBLFCtYJWzwpuqh/sDDRk1fVkHEs04l8I7vacetXVtot/8GsPPgZdC+PALhx
         0vFG09L+UJ2zXlsUiXNcen53SYy16qg9FC21A+4oMS6ouR0TQZggUHIlD27A8BqbQNwZ
         euA+tLdnegY5HO5BcaLCYRpqVTS8PYDr9XqG9YI+oMFbmCoiXQ2Xb0m1vXGnXOkcrfnT
         Tf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=FGUzSktIeEIDsFM8vyYCPEieWo/StazW6rU1WrCQ4Sc=;
        b=AX+umBlvHMUwia1bM8fg0CZ0uM9/iT7boPE6in0BJVEU4EOQ/NoX5p8ePg7IRyUhpK
         tO1S+TA30lDABlQxfokQk58bI7+ac6wXEnNatH2MT+BuhY0tJqoYDQOOfXrzw5k8xv9T
         2SPNJ+sc7XcSrLZFDXW7pc5dsQ66MVJzL1dXHqmb3O+kkkddJH2cULvJFr49t9EIhmqy
         ONwfg+1sY3Qdfju5w6X7Oq/KkMGBBNKK9aOGy436us1mVxR7LDl+0GVr5dky8sHV+QdJ
         jjlnqyY7DrMOQpy4LsZgXFT9hs4qVDBtibLKY2Un0GhpwIuW62RZBs3AaL0D7FOvGWtw
         W7MA==
X-Gm-Message-State: AOAM530656OQ+nO6lHLvucF4Y0cF8zEXyLjTZprUlVXsqaenTd8bGc6Z
        6FYCjJ0deLby8CI/yi/dPL2a
X-Google-Smtp-Source: ABdhPJyr96cALkbCjBKoe8urBSmD4Rj9c9Bsxrk9TkZIYGeCPzjxC8N2fJsHIUld2UFGjLX3IVrBUQ==
X-Received: by 2002:a05:6e02:1c85:: with SMTP id w5mr6640419ill.211.1639580366235;
        Wed, 15 Dec 2021 06:59:26 -0800 (PST)
Received: from ?IPv6:2601:281:8300:4e0:2ba9:697d:eeec:13b? ([2601:281:8300:4e0:2ba9:697d:eeec:13b])
        by smtp.gmail.com with ESMTPSA id i1sm1086042ilv.54.2021.12.15.06.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 06:59:25 -0800 (PST)
Message-ID: <9cfbcc99f8a70ba2c03a9ad99f273f12e237e09f.camel@egauge.net>
Subject: Re: [PATCH v5 1/2] wilc1000: Add reset/enable GPIO support to SPI
 driver
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Claudiu.Beznea@microchip.com, Ajay.Kathat@microchip.com
Cc:     adham.abozaeid@microchip.com, davem@davemloft.net,
        devicetree@vger.kernel.org, kuba@kernel.org, kvalo@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, robh+dt@kernel.org
Date:   Wed, 15 Dec 2021 07:59:05 -0700
In-Reply-To: <d55a2558-b05d-5995-b0f0-f234cb3b50aa@microchip.com>
References: <20211215030501.3779911-1-davidm@egauge.net>
         <20211215030501.3779911-2-davidm@egauge.net>
         <d55a2558-b05d-5995-b0f0-f234cb3b50aa@microchip.com>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-12-15 at 06:41 +0000, Claudiu.Beznea@microchip.com wrote:
> On 15.12.2021 05:05, David Mosberger-Tang wrote:
> > 
> +static int wilc_parse_gpios(struct wilc *wilc)
> > +{
> > +       struct spi_device *spi = to_spi_device(wilc->dev);
> > +       struct wilc_spi *spi_priv = wilc->bus_data;
> > +       struct wilc_gpios *gpios = &spi_priv->gpios;
> > +
> > +       /* get ENABLE pin and deassert it (if it is defined): */
> > +       gpios->enable = devm_gpiod_get_optional(&spi->dev,
> > +                                               "enable", GPIOD_OUT_LOW);
> > +       /* get RESET pin and assert it (if it is defined): */
> > +       if (gpios->enable) {
> > +               /* if enable pin exists, reset must exist as well */
> > +               gpios->reset = devm_gpiod_get(&spi->dev,
> > +                                             "reset", GPIOD_OUT_HIGH);
> 
> As far as I can tell form gpiolib code the difference b/w GPIOD_OUT_HIGH
> and GPIOD_OUT_LOW in gpiolib is related to the initial value for the GPIO.

Yes.

> Did you used GPIOD_OUT_HIGH for reset to have the chip out of reset at this
> point?

No, ~RESET is an active-low signal.  GPIOD_OUT_LOW should really be
called GPIOD_OUT_DEASSERTED or something like that.  The code ensures
that the chip is in RESET and ~ENABLEd after parsing the GPIOs.

> > +               if (IS_ERR(gpios->reset)) {
> > +                       dev_err(&spi->dev, "missing reset gpio.\n");
> > +                       return PTR_ERR(gpios->reset);
> > +               }
> > +       } else {
> > +               gpios->reset = devm_gpiod_get_optional(&spi->dev,
> > +                                                      "reset", GPIOD_OUT_HIGH);
> > +       }
> > +       return 0;
> > +}
> > +
> > +static void wilc_wlan_power(struct wilc *wilc, bool on)
> > +{
> > +       struct wilc_spi *spi_priv = wilc->bus_data;
> > +       struct wilc_gpios *gpios = &spi_priv->gpios;
> > +
> > +       if (on) {
> > +               gpiod_set_value(gpios->enable, 1);      /* assert ENABLE */
> > +               mdelay(5);
> > +               gpiod_set_value(gpios->reset, 0);       /* deassert RESET */
> 
> From what I can tell from gpiolib code, requesting the pin from device tree
> with:
> 
> +        reset-gpios = <&pioA 6 GPIO_ACTIVE_LOW>;
> 
> makes the value written with gpiod_set_value() to be negated, thus the 0
> written here is translated to a 1 on the pin. Is there a reason you did it
> like this?

Yes, of course.  RESET is an active-low signal, as defined in the
datasheet.

> Would it have been simpler to have both pins requested with
> GPIO_ACTIVE_HIGH and here to do gpiod_set_value(gpio, 1) for both of the
> pin. In this way, at the first read of the code one one would have been
> telling that it does what datasheet specifies: for power on toggle enable
> and reset gpios from 0 to 1 with a delay in between.

I think you're confusing 0 and 1 with low-voltage and high-voltage.  0
means de-assert the signal, 1 means assert the signal.  Whether that
translates to a low voltage or a high voltage depends on whether the
signal a active-low or active-high.

> 
> 
> > +       } else {
> > +               gpiod_set_value(gpios->reset, 1);       /* assert RESET */
> > +               gpiod_set_value(gpios->enable, 0);      /* deassert ENABLE */
> 
> I don't usually see comments near the code line in kernel. Maybe move them
> before the actual code line or remove them at all as the code is impler enough?

You're kidding, right?

  --david

