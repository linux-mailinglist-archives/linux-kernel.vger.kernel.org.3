Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9474B5823C3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiG0KEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiG0KEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:04:38 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8503D1707A;
        Wed, 27 Jul 2022 03:04:37 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id s9so1513421edd.8;
        Wed, 27 Jul 2022 03:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+itH6nCjnZkG3yJTUkgH3T3RkzlJIEijujwFkNTeHs=;
        b=cG/IRfZwWO83wiK8SoAZgFegp/oSsSTdk6uMQXsyEzBbyDQ15vq0yzVYGG9pEdfz0Z
         ZOOouCQXEYxdPO6EleD7jGQocetQsqrcx2C7y57nBleaH3XWNh/p9EZXeeMxomYeea0n
         ccGpQbPM3KyJhbgX8FqfpXge+UD+lyXVuyBlv7AUvzyTYioFKkLUVdtqpGd8x6O73yOd
         o3BHcOkkAf6zj76YWhjS7ePObKwBxNP5KslRU9Zg6sRbYapoWTeSb3rLO4m4qR/dd5mY
         Xo/AD9faus7q33rPJGp/5b3BvXu4+tVOAzawSfBgIW64yo4mi098uiZmqwCRYHPukGG4
         n1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+itH6nCjnZkG3yJTUkgH3T3RkzlJIEijujwFkNTeHs=;
        b=WZvdnm+5h1mw7E7184OppTLgdI+dpROLmMCyx5DBGjK/s80lN7hvcVQI+oj4ijVu/Q
         U4dDqaslZPcIQSTZTNBqHNyt7PlVm51pJDfIFXczr6RwYbT0QHOvS04HopHySpRF5UCq
         9c8dP2KT5jWGqgSq9Q9C04l4sp7OzPGptXAsbRD04zI/TV//5afpOaB1k+CRyfw/pUre
         bC1L8TGz5SzKC7rm7Fga6ocYtemAPWsqUcgc62QBKsh0cJVAuTnYlWsXWvnbysMBOi/L
         6fwPu65OLjoeDnX9yCYsccd5hQMQ4zmMiR/jV9lHcNxucQblpkj6aAxQh0RHmBtdb7Dr
         VzbA==
X-Gm-Message-State: AJIora8gA4iaqKaVRMNGG8fVnCyEJHFxIQO4B38XkaQtAB3q4kbM+SkH
        l5KStbo1QYRQPa3HInvHJTaz5Z1pCP6Cg2eppd0=
X-Google-Smtp-Source: AGRyM1uwEejs5nDWqG+s979XFdwYwQmE2ZsEpW0n4nQQ7TCJsCqlYSNktlo34cJclnigei8K3rZk9qCXUcGHByv5Ilw=
X-Received: by 2002:a05:6402:501d:b0:437:e000:a898 with SMTP id
 p29-20020a056402501d00b00437e000a898mr22474219eda.265.1658916275876; Wed, 27
 Jul 2022 03:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220722102407.2205-1-peterwu.pub@gmail.com> <20220722102407.2205-12-peterwu.pub@gmail.com>
 <CAHp75VewxvEDGoPdRBvLSLQOQ6OZzVft1ce3DkF7MK_O1VXZkQ@mail.gmail.com>
 <CABtFH5+im7=vyKLUqztYeAX81e7ETFc+9o7y0seg2pxH0PEnUQ@mail.gmail.com>
 <CAHp75Vd4ApTju2LCCHQ1skgOjttwWo5b2NF3u+zbGyVnnFKNhA@mail.gmail.com> <CABtFH5+bQx5ym5jOzCPJWbZ23WtGYYwS7cMRt2g3ipEEqTb3JA@mail.gmail.com>
In-Reply-To: <CABtFH5+bQx5ym5jOzCPJWbZ23WtGYYwS7cMRt2g3ipEEqTb3JA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Jul 2022 12:03:59 +0200
Message-ID: <CAHp75Vf7jeG_DmD3sZnerFDEVpMxDiL9DkMBddAk-kJH7Hfttg@mail.gmail.com>
Subject: Re: [PATCH v6 11/13] leds: rgb: mt6370: Add MediaTek MT6370 current
 sink type LED Indicator support
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

On Wed, Jul 27, 2022 at 9:37 AM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
> On Tue, Jul 26, 2022 at 8:18 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>
> ...
>
> > > Just for saving memory space.
> > > Because these led_classdevs do not be used at the same time.
> > > Or do you think it would be better to rewrite it as follows?
> > > -------------------------------------------------------------------------------------
> > > struct mt6370_led {
> > >        struct led_classdev isink;
> > >        struct led_classdev_mc mc;
> > >        struct mt6370_priv *priv;
> > >        u32 default_state;
> > >        u32 index;
> > > };
> > > -------------------------------------------------------------------------------------
> >
> > You obviously didn't get what I'm talking about...
> > Each union to work properly should have an associated variable that
> > holds the information of which field of the union is in use. Do you
> > have such a variable? If not, how does your code know which one to
> > use? If yes, add a proper comment there.
> >
>
> Ummm... from my understanding,
> if the colors of these four LEDs are set to 'LED_COLOR_ID_RGB' or
> 'LED_COLOR_ID_MULTI' in DT,
> their 'led->index' will be set to 'MT6370_VIRTUAL_MULTICOLOR' in
> 'mt6370_leds_probe()'.
> If so, these led devices will be set as 'struct led_classdev_mc' and
> use related ops functions in 'mt6370_init_led_properties()'.
> Instead, they whose 'led->index' is not 'MT6370_VIRTUAL_MULTICOLOR'
> will be set as 'struct led_classdev'.
> So, maybe the member 'index' of the 'struct mt6370_led' is what you
> describe the information of which field of the union is in use?

From this description it sounds like it is.

> I will add the proper comment here to describe this thing. I'm so
> sorry for misunderstanding your mean last time.

Yes, please add a compressed version of what you said above to the code.

-- 
With Best Regards,
Andy Shevchenko
