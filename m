Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A1A584723
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiG1Unh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiG1Und (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:43:33 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B58B6BD74;
        Thu, 28 Jul 2022 13:43:32 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id va17so5213024ejb.0;
        Thu, 28 Jul 2022 13:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=YqQ/iPV80N4mxWzia0Xd1NcSXuCfeJGClLLA16J1BeY=;
        b=cVnBHhLkFiQtW0++kx4EfEPl7JrDchSbhY7SSxHfPM0hW5k8u8TYMTA061tf+SPReu
         f5F5DOf4YPrNbxV3lRvasj1NNt2nkF3WKKaxuxAYaitymTO4EnWGakFpzg0Vo0GN94eR
         /WIvNWqTB/fBLlWPp5Tr0gK0zlZpXxKmLYCSGPFmpz5OHBQUXx0RE0+TGNRUWI4KchWC
         23vYHPmJJkD5R432CuD+eztTwc9fgTZtXW8vL/v9jXraHnFLgYirRl+SwkXvrOlYPaIn
         FshocVpYShqy930pnV39kWgxNvSdav4IAL2UAuQTQZ+d9Is2kqsHzoGXIJrVZVVvEU6B
         wBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=YqQ/iPV80N4mxWzia0Xd1NcSXuCfeJGClLLA16J1BeY=;
        b=T6DirdEArMcBbL6jarV8IUhX5HxF8CHImdHl2Cvx64d36IAL18V29ty0X/u5Zq35GY
         MZMjXihc56ysOn3dsaWDe9KFtqzk8Q4Yy5hZCd1fvkYc7XtuTo42A7+bidQcBMj8pDIw
         yElh0XvpPTPfHlZrqJJUC+/Lrxg38zN3jxwXECIEcTU6Io/B21ftelmRLfFxOHNeVkOx
         u3Y1rQOeAIBtHq/Ki8Vml9pp1V66/R7LaN4AsbnvWuXF7JyQUaWuMO+XRirebk8Nz8ux
         77cenlxY+VIBzNum67ml1NAsdgFk8Cu0RWL3dA1iwWCgVAFqZfRfcF7+qoU664gWJYWK
         S/TQ==
X-Gm-Message-State: AJIora/mJuzph8Mk+S8hrJIJJGXr52ruMkdNmwMvI/bbrlQCIG8Pt825
        3dFXTtDfqO3W9xSlIHKroOS1zQ0WbiQbss5zuK4=
X-Google-Smtp-Source: AGRyM1viOpUKpMdSj6ghbFS3dvhA2vr2GVmGKnHUyCL6GpFC9YiN19lIwm+4UsRQkWVeFYxBi558+ZYXu1L2HPSd9VQ=
X-Received: by 2002:a17:907:9706:b0:72b:4b0d:86a2 with SMTP id
 jg6-20020a170907970600b0072b4b0d86a2mr495492ejc.242.1659041010491; Thu, 28
 Jul 2022 13:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220728125435.3336618-1-potin.lai.pt@gmail.com> <20220728125435.3336618-3-potin.lai.pt@gmail.com>
In-Reply-To: <20220728125435.3336618-3-potin.lai.pt@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 28 Jul 2022 22:42:52 +0200
Message-ID: <CAHp75VebJQH_Ab3MjLhNr_=AJ8eZhUMzU7GnDXL4Gw8j_3vH7A@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] iio: humidity: hdc100x: add manufacturer and
 device ID check
To:     Potin Lai <potin.lai.pt@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 3:32 PM Potin Lai <potin.lai.pt@gmail.com> wrote:
>
> Add manufacturer and device ID checking during probe, and skip the
> checking if chip model not supported.
>
> Supported:
> - HDC1000
> - HDC1010
> - HDC1050
> - HDC1080
>
> Not supported:
> - HDC1008

This one is okay now, thanks!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
> ---
>  drivers/iio/humidity/hdc100x.c | 67 ++++++++++++++++++++++++++++------
>  1 file changed, 56 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> index 0d514818635cb..31f18cc1cf63c 100644
> --- a/drivers/iio/humidity/hdc100x.c
> +++ b/drivers/iio/humidity/hdc100x.c
> @@ -34,6 +34,23 @@
>  #define HDC100X_REG_CONFIG_ACQ_MODE            BIT(12)
>  #define HDC100X_REG_CONFIG_HEATER_EN           BIT(13)
>
> +#define HDC100X_REG_MFR_ID     0xFE
> +#define HDC100X_REG_DEV_ID     0xFF
> +
> +#define HDC100X_MFR_ID 0x5449
> +
> +struct hdc100x_chip_data {
> +       bool support_mfr_check;
> +};
> +
> +static const struct hdc100x_chip_data hdc100x_chip_data = {
> +       .support_mfr_check      = true,
> +};
> +
> +static const struct hdc100x_chip_data hdc1008_chip_data = {
> +       .support_mfr_check      = false,
> +};
> +
>  struct hdc100x_data {
>         struct i2c_client *client;
>         struct mutex lock;
> @@ -351,8 +368,32 @@ static const struct iio_info hdc100x_info = {
>         .attrs = &hdc100x_attribute_group,
>  };
>
> +static int hdc100x_read_mfr_id(struct i2c_client *client)
> +{
> +       return i2c_smbus_read_word_swapped(client, HDC100X_REG_MFR_ID);
> +}
> +
> +static int hdc100x_read_dev_id(struct i2c_client *client)
> +{
> +       return i2c_smbus_read_word_swapped(client, HDC100X_REG_DEV_ID);
> +}
> +
> +static bool is_valid_hdc100x(struct i2c_client *client)
> +{
> +       int mfr_id, dev_id;
> +
> +       mfr_id = hdc100x_read_mfr_id(client);
> +       dev_id = hdc100x_read_dev_id(client);
> +       if (mfr_id == HDC100X_MFR_ID &&
> +          (dev_id == 0x1000 || dev_id == 0x1050))
> +               return true;
> +
> +       return false;
> +}
> +
>  static int hdc100x_probe(struct i2c_client *client)
>  {
> +       const struct hdc100x_chip_data *chip_data;
>         struct iio_dev *indio_dev;
>         struct hdc100x_data *data;
>         int ret;
> @@ -361,6 +402,10 @@ static int hdc100x_probe(struct i2c_client *client)
>                                      I2C_FUNC_SMBUS_BYTE | I2C_FUNC_I2C))
>                 return -EOPNOTSUPP;
>
> +       chip_data = device_get_match_data(&client->dev);
> +       if (chip_data->support_mfr_check && !is_valid_hdc100x(client))
> +               return -EINVAL;
> +
>         indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>         if (!indio_dev)
>                 return -ENOMEM;
> @@ -396,22 +441,22 @@ static int hdc100x_probe(struct i2c_client *client)
>  }
>
>  static const struct i2c_device_id hdc100x_id[] = {
> -       { "hdc100x", 0 },
> -       { "hdc1000", 0 },
> -       { "hdc1008", 0 },
> -       { "hdc1010", 0 },
> -       { "hdc1050", 0 },
> -       { "hdc1080", 0 },
> +       { "hdc100X", (kernel_ulong_t)&hdc100x_chip_data },
> +       { "hdc1000", (kernel_ulong_t)&hdc100x_chip_data },
> +       { "hdc1008", (kernel_ulong_t)&hdc1008_chip_data },
> +       { "hdc1010", (kernel_ulong_t)&hdc100x_chip_data },
> +       { "hdc1050", (kernel_ulong_t)&hdc100x_chip_data },
> +       { "hdc1080", (kernel_ulong_t)&hdc100x_chip_data },
>         { }
>  };
>  MODULE_DEVICE_TABLE(i2c, hdc100x_id);
>
>  static const struct of_device_id hdc100x_dt_ids[] = {
> -       { .compatible = "ti,hdc1000" },
> -       { .compatible = "ti,hdc1008" },
> -       { .compatible = "ti,hdc1010" },
> -       { .compatible = "ti,hdc1050" },
> -       { .compatible = "ti,hdc1080" },
> +       { .compatible = "ti,hdc1000", .data = &hdc100x_chip_data },
> +       { .compatible = "ti,hdc1008", .data = &hdc1008_chip_data },
> +       { .compatible = "ti,hdc1010", .data = &hdc100x_chip_data },
> +       { .compatible = "ti,hdc1050", .data = &hdc100x_chip_data },
> +       { .compatible = "ti,hdc1080", .data = &hdc100x_chip_data },
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, hdc100x_dt_ids);
> --
> 2.31.1
>


-- 
With Best Regards,
Andy Shevchenko
