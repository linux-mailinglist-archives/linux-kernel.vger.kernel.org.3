Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6224BEBDF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 21:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbiBUUdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 15:33:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiBUUdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 15:33:01 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4FB22BFF;
        Mon, 21 Feb 2022 12:32:37 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id s14so14397194edw.0;
        Mon, 21 Feb 2022 12:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gfBXBmzZF5qhk7h6/Jp4L/7fgHtVsQgStWyonPiVpuU=;
        b=W1hsMaavN95NBCPxSXgBvjQ374ra+69M5BwWgZJT68k7fRfJnAWqxTzv+owt3yWl3s
         gb1dK/5kOiJpT1VOQ/b7k0upvPL3g0vQO7/qM0a6uL7I0nQ3Yu6OshPNh9kJLhJ71AaL
         RYskCFImoPi8o/RmixGPAd0J0TyHno4ljDtou01uzdoEfCNctecnx25pzDL+IQrv1lDY
         op2ktN0H8RolhlCusqjXpwTKPYJbd2seipXpxkJJAziF8OA5mzMt9OZ4lkYG1eWmNOJe
         gc+Zy/TsMwv+WzffDsD5xSz3L2Tgqdw8x79ojPqL4WN0jUge9C9Lwx5UUiBlnFgthYyP
         qE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gfBXBmzZF5qhk7h6/Jp4L/7fgHtVsQgStWyonPiVpuU=;
        b=jq/qJBPzy6Q6JP+iNzmdse217tWbyOdwHrsgbmI7rW1Zkj74YYMnChxwoOFyuLnijJ
         V3aGBZUuq551My3idN8g/4uWQHfB7qoJrN1wJFou4iEdER5WNDGPTHF3P+fISgmAf5LV
         Ds+zBgh8wmDU0/tCWH3yhCdHsrJM34fgZ5E2D5QAMKt6Z8F0o8RANsesU1lqNliPN5cH
         closCdt5n+Pf17/CZta+JvR1MFpxxF0RC5OEUqTmx27VuWK+b2PLGqnosGCWAsDYJOhh
         Gx7q7RXaDjICzNspoQZStNeMVZQHyNgOvr9MTbAhndnKkRhjQej2GWdW88IJOI87QEIU
         eZCA==
X-Gm-Message-State: AOAM531pwn3o1hFrnOEJJbhBaQF/pKk3cxpz/lDAlNzN9GaRbIuNwM/y
        t3q/jEv/Q1xycynuwbZYCvyQDNNeJzGhUaCC4KQ=
X-Google-Smtp-Source: ABdhPJx3/xsbtrfrmzBfxlN9/HfOWlQawBifYmoUCX1u/hLffr/xo+Z/2ojyByjcqN/QbQ9wiUsYS+WTIMvs8wBC0D8=
X-Received: by 2002:a05:6402:198:b0:410:83e3:21d7 with SMTP id
 r24-20020a056402019800b0041083e321d7mr23590064edv.159.1645475555879; Mon, 21
 Feb 2022 12:32:35 -0800 (PST)
MIME-Version: 1.0
References: <20220217162710.33615-1-andrea.merello@gmail.com> <20220217162710.33615-13-andrea.merello@gmail.com>
In-Reply-To: <20220217162710.33615-13-andrea.merello@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Feb 2022 21:32:00 +0100
Message-ID: <CAHp75Vezc+ieFE23unzNdcz5YeuduOO7OJWyS=HvEUAE4=x7Ag@mail.gmail.com>
Subject: Re: [v3 12/13] iio: imu: add BNO055 I2C driver
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
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

On Thu, Feb 17, 2022 at 5:27 PM Andrea Merello <andrea.merello@gmail.com> wrote:
>
> This path adds an I2C driver for communicating to a BNO055 IMU via I2C
> bus and it enables the BNO055 core driver to work in this scenario.

...

> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/module.h>

Keep it sorted?

...

> +static int bno055_i2c_probe(struct i2c_client *client,
> +                           const struct i2c_device_id *id)

You may switch it to use ->probe_new() (you may leave I2C ID table for
possibility to instantiate this via user space).

...

> +       struct regmap *regmap =
> +               devm_regmap_init_i2c(client, &bno055_regmap_config);

Please, split the definition and assignment.

> +       if (IS_ERR(regmap)) {
> +               dev_err(&client->dev, "Unable to init register map");
> +               return PTR_ERR(regmap);

return dev_err_probe(...);

...

> +       .probe = bno055_i2c_probe,
> +       .id_table = bno055_i2c_id

Missed comma.

-- 
With Best Regards,
Andy Shevchenko
