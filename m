Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEC7582141
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiG0Hhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiG0Hhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:37:37 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27D63B950;
        Wed, 27 Jul 2022 00:37:36 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id y9so12106192qtv.5;
        Wed, 27 Jul 2022 00:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7wBtopi5nrrnF3/tK6d3mUXKRzW2T+DIHWRi/Z/g55U=;
        b=JrXv07SnypKXIiO9c1hDaO1ve2XFoCQh3YJA9N0xzJ8VKdcy+NOWbVByEfE93yA1bT
         Tl79vU21bY1Riyh5vdmQjiXNRM6Y+lisVzjlFGA12N5TkfsJVvBTZVM+DXhLMCRLgtAT
         CWazI0B5gaYgTPfT/LBhBjVu7eM5hrdl/RUhg4FDmsUWR19oAbFy6HoE9edFHPyenD8T
         Qf2WPKI/e5SPnIeUMPrpopEK3VVMRKkcz81I6LE01vsC+va5BFGobzRlWIltgg+x4gCQ
         EHVJv70L2zauSaiZEF5yiD6RME26xNIBHXc93G+wfeZxZyIdgW4ZKl6QFkorqrFDfTKD
         6LhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7wBtopi5nrrnF3/tK6d3mUXKRzW2T+DIHWRi/Z/g55U=;
        b=6Jat2MyN2X/bCcy4KChsFEgToktjw+TM2nIp1GsWV6ZzmD6Rvuyrj1WVCZLEay7Yy8
         q74Yij3pzdIaz/b3Dx1814Y7F7SZ4G/HV33u1NUwo1HFCib9KKUGzmTEDTFzeUjfU0Bs
         QX31Xn8Ix8XeXydaf8AcdSF3TvwfwPs2BaLCmimOEG8poqkdfChiJgGU3sbSMzaEOAPp
         tjrZy4no79UXKPkp/eBai9E81Hw5Bzcf2HNvuOYOYl0cPXcPSChnTM9IDK5Jn7McZXoP
         xHO/bCA9YNSGqGzehOVJ5hVsFJnBC1xruUQWUOhNGDVuRflhxLBmPlRaFHVf97VUhQHe
         GsuA==
X-Gm-Message-State: AJIora+ycXd0R3vO91GJKaKDVU9HJPaB0TnRR6u89peGwkCT5WgXMS1m
        XRVpcxeT3Rf2n10XEOj8napxn7O9AWFngkOo0UeP0b2UjH0=
X-Google-Smtp-Source: AGRyM1sXpKQZrYG0IbOgoxNKanSErlzr5LcY9lrHn4FGhRFmisG96yuJDLZQZGtegCOB6F8ydUZqqM5XWqwFIZtxfFQ=
X-Received: by 2002:a05:622a:6098:b0:2f0:f0d2:b5f0 with SMTP id
 hf24-20020a05622a609800b002f0f0d2b5f0mr17361865qtb.583.1658907456035; Wed, 27
 Jul 2022 00:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220722102407.2205-1-peterwu.pub@gmail.com> <20220722102407.2205-12-peterwu.pub@gmail.com>
 <CAHp75VewxvEDGoPdRBvLSLQOQ6OZzVft1ce3DkF7MK_O1VXZkQ@mail.gmail.com>
 <CABtFH5+im7=vyKLUqztYeAX81e7ETFc+9o7y0seg2pxH0PEnUQ@mail.gmail.com> <CAHp75Vd4ApTju2LCCHQ1skgOjttwWo5b2NF3u+zbGyVnnFKNhA@mail.gmail.com>
In-Reply-To: <CAHp75Vd4ApTju2LCCHQ1skgOjttwWo5b2NF3u+zbGyVnnFKNhA@mail.gmail.com>
From:   ChiaEn Wu <peterwu.pub@gmail.com>
Date:   Wed, 27 Jul 2022 15:36:59 +0800
Message-ID: <CABtFH5+bQx5ym5jOzCPJWbZ23WtGYYwS7cMRt2g3ipEEqTb3JA@mail.gmail.com>
Subject: Re: [PATCH v6 11/13] leds: rgb: mt6370: Add MediaTek MT6370 current
 sink type LED Indicator support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Tue, Jul 26, 2022 at 8:18 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

...

> > Just for saving memory space.
> > Because these led_classdevs do not be used at the same time.
> > Or do you think it would be better to rewrite it as follows?
> > -------------------------------------------------------------------------------------
> > struct mt6370_led {
> >        struct led_classdev isink;
> >        struct led_classdev_mc mc;
> >        struct mt6370_priv *priv;
> >        u32 default_state;
> >        u32 index;
> > };
> > -------------------------------------------------------------------------------------
>
> You obviously didn't get what I'm talking about...
> Each union to work properly should have an associated variable that
> holds the information of which field of the union is in use. Do you
> have such a variable? If not, how does your code know which one to
> use? If yes, add a proper comment there.
>

Ummm... from my understanding,
if the colors of these four LEDs are set to 'LED_COLOR_ID_RGB' or
'LED_COLOR_ID_MULTI' in DT,
their 'led->index' will be set to 'MT6370_VIRTUAL_MULTICOLOR' in
'mt6370_leds_probe()'.
If so, these led devices will be set as 'struct led_classdev_mc' and
use related ops functions in 'mt6370_init_led_properties()'.
Instead, they whose 'led->index' is not 'MT6370_VIRTUAL_MULTICOLOR'
will be set as 'struct led_classdev'.
So, maybe the member 'index' of the 'struct mt6370_led' is what you
describe the information of which field of the union is in use?
I will add the proper comment here to describe this thing. I'm so
sorry for misunderstanding your mean last time.
Thanks again for your review.

-- 
Best Regards,
ChiaEn Wu
