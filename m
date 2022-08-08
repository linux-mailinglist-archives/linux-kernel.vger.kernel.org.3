Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B3858C55A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242239AbiHHJOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbiHHJOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:14:34 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA577CE30;
        Mon,  8 Aug 2022 02:14:33 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id j17so1224724qtp.12;
        Mon, 08 Aug 2022 02:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=uFht8a8ovmyBkPnRH1XT0i8t80lVOE4E7/7ZL9FAG7A=;
        b=JKmh6rti3bU7uUqajEyn+DaU2K3an5BPuydCExpnTy90LBBIDASxpirKTByemag4s2
         YFwPi3dsSMiqoR2IrZZb+exMIhCbYY0SMQQfAV4ubYlvftlsHXV33Es+85Gjs5Y9wBhn
         Ta6RYGMXHxsX1p6rxTa6D1/KQMHG9rjjelEHXYYd7RqBy0JEezbSpU8wrVFbf9VHO38v
         Ft4w04Jy0I58XPhYPa3kkdpXWP9ixfoPdRgYP8+APjj6qTgW1mBTZKUIMqClhaEwx3Kq
         Kd+8IU1+3deaXeorOeb2MRiwTMpxljT+UPSpISmzULP6amilW4d+5KwhM6LFc4f3AsP3
         cFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=uFht8a8ovmyBkPnRH1XT0i8t80lVOE4E7/7ZL9FAG7A=;
        b=qasc+AhwSt1tJ66MOVX7sUFyoNYkViDUVyYMtATK48axmi5qnFNNibcSorRfPRqSzq
         i94AXkJ+/1azJTHNURLsqW0ivvE6h05aPzU8mCrOsF2XIxvGZk2XuwxLLWzjB2CzWrSu
         rggaevbl8EEr7mMduq/EXSwrKVhMbWBQYAyay4h1aHOa3dEaHEFtP+3Odan7N949+Y7O
         Mc3wlDe7oHXUcD/yYG6CiCveVptzwtAUImCfoZDqNvLxjjcapf2E7ITYgVQIije3lBbC
         327UCZxAFI8ln8ROoB2siCJL/kDqDWbskTV/LPZIKpSK2vdrgb0BQcP8/0jLpKPGyFBn
         O0GQ==
X-Gm-Message-State: ACgBeo37JShS7BJx+EZy0wZsEhKpHyQDjTwioVxSZcucbkGMMazdQZbe
        v84eLoFa5gRiyO0t/ehi6ZHPFNFbNVRBtn+VRDE=
X-Google-Smtp-Source: AA6agR69LhFUpKcxw/PPJSOcQM0CQw6pyo/5echNqr9skNGP5VzHtFR9CgC8qMrdFB1oq9K+Q1eX0ttLRcyXUUAxEAw=
X-Received: by 2002:a05:622a:14d2:b0:341:9fcb:79a6 with SMTP id
 u18-20020a05622a14d200b003419fcb79a6mr14855900qtx.195.1659950072842; Mon, 08
 Aug 2022 02:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1659872590.git.ang.iglesiasg@gmail.com> <680e7218234676ba78fc5eccd5f93e29c06c3983.1659872590.git.ang.iglesiasg@gmail.com>
In-Reply-To: <680e7218234676ba78fc5eccd5f93e29c06c3983.1659872590.git.ang.iglesiasg@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 11:13:56 +0200
Message-ID: <CAHp75VeNctrQjW4RHwbsF-y--9bAzg3XTFTZzXk+6whRFJcFYg@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] iio: pressure: bmp280: Add more tunable config
 parameters for BMP380
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
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

On Sun, Aug 7, 2022 at 2:44 PM Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
>
> Allows sampling frequency and IIR filter coefficients configuration
> using sysfs ABI.
>
> The IIR filter coefficient is configurable using the sysfs attribute
> "filter_low_pass_3db_frequency".

...

> +static const int bmp380_odr_table[][2] = {

s32_fract ?

> +       [BMP380_ODR_200HZ]      = {200, 0},
> +       [BMP380_ODR_100HZ]      = {100, 0},
> +       [BMP380_ODR_50HZ]       = {50, 0},
> +       [BMP380_ODR_25HZ]       = {25, 0},
> +       [BMP380_ODR_12_5HZ]     = {12, 500000},
> +       [BMP380_ODR_6_25HZ]     = {6, 250000},
> +       [BMP380_ODR_3_125HZ]    = {3, 125000},
> +       [BMP380_ODR_1_5625HZ]   = {1, 562500},
> +       [BMP380_ODR_0_78HZ]     = {0, 781250},
> +       [BMP380_ODR_0_39HZ]     = {0, 390625},
> +       [BMP380_ODR_0_2HZ]      = {0, 195313},
> +       [BMP380_ODR_0_1HZ]      = {0, 97656},
> +       [BMP380_ODR_0_05HZ]     = {0, 48828},
> +       [BMP380_ODR_0_02HZ]     = {0, 24414},
> +       [BMP380_ODR_0_01HZ]     = {0, 12207},
> +       [BMP380_ODR_0_006HZ]    = {0, 6104},
> +       [BMP380_ODR_0_003HZ]    = {0, 3052},
> +       [BMP380_ODR_0_0015HZ]   = {0, 1526},
> +};

...

> +               ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
> +                                       BMP380_MODE_MASK,

> +                                       FIELD_PREP(BMP380_MODE_MASK,
> +                                                  BMP380_MODE_SLEEP));

One line?

...

> +               ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
> +                                       BMP380_MODE_MASK,

> +                                       FIELD_PREP(BMP380_MODE_MASK,
> +                                                  BMP380_MODE_NORMAL));

Ditto.

...

> +static const int bmp380_iir_filter_coeffs_avail[] = { 0, 1, 3, 7, 15, 31, 63, 127 };

This seems like a power of two - 1, can it be replaced by a formula in the code?

-- 
With Best Regards,
Andy Shevchenko
