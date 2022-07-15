Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2094A57669B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 20:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiGOSOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 14:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGOSO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 14:14:29 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8786015FD9;
        Fri, 15 Jul 2022 11:14:27 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-31bf3656517so54333307b3.12;
        Fri, 15 Jul 2022 11:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wYQx40/iCC7JCsgHdkd0E1jOgqV54xGVWGfgqFpzTxo=;
        b=CCNqrZ6xxLNILlnpWQJZURCM7WccDYI4HArJBKyxVZQ4tUE7wHsb8C+1xQrCcy/ctP
         hgNxqF3L/l+JVN/sIioIK7hlY2E24EgjBaYcjObgBZ96Go1MFnvrauI9olx68o+tAec5
         0zqXIns8v8XdElhZwR+ilBWSFm2BAz09sy+iAz5QQOYZmnuuIUuyYZ7ilSKeAOMj7Dr0
         nmKdVBdXufKKDMVxiWrXIc+cIpZBo8ghQfSQgHJj69Av/M38jJkwWwu38WYhZktwk2Sr
         Ktcv4iMX1VtKF6apNGtKuW2hT3Gz86OVl/1giJmpSuReSlovrn8AP0YP6RZk9atjVy9y
         /pvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wYQx40/iCC7JCsgHdkd0E1jOgqV54xGVWGfgqFpzTxo=;
        b=F1Rb0F4hJTU3z+RjtUcnUk40dINLOEJWsSkUJXA19zkvWio+EVFRGGZI3TZN9Jsdor
         ikHvlAI8RfNLkl6B+9LXP2LwEHF5pr3aEg6bTqDJQL3dw25xiXFDcxENbovKZxZpP9Me
         xJQqt9rCvQXLMtdk7s2mByd4+g9tglCxLp26Z/evry+1ygE8upN5PDhuGlYo3Ilm+yV5
         ddRdRN9SNRTJxX6sefLpjqplGeirGYTyK2eVs6x+4XEUYSbyN+EwwtLuEORFiJPFD5jD
         WamwcsOyWXoUBf9l23BWRjFx67ikGRmfHHoVy0y4YK/24x32ZZJeLVRxytkeDPCwI9dX
         F07A==
X-Gm-Message-State: AJIora+cA9Ick5GK3oJPozXOmfTohLm1/p2y2Rch9m3FQCOwpJtKa7H9
        IXceeMgrt1X5ZX5XuFvKeZeE1MebIhmgsHZvXwjOCc4HxYo=
X-Google-Smtp-Source: AGRyM1uDhQ/IPsk1j9mwzTNaBs0PF9Af75W/5SyN9tcIUEjc7IVgAe4YsQYGo3tn1MHf1/3mBdT0R30hiBZKjAGSBRA=
X-Received: by 2002:a81:4bd7:0:b0:31c:91da:5a20 with SMTP id
 y206-20020a814bd7000000b0031c91da5a20mr18833575ywa.131.1657908866682; Fri, 15
 Jul 2022 11:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220715112607.591-1-peterwu.pub@gmail.com> <20220715112607.591-13-peterwu.pub@gmail.com>
In-Reply-To: <20220715112607.591-13-peterwu.pub@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 Jul 2022 20:13:49 +0200
Message-ID: <CAHp75Vc7wNkhG2dL=0vVZq5paDQy_8+WJ25Jk4E8SG2TW6EZdw@mail.gmail.com>
Subject: Re: [PATCH v5 12/13] leds: flashlight: mt6370: Add MediaTek MT6370
 flashlight support
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Helge Deller <deller@gmx.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        cy_huang <cy_huang@richtek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        szuni chen <szunichen@gmail.com>
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

On Fri, Jul 15, 2022 at 1:29 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote:

> The MediaTek MT6370 is a highly-integrated smart power management IC,
> whichincludes a single cell Li-Ion/Li-Polymer switching battery

which includes

> charger, a USB Type-C & Power Delivery (PD) controller, dual Flash
> LED current sources, a RGB LED driver, a backlight WLED driver,
> a display bias driver and a general LDO for portable devices.
>
> The Flash LED in MT6370 has 2 channel and support torch/strobe mode.

channels

> The commit add the support of MT6370 FLASH LED.

Add the

...

> +#define MT6370_FLCSEN_MASK_ALL         (BIT(0) | BIT(1))

GENMASK()

...

> +               for (i = 0; i < MT6370_MAX_LEDS; i++) {
> +                       ret = regmap_update_bits(priv->regmap,
> +                                               MT6370_REG_FLEDISTRB(i),
> +                                               MT6370_ISTROBE_MASK, flevel[i]);
> +                       if (ret)
> +                               return ret;
> +               }
> +       } else {

> +               ret = regmap_update_bits(priv->regmap,
> +                                        MT6370_REG_FLEDISTRB(led->led_no),
> +                                        MT6370_ISTROBE_MASK, val);
> +       }
> +       return ret;

    return regmap_update_bits(...);
  }

  return 0;

...

> +       /*
> +        * If the flash need to be on,

needs

> +        * config the flash current ramping up to the setting value.
> +        * Else, always recover back to the minimum one.
> +        */

...

> +       /* For the flash turn on/off, need to wait HW ramping up/down time

to turn

> +        * 5ms/500us to prevent the unexpected problem.
> +        */

Wrong multi-line comment style.

> +

No need for a blank line.

> +       if (!prev && curr)
> +               usleep_range(5000, 6000);
> +       else if (prev && !curr)
> +               udelay(500);

...

> +static int mt6370_led_register(struct device *parent, struct mt6370_led *led,
> +                               struct led_init_data *init_data)
> +{
> +       struct v4l2_flash_config v4l2_config = {0};
> +       int ret;
> +
> +       ret = devm_led_classdev_flash_register_ext(parent, &led->flash,
> +                                                  init_data);
> +       if (ret) {
> +               dev_err(parent, "Couldn't register flash %d\n", led->led_no);
> +               return ret;

return dev_err_probe() here and everywhere where it is about probe stage.

> +       }
> +
> +       mt6370_init_v4l2_flash_config(led, &v4l2_config);
> +       led->v4l2_flash = v4l2_flash_init(parent, init_data->fwnode,
> +                                         &led->flash, &v4l2_flash_ops,
> +                                         &v4l2_config);
> +       if (IS_ERR(led->v4l2_flash)) {
> +               dev_err(parent, "Failed to register %d v4l2 sd\n", led->led_no);
> +               return PTR_ERR(led->v4l2_flash);
> +       }
> +
> +       return 0;
> +}

...

> +       num = fwnode_property_count_u32(init_data->fwnode, "led-sources");
> +       if (num < 1 || num > MT6370_MAX_LEDS) {
> +               dev_err(priv->dev,
> +                       "Not specified or wrong number of led-sources\n");
> +               return -EINVAL;

Ditto.

> +       }

...

> +       ret = fwnode_property_read_u32(init_data->fwnode, "led-max-microamp",
> +                                      &val);

One line?

...

> +               val = clamp_align(val, MT6370_STRBTO_MIN_US, MT6370_STRBTO_MAX_US,
> +                                 MT6370_STRBTO_STEP_US);

I would name it mt6370_clamp() to avoid potential collision in the
global namespace in the future.

-- 
With Best Regards,
Andy Shevchenko
