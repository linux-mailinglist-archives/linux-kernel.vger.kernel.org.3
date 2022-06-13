Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5EC549CC7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347172AbiFMTEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346091AbiFMTDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:03:10 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927A02E9D8;
        Mon, 13 Jun 2022 09:44:47 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g7so7987645eda.3;
        Mon, 13 Jun 2022 09:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eGdfXfwfV78gnjcf5UQqAMy9o19LId4Sm/qy2tCjefs=;
        b=gsPB1T8UwmLJ1VZ61mRDNQvLBYrwjhjBqt/329BAIA+3SWHdyZWq5P/srAA8mQz2Vg
         X4SH0kJTHXqlUv4UfZXuA+pPanPwPwqsFxEYsoMy7nsTwoIRHMMrF10tZOmWrS4I8COp
         T4kJWRqrqX/dZXSg4lRzX8AWr9U7kmdfdEKzUboA62O9M9+GnPu8XWQIPOV8C0rjW9U/
         PWbTD1kgEcV5StqWbzVRUbaaDZp3zN1/hdNJrmv6o8JhYAoK8F6Fr+fCvUB+xL9X+gsu
         B4fgGZ0ru7YLIs/i4HhVtBoMPyGEt43GMTiu2gYKp/IbCJcVuP3zrAjjrGZDgcyOeET9
         xuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eGdfXfwfV78gnjcf5UQqAMy9o19LId4Sm/qy2tCjefs=;
        b=txPegyLmNPjX+yJo9QY1Spml6GdMmbSJyawVzUIkad7c99yWGzO9RUUB6z3guM+m3G
         hrpy6nFcwhrT6J/JAvEtNhxPcn5+LJ6QpjqpwwUZhl6FR9Yk1NJWFC4bsILh5wIlm/6l
         CrpCvW7TmXAdIJIW94lnlQz5nOAjE33R/1ibWi7U+FJj3pR/Cxm1mZjidTBtHjJAegsm
         LAQKVPl8xd2P5CaEL3ANsyzQ2hHmNHrTo+XYVJ1jFJxMd77JvbeXyY+nN7EDhBrVQjAk
         Ym7eiW1ILwj2ivUeOBaZSMfMtfe0nbu6ikrljiJCcOvmKsTEPjkKdj1AZRIVQkynlmVM
         lCGA==
X-Gm-Message-State: AOAM532Nnwp8E2qt/4tjGLxkyD7Xz1G7ae2Vk4N1nDwJwHlwGXpWamHb
        xCDT6MTjndkrG0piWsJe7PyP7mWljDGlZ9oG/sY=
X-Google-Smtp-Source: ABdhPJwG44xMdsA8yWvhv1Mlf7JhAM8ZMHZetdju+DGsqfsYqwGExdR6mkw15zu1TDUYOimhqvxQGFQqzsWwdcDfrV0=
X-Received: by 2002:aa7:d481:0:b0:42d:d5fd:f963 with SMTP id
 b1-20020aa7d481000000b0042dd5fdf963mr664238edr.209.1655138685998; Mon, 13 Jun
 2022 09:44:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220613120534.36991-1-andrea.merello@iit.it> <20220613120534.36991-9-andrea.merello@iit.it>
In-Reply-To: <20220613120534.36991-9-andrea.merello@iit.it>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 13 Jun 2022 18:44:09 +0200
Message-ID: <CAHp75Vdh8kAH6540xCwzFh5uf=QMVTHC42a8pOgvkpObzjfD+w@mail.gmail.com>
Subject: Re: [v6 08/14] iio: imu: add Bosch Sensortec BNO055 core driver
To:     Andrea Merello <andrea.merello@iit.it>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>
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

On Mon, Jun 13, 2022 at 2:05 PM <andrea.merello@iit.it> wrote:
>
> From: Andrea Merello <andrea.merello@iit.it>
>
> Add the core driver for the BNO055 IMU from Bosch. This IMU can be
> connected via both serial and I2C busses; separate patches will add support
> for them.
>
> The driver supports "AMG" (Accelerometer, Magnetometer, Gyroscope) mode,
> that provides raw data from the said internal sensors, and a couple of
> "fusion" modes (i.e. the IMU also does calculations in order to provide
> euler angles, quaternions, linear acceleration and gravity measurements).
>
> In fusion modes the AMG data is still available (with some calibration
> refinements done by the IMU), but certain settings such as low pass filters
> cut-off frequency and sensors' ranges are fixed, while in AMG mode they can
> be customized; this is why AMG mode can still be interesting.

...

> +config BOSCH_BNO055_IIO

Does it need _IIO suffix? Any name collision?

...

> +static int bno055_acc_lpf_vals[] = {
> +       7, 810000, 15, 630000, 31, 250000, 62, 500000,
> +       125, 0, 250, 0, 500, 0, 1000, 0

+ Comma?

> +};

...

> +                                /* G:   2,    4,    8,    16 */

Indentation of this comment is a bit off.

> +static int bno055_acc_range_vals[] = {1962, 3924, 7848, 15696};

Perhaps split this to 4 lines and put the comment on top of the third line?

...

> +static int bno055_gyr_scale_vals[] = {
> +       125, 1877467, 250, 1877467, 500, 1877467,
> +       1000, 1877467, 2000, 1877467

+ Comma?

> +};

...

> +#ifdef CONFIG_DEBUG_FS
> +       struct dentry *debugfs;
> +#endif

...

> +                       /*
> +                        * IMU reports sensor offests; IIO wants correction

offsets

> +                        * offsets, thus we need the 'minus' here.
> +                        */

...

> +       if (kstrtobool(buf, &en))
> +               return -EINVAL;

Why shadow an actual error code(s)?

...

> +       ret = kstrtoul(buf, 10, &val);
> +       if (ret)
> +               return ret;

Here it's done properly (see just above).

...

> +static void bno055_debugfs_init(struct iio_dev *iio_dev)
> +{
> +       struct bno055_priv *priv = iio_priv(iio_dev);
> +
> +       priv->debugfs = debugfs_create_file("firmware_version", 0400,
> +                                           iio_get_debugfs_dentry(iio_dev),
> +                                           priv, &bno055_fw_version_ops);

> +       devm_add_action_or_reset(priv->dev, bno055_debugfs_remove, priv->debugfs);

Shouldn't we report the potential error here? It's not directly
related to debugfs, but something which is not directly related.

> +}

...

> +static IIO_DEVICE_ATTR(fusion_enable, 0644,
> +                      bno055_fusion_enable_show,
> +                      bno055_fusion_enable_store, 0);

IIO_DEVICE_ATTR_RW()

> +static IIO_DEVICE_ATTR(in_magn_calibration_fast_enable, 0644,
> +                      bno055_fmc_enable_show,
> +                      bno055_fmc_enable_store, 0);
> +
> +static IIO_DEVICE_ATTR(in_accel_range_raw, 0644,
> +                      bno055_in_accel_range_show,
> +                      bno055_in_accel_range_store, 0);

Ditto for above.

...

> +       /*
> +        * All chans are made up 1 16-bit sample, except for quaternion that is

channels

> +        * made up 4 16-bit values.
> +        * For us the quaternion CH is just like 4 regular CHs.
> +        * If our read starts past the quaternion make sure to adjust the
> +        * starting offset; if the quaternion is contained in our scan then make
> +        * sure to adjust the read len.
> +        */

-- 
With Best Regards,
Andy Shevchenko
