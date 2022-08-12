Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3B7591760
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 00:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbiHLWfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 18:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiHLWfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 18:35:18 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E58AE53;
        Fri, 12 Aug 2022 15:35:17 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id c28so1836135qko.9;
        Fri, 12 Aug 2022 15:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Xtz7Qdm52hY6teOohbF4wKOsJYPRJQ4hCIc2H3BCaLo=;
        b=c6vXMPXpF1F3ufYfJUNmW9HfTGRxOgDH3lA/T4/s4pww0iQRtxOxFbjn5m8s6rGlFc
         xTkPCehnEFcMpdcYU3zcGmFDH/CWssFx17GHi/Y+yo6raVX1p9CihzMF1zIawkpioldb
         nSo82udz15Oa0VjbJfKv5zd/l1xT5NXRaS4+YnO20aJL98+TpZ1GJm4kcxp/mdMXoQws
         //vuVKL0DXJ1WM/O8hcUQJdiXq/Jcb32cX1eUIe/4l4YNIr82BMmZdwvO8/6iuYWr6Xp
         Mxc1ZHt1tmxG6jEA9RjpUD8zutvE9V95euNF6QWfTGqMTyC5mzve87E8RIMP3jaTAegN
         pA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Xtz7Qdm52hY6teOohbF4wKOsJYPRJQ4hCIc2H3BCaLo=;
        b=fIsvhMn/cnLXabHs16M9uID1uJMTEvjHx4mXVg6ovBXO4ezjRdIdJKORsqGosurprW
         W+VJvke4YKvxJ602gyUBVMUQFK6dnBMJuKbofRF2yg0Nj2aeJp+sL/f551P8Jxczy1AS
         OfIDceRazrtPOO6h/IwqkZIrj2A10waQoxHFM6dXrPNdBlbSHnZSqXdJG4JHUcu6OrWQ
         gqDa95oNYcT/y0WS0P2diI7OgH7SQmIOMdZnZKrf9r98IbyPqGN27fFVYDyuX9rWcBkE
         lGSPpRMWCQcXOj5JqB/N84a4ivBiPfA+lqothHQgwaQ/dkxLAy13xIZ88HxSsPSEwlGD
         dd+g==
X-Gm-Message-State: ACgBeo1zk0R1ZSQymwUKRl872reGU/tTmPCVrsVTcoqF1h9/f/IdFDP7
        fePh5Vu2ayIeB1Qku1N/H7iXTnAFvE2fWvW3ML4=
X-Google-Smtp-Source: AA6agR7FEHMHgJ001fwppuZfJYinJYI0mNfethWBer0MzcsYdwmVfHnChDVM+6/a1EN6hBNZfv2iaI4JWl7253U24Gw=
X-Received: by 2002:a05:620a:288a:b0:6b8:fcfe:db02 with SMTP id
 j10-20020a05620a288a00b006b8fcfedb02mr4600392qkp.504.1660343716534; Fri, 12
 Aug 2022 15:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220812165243.22177-1-ddrokosov@sberdevices.ru> <20220812165243.22177-7-ddrokosov@sberdevices.ru>
In-Reply-To: <20220812165243.22177-7-ddrokosov@sberdevices.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 13 Aug 2022 01:34:40 +0300
Message-ID: <CAHp75Ve8VtwGX6YeuGvhUat5UfoLXB4RdkW4vc1kQUk71+_aCA@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] iio: add MEMSensing MSA311 3-axis accelerometer driver
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jbhayana@google.com" <jbhayana@google.com>,
        "lucas.demarchi@intel.com" <lucas.demarchi@intel.com>,
        "jani.nikula@intel.com" <jani.nikula@intel.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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

On Fri, Aug 12, 2022 at 7:52 PM Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
>
> MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
> sensitivity consumer applications. It has dynamic user-selectable full
> scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measurements
> with output data rates from 1Hz to 1000Hz.

> Spec: https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-ENG.pdf

Can you use Datasheet: tag below (just before your SoB tag)?

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

> +static const struct {
> +       int val;
> +       int val2;
> +} msa311_fs_table[] = {
> +       {0, 9580}, {0, 19160}, {0, 38320}, {0, 76641}
> +};

At least you may deduplicate the type definition for these data structures, like

struct iio_float {
  int integer;
  int fract;
};

...

> +               dev_err(dev,
> +                       "cannot set odr %u.%luHz, not available in %s mode\n",
> +                       msa311_odr_table[odr].val,
> +                       msa311_odr_table[odr].val2 / MILLIHZ_PER_HZ,

Logically it's MICROHZ_PER_MILLIHZ.

> +                       msa311_pwr_modes[pwr_mode]);

...

> +       freq_uhz = msa311_odr_table[odr].val * MICROHZ_PER_HZ +
> +                  msa311_odr_table[odr].val2;
> +       wait_ms = (MICROHZ_PER_HZ / freq_uhz) * MSEC_PER_SEC;

On the contrary this seems correct.

...

> +       err = iio_device_claim_direct_mode(indio_dev);
> +       if (err)
> +               return err;
> +
> +       mutex_lock(&msa311->lock);
> +       err = msa311_get_axis(msa311, chan, &axis);
> +       mutex_unlock(&msa311->lock);
> +
> +       iio_device_release_direct_mode(indio_dev);
> +
> +       if (err) {
> +               dev_err(dev, "cannot get axis %s (%pe)\n",
> +                       chan->datasheet_name, ERR_PTR(err));
> +               return err;
> +       }
> +
> +       pm_runtime_mark_last_busy(dev);
> +       pm_runtime_put_autosuspend(dev);

All error cases above miss the PM restoration. Is it on purpose?
Otherwise fix it here and check everywhere else.

...

> +       used = scnprintf(msa311->chip_name, sizeof(msa311->chip_name),
> +                        "msa311-%hhx", partid);

> +       msa311->chip_name[used] = '\0';

What is this for exactly?

...

> +       /* Disable all interrupts by default */
> +       err = regmap_write(msa311->regs, MSA311_INT_SET_0_REG, 0);
> +       if (err)
> +               return dev_err_probe(dev, err,
> +                                    "cannot disable set0 interrupts\n");
> +
> +       err = regmap_write(msa311->regs, MSA311_INT_SET_1_REG, 0);
> +       if (err)
> +               return dev_err_probe(dev, err,
> +                                    "cannot disable set1 interrupts\n");

Wondering if the above can be combined to bulk write.

...

> +       /* Unmap all INT1 interrupts by default */
> +       err = regmap_write(msa311->regs, MSA311_INT_MAP_0_REG, 0);
> +       if (err)
> +               return dev_err_probe(dev, err,
> +                                    "failed to unmap map0 interrupts\n");
> +
> +       err = regmap_write(msa311->regs, MSA311_INT_MAP_1_REG, 0);
> +       if (err)
> +               return dev_err_probe(dev, err,
> +                                    "failed to unmap map1 interrupts\n");

Ditto.

...

> +       /* Keep going without interrupts if no initialized I2C irq */

IRQ

...

> +                                    "cannot allocate newdata trigger\n");

In case you wish to make them shorter, you can use "can't".

...

> +                                    "can't register newdata trigger\n");

...esp. if you already do this in the other message, but not in all.
So, some consistency would be good to have.

...

I avoided commenting on the points that were not addressed and you
explained why.

-- 
With Best Regards,
Andy Shevchenko
