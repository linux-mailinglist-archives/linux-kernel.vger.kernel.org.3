Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C683358063E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbiGYVQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiGYVQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:16:38 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6762A470;
        Mon, 25 Jul 2022 14:16:37 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id oy13so22837002ejb.1;
        Mon, 25 Jul 2022 14:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dzqsg7+JuF3LAlSgaMlMSRRgs1ArxUnpTbqt1d3exVk=;
        b=RPTlyU9TAfxY8p9GFNcVs1x8JBjotrjfPA+6plXrFf2F0FtvaQXkLjqMe5yz3IQwzu
         YBeSoiNRwYzPuAYDuq3f9kkevLkcaZ8gnLjLOXee0itUZbypwIgU1qWdMUJvwZtvfC6s
         KATyQmonoplSF0j0cjC205hw44M/4LQZPb+dCEQwnETCmiX1FzfepoECkzo5vtHmRCuA
         lOVtTNc29YuBpyzAoXVi2QipLFwZMfcUeVeVPHQKtvaGA4K1QEeQ3O8OmYPAltpcHtMV
         BUtP7ZXSSzxt5nnZNbcY7slWqITlrGghYCFdoexIH8e20KPNcUC98aYL5LgMlGU8bBGO
         u48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dzqsg7+JuF3LAlSgaMlMSRRgs1ArxUnpTbqt1d3exVk=;
        b=cizARIbzOLJzoOFZdxCR95t13otZwpfT/r/RLwHLjhUoSOSTzHBxhFY84TpIlgfM5o
         s9pEBNW7kXID2lxrQyH0F7CB9hyrxK5/clhh/UdjSB+KvqfF3MM2xpg2x8HOLnofUVeH
         EhUQQXMd3bIGsGMaVJ8dWXAdI0y6vcp9mLeEJRlcI1jUhnZ+UQMpCG10bOemtH1RgvQL
         kBy9LKwpQrV6+9Za1P0F5riJkcx5MD/ZsOyKqHUiq+JJ0pJdpIffOrDPr6+KRcvwWpHf
         GnJzJBc4xMUmCM8XKBAEZKQ8MQJXOmJuhLfvAKrIC5gFs7k5mfXqUSZEgnzkLsIgshha
         F7yg==
X-Gm-Message-State: AJIora+nJRz/7MGw3tB+NmIcL/A40fMv7wRABuh4y79+tzzBHxzsktJy
        Pax2gSdcRrp7TrDDdgB89nvqar7sTs3g23bynSk=
X-Google-Smtp-Source: AGRyM1u36HPoDbas77V1ajAhCR5VMkr0JYySvUpJ4RZ1BHrCutGJHJbfTtpLPr3JozXmwGSF5q5kDBsG+U7hZPXzReM=
X-Received: by 2002:a17:906:8a4a:b0:72b:5b23:3065 with SMTP id
 gx10-20020a1709068a4a00b0072b5b233065mr11834533ejc.557.1658783796007; Mon, 25
 Jul 2022 14:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1658597501.git.ang.iglesiasg@gmail.com> <50841287411a4e459487cc94a05bc6de66be4acf.1658597501.git.ang.iglesiasg@gmail.com>
In-Reply-To: <50841287411a4e459487cc94a05bc6de66be4acf.1658597501.git.ang.iglesiasg@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 23:15:59 +0200
Message-ID: <CAHp75VdQ_oCjyXsXxTEWfKJK=T+OOP=AEXz8KQq5b2Hu8VHy9w@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] iio: pressure: bmp280: Add support for BMP380
 sensor family
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
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

On Sat, Jul 23, 2022 at 7:40 PM Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
>
> Adds compatibility with the new generation of this sensor, the BMP380
>
> Includes basic sensor initialization to do pressure and temp
> measurements and allows tuning oversampling settings for each channel.
>
> The compensation algorithms are adapted from the device datasheet and
> the repository https://github.com/BoschSensortec/BMP3-Sensor-API

...

> +       /* wait for 2ms for command to be proccessed */

processed

> +       dev_dbg(data->dev, "Command 0x%X proccessed successfully\n", cmd);

Ditto. Can you run a spell checker? Kernel has a little one called codespell.

> +
> +       return 0;
> +}

...

> +static s32 bmp380_compensate_temp(struct bmp280_data *data, u32 adc_temp)
> +{
> +       s64 var1, var2, var3, var4, var5, var6, comp_temp;
> +       struct bmp380_calib *calib = &data->calib.bmp380;
> +
> +       var1 = ((s64) adc_temp) - (((s64) calib->T1) << 8);
> +       var2 = var1 * ((s64) calib->T2);
> +       var3 = var1 * var1;
> +       var4 = var3 * ((s64) calib->T3);
> +       var5 = (var2 << 18) + var4;
> +       var6 = var5 >> 32;
> +       data->t_fine = (s32) var6;
> +       comp_temp = (var6 * 25) >> 14;
> +
> +       comp_temp = clamp_val(comp_temp, BMP380_MIN_TEMP, BMP380_MAX_TEMP);
> +       return (s32) comp_temp;
> +}

...

> +       s64 var1, var2, var3, var4, var5, var6, offset, sensitivity;
> +       u64 comp_press;
> +       struct bmp380_calib *calib = &data->calib.bmp380;
> +
> +       var1 = ((s64)data->t_fine) * ((s64)data->t_fine);
> +       var2 = var1 >> 6;
> +       var3 = (var2 * ((s64) data->t_fine)) >> 8;
> +       var4 = (((s64)calib->P8) * var3) >> 5;
> +       var5 = (((s64) calib->P7) * var1) << 4;
> +       var6 = (((s64) calib->P6) * ((s64)data->t_fine)) << 22;
> +       offset = (((s64)calib->P5) << 47) + var4 + var5 + var6;
> +       var2 = (((s64)calib->P4) * var3) >> 5;
> +       var4 = (((s64) calib->P3) * var1) << 2;
> +       var5 = (((s64) calib->P2) - ((s64) 1<<14)) *
> +               (((s64)data->t_fine) << 21);
> +       sensitivity = ((((s64) calib->P1) - ((s64) 1 << 14)) << 46) +
> +                       var2 + var4 + var5;
> +       var1 = (sensitivity >> 24) * ((s64)adc_press);
> +       var2 = ((s64)calib->P10) * ((s64) data->t_fine);
> +       var3 = var2 + (((s64) calib->P9) << 16);
> +       var4 = (var3 * ((s64)adc_press)) >> 13;
> +
> +       /*
> +        * Dividing by 10 followed by multiplying by 10 to avoid
> +        * possible overflow caused by (uncomp_data->pressure * partial_data4)
> +        */
> +       var5 = (((s64)adc_press) * (var4 / 10)) >> 9;
> +       var5 *= 10;
> +       var6 = ((s64)adc_press) * ((s64)adc_press);
> +       var2 = (((s64)calib->P11) * var6) >> 16;
> +       var3 = (var2 * ((s64)adc_press)) >> 7;
> +       var4 = (offset >> 2) + var1 + var5 + var3;
> +       comp_press = ((u64)var4 * 25) >> 40;


Kbuild bot is right, you forgot to (compile-)test for a 32-bit machine.

...

> +       ret = regmap_bulk_read(data->regmap, BMP380_REG_TEMP_XLSB, data->buf, 3);

sizeof() ?

...

> +       /* Read and compensate temperature so we get a reading of t_fine. */

for temperature

...

> +       ret = regmap_bulk_read(data->regmap, BMP380_REG_PRESS_XLSB, data->buf, 3);

sizeof() ?

...

> +       .oversampling_temp_default = ilog2(1),

> +       .oversampling_press_default = ilog2(4),

BIT()

...

> +#define BMP380_REG_CMD                 0x7E
> +#define BMP380_REG_CONFIG              0x1F
> +#define BMP380_REG_ODR                 0X1D
> +#define BMP380_REG_OSR                 0X1C
> +#define BMP380_REG_POWER_CONTROL       0X1B
> +#define BMP380_REG_IF_CONFIG           0X1A
> +#define BMP380_REG_INT_CONTROL         0X19
> +#define BMP380_REG_INT_STATUS          0X11
> +#define BMP380_REG_EVENT               0X10
> +#define BMP380_REG_STATUS              0X03
> +#define BMP380_REG_ERROR               0X02
> +#define BMP380_REG_ID                  0X00
> +
> +#define BMP380_REG_FIFO_CONFIG_1       0X18
> +#define BMP380_REG_FIFO_CONFIG_2       0X17
> +#define BMP380_REG_FIFO_WATERMARK_MSB  0X16
> +#define BMP380_REG_FIFO_WATERMARK_LSB  0X15
> +#define BMP380_REG_FIFO_DATA           0X14
> +#define BMP380_REG_FIFO_LENGTH_MSB     0X13
> +#define BMP380_REG_FIFO_LENGTH_LSB     0X12
> +
> +#define BMP380_REG_SENSOR_TIME_MSB     0X0E
> +#define BMP380_REG_SENSOR_TIME_LSB     0X0D
> +#define BMP380_REG_SENSOR_TIME_XLSB    0X0C
> +
> +#define BMP380_REG_TEMP_MSB            0X09
> +#define BMP380_REG_TEMP_LSB            0X08
> +#define BMP380_REG_TEMP_XLSB           0X07
> +
> +#define BMP380_REG_PRESS_MSB           0X06
> +#define BMP380_REG_PRESS_LSB           0X05
> +#define BMP380_REG_PRESS_XLSB          0X04
> +
> +#define BMP380_REG_CALIB_TEMP_START    0x31

Be consistent x vs X (we prefer x).

-- 
With Best Regards,
Andy Shevchenko
