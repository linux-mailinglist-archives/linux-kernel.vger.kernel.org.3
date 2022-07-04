Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E65565EC1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 23:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiGDVGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 17:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiGDVGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 17:06:00 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B38B5F65;
        Mon,  4 Jul 2022 14:06:00 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id c143so10096657ybf.3;
        Mon, 04 Jul 2022 14:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VjZ3yzk/koQQf8zjxBLs4QwpOzuOIkcuZx3e6uOiaGo=;
        b=XAO9XvLkJnavV0BlpGD+ClNY1uK6ZfLyjbo4n/ZLW8wmrgbwYg5bneBkPszuL0qItE
         XJI/Um1JbtICgrAWB2CbGTIQL3XiiI2CrvIzS3z6cX+0fWMEmTP/m05hoU/XeDh0JO+1
         eeHvwD6DxA036OjtJ1Awdqd8jOkI2onMTEJcqz2T5m6m+nRgsY0HzmkAIs+HuG9M0gvY
         OFUCInVfTCYeAF0Lc4c62oICHpgKN8SFXHnHvcx1YtkZYz9O+ZylSp/45sY17OaSjN0m
         IlghfWm5NOnrrvHQ0++R9QZOLHNJ+fo0gumeOMXqd+yZ0GZJC1bXUW/tMLgcUZq+m6/s
         0PeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VjZ3yzk/koQQf8zjxBLs4QwpOzuOIkcuZx3e6uOiaGo=;
        b=N5+0oGNFdCrouwn55H5TQZco0epv8j2DIDF6Ovs/qCofD3eWe1onXSExjQp/A1oeRC
         C7Upbw2zD1hWAZbWPRMb7zPje0TBWUNgGeer8WH2MhpSqOZTkKaa+oBmhKmjOYrk61g+
         CsnwHX9S9gXQ23p48L2G9D9llEDcdP4BJTyk29rtMAHSH1zCpqbISFnIx2hfI4bb6dlv
         IwO3x33/E3mKNN4MgFkumUY2/cwRjJJSokVnyLzv3aA+blZ7QfyKQ4Ip43xgGWg6YQKe
         DnCSsXlYVLhMB6I9sOBOnFYq64ZsSPZ5YZaKcxGPBRWB1ul6Kvln7Cs/z2GiiR5V+jLQ
         fGEA==
X-Gm-Message-State: AJIora96yadK5hcSo7t/jOmVAjPMfPNOE31fnYPMcQjJ1769rPH1KcbY
        Ud+55mWK0AUeKXG2Ia1VBYIUDl2LoQ8nRnMToBimEDhrVZoIog==
X-Google-Smtp-Source: AGRyM1sv4WckZUH06N23fcQXnL/x2rHJiYiT8ToR3cUqaWbGObXlg//Fkee64+CFjVKfldQI9mTw3vJ9ryFFyL1X6HM=
X-Received: by 2002:a5b:68a:0:b0:66e:472a:83f4 with SMTP id
 j10-20020a5b068a000000b0066e472a83f4mr8717309ybq.570.1656968759476; Mon, 04
 Jul 2022 14:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220704053901.728-1-peterwu.pub@gmail.com> <20220704053901.728-13-peterwu.pub@gmail.com>
In-Reply-To: <20220704053901.728-13-peterwu.pub@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Jul 2022 23:05:22 +0200
Message-ID: <CAHp75Vciq4M4kVrabNV9vTLLcd1vR=bMe8JLEdAF9MkRTpcB5g@mail.gmail.com>
Subject: Re: [PATCH v4 12/13] leds: flashlight: mt6370: Add Mediatek MT6370
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 4, 2022 at 7:43 AM ChiaEn Wu <peterwu.pub@gmail.com> wrote:

> Add Mediatek MT6370 flashlight support.

...

> +         This driver can also be built as a module. If so the module

If so,

> +         will be called "leds-mt6370-flash.ko".

No ".ko" part.

...

> +#define MT6370_ITORCH_MINUA            25000
> +#define MT6370_ITORCH_STEPUA           12500
> +#define MT6370_ITORCH_MAXUA            400000
> +#define MT6370_ITORCH_DOUBLE_MAXUA     800000
> +#define MT6370_ISTRB_MINUA             50000
> +#define MT6370_ISTRB_STEPUA            12500
> +#define MT6370_ISTRB_MAXUA             1500000
> +#define MT6370_ISTRB_DOUBLE_MAXUA      3000000
> +#define MT6370_STRBTO_MINUS            64000
> +#define MT6370_STRBTO_STEPUS           32000
> +#define MT6370_STRBTO_MAXUS            2432000

Make units suffix visible, i.e. _US, _uA, etc.

...

> +       if (curr)
> +               val |= MT6370_TORCHEN_MASK;
> +
> +

One blank line is enough.

...

> +       /*
> +        * Due to the current spike when turning on flash,
> +        * let brightness to be kept by framework.

brightness be
the framework

> +        * This empty function is used to
> +        * prevent led_classdev_flash register ops check failure.
> +        */

...

> +       } else {
> +               ret = regmap_update_bits(priv->regmap,
> +                                        MT6370_REG_FLEDISTRB(led->led_no),
> +                                        MT6370_ISTROBE_MASK, val);

> +               if (ret)
> +                       return ret;

Dup of the below.

> +       }
> +       return ret;

...

> +       /*
> +        * If the flash need to be on,
> +        * config the flash current ramping up to the setting value
> +        * Else, always recover back to the minimum one

Missed periods.

> +        */

...

> +       /*
> +        * For the flash turn on/off, HW ramping up/down time is 5ms/500us
> +        * respectively.
> +        */
> +       if (!prev && curr)
> +               usleep_range(5000, 6000);
> +       else if (prev && !curr)
> +               udelay(500);

Comment doesn't explain why this is suddenly a busy loop operation?


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

> +       } else
> +               val = clamp_align(val, MT6370_STRBTO_MINUS, MT6370_STRBTO_MAXUS,
> +                                 MT6370_STRBTO_STEPUS);

Missed {}

> +
> +

One blank line is enough.

-- 
With Best Regards,
Andy Shevchenko
