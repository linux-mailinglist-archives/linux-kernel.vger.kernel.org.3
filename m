Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980095A9A1A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbiIAOWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbiIAOVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:21:45 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DA07170D;
        Thu,  1 Sep 2022 07:21:26 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id e28so13499212qts.1;
        Thu, 01 Sep 2022 07:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=2guHmUXUEgWXxY+gDQPqQNXNAZmLdx374eGlGLm8JNw=;
        b=a8+nJXBWvMhetvStRLQPqahJmbFu7Dao9kOOfWM86IQXi8DH3BFzjepBnqbbEA653i
         9oU5l1U2WPuFJ0V15f4G6OZklMqGb8r3YWIBOdNYxKYqhUi4//ATYWy/sXa04Sv9sASg
         FIlujEr1uXU+SsAzDwufG5Pw0F5lekxMciTGb1/a25LxOkawDHkUcpoZDxMZFz1HCWfm
         K9JlSzEpPuN2ulZvEkthvMp7ZYf80tzZQPua69Unb8XWUdsL7PZCS2H60IFIauE0cnRs
         AGOWzsdBm/h/BOCm9sySjCfi8evVGHOEO7p6nYfQMI++yXnKj22f8Wqdry2pV2HMKwpW
         Fj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=2guHmUXUEgWXxY+gDQPqQNXNAZmLdx374eGlGLm8JNw=;
        b=LsPkwHI7XUA7FekJ5GMfuqJPWcppc5hZl0QVR+pk/5TuxJWWRJW70dVhUyUmZIAiKT
         1EQwvkbUHZkkvy4hlEzzM0WaklH1xSniXmGeFHWwT5zkkyNduvmbgWXKoLEUfE4Lp/Dm
         ylE8n16PufRHdSl0No1mdVBoMDAureTadW4mOCRgsq2xTyI+t9LjIDxT0McTxeIB8MNI
         ZA8Nd0+Yoso+U15rlfnDWuW0RIPI0VRKRWWXVJJ3tCOfDl8gjDjMUqxRFPOhU4FQ0hKt
         huNtBD9gA7OR8P1QEVPtHVq9Hd0bmz6g1eGhy6Cu5rPwYHcQGOO23qnw2mDTypEk+m7p
         zevw==
X-Gm-Message-State: ACgBeo0VZPdTvUREaqUZEUyyAtxEJ078zVQr+UplrZUyOS00566Z6uzm
        vLzoenL2HD0AzWtBp6joV5fLh8WQkcpY8yo4fGs=
X-Google-Smtp-Source: AA6agR7tDKBNZvk98n4eDs3dYrIf0a4H7sAbgfySK+duWCSFYdeYrDXJ7C5A15IlzUcI1brpxEFUWkcd9arrf4p/w+o=
X-Received: by 2002:a05:622a:40a:b0:343:77ba:727f with SMTP id
 n10-20020a05622a040a00b0034377ba727fmr24092510qtx.481.1662042085616; Thu, 01
 Sep 2022 07:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220901041146.3652287-1-o.rempel@pengutronix.de> <20220901041146.3652287-3-o.rempel@pengutronix.de>
In-Reply-To: <20220901041146.3652287-3-o.rempel@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Sep 2022 17:20:49 +0300
Message-ID: <CAHp75VcXS0inektGRKPCgqHv81c8gL29iiJSQKOL-c4u9kcz6A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] iio: adc: tsc2046: silent spi_device_id warning
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
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

On Thu, Sep 1, 2022 at 7:12 AM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> Add spi_device_id to silent following kernel runtime warning:
> "SPI driver tsc2046 has no spi_device_id for ti,tsc2046e-adc".

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes v3:
> - add missing point
> - remove unneeded blank line
> - assignment id at the definition line
> changes v2:
> - attach actual driver_data
> - use spi_get_device_id fallback
> ---
>  drivers/iio/adc/ti-tsc2046.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
> index bbc8b4137b0b1..d5d799972fefd 100644
> --- a/drivers/iio/adc/ti-tsc2046.c
> +++ b/drivers/iio/adc/ti-tsc2046.c
> @@ -762,6 +762,11 @@ static int tsc2046_adc_probe(struct spi_device *spi)
>         }
>
>         dcfg = device_get_match_data(dev);
> +       if (!dcfg) {
> +               const struct spi_device_id *id = spi_get_device_id(spi);
> +
> +               dcfg = (const struct tsc2046_adc_dcfg *)id->driver_data;
> +       }
>         if (!dcfg)
>                 return -EINVAL;
>
> @@ -878,11 +883,18 @@ static const struct of_device_id ads7950_of_table[] = {
>  };
>  MODULE_DEVICE_TABLE(of, ads7950_of_table);
>
> +static const struct spi_device_id tsc2046_adc_spi_ids[] = {
> +       { "tsc2046e-adc", (unsigned long)&tsc2046_adc_dcfg_tsc2046e },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(spi, tsc2046_adc_spi_ids);
> +
>  static struct spi_driver tsc2046_adc_driver = {
>         .driver = {
>                 .name = "tsc2046",
>                 .of_match_table = ads7950_of_table,
>         },
> +       .id_table = tsc2046_adc_spi_ids,
>         .probe = tsc2046_adc_probe,
>         .remove = tsc2046_adc_remove,
>  };
> --
> 2.30.2
>


-- 
With Best Regards,
Andy Shevchenko
