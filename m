Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8560524706
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351026AbiELHcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiELHcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:32:01 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5E833A3A;
        Thu, 12 May 2022 00:32:00 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id cu23-20020a17090afa9700b001d98d8e53b7so5544023pjb.0;
        Thu, 12 May 2022 00:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PK+zEjT0FwnfyuqNzIGPbA6J7wMPiAnBkII/UnzliNo=;
        b=I9ocdOKHMOQzPWcvTeVkMOm3iPrQGP6UTm/mB5DEmvSJsxSwCkmrtMDfYgSuPWKFP5
         8FvYLhAGh+qlInjBDGuAPwJfxldrH8jQigVYJGDwLlCfzs6pUpmlhfybK78tIGDtG+hC
         M/a5YLrYlHt3VKZAzXvGR9o1A+eq0kZL6S4tlfnbzbDlrae0K/EjWRmlIlEJNMvelERB
         2FT3s1ChLewqy9+xI9v4iODVSpU8PvF3FNEcSNhrRsTXthBU5vPV8E9Rw5z0EZ0NLvA9
         yqLK41Untd+oJaad1jYWBBQ8nd2I6PnaRD5TV3G/D+J9ud1XQVMNkuSLC6IZy/87Vgfj
         9NeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PK+zEjT0FwnfyuqNzIGPbA6J7wMPiAnBkII/UnzliNo=;
        b=zFi4xMpG2Hg7YV4sGz483m6vptml3eLOPhvkhXmm9UoTmnVntLoieHseMQDolM+600
         sTyF3Dw13Qn3ooGW2EgsRSuqTPn2sKtXKleGrvju/vq9i7YIQqj9x9zFY8iSCFVa2fu+
         6DfdTNqe0SZ/I6OcSoKXKhha/02rIk4XQ6DWTRYzwexKFqiW6CymPXnJc1xVYHDZu75b
         Ishd3vN0G5Wm0dfSca4hzPCGMfytDmhwoW6r4OwdpRwe5CbUxHTsUhGyqVXtki3bVRDc
         Us79J+QUNJfj2VkIZ7J+v7JzEQFV5r7tkDZKQsPfPHphkLHbKFs4G0uQu7rfcb4Gl+wu
         9hOA==
X-Gm-Message-State: AOAM533mxTs5F9P7jbKNZNWV+TY/Zhgx8v52xr49Ytj18WWtjKsR24cp
        cL25rUpPPHWde6B0e7Dfe4+0YVURZu3IqahuMNQ=
X-Google-Smtp-Source: ABdhPJyNy2ltsylm+FZOgVt68fjIenNg5NWdfleHLhcviWLXS4BlU+/cc1KWA/xpzG7S/mnkaEmG/SnQe+e3DclLVeQ=
X-Received: by 2002:a17:903:20f:b0:158:d86a:f473 with SMTP id
 r15-20020a170903020f00b00158d86af473mr29201585plh.92.1652340719755; Thu, 12
 May 2022 00:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220510141753.3878390-1-Qing-wu.Li@leica-geosystems.com.cn> <20220510141753.3878390-4-Qing-wu.Li@leica-geosystems.com.cn>
In-Reply-To: <20220510141753.3878390-4-Qing-wu.Li@leica-geosystems.com.cn>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 12 May 2022 10:31:48 +0300
Message-ID: <CA+U=Dsqu_5JVyhs8juznQ5SyBx1V6Q5yT-fsnYuoYHX9ESE=Tg@mail.gmail.com>
Subject: Re: [PATCH V2 3/6] iio: accel: bmi088: modified the device name
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        mchehab+huawei@kernel.org, linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 5:18 PM LI Qingwu
<Qing-wu.Li@leica-geosystems.com.cn> wrote:
>
> It is possible to have multiple sensors connected on the same platform,
> To support multiple sensors, the commit makes it possible to obtain the
> device name by reading the chip ID instead of the device-tree name.
> To be compatible with previous versions, renam bmi088a to bmi088-accel.

// my spellcheck in GMail found this :p

typo: renam -> rename

I also have a comment about a duplication that is highlighted by this change.

You can disregard my comment about the duplication and leave this change as-is.

>
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  drivers/iio/accel/bmi088-accel-core.c | 6 +++---
>  drivers/iio/accel/bmi088-accel-spi.c  | 4 +---
>  drivers/iio/accel/bmi088-accel.h      | 2 +-
>  3 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
> index 8fee1d02e773..de2385e4dad5 100644
> --- a/drivers/iio/accel/bmi088-accel-core.c
> +++ b/drivers/iio/accel/bmi088-accel-core.c
> @@ -459,7 +459,7 @@ static const struct iio_chan_spec bmi088_accel_channels[] = {
>
>  static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
>         [0] = {
> -               .name = "bmi088a",
> +               .name = "bmi088-accel",
>                 .chip_id = 0x1E,
>                 .channels = bmi088_accel_channels,
>                 .num_channels = ARRAY_SIZE(bmi088_accel_channels),
> @@ -524,7 +524,7 @@ static int bmi088_accel_chip_init(struct bmi088_accel_data *data)
>  }
>
>  int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap,
> -       int irq, const char *name, bool block_supported)
> +       int irq, bool block_supported)
>  {
>         struct bmi088_accel_data *data;
>         struct iio_dev *indio_dev;
> @@ -545,7 +545,7 @@ int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap,
>
>         indio_dev->channels = data->chip_info->channels;
>         indio_dev->num_channels = data->chip_info->num_channels;
> -       indio_dev->name = name ? name : data->chip_info->name;
> +       indio_dev->name = data->chip_info->name;

(with this change) i can better see, a bit of duplication between the
spi_device table and the chip_info table

this was not introduced by this change, but it was made a bit more
obvious by this change;

one way to address this, is to remove the `const char *name;` and
continue using the `name` provided as a parameter from
bmi088_accel_core_probe();
(apologies if I seem to have changed my mind (from the previous
changeset), but I did not see it too well before)

and we can convert

enum {
   ID_BMI088,
   ID_BMI085,
   ...
};

 static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
         [ID_BMI088] = {
                 .chip_id = 0x1E,
                 .channels = bmi088_accel_channels,
                .num_channels = ARRAY_SIZE(bmi088_accel_channels),
        },
         [ID_BMI085] = {
         ........

>         indio_dev->available_scan_masks = bmi088_accel_scan_masks;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->info = &bmi088_accel_info;
> diff --git a/drivers/iio/accel/bmi088-accel-spi.c b/drivers/iio/accel/bmi088-accel-spi.c
> index dd1e3f6cf211..0fed0081e1fd 100644
> --- a/drivers/iio/accel/bmi088-accel-spi.c
> +++ b/drivers/iio/accel/bmi088-accel-spi.c
> @@ -42,7 +42,6 @@ static struct regmap_bus bmi088_regmap_bus = {
>  static int bmi088_accel_probe(struct spi_device *spi)
>  {
>         struct regmap *regmap;
> -       const struct spi_device_id *id = spi_get_device_id(spi);
>
>         regmap = devm_regmap_init(&spi->dev, &bmi088_regmap_bus,
>                         spi, &bmi088_regmap_conf);
> @@ -52,8 +51,7 @@ static int bmi088_accel_probe(struct spi_device *spi)
>                 return PTR_ERR(regmap);
>         }
>
> -       return bmi088_accel_core_probe(&spi->dev, regmap, spi->irq, id->name,
> -                                      true);
> +       return bmi088_accel_core_probe(&spi->dev, regmap, spi->irq, true);
>  }
>
>  static int bmi088_accel_remove(struct spi_device *spi)
> diff --git a/drivers/iio/accel/bmi088-accel.h b/drivers/iio/accel/bmi088-accel.h
> index 5c25f16b672c..c32afe9606a8 100644
> --- a/drivers/iio/accel/bmi088-accel.h
> +++ b/drivers/iio/accel/bmi088-accel.h
> @@ -12,7 +12,7 @@ extern const struct regmap_config bmi088_regmap_conf;
>  extern const struct dev_pm_ops bmi088_accel_pm_ops;
>
>  int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
> -                           const char *name, bool block_supported);
> +                           bool block_supported);
>  int bmi088_accel_core_remove(struct device *dev);
>
>  #endif /* BMI088_ACCEL_H */
> --
> 2.25.1
>
