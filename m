Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABED15A8779
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 22:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiHaUVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 16:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiHaUVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 16:21:00 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD51D2927;
        Wed, 31 Aug 2022 13:20:58 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id b2so11731777qkh.12;
        Wed, 31 Aug 2022 13:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=AThWrQfN6/eN3KCXa9I/bfm86yJ82jDlu5BASjK5tqc=;
        b=m3LKEXtbRN8bk8yRrBJ0UJkyUNH9f0kdP7TqRpEfHYsaUYQvadMdux0zJAlkHV1vas
         DyN3tgUeLaNC/n8n68XbFB5oxcyfcahG2D/An+MQ2FUa9oK834xzYPRsxhgq0H+CpGVf
         WK+nRnSrbwnnu7g8Rm/TekCwDYh3byZhLxCmzd2Bi4GdypOXAN8+xdCkUgtEHOWYt3ro
         N8+iWfdMlGvvIRSUh2RjSfXIVa0984uIy/uU96tmM+CvO4Zw3ZVsdVR56Tdr0y4T0Gwl
         B7GybI5AWnoWxrPIi6ONw08WZO9r404YmT/+iPLG0IdBScl1XJdvR6qxK857m7Q485pg
         PjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=AThWrQfN6/eN3KCXa9I/bfm86yJ82jDlu5BASjK5tqc=;
        b=UchvNTVMSq6alZGdRE61Rpt8BErzL3y3Pfx/0YD8l60Aar7sTYhPbe8UVLxVzAUJ/Q
         1DE+CHJ97dDoautW/QA1KXEcj3b4Lpqt+BSxblQwcJ/yd4hrRN3l3FDJqFpsI5jlyWJ+
         BNi8p6xfKktHIEg0PThF7/Jrghpe4f2uRfWqG2FLzC0tkm663vQcFzr2cjdpaujdFlcr
         8l943n2oTiQUUE4yvaCIlFliasObAVNIXNzCpiRQgAAK+GOBhSZqraiybSbaMInxmQDZ
         Xgpe/zpLR6MvXDTg/T+cXrb0oVOruqIM+Tf9jXNz724TZ2KJZAHgSLRHRwre3oyCT4gL
         gKvA==
X-Gm-Message-State: ACgBeo0tE9aHzOKYIyglW03YyLYHj3wj+7SHGQw1nOLVzs7nT12Y2a/O
        1OWhdGHyXKKhSeRoXOlE5PjacaXdyC5hfMlGeSQ=
X-Google-Smtp-Source: AA6agR4WcEVXsR64EKTa6zlaLNT8Hjof8P9Kyd7ccFS8v0/+jw8xvASNxax8J0TfAnwHLSmaQDvcwWdVCPmChWagnD8=
X-Received: by 2002:a05:620a:2987:b0:6ba:dc04:11ae with SMTP id
 r7-20020a05620a298700b006badc0411aemr16838270qkp.748.1661977257251; Wed, 31
 Aug 2022 13:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220831133021.215625-1-ramona.bolboaca@analog.com> <20220831133021.215625-2-ramona.bolboaca@analog.com>
In-Reply-To: <20220831133021.215625-2-ramona.bolboaca@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 31 Aug 2022 23:20:20 +0300
Message-ID: <CAHp75Vco8ftAkjVEmKGKKYHS-1mnZzLuPA+N98giqi17mqQnRw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: add max11205 adc driver
To:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
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

On Wed, Aug 31, 2022 at 4:36 PM Ramona Bolboaca
<ramona.bolboaca@analog.com> wrote:
>
> Adding support for max11205 16-bit single-channel ultra-low power
> delta-sigma adc.
> The MAX11205 is compatible with the 2-wire interface and uses
> SCLK and RDY/DOUT for serial communications. In this mode, all
> controls are implemented by timing the high or low phase of the SCLK.
> The 2-wire serial interface only allows for data to be read out through
> the RDY/DOUT output.

Couple of minor comments, if you are going to address them,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX11205.pdf
> Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
> ---
> changes in v2:
>  - add chip_info null pointer check
>  - add support for probing with ACPI table
>  - remove function for module removal
>  - remove irq flag from max11205_sigma_delta_info
>  - add missing commas and missing spaces
>  - remove redundant blank line
>  - wrap text to 75-80 chars
>  - removed typos in commit message
>  drivers/iio/adc/Kconfig    |  14 +++
>  drivers/iio/adc/Makefile   |   1 +
>  drivers/iio/adc/max11205.c | 183 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 198 insertions(+)
>  create mode 100644 drivers/iio/adc/max11205.c
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 7fe5930891e0..0c8f376b65d8 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -653,6 +653,20 @@ config MAX1118
>           To compile this driver as a module, choose M here: the module will be
>           called max1118.
>
> +config MAX11205
> +       tristate "Maxim max11205 ADC driver"
> +       depends on SPI
> +       select AD_SIGMA_DELTA
> +       select IIO_BUFFER
> +       select IIO_TRIGGERED_BUFFER
> +
> +       help
> +         Say yes here to build support for Maxim max11205 16-bit, single-channel
> +         ultra-low power delta-sigma ADC.
> +
> +         To compile this driver as a module, choose M here: the module will be
> +         called max11205.
> +
>  config MAX1241
>         tristate "Maxim max1241 ADC driver"
>         depends on SPI_MASTER
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 1772a549a3c8..bb681844e497 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -61,6 +61,7 @@ obj-$(CONFIG_LTC2497) += ltc2497.o ltc2497-core.o
>  obj-$(CONFIG_MAX1027) += max1027.o
>  obj-$(CONFIG_MAX11100) += max11100.o
>  obj-$(CONFIG_MAX1118) += max1118.o
> +obj-$(CONFIG_MAX11205) += max11205.o
>  obj-$(CONFIG_MAX1241) += max1241.o
>  obj-$(CONFIG_MAX1363) += max1363.o
>  obj-$(CONFIG_MAX9611) += max9611.o
> diff --git a/drivers/iio/adc/max11205.c b/drivers/iio/adc/max11205.c
> new file mode 100644
> index 000000000000..68e6082e70e5
> --- /dev/null
> +++ b/drivers/iio/adc/max11205.c
> @@ -0,0 +1,183 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * max11205 16-Bit Delta-Sigma ADC

Can you spell the vendor and part number verbosely?
Something like "Maxim MAX11205" or similar.

> + *
> + * Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX1240-max11205.pdf
> + * Copyright (C) 2022 Analog Devices, Inc.
> + * Author: Ramona Bolboaca <ramona.bolboaca@analog.com>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/adc/ad_sigma_delta.h>
> +
> +#define MAX11205_BIT_SCALE     15
> +#define MAX11205A_OUT_DATA_RATE        116
> +#define MAX11205B_OUT_DATA_RATE        13
> +
> +enum chip_type {
> +       TYPE_MAX11205A,
> +       TYPE_MAX11205B,
> +};
> +
> +struct chip_info {
> +       unsigned int    out_data_rate;
> +       const char      *name;
> +};
> +
> +struct max11205_state {
> +       const struct chip_info  *chip_info;
> +       struct regulator        *vref;
> +       struct ad_sigma_delta   sd;
> +};
> +
> +static const struct ad_sigma_delta_info max11205_sigma_delta_info = {
> +       .has_registers = false,
> +};
> +
> +static int max11205_read_raw(struct iio_dev *indio_dev,
> +                            struct iio_chan_spec const *chan,
> +                            int *val, int *val2, long mask)
> +{
> +       struct max11205_state *st = iio_priv(indio_dev);
> +       int reg_mv;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               return ad_sigma_delta_single_conversion(indio_dev, chan, val);
> +       case IIO_CHAN_INFO_SCALE:
> +               reg_mv = regulator_get_voltage(st->vref);
> +               if (reg_mv < 0)
> +                       return reg_mv;
> +               reg_mv /= 1000;
> +               *val = reg_mv;
> +               *val2 = MAX11205_BIT_SCALE;
> +               return IIO_VAL_FRACTIONAL_LOG2;
> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               *val = st->chip_info->out_data_rate;
> +               return IIO_VAL_INT;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static const struct iio_info max11205_iio_info = {
> +       .read_raw = max11205_read_raw,
> +       .validate_trigger = ad_sd_validate_trigger,
> +};
> +
> +static const struct iio_chan_spec max11205_channels[] = {
> +       {
> +               .type = IIO_VOLTAGE,
> +               .indexed = 1,
> +               .scan_type = {
> +                       .sign = 's',
> +                       .realbits = 16,
> +                       .storagebits = 16,
> +                       .endianness = IIO_BE
> +               },
> +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +               BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +               BIT(IIO_CHAN_INFO_SCALE),
> +       },
> +};
> +
> +static const struct chip_info max11205_chip_info[] = {
> +       [TYPE_MAX11205A] = {
> +               .out_data_rate = MAX11205A_OUT_DATA_RATE,
> +               .name = "max11205a",
> +       },
> +       [TYPE_MAX11205B] = {
> +               .out_data_rate = MAX11205B_OUT_DATA_RATE,
> +               .name = "max11205b",
> +       },
> +};
> +
> +static void max11205_reg_disable(void *reg)
> +{
> +       regulator_disable(reg);
> +}
> +
> +static int max11205_probe(struct spi_device *spi)
> +{
> +       struct max11205_state *st;
> +       struct iio_dev *indio_dev;
> +       int ret;
> +
> +       indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       st = iio_priv(indio_dev);
> +
> +       ad_sd_init(&st->sd, indio_dev, spi, &max11205_sigma_delta_info);

> +       st->chip_info = device_get_match_data(&spi->dev);

> +

Unneeded blank line.

> +       if (!st->chip_info)
> +               st->chip_info = (const struct chip_info *)spi_get_device_id(spi)->driver_data;
> +
> +       indio_dev->name = st->chip_info->name;
> +       indio_dev->modes = INDIO_DIRECT_MODE;
> +       indio_dev->channels = max11205_channels;
> +       indio_dev->num_channels = 1;
> +       indio_dev->info = &max11205_iio_info;
> +
> +       st->vref = devm_regulator_get(&spi->dev, "vref");

devm_regulator_get_enable() ?

> +       if (IS_ERR(st->vref))
> +               return dev_err_probe(&spi->dev, PTR_ERR(st->vref),
> +                                    "Failed to get vref regulator\n");
> +
> +       ret = regulator_enable(st->vref);
> +       if (ret)
> +               return ret;
> +
> +       ret = devm_add_action_or_reset(&spi->dev, max11205_reg_disable, st->vref);
> +       if (ret)
> +               return ret;
> +
> +       ret = devm_ad_sd_setup_buffer_and_trigger(&spi->dev, indio_dev);
> +       if (ret)
> +               return ret;
> +
> +       return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static const struct spi_device_id max11205_spi_ids[] = {
> +       { "max11205a", (kernel_ulong_t)&max11205_chip_info[TYPE_MAX11205A] },
> +       { "max11205b", (kernel_ulong_t)&max11205_chip_info[TYPE_MAX11205B] },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(spi, max11205_spi_ids);
> +
> +static const struct of_device_id max11205_dt_ids[] = {
> +       {
> +               .compatible = "maxim,max11205a",
> +               .data = &max11205_chip_info[TYPE_MAX11205A],
> +       },
> +       {
> +               .compatible = "maxim,max11205b",
> +               .data = &max11205_chip_info[TYPE_MAX11205B],
> +       },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, max11205_dt_ids);
> +
> +static struct spi_driver max11205_spi_driver = {
> +       .driver = {
> +               .name = "max11205",
> +               .of_match_table = max11205_dt_ids,
> +       },
> +       .probe = max11205_probe,
> +       .id_table = max11205_spi_ids,
> +};
> +module_spi_driver(max11205_spi_driver);
> +
> +MODULE_AUTHOR("Ramona Bolboaca <ramona.bolboaca@analog.com>");
> +MODULE_DESCRIPTION("MAX11205 ADC driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
