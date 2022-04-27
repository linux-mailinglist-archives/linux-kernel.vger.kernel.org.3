Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703715118F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbiD0N0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbiD0N0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:26:47 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3D22E080;
        Wed, 27 Apr 2022 06:23:34 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id j6so3322271ejc.13;
        Wed, 27 Apr 2022 06:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MDq52gg2S38jY8GvvNKkgYiJaKJ9lQGspuro9WnAZFg=;
        b=QNK8zs7gmg2UP+y5f47IHIL5U/Nm0NbHPkEjS8O7QFnhb8ybi231TTIx6UfJDQBGSb
         H/SDRoXW0Awz9AAT+V7+oltV0apQ/aFFox2WVuy9VWFr8PWBOwFxq9rE0QqTijSwe6Co
         B7epnNx9KG9l4TDXhXH2EAMAZDz+/UHOYwL6KXwdlezL/vpp93gQamVgKv5NLXQWKzR0
         I0A0UA+Ec/y+0xnT9EKIlcOYNwnafKvY4XQzNuTR0JVDuhdzA/vWRboWBQgHobXFBBix
         103KSgh7fkRcWg70vqkVxFNuWwaii3GCeIcQi1p0Gwb6inlHvwzWWH0r/WXt322UqS31
         0zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MDq52gg2S38jY8GvvNKkgYiJaKJ9lQGspuro9WnAZFg=;
        b=KioDHUbulDfnvdbzi5xDX3WrFZUij8n7zbDGaZlsQtKJOFv7ex4HUxI8228AvILOQV
         dqJ5dF1+RG3vUNP6aAgpmdgp+ySEaqn47bt+nS+wzUIpjMQiedhRiRYTArgFk6oEMoLb
         8Q/12BebcEv35HlwgTMn1yeGaQC4okl2wqBnL9BMwRZc1tPqDXAX/hhRDOKxnelOZqEa
         vFWDQAeNc5rKoOzaQ4NvH4TzoCp5q21MZ+Jw/kQioPOAWp3L72uet25+dQiCFOesHXms
         wDffeFPN1lacXLzLkkp3meixlmBxTsBElXK+pInEhGk8gn8AsK0TBtNgcZaL7q9/kEM/
         vRBg==
X-Gm-Message-State: AOAM532NxGV8ENPy5g+ABCGullIIovKLray1Oj0K65myIoZllEyenktg
        1rAZ+grbusYsDCSE+TVvDnTGMUDk0MzkT0wLADU=
X-Google-Smtp-Source: ABdhPJyj6mlB0EWyd+wFjOfEIqh3Q6vXrOtLzz3fxJ4dKTqYbIdJ94W58ikbzgIQiKJJgJTJKT7F3Q4JmSd8LJUXxn8=
X-Received: by 2002:a17:906:1cd1:b0:6ec:c59:6a1d with SMTP id
 i17-20020a1709061cd100b006ec0c596a1dmr27039743ejh.77.1651065813236; Wed, 27
 Apr 2022 06:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220426131102.23966-1-andrea.merello@gmail.com> <20220426131102.23966-9-andrea.merello@gmail.com>
In-Reply-To: <20220426131102.23966-9-andrea.merello@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Apr 2022 15:22:56 +0200
Message-ID: <CAHp75VdLiBkg100UjFN36rW_vaOObOoJ_Mv9n=4LjSWb+dQWMw@mail.gmail.com>
Subject: Re: [v5 08/14] iio: imu: add Bosch Sensortec BNO055 core driver
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
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

On Tue, Apr 26, 2022 at 3:11 PM Andrea Merello <andrea.merello@gmail.com> wrote:
>
> From: Andrea Merello <andrea.merello@iit.it>
>
> Add the core driver for the BNO055 IMU from Bosch. This IMU can be
> connected via both serial and I2C busses; separate patches will add support
> for them.
>
> The driver supports "AMG" (Accelerometer, Magnetometer, Gyroscope) mode,
> that provides raw data from the said internal sensors, and a couple of
> "fusion" modes (i.e. the IMU also do calculations in order to provide euler

does

> angles, quaternions, linear acceleration and gravity measurements).
>
> In fusion modes the AMG data is still available (with some calibration
> refinements done by the IMU), but certain settings such as low pass filters
> cut-off frequency and sensors ranges are fixed, while in AMG mode they can

sensor?
sensors'?

> be customized; this is why AMG mode can still be interesting.

...

> +#include <linux/bitmap.h>
> +#include <linux/clk.h>
> +#include <linux/bitfield.h>
> +#include <linux/debugfs.h>
> +#include <linux/device.h>
> +#include <linux/firmware.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/util_macros.h>

Keep them ordered?

...

> +#include <linux/iio/iio.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/sysfs.h>

Ditto.

...

> +#define BNO055_FW_NAME "bno055-caldata"
> +#define BNO055_FW_EXT ".dat"
> +#define BNO055_FW_UID_NAME BNO055_FW_NAME "-%*phN" BNO055_FW_EXT

I believe this should be _FMT prefix, since it's not a name (I don't
think %*phN is a part of the actual file name).

> +#define BNO055_FW_GENERIC_NAME (BNO055_FW_NAME BNO055_FW_EXT)

And these macros of macros look unreadable, can we just hardcode
format and generic name?

...

> +#define BNO055_ATTR_VALS(...)          \
> +       .vals = (int[]){ __VA_ARGS__},  \
> +       .len = ARRAY_SIZE(((int[]){__VA_ARGS__}))

Not sure this adds any readability to the code. Can we simply have an
array of int for each case with the explicit ARRAY_SIZE() calls?

...

> +/*
> + * Theoretically the IMU should return data in a given (i.e. fixed) unit
> + * regardless the range setting. This happens for the accelerometer, but not for

regardless of

> + * the gyroscope; the gyroscope range setting affects the scale.
> + * This is probably due to this[0] bug.
> + * For this reason we map the internal range setting onto the standard IIO scale
> + * attribute for gyro.
> + * Since the bug[0] may be fixed in future, we check for the IMU FW version and
> + * eventually warn the user.
> + * Currently we just don't care about "range" attributes for gyro.
> + *
> + * [0]  https://community.bosch-sensortec.com/t5/MEMS-sensors-forum/BNO055-Wrong-sensitivity-resolution-in-datasheet/td-p/10266
> + */

...

> +       /* calibration data may be updated by the IMU */
> +       if (reg >= BNO055_CALDATA_START && reg <= BNO055_CALDATA_END)
> +               return true;
> +
> +       return false;

Can be done in one return statement w/o branch, but probably OK taking
into account other related functions.

> +}

...

> +       {
> +               .range_min = 0,
> +               .range_max = 0x7f * 2,
> +               .selector_reg = BNO055_PAGESEL_REG,
> +               .selector_mask = GENMASK(7, 0),
> +               .selector_shift = 0,
> +               .window_start = 0,
> +               .window_len = 0x80

In all cases like this, keep the trailing comma.

> +       },

...

> +       msleep(20);

Perhaps a comment why so long sleep is needed.

...

> +static int bno055_system_reset(struct bno055_priv *priv)
> +{
> +       int ret;
> +
> +       if (priv->reset_gpio) {
> +               gpiod_set_value_cansleep(priv->reset_gpio, 0);
> +               usleep_range(5000, 10000);
> +               gpiod_set_value_cansleep(priv->reset_gpio, 1);
> +       } else {
> +               if (!priv->sw_reset)
> +                       return 0;

Can be unified with the above 'else':

} else if (...) {
  return 0;
} else {

> +               ret = regmap_write(priv->regmap, BNO055_SYS_TRIGGER_REG,
> +                                  BNO055_SYS_TRIGGER_RST_SYS);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       regcache_drop_region(priv->regmap, 0x0, 0xff);
> +       usleep_range(650000, 700000);
> +
> +       return 0;
> +}

...

> +exit:

exit_unlock: ?

> +       mutex_unlock(&priv->lock);
> +       return ret;
> +}

...

> +       .scan_type = {                                                          \
> +               .sign = 's',                                                    \
> +               .realbits = 16,                                                 \
> +               .storagebits = 16,                                              \
> +               .endianness = IIO_LE,                                           \
> +               .repeat = IIO_MOD_##_axis == IIO_MOD_QUATERNION ? 4 : 0         \

+ Comma.

> +       },                                                                      \

...

> +       {
> +               .type = IIO_TEMP,
> +               .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +               .scan_index = -1

+ Comma.

> +       },

...

> +       /*
> +        * We always get a request in INT_PLUS_MICRO, but we
> +        * take care of the micro part only when we really have
> +        * non-integer tables. This prevents 32-bit overflow with
> +        * larger integers contained in integer tables.
> +        */
> +       req_val = val;
> +       if (attr->type != IIO_VAL_INT) {


> +               if (val > 2147)
> +                       val = 2147;

min() ?

It seems it's not used outside of this branch, so this min() can be
integrated into below without corrupting val itself.

> +               len /= 2;
> +               req_val = val * 1000000 + val2;
> +       }

...

> +               if (first || delta < best_delta) {

In such cases checking 'first' last might slightly be better.

> +                       best_delta = delta;
> +                       hwval = i;
> +                       first = false;
> +               }

...

> +                       /*
> +                        * IMU reports sensor offests; IIO wants correction

offsets

> +                        * offset, thus we need the 'minus' here.
> +                        */

...

> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               if (chan->type != IIO_MAGN)
> +                       return -EINVAL;

> +               else

redundant.

> +                       return bno055_get_regmask(priv, val, val2,
> +                                                 BNO055_MAG_CONFIG_REG,
> +                                                 BNO055_MAG_CONFIG_ODR_MASK,
> +                                                 &bno055_mag_odr);

...

> +       for (i = 0; i < bno055_acc_range.len; i++)
> +               len += sysfs_emit_at(buf, len, "%d%c", bno055_acc_range.vals[i],
> +                                    (i == bno055_acc_range.len - 1) ? '\n' : ' ');

You may move the condition out of the loop.

...

> +       int ret = 0;

Redundant assignment, see below.

> +       if (indio_dev->active_scan_mask &&
> +           !bitmap_empty(indio_dev->active_scan_mask, _BNO055_SCAN_MAX))
> +               return -EBUSY;
> +
> +       if (sysfs_streq(buf, "0")) {
> +               ret = bno055_operation_mode_set(priv, BNO055_OPR_MODE_AMG);

return bno055_operation_mode_set(...);

> +       } else {

...and drop this with the following decreasing indentation.

> +               /*
> +                * Coming from AMG means the FMC was off, just switch to fusion
> +                * but don't change anything that doesn't belong to us (i.e let
> +                * FMC stay off.
> +                * Coming from any other fusion mode means we don't need to do
> +                * anything.
> +                */
> +               if (priv->operation_mode == BNO055_OPR_MODE_AMG)
> +                       ret = bno055_operation_mode_set(priv, BNO055_OPR_MODE_FUSION_FMC_OFF);
> +       }
> +       if (ret)
> +               return ret;
> +       return len;

...

> +       if (count < BNO055_CALDATA_LEN || pos != 0)

Drop ' != 0' part ?

> +               return -EINVAL;

...

> +unlock:

exit_unlock: to be consistent?

> +       mutex_unlock(&priv->lock);
> +       return ret;

...

> +       /*
> +        * Walk the bitmap and eventually perform several transfers.
> +        * Bitmap ones-fileds that are separated by gaps <= xfer_burst_break_thr

ones-fields ?

> +        * will be included in same transfer.
> +        * Every time the bitmap contains a gap wider than xfer_burst_break_thr
> +        * then we split the transfer, skipping the gap.
> +        */

...

> +               /*
> +                * First transfer will start from the beginnig of the first

beginning

> +                * ones-field in the bitmap
> +                */
> +               if (first)
> +                       xfer_start = start;
> +
> +               /*
> +                * We found the next ones-field; check whether to include it in
> +                * the current transfer or not (i.e. let's perform the current
> +                * transfer and prepare for another one).
> +                */

> +               if (!first) {

'else {' ?


> +               }

...

> +static void bno055_clk_disable(void *arg)
> +{
> +       clk_disable_unprepare((struct clk *)arg);

Redundant casting.

> +}

...

> +       const u8 *caldata_data = NULL;

> +       int caldata_size = 0;

No need. See below.

...

> +       if (priv->reset_gpio) {
> +               usleep_range(5000, 10000);
> +               gpiod_set_value_cansleep(priv->reset_gpio, 1);
> +               usleep_range(650000, 750000);

> +       } else {
> +               if (!sw_reset)

} else if () {

> +                       dev_warn(dev, "No usable reset method; IMU may be unreliable");
> +       }

...

> +       /*
> +        * Seems that stock FW version conains a bug (see comment at the

the stock
contains

> +        * beginning of this file) that causes the anglvel scale to be changed
> +        * depending by the chip range setting. We workaround this, but we don't

on the chip

> +        * know what other FW version might do..

versions

One period at the end is enough, or add another one if there is a
continuation below.

> +        */

...

> +       ret = request_firmware(&caldata, fw_name_buf, dev);
> +       kfree(fw_name_buf);
> +       if (ret)
> +               ret = request_firmware(&caldata, BNO055_FW_GENERIC_NAME, dev);

> +

Can be removed to group all related checks together.

> +       if (ret)
> +               dev_notice(dev, "Calibration file load failed. See instruction in kernel Documentation/iio/bno055.rst");
> +
> +       if (caldata) {
> +               caldata_data = caldata->data;
> +               caldata_size = caldata->size;
> +       }
> +       ret = bno055_init(priv, caldata_data, caldata_size);

> +       if (caldata)
> +               release_firmware(caldata);

> +       if (ret)
> +               return ret;

Can be rewritten in a form of

if (caldata) {
 ret = bno055_init();
 release_firmware(...);
} else {
 ret = bno055_init();
}
if (ret)
  return ret;

?

...

> +#include <linux/regmap.h>

Missed types.h.

> +struct device;
> +int bno055_probe(struct device *dev, struct regmap *regmap,
> +                int xfer_burst_break_thr, bool sw_reset);
> +extern const struct regmap_config bno055_regmap_config;

-- 
With Best Regards,
Andy Shevchenko
