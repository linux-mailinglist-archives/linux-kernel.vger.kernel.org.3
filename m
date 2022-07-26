Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95FF580AF8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 08:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiGZGLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 02:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiGZGLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 02:11:36 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7C41EEEE;
        Mon, 25 Jul 2022 23:11:33 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e15so16529228edj.2;
        Mon, 25 Jul 2022 23:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5iTBFaujydfzjNtZ+tuEW42yh94kmq7eTQthHnu+Umc=;
        b=DFreK31JfLkd3fAd0uB7CR6gjxpG6yBsGmnlSdQdVK9K9Iop3MmbjSc5l5Mqska/9F
         6zDsLVWtd4iSJbART2yOrMPnU6eocnuJbVN14OsRvUxL4fHsO7Wrgfc2UhIcTUjufoph
         2DxioqWBkat/Lt1MPd86qgmI4fJ9X5pOYvgIQ3L8XLGI4V6pl/+7xrFDCD36BkcmbO3v
         msDZGsDArMOOY56AIoIP2Boyoi0IybH+bd3McBS1U0EmQcx61Apt04nGaujtweQDBRAO
         5Sbq2NspvHrUHv6ggNUA5i+nF0w1W6dwyWvXZUzuukyS0Uo/f8jv4B+Fz7jfoW/fM0P7
         F9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5iTBFaujydfzjNtZ+tuEW42yh94kmq7eTQthHnu+Umc=;
        b=BlAlzcA1MUrg7S4dIEucIEGjRfOoqen2XN9v1xrd8WPiwPJelPEvZOR53CSMHOw0bS
         LGPA/U59ua6BMhoSECfgEy8/EGGiWBNZTPZx6e5vieTMcci3UmYoHtJ1RCf55sWLhBx+
         rXgNbESeMDWnbdMW+CswYe9gyP+/J7gOdHu2Mg8EI0UOZkeHbMqJhCJnGbcHfXsxNk5g
         Idy7Qx+FB8B7qOCVeygWdcE0P63QFG01kWmbdxxKyy5YvBsNwpzBUaEY2Opgbe/i2UiH
         VaZHwzNV2u8wg9zeFKb+oFo6zT5agqi/2ygo5Gb/TgS7wX3D20qqI+/5/i6qMDEX9mL2
         /CMQ==
X-Gm-Message-State: AJIora9zbTMUbMaiUEu6d/Zud6rLXqVauQLyybsfYT/7geaGZBcHnKy9
        UOgRBdN6J1k/CawajG6tSRJH2fjrEtTKswoBluYXHfMBpj7Lyw==
X-Google-Smtp-Source: AGRyM1sDJR+2SWBXIadraV+/yk5L7Vs9denzeP6s+Yyxwc5C8W1vNP4hRGI/bOS7pUxW1lVGaWNV5mppOqxOjOJF8tE=
X-Received: by 2002:a05:6402:d05:b0:435:b2a6:94eb with SMTP id
 eb5-20020a0564020d0500b00435b2a694ebmr16409469edb.87.1658815891980; Mon, 25
 Jul 2022 23:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220722102407.2205-1-peterwu.pub@gmail.com> <20220722102407.2205-13-peterwu.pub@gmail.com>
 <CAHp75VfgiK87VwWu2bTJ_mR0=g0sa0LPJ+H16OGcUdARmzFRSA@mail.gmail.com> <CA+hk2fYpDRw+DRRU3m=EDOP6UEQNpJLyNBHe8Zi0qOfUObTb4Q@mail.gmail.com>
In-Reply-To: <CA+hk2fYpDRw+DRRU3m=EDOP6UEQNpJLyNBHe8Zi0qOfUObTb4Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Jul 2022 08:10:55 +0200
Message-ID: <CAHp75VdxWfo0QW=SXc0v+Ue92VO1TbpTqAqHT6mAK=GA606oFg@mail.gmail.com>
Subject: Re: [PATCH v6 12/13] leds: flash: mt6370: Add MediaTek MT6370
 flashlight support
To:     szuni chen <szunichen@gmail.com>
Cc:     ChiaEn Wu <peterwu.pub@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
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
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>
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

On Tue, Jul 26, 2022 at 6:15 AM szuni chen <szunichen@gmail.com> wrote:

...

> > > +#define MT6370_ITORCH_MIN_UA           25000
> > > +#define MT6370_ITORCH_STEP_UA          12500
> > > +#define MT6370_ITORCH_MAX_UA           400000
> > > +#define MT6370_ITORCH_DOUBLE_MAX_UA    800000
> > > +#define MT6370_ISTRB_MIN_UA            50000
> > > +#define MT6370_ISTRB_STEP_UA           12500
> > > +#define MT6370_ISTRB_MAX_UA            1500000
> > > +#define MT6370_ISTRB_DOUBLE_MAX_UA     3000000
> >
> > Perhaps _uA would be better and consistent across your series
> > regarding current units.
>
> Yes, _uA will be more consistent, but in general, using upper case in
> the define macro is a convention, doesn't it?

There is general convention, but there are also:
1) common sense;
2) usage in practice (e.g. _US, etc for *seconds and _HZ for *frequency).

My common sense tells me that it is convenient to use mA,uA, etc.
Plus "in practice" it's related to use as in your series and elsewhere.

But of course it's minor to me, decide yourself.

...

> > > +       /*
> > > +        * For the flash to turn on/off, need to wait for HW ramping up/down time
> >
> > we need
> >
> > > +        * 5ms/500us to prevent the unexpected problem.
> > > +        */
> > > +       if (!prev && curr)
> > > +               usleep_range(5000, 6000);
> > > +       else if (prev && !curr)
> > > +               udelay(500);
> >
> > This still remains unanswered, why in the first place we allow
> > switching, and a busy loop in the other place?
>
> If I refine the description to
> "For the flash to turn on/off, need to wait for 5ms/500us analog settling time.
> If any flash led is already used, then the analog is settled done, we
> don't need to wait again."
> is it answer the question?

No. I'm talking from the Linux APIs perspective. There is a huge
difference between those branches. Please, conduct research, read
documentation to understand what my question is about.

-- 
With Best Regards,
Andy Shevchenko
