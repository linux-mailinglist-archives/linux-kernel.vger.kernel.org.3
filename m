Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B9E573603
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbiGMMIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236288AbiGMMH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:07:57 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA17104034;
        Wed, 13 Jul 2022 05:07:53 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id e69so18909626ybh.2;
        Wed, 13 Jul 2022 05:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H60c6BQz+0PUGxMp0vbXoiihGTO7ZBPYPm+08N4mLfI=;
        b=cFwaO0bDU4Rlt7N9UDqzRHYc/L/LXwPsecY5KlQfSKmfeHbUGfJju92GNvM+QXRy/A
         MfFCd9EiEFbUqGG0Dk3UDyeTjK2mKB+J26YUCLsjwjV1AqSW8ALXoZ+QUWDjp8FbHEeY
         dwnLTjlohJXN4MlqdlflbgJKO0LHlSOv3alwCbci2ARAUzjG69r4BZ9OGDCDuqQtQA7F
         3fzpmlRGWBNYqAxA0gsKxiBlo4ApaOY7UboYG9JKS2cowDCyOJujzJrS984DN9KyXzOA
         PlokWUEqgVaq6a1qwFa+85+pBBg3DMQ+qHXOl22B3dO6jAPN+bwQ7BsHm3cmgJ/HPnXL
         vfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H60c6BQz+0PUGxMp0vbXoiihGTO7ZBPYPm+08N4mLfI=;
        b=Fivb87gLnZouIU5+jpNhiWYCJYnKwvrl08ZulwjqKwexabykfs5NmueHwoe9axfZiM
         WwgJ0XbWWxnl9f2Dr7hMUigRxHvlDBAtXjev0pmWh38OHPFq3aPJmrOASOnk+FlzZm+2
         vRvb31GLWQxYLclInHmG5SXdolALn2TDcuE6TSswJfLi/gM9hWQhJ4cC4bFb1RYAfZnc
         QpF/YFQitOwkM2PKC/EzIy89TucBS7SBD/zMYiB/kQ/GJLpOu+qNt8GkyLtCgfXFE9NI
         +Ke+iAQMSaOzLWoM245iH/95uA5lup89eI9NKsAjxy3F/xP4Hn5xDPlxk8SWKw39Aar5
         JuuQ==
X-Gm-Message-State: AJIora+CSYWjUY8C4JxXpsIHgbUraLYgkFMLHQ3Sckf5ZK4tS2EQ4WEl
        gUZbCPGR3ntZUUCQeVmB9KdqlYB2EZhuTxS094g=
X-Google-Smtp-Source: AGRyM1sbQCBjmYhKYL+xb2AwlOmpuB0R1EP+WnPrRn0L3M4TSuIwm0awKcRUCK7kwFw6PIL77qpLuzj23J+O5rqZCJA=
X-Received: by 2002:a25:858e:0:b0:66e:4898:63e2 with SMTP id
 x14-20020a25858e000000b0066e489863e2mr3559399ybk.296.1657714072552; Wed, 13
 Jul 2022 05:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220704053901.728-1-peterwu.pub@gmail.com> <20220704053901.728-14-peterwu.pub@gmail.com>
 <CAHp75VdwEc9AW1w8ejsxkw+sBTF1dumd99QyzTY9BZaXiViRWQ@mail.gmail.com> <CABtFH5K-2+2hbpvpq2nPE5AsznkQxZF2r3MVC64Q39DJhVuUtA@mail.gmail.com>
In-Reply-To: <CABtFH5K-2+2hbpvpq2nPE5AsznkQxZF2r3MVC64Q39DJhVuUtA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jul 2022 14:07:15 +0200
Message-ID: <CAHp75VevDwdAKLYEWJgnMDvzuPuFibLuVqH-GKazEOT76wM6_A@mail.gmail.com>
Subject: Re: [PATCH v4 13/13] video: backlight: mt6370: Add Mediatek MT6370 support
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 12:53 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=
=9C=885=E6=97=A5 =E9=80=B1=E4=BA=8C =E6=B8=85=E6=99=A85:14=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > On Mon, Jul 4, 2022 at 7:43 AM ChiaEn Wu <peterwu.pub@gmail.com> wrote:

Please, remove unneeded context when replying!

...

> > > +               brightness_val[0] =3D (brightness - 1) & MT6370_BL_DI=
M2_MASK;
> > > +               brightness_val[1] =3D (brightness - 1)
> > > +                                   >> fls(MT6370_BL_DIM2_MASK);
> >
> > Bad indentation. One line?
>
> Well... if indent to one line, it will be over 80 characters(or called co=
lumns?)
> From my understanding, it is not allowed, right??

It's allowed to some extent.Use your common sense.
Here it's obviously broken indentation.

...

> > > +               prop_val =3D (ilog2(roundup_pow_of_two(prop_val)) + 1=
) >> 1;
> >
> > Isn't something closer to get_order() or fls()?
>
> I will revise it to "(get_order(prop_va * PAGE_SIZE) + 1) / 2" and
> this change is meet your expectations??

Nope. Try again. What about fls()?

...

> > > +       props->max_brightness =3D min_t(u32, brightness,
> > > +                                     MT6370_BL_MAX_BRIGHTNESS);
> >
> > One line?
>
>  Ditto, it will be over 80 characters...

As per above.

--=20
With Best Regards,
Andy Shevchenko
