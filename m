Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C499586567
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 08:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbiHAGsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 02:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbiHAGsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 02:48:22 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F96A13F49;
        Sun, 31 Jul 2022 23:48:13 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id o1so7734990qkg.9;
        Sun, 31 Jul 2022 23:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0pCQwRUtQqbmZSwhlAYKv7D+OaWBuV6jzuOG3pLiqnE=;
        b=ln2eP881w+pJWsnC+kYg6rYGAd3maj9S7mJ+gV/lLUoTHa07yJ7pdTT1iddtkvut7G
         wCE3Vn0TT0sSu2CGZvq/wm0E+8dX8DAzc0wcrTU8f68Bf945HKsgWEqdxw/iLewJID2+
         U3xISuK9fbiy0BRYeJ5aJIV0S+Q+NI5ty1LBv5VOtK4++uo7wdiHC9lGtmGhCbrpNouT
         poWweP7l/AaVWeIy/2bVG85dC0G/EueHZA6lUebLElpHSoCxf4b25lXpFCUPSvI2lhdW
         7jc02DOr4iyObq+BZvCMVIS2hbqCqgw3xx0epY1nfMPIBNYZpFTwGEBUDoh2MKMua6y2
         T4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pCQwRUtQqbmZSwhlAYKv7D+OaWBuV6jzuOG3pLiqnE=;
        b=Y97cQMDQsqGK7AYWLfOKdA8pvvi9aEfceRVlMf3wL/m6lPqs47koW/+OhY9eyN1wkg
         pK0cDrMXcIjTVa0EyQHvpuPLThUewNvCcuBk8viNdK4geO0JfT8x4FlZzB9ijjvsafqL
         KGZz8LoxAzCVh4uFSLaGXCpBwaP9mVp1/VDGlXRyxduwr86NbL2cfvnGeSwXnQ1OZiNa
         HxWPTomC4xKawKmjBpHtdNs1+5OKJir14AtnUFQTOiA7Q+mM7Kfb/oymAm4JETnVZ/9Q
         RMw9vjpUaqQZ/AmqmQMHBTVIpccUTDMeLAFEpq1PPbX1LDJTcD1ghg4EnpiBZVuPmAsA
         hzXw==
X-Gm-Message-State: AJIora8FopjwlP1rSx/ZiX8GU9Ml6sQ5dwYKhNl+ABKNwpljS/SabVTB
        3yFUopDMAgRVTFtAi/wOQsmnzKvv9Rzze5tpm3k=
X-Google-Smtp-Source: AGRyM1vi8vD3grhYbZ/WLviZ2IFccZbjNO75ItldTtC+nPOI6OOaG7LKKV2FJNQbFGfWSid26gTwustg4ausWvfIn5M=
X-Received: by 2002:a05:620a:1706:b0:6b8:705a:c61e with SMTP id
 az6-20020a05620a170600b006b8705ac61emr8915998qkb.129.1659336492750; Sun, 31
 Jul 2022 23:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220722102407.2205-1-peterwu.pub@gmail.com> <20220722102407.2205-6-peterwu.pub@gmail.com>
In-Reply-To: <20220722102407.2205-6-peterwu.pub@gmail.com>
From:   ChiaEn Wu <peterwu.pub@gmail.com>
Date:   Mon, 1 Aug 2022 14:47:36 +0800
Message-ID: <CABtFH5L83d5Di6O9TC-L3UX2ma5J3PE47ihfJFfPD5YGJ43NxQ@mail.gmail.com>
Subject: Re: [PATCH v6 05/13] dt-bindings: backlight: Add MediaTek MT6370 backlight
To:     Lee Jones <lee.jones@linaro.org>,
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
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
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
        szuni chen <szunichen@gmail.com>, Rob Herring <robh@kernel.org>
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

On Fri, Jul 22, 2022 at 6:24 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

[snip]

> +  compatible:
> +    const: mediatek,mt6370-backlight
> +
> +  default-brightness:
> +    minimum: 0
> +    maximum: 2048
> +
> +  max-brightness:
> +    minimum: 0
> +    maximum: 2048
> +

Hi Rob, Krzysztof,

First, I'm so sorry for our SoB writing wrong, I'll fix it in the next patch.
Because of this mail thread
(https://lore.kernel.org/all/20220728113109.7gf3b36mqjxlhcq3@maple.lan/),
I would like to discuss with you that I may change the following in
this DT document, I am not sure whether you agree or not.

1. Add some descriptions about MT6372, which supports 16384 steps (14
bits) and is different from MT6370/MT6371 (2048 steps, 11 bits)
2. Modify the format of 'compatible' as follows to distinguish between
MT6370/MT6371 or MT6372
------------------------------------------
properties:
  compatible:
    enum:
      - mediatek,mt6370-backlight
      - mediatek,mt6372-backlight
------------------------------------------

3. Remove the 'maximum' value of 'default-brightness' and
'max-brightness', and add "if-else" to determine the "maximum" value
as follows
------------------------------------------
  default-brightness:
    minimum: 0

  max-brightness:
    minimum: 0

...

if:
  properties:
    compatible:
      contains:
        const: mediatek,mt6372-backlight

then:
  properties:
    default-brightness:
      maximum: 16384

    max-brightness:
      maximum: 16384

else:
  properties:
    default-brightness:
      maximum: 2048

    max-brightness:
      maximum: 2048
------------------------------------------

4. Add a new boolean property to allow the user to determine whether
to enable the exponential mode of backlight brightness or not. Like
this,
------------------------------------------
  mediatek,bled-exponential-mode-enable:
    description: |
      Enable the exponential mode of backlight brightness. If this property
      is not enabled, the default is to use linear mode.
    type: boolean
------------------------------------------

I hope these changes I have added will meet your expectations.
And I'm not sure if I should remove 'Reviewed-By' first until it
passes your review.
Thanks.

-- 
Best Regards,
ChiaEn Wu
