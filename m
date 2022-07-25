Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A441157FBBB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiGYIvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbiGYIvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:51:47 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EA6140C4;
        Mon, 25 Jul 2022 01:51:44 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l23so19329568ejr.5;
        Mon, 25 Jul 2022 01:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sRH3Ko4u3nUzP+XsjQZDkgCAeoY72VHZaoe9ljYtNKk=;
        b=b1ttEgokmKJ5jDFSHg4C3qui+lCgzhMb1cFI+vnFX9/Qaqz5wXWkN7XbXTCmQ3rbX8
         /3TN1NF7tN2a41ftKlXShOS7XLz6vjt/dE/JoVvRFVa7TBsRv37MEJRyEWP7V4gtObN8
         DWOlJaAA+IaENb1E9U2bsj5iMsc5NaHbap/4bNNdkO+vyaoG6bExWIwrQG9s7uFg7Baj
         s+FY3gPXBy8r3qaYg0AV960MNBWHc4g/ppm+fVbr7FGTau4bS6hbfDOGbOOSslhkiqHB
         4edKEq3lX1FHBOVPE941JMEmpBIHu6i/Z5b0c8XziqmaTyViSW8bxZxzR+/rVIJcM7jV
         un+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sRH3Ko4u3nUzP+XsjQZDkgCAeoY72VHZaoe9ljYtNKk=;
        b=W8jUwZGhehqGXf2omf/rXy1s93Pmb6J8SzTXfCNpY4DNQVAr4N7/dxmWhNrNt4jwdR
         xPMpS3zle8XoODg+lVdPaJglcRWLR+ced9JjGz2xfnKwjY+C+wWpEJwTXFvFLq64kUH0
         A4tFXi0uiV/JPAAieFbal1RipjM7a5/n+xMHSgqsh93VL40N/WjBZvfqfV9FRGJ89DX8
         6NE4PFg2kxn8hVp5a5QDvvDM13/cyiLpCkga1Ej2vdPTwnYYDRQj244cAXKmRMjSRBAJ
         hHtB58nAqbyxmyKffuYumE7MgzwZBUuPbj9u3YfKmGOvXNm59ouPyo0fjWIEgqjAWOxw
         oTVg==
X-Gm-Message-State: AJIora+yz8UfFvOLxWhTVECYfKpJXUWAbm01y+ne/QMRetXDH0qdZcp2
        iW2x70TFKMnYViWcAH7tPewuFhWaiPBCMrYTwO4=
X-Google-Smtp-Source: AGRyM1t++SIdSmibdfYzJgTAAGzjzRMgfSGJttBagInbaOHb+Jia4m43oDM7a3cRNSWK7OUMOrpRHLsW33nuUHySItE=
X-Received: by 2002:a17:907:1c8d:b0:6f2:eb2:1cd6 with SMTP id
 nb13-20020a1709071c8d00b006f20eb21cd6mr9106852ejc.568.1658739102757; Mon, 25
 Jul 2022 01:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220722102407.2205-1-peterwu.pub@gmail.com> <20220722102407.2205-13-peterwu.pub@gmail.com>
In-Reply-To: <20220722102407.2205-13-peterwu.pub@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 10:51:06 +0200
Message-ID: <CAHp75Vf85_uzA9fRxTizbPJxODcXFpM4wuU6DxP2j9UA47B_2g@mail.gmail.com>
Subject: Re: [PATCH v6 12/13] leds: flash: mt6370: Add MediaTek MT6370
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

On Fri, Jul 22, 2022 at 12:25 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
>
> From: Alice Chen <alice_chen@richtek.com>
>
> The MediaTek MT6370 is a highly-integrated smart power management IC,
> which includes a single cell Li-Ion/Li-Polymer switching battery
> charger, a USB Type-C & Power Delivery (PD) controller, dual Flash
> LED current sources, a RGB LED driver, a backlight WLED driver,
> a display bias driver and a general LDO for portable devices.
>
> The Flash LED in MT6370 has 2 channels and support torch/strobe mode.
> Add the support of MT6370 FLASH LED.
>
> Signed-off-by: Alice Chen <alice_chen@richtek.com>

This SoB chain is wrong. Prioritize and read Submitting Patches!

...

> +static int mt6370_torch_brightness_set(struct led_classdev *lcdev,
> +                                      enum led_brightness level)
> +{
> +       struct mt6370_led *led = to_mt6370_led(lcdev, flash.led_cdev);
> +       struct mt6370_priv *priv = led->priv;
> +       u32 led_enable_mask = (led->led_no == MT6370_LED_JOINT) ?
> +                             MT6370_FLCSEN_MASK_ALL :
> +                             MT6370_FLCSEN_MASK(led->led_no);
> +       u32 enable_mask = MT6370_TORCHEN_MASK | led_enable_mask;
> +       u32 val = level ? led_enable_mask : 0;

> +       u32 prev = priv->fled_torch_used, curr;

Here and in the other functions with similar variables it seems you
never use prev after assigning curr.
Just define a single variable and use it accordingly.

> +       int ret, i;
> +
> +       mutex_lock(&priv->lock);
> +
> +       /*
> +        * Only one set of flash control logic,
> +        * use the flag to avoid strobe is currently used.
> +        */
> +       if (priv->fled_strobe_used) {
> +               dev_warn(lcdev->dev, "Please disable strobe first [%d]\n",
> +                        priv->fled_strobe_used);
> +               ret = -EBUSY;
> +               goto unlock;
> +       }
> +
> +       if (level)
> +               curr = prev | BIT(led->led_no);
> +       else
> +               curr = prev & ~BIT(led->led_no);
> +
> +       if (curr)
> +               val |= MT6370_TORCHEN_MASK;
> +
> +       if (level) {
> +               level -= 1;
> +               if (led->led_no == MT6370_LED_JOINT) {
> +                       int flevel[MT6370_MAX_LEDS];
> +
> +                       flevel[0] = level / 2;
> +                       flevel[1] = level - flevel[0];
> +                       for (i = 0; i < MT6370_MAX_LEDS; i++) {
> +                               ret = regmap_update_bits(priv->regmap,
> +                                               MT6370_REG_FLEDITOR(i),
> +                                               MT6370_ITORCH_MASK, flevel[i]);
> +                               if (ret)
> +                                       goto unlock;
> +                       }
> +               } else {
> +                       ret = regmap_update_bits(priv->regmap,
> +                                       MT6370_REG_FLEDITOR(led->led_no),
> +                                       MT6370_ITORCH_MASK, level);
> +                       if (ret)
> +                               goto unlock;
> +               }
> +       }
> +
> +       ret = regmap_update_bits(priv->regmap, MT6370_REG_FLEDEN,
> +                                enable_mask, val);
> +       if (ret)
> +               goto unlock;
> +
> +       priv->fled_torch_used = curr;
> +
> +unlock:
> +       mutex_unlock(&priv->lock);
> +       return ret;
> +}

...

> +       struct v4l2_flash_config v4l2_config = {0};

0 is not needed.

-- 
With Best Regards,
Andy Shevchenko
