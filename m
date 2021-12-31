Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5C34823EF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 13:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhLaMPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 07:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhLaMPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 07:15:09 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEDFC06173E
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 04:15:09 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id g11so60076034lfu.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 04:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qA48Fk3mQBHDUQYEpc8DXFnUfIf/OAvjGHgizTaa2Rs=;
        b=Dd9Hc2hoiQD56GDie5hYLl56IxuoyREYBA/QBeDuW83mVjBF5S+ttDPs1ypjV4KY5n
         qQu7LWeBnYgsbZSY2UxPPyQ3jo9jzhIttuWh1bOjR9cTe+8JsG8E7ZmtQftPeo5NXKHr
         3rCPvkwjP0dw5HR3BOFRrrCMW+7TnJAPQtuh0FNkbPWMxaOxdGWNnKlS24qgWQx/X6H5
         l1PJYZtl/omcNOe4fOlTxilJUGUOta8YRQHjLkVaL5meRIvLnnTnA2Ct3XVZmyZwS1U/
         jEAZDY1ICBe35GQQcLdzEqftwDKpQXdJA31/eFYrBqrwT8NfUhGHeIQQGk9RHvF9l1eT
         gW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qA48Fk3mQBHDUQYEpc8DXFnUfIf/OAvjGHgizTaa2Rs=;
        b=E+SUl5k3lw2Yc2aCiN7/T96ASFCalFdJqzbxue/poWTPet//MdhMjSCAfpU1ENrUYv
         v3Tar0a/+h/CwCwRA2f8EWgE8F+pcK5iIXuVxuJGXMwqpRTaEkyFU0P9Bexkr2sXTYsR
         qf/Rzuotv6bRCoXvJyZMlK6DHc0/YFuFk0sPh+J2cE6avXt0ILzBYjCxJFc2KWWHk8sZ
         OV18VxnM8eXnVWTQ/wG2v1h2HOkSkkc5ZQLas79QcTNxYPMHYA1AnAAW0LJwb+2VkzFt
         EEqzW6IIfBA1oGTKTvO7FLJRGCnKHjNnWJCOkVwN9nJtz/rtl7UBuYWnmLgKRniNA7H7
         bSSw==
X-Gm-Message-State: AOAM530hrkyEfYxc+1gcjesr6IUFoQXVhAzRaKlxYlrnnrWuyyO8RT1Z
        kL7ZiSS/21WJC5nigTDq6PnWesYiIZwh0RCaTfSFUA==
X-Google-Smtp-Source: ABdhPJxB39SYIrqnEbN1Ilx/4u6YrucaTYRt8Dnw/aiO1ez8cHGoyYDvdb9NnCiH6rmQEcuBQzLFiuVZRWuE+q1QEq8=
X-Received: by 2002:a19:6748:: with SMTP id e8mr2099004lfj.358.1640952907072;
 Fri, 31 Dec 2021 04:15:07 -0800 (PST)
MIME-Version: 1.0
References: <20211222030634.33816-1-michael@allwinnertech.com>
 <CAPDyKFoNuWX76Haq0MfvukbHR8mMq0rX7qC+o_ZhEAxAwwpBbQ@mail.gmail.com> <2021123116275961132724@allwinnertech.com>
In-Reply-To: <2021123116275961132724@allwinnertech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 31 Dec 2021 13:14:30 +0100
Message-ID: <CAPDyKFpnTk9Ky-zr-dakTZJr1N_65_6py9=3_78vwOR930apEQ@mail.gmail.com>
Subject: Re: Re: [PATCH 1/3] mmc:sunxi-mmc:add support on discrete device
 power supply
To:     "michael@allwinnertech.com" <michael@allwinnertech.com>
Cc:     mripard <mripard@kernel.org>, wens <wens@csie.org>,
        samuel <samuel@sholland.org>,
        "andre.przywara" <andre.przywara@arm.com>,
        "jernej.skrabec" <jernej.skrabec@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Dec 2021 at 09:28, michael@allwinnertech.com
<michael@allwinnertech.com> wrote:
>
> > From: Ulf Hansson
> > Date: 2021-12-29 00:49
> > To: Michael Wu
> > CC: mripard; wens; samuel; andre.przywara; jernej.skrabec; linux-mmc; linux-arm-kernel; linux-sunxi; linux-kernel
> > Subject: Re: [PATCH 1/3] mmc:sunxi-mmc:add support on discrete device power supply
> > On Wed, 22 Dec 2021 at 04:07, Michael Wu <michael@allwinnertech.com> wrote:
> > >
> > > Because some platform has no regulator, only use discrete devices
> > > to supply power,For this situation, to use sd/mmc card, we add ocr manually
> > >
> > > Signed-off-by: Michael Wu <michael@allwinnertech.com>
> > > ---
> > >  drivers/mmc/host/sunxi-mmc.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> > > index 2702736a1c57..afeefead6501 100644
> > > --- a/drivers/mmc/host/sunxi-mmc.c
> > > +++ b/drivers/mmc/host/sunxi-mmc.c
> > > @@ -1300,6 +1300,14 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
> > >         if (ret)
> > >                 return ret;
> > >
> > > +       /**
> > > +        * Some platforms has no regulator. Discrete devices are used instead.
> > > +        * To support sd/mmc card, we need to add ocr manually.
> > > +        */
> > > +       if (!host->mmc->ocr_avail)
> > > +               host->mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
> > > +
> >
> > Rather than doing this, I suggest you hook up a fixed vmmc regulator in the DTS.
> >
> > Nevertheless, it seems reasonable to check that the ocr_avail gets set
> > up correctly. And if it doesn't, perhaps we should print a warning and
> > return an error code.
> >
> > > +
> > >         host->reg_base = devm_platform_ioremap_resource(pdev, 0);
> > >         if (IS_ERR(host->reg_base))
> > >                 return PTR_ERR(host->reg_base);
> >
> > Kind regards
> > Uffe
>
> Dear Uffe,
> Thanks for your suggestion. It is a better solution.
> I've modified my patch. Please check if it's reasonable. If it is, I'll re-sumbit it later.
>
> ---
> Subject: [PATCH v2] mmc: sunxi-mmc: check ocr_avail on resource request
>
> Some platforms have no regulator, discrete power devices are used instead.
> However, sunxi_mmc_probe does not catch this exception when regulator is
> absent in DTS. This leads to sd or eMMC init failure.
> To solve this, a fixed vmmc regulator must be hooked up in DTS, like this:
> reg_dummy_vmmc: dummy_vmmc {
>         compatible = "regulator-fixed";
>         regulator-name = "dummy-vmmc";
>         regulator-min-microvolt = <500000>;
>         regulator-max-microvolt = <3500000>;

The min/max should be set to the same value as you can't really change
the voltage levels.

If you know the voltage level that is supplied for your platform, then
state this value - otherwise I would suggest picking 3.3V, which is
rather commonly used for MMC/SD.

> };
> mmc0:mmc@4020000 {
>         compatible = "allwinner,sun50i-a100-emmc";
>         device_type = "mmc0";
>         vmmc-supply = <&reg_dummy_vmmc>;
> }
> In this patch, we print an error message and abort the probe process if
> the regulator is not specified in DTS.
>
> Signed-off-by: Michael Wu <michael@allwinnertech.com>
> ---
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 2702736..0da74bd 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1300,6 +1300,11 @@
>         if (ret)
>                 return ret;
>
> +       if (!host->mmc->ocr_avail) {
> +               dev_err(&pdev->dev, "Could not get mmc regulator\n");
> +               return -EINVAL;
> +       }
> +
>         host->reg_base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(host->reg_base))
>                 return PTR_ERR(host->reg_base);
>
> Best Regards,
> Michael Wu

Yep, this looks good to me!

Kind regards
Uffe
