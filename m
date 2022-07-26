Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8575581309
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbiGZMS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiGZMSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:18:25 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D142E13F9E;
        Tue, 26 Jul 2022 05:18:22 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i13so8372689edj.11;
        Tue, 26 Jul 2022 05:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uFNBuksRAUHG8SQKGfIMoqHF0ZeQIQql/Pes//0/1FE=;
        b=p25ViQRAGjIzoqbyw32XacT85JsM0ATOnc/aJ7f4OQUM+aio/Y993fmTKcDeocHCd9
         Ip6z+1IDcK1emNmby8GCnHh8nTAZJOit+jilIBMN3MN8BHArbq5Y7jX0AdPoo5PJRGP+
         qBAvo4C0uBT25Q/8kqgwUa9AThgrYs6OVHHMaOpyea8oHPpg79QNvmgM1Uz/oDBPwnAl
         AufVZdMZG9DZBf3rhJ84O3aYj5LM94YzLZW6y/dSBdJHdO6Du6+eIPe3NFTEc8T9fHX5
         OTqmGMZhfJaXrcwzJtTP8MEOT5b0nUwAv/+Z19lTei3pSAbzl6AU10dk5npcBMsgvF/p
         dQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uFNBuksRAUHG8SQKGfIMoqHF0ZeQIQql/Pes//0/1FE=;
        b=cNPpWFqrhdUYHBqsgEaKSBbbCWj+L+Ph7rG5Vg/7tJqlHs9dmJPxGmZAUZLAI3R4Ik
         LQNHuKIA+fNSCbYisXlsazusZ18iTXASS+Xw0fUFivYKXPm3I5ESHF3u6pVcO+Dqs5DX
         EzKjBjWvyXHgqqHff8Kqt5vRgEv0s93RtydqdX4/F7wWDygs95G/ytCu2dTC8J8sREI0
         iWWz1brG+cEbncvzjLJ1Ep5lEVqRdHDDLlgqgiJdRBgxqSO9cB9XmoLOCPCc6NOFIjsJ
         eRBoOct2RcXQE9Rlb6hZQQt6x03vQpSpYdZWNXIw8wc49M3/zyIGiYbhFsGwcmWK84Ku
         GnEQ==
X-Gm-Message-State: AJIora9udDXmKi0XUWumhr7oTYzH83T+bzAVHWjLznKPMo+0lGED8+7i
        KnuVjbACRyRoSw2A6Eg3XQwXUwwa4f0Au59k6rY=
X-Google-Smtp-Source: AGRyM1uzT38suKCsbCmFfyzBHLwwuulTdOWUnr3cD4+NYEDfZRxNjDpqwVCvJTRb6rCtiz3um/F+ZSKguXrhc6flE20=
X-Received: by 2002:a05:6402:50c9:b0:43c:163a:4d5f with SMTP id
 h9-20020a05640250c900b0043c163a4d5fmr7812854edb.386.1658837901255; Tue, 26
 Jul 2022 05:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220722102407.2205-1-peterwu.pub@gmail.com> <20220722102407.2205-12-peterwu.pub@gmail.com>
 <CAHp75VewxvEDGoPdRBvLSLQOQ6OZzVft1ce3DkF7MK_O1VXZkQ@mail.gmail.com> <CABtFH5+im7=vyKLUqztYeAX81e7ETFc+9o7y0seg2pxH0PEnUQ@mail.gmail.com>
In-Reply-To: <CABtFH5+im7=vyKLUqztYeAX81e7ETFc+9o7y0seg2pxH0PEnUQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Jul 2022 14:17:44 +0200
Message-ID: <CAHp75Vd4ApTju2LCCHQ1skgOjttwWo5b2NF3u+zbGyVnnFKNhA@mail.gmail.com>
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

On Tue, Jul 26, 2022 at 1:46 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
> On Mon, Jul 25, 2022 at 4:41 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:

...

> > > +struct mt6370_led {
> > > +       union {
> > > +               struct led_classdev isink;
> > > +               struct led_classdev_mc mc;
> > > +       };
> >
> > Where is the field that makes union work?
>
> Just for saving memory space.
> Because these led_classdevs do not be used at the same time.
> Or do you think it would be better to rewrite it as follows?
> -------------------------------------------------------------------------------------
> struct mt6370_led {
>        struct led_classdev isink;
>        struct led_classdev_mc mc;
>        struct mt6370_priv *priv;
>        u32 default_state;
>        u32 index;
> };
> -------------------------------------------------------------------------------------

You obviously didn't get what I'm talking about...
Each union to work properly should have an associated variable that
holds the information of which field of the union is in use. Do you
have such a variable? If not, how does your code know which one to
use? If yes, add a proper comment there.

-- 
With Best Regards,
Andy Shevchenko
