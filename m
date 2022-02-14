Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2614B4EEF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352921AbiBNLmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:42:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353773AbiBNLmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:42:00 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D13E66239;
        Mon, 14 Feb 2022 03:33:45 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id h18so4226803edb.7;
        Mon, 14 Feb 2022 03:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XoIGUc7L1CNxby6hJQisyEzt3VmpKa35bNMvST/YPuE=;
        b=JlN98nyPpMDUKHiyYlGiPuS7cQJHiFTCs3X6VJUvUDUyjMH04GGi1UiVpeTpW0etd5
         piy+HN1nnL3JqFiwFC2q/KiFgk8tp6xOXEZMSUjbGTto63xB0ZZ8rKvn4Id3sx0suOa3
         YqnROkPIS+UkqAqF6v8eCKUPgbumINw1KwtblAfeFsP49L/S5BzM8XiM0V4mJaV5yGys
         AzA4WejMe721YwVpHQe5uv1AaDYxvmB/fCtrLcaaaS+k21qCVsEUZViAc60oeaP6Ni4A
         dMAgEtn2oQ4cX7A8MWI9CpcMuiyLePimbafnMB1L28kzbj9t4geyzCVGcLgd5cP5TmhT
         I8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XoIGUc7L1CNxby6hJQisyEzt3VmpKa35bNMvST/YPuE=;
        b=fju/APajZwRvSTMVZzJBvlx5hzM9PKgP7sDw+YhNC5Rg8sc7TixE3mq0lhisOUvRoy
         xVx+QrIghOKUgAHDiEZD1REtIYAeOI/Pkv2OnpalcdeoLBNXqrLaXhf349Dt9wUycu5r
         A7fiDO/hR5c9Ti+tYXApW/O2DbmTTHW+Xd+ktRDUmZt+Qj1ah0Yyn5DiWvn6nlaxjQVn
         J+OKYrfWwjOkqEgS09xFqYIlA1OzxPsPH1fNY+YH5VaBnQTrQRm5uno4dOlefqIPKwbv
         Cw5EdqkaSLAe9MqMf4p6/bqVeCYRSBCaYbIkxXqu4YlVUwo5Nb5jFF7YP3K8XiPV8/Tw
         ktgw==
X-Gm-Message-State: AOAM530zy1nADY8Ir72KnjHwFfForsXOXSbVbI0CckAo5s8LIMupbrGA
        yPR0vaArHetjDcG+nQIosMVhJdihyjmxlfzaDsk=
X-Google-Smtp-Source: ABdhPJxdjDrQ1VObEg1fJDmTAzjNNascf/eT/ASfc96PvXg+NyV2kooWdTZhgBk30cN/cpVwEf4p/OyzKfS1/Y1gQqI=
X-Received: by 2002:a05:6402:4254:: with SMTP id g20mr15512109edb.281.1644838422989;
 Mon, 14 Feb 2022 03:33:42 -0800 (PST)
MIME-Version: 1.0
References: <20220214033620.4059-1-jagathjog1996@gmail.com> <20220214033620.4059-4-jagathjog1996@gmail.com>
In-Reply-To: <20220214033620.4059-4-jagathjog1996@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 14 Feb 2022 13:32:14 +0200
Message-ID: <CAHp75VcWym5vyDAVyTUCpj=Qkm28VUaqdqJ7VuFL_bsb0fmhaA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] iio: potentiometer: Add support for Maxim DS3502
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Slawomir Stepien <sst@poczta.fm>,
        Rob Herring <robh+dt@kernel.org>,
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

On Mon, Feb 14, 2022 at 5:36 AM Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> The DS3502 is a 7-bit, nonvolatile digital potentiometer featuring
> an output voltage range of up to 15.5V.
> DS3502 support is implemented into existing ds1803 driver

Be consistent here and in other commit messages with how you refer to
the IC parts, i.e.
DS1803. Don't forget English grammar and punctuation, i.e. missed period above.

> Datasheet: https://datasheets.maximintegrated.com/en/ds/DS3502.pdf

>

A tag block may not have blank lines. Drop it.

> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>

...

> -       tristate "Maxim Integrated DS1803 Digital Potentiometer driver"
> +       tristate "Maxim Integrated DS1803 and similar Digital Potentiometer driver"

Please, list them like other drivers do:

       tristate "Maxim Integrated DS1803/DS... Digital Potentiometer driver"

...

> -         Say yes here to build support for the Maxim Integrated DS1803
> -         digital potentiometer chip.
> +         Say yes here to build support for the Maxim Integrated DS1803 and
> +         similar digital potentiometer chip.

Same here.

...

> - * Maxim Integrated DS1803 digital potentiometer driver
> + * Maxim Integrated DS1803 and similar digital potentiometer driver

Same here.

...

> -#define DS1803_MAX_POS         255
> -#define DS1803_WRITE(chan)     (0xa8 | ((chan) + 1))

Not sure why these were removed (or moved?)

...

> +static const struct ds1803_cfg ds1803_cfg[] = {
> +       [DS1803_010] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms =  10,
> +                        .channels = ds1803_channels,
> +                        .num_channels = ARRAY_SIZE(ds1803_channels) },
> +       [DS1803_050] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms =  50,
> +                        .channels = ds1803_channels,
> +                        .num_channels = ARRAY_SIZE(ds1803_channels) },
> +       [DS1803_100] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms = 100,
> +                        .channels = ds1803_channels,
> +                        .num_channels = ARRAY_SIZE(ds1803_channels) },
> +       [DS3502] =     { .wipers = 1, .avail = { 0, 1, 127 }, .kohms =  10,
> +                        .channels = ds3502_channels,
> +                        .num_channels = ARRAY_SIZE(ds3502_channels) },
>  };

Split this on a per type basis. I believe it won't be too much work,
also, consider adding channels as a separate preparatory patch as you
did with avail.

...

> -       data->cfg = &ds1803_cfg[id->driver_data];
> +       data->chip_type = (uintptr_t)device_get_match_data(dev);
> +       if (data->chip_type < DS1803_010 || data->chip_type > DS3502)
> +               data->chip_type = id->driver_data;

Split it into a separate patch and use pointer validation instead:

data->cfg = ...
if (!data->cfg)
  data->cfg = ...id->driver_data;

...

> -       { .compatible = "maxim,ds1803-010", .data = &ds1803_cfg[DS1803_010] },
> -       { .compatible = "maxim,ds1803-050", .data = &ds1803_cfg[DS1803_050] },
> -       { .compatible = "maxim,ds1803-100", .data = &ds1803_cfg[DS1803_100] },
> +       { .compatible = "maxim,ds1803-010", .data = (void *)DS1803_010 },
> +       { .compatible = "maxim,ds1803-050", .data = (void *)DS1803_050 },
> +       { .compatible = "maxim,ds1803-100", .data = (void *)DS1803_100 },

This is not good, please use pointers as it was before.

> +       { .compatible = "maxim,ds3502",     .data = (void *)DS3502 },

Ditto. Create a new, separate structure for this type.

...

>         { "ds1803-010", DS1803_010 },
>         { "ds1803-050", DS1803_050 },
>         { "ds1803-100", DS1803_100 },
> +       { "ds3502",     DS3502     },

Too many spaces.
Besides this, please create a new prerequisite patch to convert this
to use pointers as above.

-- 
With Best Regards,
Andy Shevchenko
