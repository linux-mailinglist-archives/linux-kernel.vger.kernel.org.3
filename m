Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B55E54E0AD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 14:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238637AbiFPMTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 08:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiFPMTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 08:19:32 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0D44B423;
        Thu, 16 Jun 2022 05:19:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id hj18so1811612ejb.0;
        Thu, 16 Jun 2022 05:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v6MtyAVz31cm+skLCA1E7opx+p3Kmx2UCHEt7uQwhqk=;
        b=IiEyuoaGVRdKabkTBrnth95HOOK5f3uasoz8JA6CSsSrbHDUI0RtEIQbivZ8Qolm4Q
         /Jz22LwpJUVm9hZ0fcbv9vc6153Qu7t96xsnR7PukCatEEKJza7AodL3vGHzCessZpf9
         QN/uwI1PQg26wimYLC9s2pY664cuG7FpFnXneZTXyU3jFHIdd/4/Wt6qJogpKUlGCJ23
         NdsTgH0MGkir2NgGq8E6ht0HLD+bF9TBm1zyoH0gHDaJzIJn+gA5gSLpdChFwgAr6n5L
         7wOTaE9zXA2vzZOCuId1G+1pJL3SM4V08hIfz/3FZxlISSioRQvaRAuI/M/iOJwyEI52
         pW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v6MtyAVz31cm+skLCA1E7opx+p3Kmx2UCHEt7uQwhqk=;
        b=jJUyckJWCsAfG3ZMlihBBcucKnp8078x450bgteULe5UteoGXgs0an1y14I5mqbFPt
         00bMpKN4DH8E67dxmSb9Gfp2MEH/PIZPELgpaU0a20kqMkPzuC+IPxpXU0O/nrGOK4yu
         0xEWtewY2ZnhXZvU7m38240CGs9fqx8NmJXjnztPSevi+7z9twbWb+q49znhszM3hfui
         i8bFeRlx5qporBAZT/e6g1hcZB585duHDKKs8c7AkjBVH1vvctyhottuX9LIYqwpMZ4Q
         qHtGmNhowasyEVaX/9aUZ2GN3SbKZBhngve2shSRZzgz/yXxiYKuzUNpzfLPcX+gmJZ8
         N3Lg==
X-Gm-Message-State: AJIora+6z4jw74fpCi0e5WmWVB8A7HHGkdbTszgnq0sPTO1YYCuHalaZ
        hGPo3URqUp54m0vWMvgIdqV/Ye6nn/OiQU/sdu66ajQCccvXQfXL
X-Google-Smtp-Source: AGRyM1sZTLCtLGcsb9jvYqR2RTY3P/hstRkWuTyP5+AjnEzqF2W6n1PKf0HWZECzdr7r9UqeSjswAuc8ktWcQLtFPnI=
X-Received: by 2002:a17:906:d550:b0:704:7ba6:9854 with SMTP id
 cr16-20020a170906d55000b007047ba69854mr4253929ejc.579.1655381969798; Thu, 16
 Jun 2022 05:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220616104211.9257-1-ddrokosov@sberdevices.ru> <20220616104211.9257-3-ddrokosov@sberdevices.ru>
In-Reply-To: <20220616104211.9257-3-ddrokosov@sberdevices.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 16 Jun 2022 14:18:52 +0200
Message-ID: <CAHp75Vc0+ckNnm2tzLMPrjeFRjwoj3zy0C4koNShFRG3kP8b6w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio: add MEMSensing MSA311 3-axis accelerometer driver
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Thu, Jun 16, 2022 at 12:42 PM Dmitry Rokosov
<DDRokosov@sberdevices.ru> wrote:
>
> MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
> sensitivity consumer applications. It has dynamical user selectable full

dynamic
user-selectable

> scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measurements
> with output data rates from 1Hz to 1000Hz.
>
> Datasheet can be found at following URL:
> https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-ENG.pdf

Make it  a tag. (Move closer to SoB without any blank lines and
keeping as one tag == one line, even if it's longer than any limit)

> This driver supports following MSA311 features:
>     - IIO interface
>     - Different power modes: NORMAL and SUSPEND (using pm_runtime)
>     - ODR (Output Data Rate) selection
>     - Scale and samp_freq selection
>     - IIO triggered buffer, IIO reg access
>     - NEW_DATA interrupt + trigger
>
> Below features to be done:
>     - Motion Events: ACTIVE, TAP, ORIENT, FREEFALL
>     - Low Power mode

...

> +MEMSENSING MICROSYSTEMS MSA311 ACCELEROMETER DRIVER

If MSA311 is accelerometer _only_, then the word "ACCELEROMETER" can be dropped.

...

> +/*
> + * msa311.c - MEMSensing digital 3-Axis accelerometer

Don't put the filename inside the file. Rationale -- less churn and
error prone in case it would be renamed.

> + *
> + * MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
> + * sensitivity consumer applications. It has dynamical user selectable full

dynamic
user-selectable

> + * scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measurements
> + * with output data rates from 1Hz to 1000Hz.
> + *
> + * MSA311 is available in an ultra small (2mm x 2mm, height 0.95mm) LGA package
> + * and is guaranteed to operate over -40C to +85C.
> + *
> + * This driver supports following MSA311 features:
> + *     - IIO interface
> + *     - Different power modes: NORMAL, SUSPEND
> + *     - ODR (Output Data Rate) selection
> + *     - Scale selection
> + *     - IIO triggered buffer
> + *     - NEW_DATA interrupt + trigger
> + *
> + * Below features to be done:
> + *     - Motion Events: ACTIVE, TAP, ORIENT, FREEFALL
> + *     - Low Power mode
> + *
> + * Copyright (c) 2022, SberDevices. All Rights Reserved.
> + *
> + * Author: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> + */

...

> +enum msa311_fields {
> +       F_SOFT_RESET_I2C, F_SOFT_RESET_SPI,
> +
> +       F_ORIENT_INT, F_S_TAP_INT, F_D_TAP_INT, F_ACTIVE_INT, F_FREEFALL_INT,
> +
> +       F_NEW_DATA_INT,
> +
> +       F_TAP_SIGN, F_TAP_FIRST_X, F_TAP_FIRST_Y, F_TAP_FIRST_Z, F_ACTV_SIGN,
> +       F_ACTV_FIRST_X, F_ACTV_FIRST_Y, F_ACTV_FIRST_Z,
> +
> +       F_ORIENT_Z, F_ORIENT_X_Y,
> +
> +       F_FS,
> +
> +       F_X_AXIS_DIS, F_Y_AXIS_DIS, F_Z_AXIS_DIS, F_ODR,
> +
> +       F_PWR_MODE, F_LOW_POWER_BW,
> +
> +       F_X_POLARITY, F_Y_POLARITY, F_Z_POLARITY, F_X_Y_SWAP,
> +
> +       F_ORIENT_INT_EN, F_S_TAP_INT_EN, F_D_TAP_INT_EN, F_ACTIVE_INT_EN_Z,
> +       F_ACTIVE_INT_EN_Y, F_ACTIVE_INT_EN_X,
> +
> +       F_NEW_DATA_INT_EN, F_FREEFALL_INT_EN,
> +
> +       F_INT1_ORIENT, F_INT1_S_TAP, F_INT1_D_TAP, F_INT1_ACTIVE,
> +       F_INT1_FREEFALL,
> +
> +       F_INT1_NEW_DATA,
> +
> +       F_INT1_OD, F_INT1_LVL,
> +
> +       F_RESET_INT, F_LATCH_INT,
> +
> +       F_FREEFALL_MODE, F_FREEFALL_HY,
> +
> +       F_ACTIVE_DUR,
> +
> +       F_TAP_QUIET, F_TAP_SHOCK, F_TAP_DUR,
> +
> +       F_TAP_TH,
> +
> +       F_ORIENT_HYST, F_ORIENT_BLOCKING, F_ORIENT_MODE,
> +
> +       F_Z_BLOCKING,
> +
> +       F_MAX_FIELDS,

Not sure why you put those blank lines herey, it makes code not compact.

> +};

...

> +/* All supported power modes */
> +#define MSA311_PWR_MODE_NORMAL  0b00

#define MSA311_PWR_MODE_UNKNOWN_01 0b01
#define MSA311_PWR_MODE_UNKNOWN_10 0b01

> +#define MSA311_PWR_MODE_SUSPEND 0b11

const char * const msa311_pwr_modes[] = { "normal", "unknown_01",
"unknown_10", "suspend" };

See below why this is here.

...

> +#define MSA311_GENMASK(field) ({                \

> +       typeof(field) _field = (field);         \

Why not define a pointer to the field here?

_field = &msa311_reg_fields[field];
GENMASK(_field->msb, _field->lsb);

> +       GENMASK(msa311_reg_fields[_field].msb,  \
> +               msa311_reg_fields[_field].lsb); \
> +})

...

> +struct msa311_priv {

> +       struct i2c_client *i2c;

Not sure you need this. Dropping i2c dependency from this structure
allows much easier to add, e.g. SPI support of the same hardware.

> +       struct mutex lock; /* state guard */
> +
> +       struct iio_trigger *new_data_trig;
> +
> +       struct regmap *regs;

I believe this is used most, so making this a first member in the
structure saves  some instructions (check with bloat-o-meter).

> +       struct regmap_field *fields[F_MAX_FIELDS];
> +};

...

> +       /* Filter bad ODR values */
> +       switch (pwr_mode) {
> +       case MSA311_PWR_MODE_NORMAL:
> +               mode = "normal";
> +               good_odr = (odr > MSA311_ODR_1_95_HZ);
> +               break;
> +       case MSA311_PWR_MODE_SUSPEND:
> +               mode = "suspend";
> +               break;
> +       default:
> +               mode = "unknown";
> +               break;
> +       }

As mentioned below you may think about an array of const char * const [].

...

> +       wait_ms = (USEC_PER_SEC * MSEC_PER_SEC) / freq_uhz;

This looks very odd from a physics perspective: sec * sec * sec == sec ?!

Perhaps you meant some HZ* macros from units.h?

...

> +       dev_dbg(dev, "transition to %s mode\n",
> +               (mode == MSA311_PWR_MODE_NORMAL) ? "normal" :
> +               (mode == MSA311_PWR_MODE_SUSPEND) ? "suspend" :
> +               "unknown");

I would rather put it (near to the mode enum / definitions) like

const char * const msa311_pwr_modes[] = { "normal", "suspend" };

(Also it seems you may reuse this above.)

And use here something like

mode >= ARRAY_SIZE() ? "unknown" : _pwr_modes[mode];

...

> +       /* Wait actual data if we wakeup */

wake up

...

> +       /* We do not have fs >= 1, so skip such values */
> +       if (val != 0)

if (val)

> +               return 0;

...

> +       err = -EINVAL;
> +       mutex_lock(&msa311->lock);
> +       for (odr = 0; odr < ARRAY_SIZE(msa311_odr_table); ++odr)
> +               if (val == msa311_odr_table[odr].val &&
> +                   val2 == msa311_odr_table[odr].val2) {
> +                       err = msa311_set_odr(msa311, odr);

> +                       if (err) {
> +                               dev_err(dev, "cannot update freq (%d)\n", err);
> +                               goto failed;
> +                       }

Why is this inside the loop and more important under lock? Also you
may cover the initial error code by this message when moving it out of
the loop and lock.

Ditto for other code snippets in other function(s) where applicable.

> +                       break;
> +               }
> +
> +failed:
> +       mutex_unlock(&msa311->lock);

...

> +       if (!readval)

Why not positive conditional?
Same Q whenever this is the case.

> +               err = regmap_write(msa311->regs, reg, writeval);
> +       else
> +               err = regmap_read(msa311->regs, reg, readval);

...

> +       mutex_lock(&msa311->lock);
> +       err = regmap_field_write(msa311->fields[F_NEW_DATA_INT_EN], state);
> +       mutex_unlock(&msa311->lock);

> +

No need.

> +       if (err)
> +               dev_err(dev,
> +                       "cannot %s buffer due to new_data_int failure (%d)\n",
> +                       state ? "enable" : "disable", err);

str_enable_disable()

...

> +       return (iio_trigger_get_drvdata(trig) != indio_dev) ? -EINVAL : 0;

Unnecessary parentheses and why not the positive conditional?

  return ... == ... ? 0 : ...;

...

> +       __le16 axis;
> +       int bit = 0, err, i = 0;

> +

Unnecessary blank line.

...

> +       /* TODO: send motion events if needed */

Are you going to address all TODOs? If no, drop ones that you are not
going to address in the future, better to put into the top of the file
comment what is supported and what's not.

...

> +       dev_dbg(dev, "Found MSA311 compatible chip[%#x]\n", partid);
> +
> +       if (partid != MSA311_WHO_AM_I)
> +               dev_warn(dev, "invalid partid (%#x), expected (%#x)\n",
> +                        partid, MSA311_WHO_AM_I);

I would put it rather like:

  if (partid == ...)
    dev_dbg("Found compatible chip'n");
  else
    dev_warn(...);

...

> +               if (IS_ERR(msa311->fields[i])) {
> +                       return dev_err_probe(dev, PTR_ERR(msa311->fields[i]),
> +                                            "cannot alloc reg field[%d]\n", i);
> +               }

{} are not needed.

...

> +       struct msa311_priv *msa311;
> +       struct iio_dev *indio_dev;

> +       struct device *dev = &i2c->dev;

Making it first line (the rule of thumb "longer lines first") here and
in any other similar cases?

...

> +       indio_dev->modes = INDIO_DIRECT_MODE; /* setup buffered mode later */

Leaving it 0 is probably better, it's a pity that we don't have
INDIO_NO_MODE_SET 0 there. However, I haven't checked if it's possible
to leave it unset like this.

...

> +       if (i2c->irq > 0) {
> +               err = msa311_setup_interrupts(msa311);
> +               if (err)
> +                       return err;
> +       }

Slightly cleaner is to save what's needed in the your private
structure, drop i2c_client pointer and move the above check inside the
function:

/* IRQ is optional */
if (msa311->irq <= 0)
  return 0;

But see if it's indeed better...

...

> +static int msa311_runtime_suspend(struct device *dev)

See comments for ->resume() below.

...

> +       dev_dbg(dev, "resuming %s\n", dev->driver->name);

Useless. Remove in other places. In case you need it, use ftracer and
PM suspend/resume debugging features.

> +       mutex_lock(&msa311->lock);
> +       err = msa311_set_pwr_mode(msa311, MSA311_PWR_MODE_NORMAL);
> +       mutex_unlock(&msa311->lock);

> +

No need.

> +       if (err) {
> +               dev_err(dev, "failed to power on device (%d)\n", err);

> +               return err;
> +       }
> +
> +       return 0;

  return err;

4 LoCs --> 1 LoC

...

> +static struct i2c_driver msa311_driver = {
> +       .driver = {
> +               .name = "msa311",
> +               .owner = THIS_MODULE,
> +               .of_match_table = msa311_of_match,
> +               .pm = pm_ptr(&msa311_pm_ops),
> +       },
> +       .probe_new      = msa311_probe,
> +       .id_table       = msa311_i2c_id,
> +};

> +

No need for a blank line here.

> +module_i2c_driver(msa311_driver);

-- 
With Best Regards,
Andy Shevchenko
