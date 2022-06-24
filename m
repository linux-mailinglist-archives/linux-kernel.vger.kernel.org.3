Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD4E55971A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiFXJ5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiFXJ4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:56:55 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2C67A19C;
        Fri, 24 Jun 2022 02:56:52 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id k7so1144678ils.8;
        Fri, 24 Jun 2022 02:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M4nnsvgHgIi0r2ItWc5dFuhTU+zH2GcT6p/faSXA7jc=;
        b=HsRYekV2sU4Xv613pAvXWZuwPyAd8ueafTN7t5ELrygCaBWqwnSFn/yimTyvXphliU
         rk/k1nDNQ3ECBrZQCQibcC5/SXphAPug9oObZB9Femn+4ZMKO367Z07kbw302ugSier+
         3u6Ie+cqpVmNjf+nVQ2o9wUhernyrputNPwEkW+iFxQ7yrQw609omGwbvjVllqqdkQlb
         DFP5VJKZgPzIyttK1WQpTnymekzhmxmCFLdIDv+zhBnfs0Quw4/dsjyIWcL8P0Yv01Hh
         HffrHojwf2vBBMXK+Xv5kciDDgUaOI7o+FqSBYVUB7RtJd64wGJ3mx0TRrsc6+x3jNA+
         Uofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M4nnsvgHgIi0r2ItWc5dFuhTU+zH2GcT6p/faSXA7jc=;
        b=4QDiFNuyHmWZ9g7JG7KiFjNCuKE0VSg4BJHi+DiYOHzJt/uoBbIVM9hFGCnvbvdVCh
         mcCfzOV5cdTiu/nyBKtUk2rn94PXsuBaKcLIQvxlhOwa8Hjh2WfQnvioOUQUPd8jME1Q
         lSBQZ7qEKfFqlrwpl/i2htzpPw7KvnSXQ+UzkUr9hBCZbcxra8iyK5dEL7tk4Oafxrdh
         5AcBU2Z+Z+Pku+8dfcenyWlaZihS5FCZ6PiiR7fwrRe9TXgEstWY9EWd3rhQSiMeej47
         b52MeYyucdragJiPypszqtb9qtORrIjpPKodKaSYK5ID4iHSLRLXFded5trEyyOBqRkB
         /TFA==
X-Gm-Message-State: AJIora/6KcZfLeHvLltf6HoUjQX3vWt/X+htkbzI/g9LMK4U4CcukgVa
        QvgBC7wz3ztve1xxi0BbZs38WJPNpDB6FwM9wiQ=
X-Google-Smtp-Source: AGRyM1u4tHhqAdEi5ogAeS0dS5voh35vGz3kiJUl5ktCSsYPoM0YYC7H2ztWgE2w6YlrhoWKAwKgDMijTEOWiU+6IC8=
X-Received: by 2002:a05:6e02:10cf:b0:2d9:2310:e6b3 with SMTP id
 s15-20020a056e0210cf00b002d92310e6b3mr7601053ilj.212.1656064612053; Fri, 24
 Jun 2022 02:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220623115631.22209-1-peterwu.pub@gmail.com> <20220623115631.22209-15-peterwu.pub@gmail.com>
 <20220623134316.rg3adyobz3hkgflt@maple.lan>
In-Reply-To: <20220623134316.rg3adyobz3hkgflt@maple.lan>
From:   ChiaEn Wu <peterwu.pub@gmail.com>
Date:   Fri, 24 Jun 2022 17:56:41 +0800
Message-ID: <CABtFH5JnAAGh46i9yb1J6c2gAZfRHgTOhK19dOCdCuvdLW1ALg@mail.gmail.com>
Subject: Re: [PATCH v3 14/14] video: backlight: mt6370: Add Mediatek MT6370 support
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>, jingoohan1@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, Jonathan Cameron <jic23@kernel.org>,
        lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org,
        linux@roeck-us.net, heikki.krogerus@linux.intel.com, deller@gmx.de,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com
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

Hi Daniel,

Thanks for your comments!

Daniel Thompson <daniel.thompson@linaro.org> =E6=96=BC 2022=E5=B9=B46=E6=9C=
=8823=E6=97=A5 =E9=80=B1=E5=9B=9B =E6=99=9A=E4=B8=8A9:43=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Thu, Jun 23, 2022 at 07:56:31PM +0800, ChiaEn Wu wrote:
> > From: ChiaEn Wu <chiaen_wu@richtek.com>
> >
> > Add Mediatek MT6370 Backlight support.
> >
> > Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
>
> > diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/=
Kconfig
> > index a003e02..7cd823d 100644
> > <snip>
> > +static int mt6370_init_backlight_properties(struct mt6370_priv *priv,
> > +                                         struct backlight_properties *=
props)
> > +{
> > +     struct device *dev =3D priv->dev;
> > +     u8 prop_val;
> > +     u32 brightness, ovp_uV, ocp_uA;
> > +     unsigned int mask, val;
> > +     int ret;
> > +
> > +     /* Vendor optional properties */
> > +     val =3D 0;
> > +     if (device_property_read_bool(dev, "mediatek,bled-pwm-enable"))
> > +             val |=3D MT6370_BL_PWM_EN_MASK;
> > +
> > +     if (device_property_read_bool(dev, "mediatek,bled-pwm-hys-enable"=
))
> > +             val |=3D MT6370_BL_PWM_HYS_EN_MASK;
> > +
> > +     ret =3D device_property_read_u8(dev,
> > +                                   "mediatek,bled-pwm-hys-input-th-ste=
ps",
> > +                                   &prop_val);
> > +     if (!ret) {
> > +             prop_val =3D clamp_val(prop_val,
> > +                                  MT6370_BL_PWM_HYS_TH_MIN_STEP,
> > +                                  MT6370_BL_PWM_HYS_TH_MAX_STEP);
> > +             /*
> > +              * prop_val =3D  1      -->  1 steps --> 0x00
> > +              * prop_val =3D  2 ~  4 -->  4 steps --> 0x01
> > +              * prop_val =3D  5 ~ 16 --> 16 steps --> 0x10
> > +              * prop_val =3D 17 ~ 64 --> 64 steps --> 0x11
>
>                                                       ^^^^^
> These numbers are binary, not hex, right? If so, the comments
> should be 0b00 to 0b03 .

Ohh! Yes! These numbers are binary!
I so apologize for making this mistake...
I will revise the comments in the next patch!
Thank you so much!

>
>
> > +              */
> > +             prop_val =3D (ilog2(roundup_pow_of_two(prop_val)) + 1) >>=
 1;
> > +             val |=3D prop_val << (ffs(MT6370_BL_PWM_HYS_SEL_MASK) - 1=
);
> > +     }
> > +
> > +     ret =3D regmap_update_bits(priv->regmap, MT6370_REG_BL_PWM,
> > +                              val, val);
> > +     if (ret)
> > +             return ret;
>
> Overall, I like this approach! Easy to read and understand.
>
>
> > <snip>
> > +static int mt6370_bl_probe(struct platform_device *pdev)
> > +{
> > +     struct mt6370_priv *priv;
> > +     struct backlight_properties props =3D {
> > +             .type =3D BACKLIGHT_RAW,
> > +             .scale =3D BACKLIGHT_SCALE_LINEAR,
>
> Sorry, I missed this before but the KConfig comment says that the
> backlight can support both linear and exponential curves.
>
> Is there a good reason to default to linear?

Well...
The customers who used this PMIC have very few or even no use exponential c=
urve,
so I set the default to linear.

If you think this is inappropriate, I will add a DT property to
control this feature in the next patch!

By the way,
I found some mistakes in my probe() function... I didn't use "return"
when I use dev_err_probe()...
I will refine it in the next patch!

>
>
> Daniel.
> >

Best regards,
ChiaEn Wu
