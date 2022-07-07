Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D411756A05E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbiGGKtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiGGKti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:49:38 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF112564C6;
        Thu,  7 Jul 2022 03:49:37 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y9so4344889pff.12;
        Thu, 07 Jul 2022 03:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/FFWXQHfHuTAnSajIxw6WITRnf577MGViKmqh2rQTck=;
        b=pNuDXa/tbcZ8L6jUMcFhfkiiN+HCY2bTy8g4vxrKF0uCnbdZzaUEHFI3UEhvKFQ1UC
         eE6uNL4ZcikxGKWmBQMWNFn2vi2ETQWNjJHAKM/K8ooax1hYtWjIkuCEoiWjzlwmG9GX
         WoMgg2sO0TOL1BOmFZkYZQjlUeFnk4VUM4ID13qr9aO5fAUOHNV8WcMiuWT0KyCv3tNs
         yt5TOLt/k314oncIAs4MSxNIPDyesqnVGGLLLmR1OaKx2ayShDI5LtdAatcf/iDhjUT+
         nlXRge1dqHFL7OZkv58zzWV44JyXq8nAHQm1a8SdNpsI3zpdsjcEr5X6BK+lhzi+b04Z
         O/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/FFWXQHfHuTAnSajIxw6WITRnf577MGViKmqh2rQTck=;
        b=p/tO1xIVx83xaaVnQOtPe1agONqonGUSwCMwNVjMgG+8XqFqmGWuYZWqsaHuPjo6VW
         295vUjclOp1Cb8oO4S690ZRH4EmDPx79e4jjLKB78Uet3fwznhU9ghsIQcGMeR67Ap6Q
         xLVXfketpGr/YcJyV76oY56er0HuDwIw/Kh0+QlfmVZmqyMc98La0SBb73i5zmylmzfR
         BoC5ZHW28i66xi7ISstl9zdy5yynlLZpixoCnvbkBcNgmjuP+Su41XvWiaA9tFQ5gZIz
         DPkurssdLXEUfYDxsMb7gugIPLAVzkBc9SoAj04hzOaXh5Vc63nFI3Wqizg2Affilds6
         GVhw==
X-Gm-Message-State: AJIora/cpEEQMHlXGfbRHbXz3sb6382yY1YRR/of5dcV0XLcWuitsaFg
        N/omYqwM35/G1yCPRT16IX5aXsIPQWFKYaL3qzQ=
X-Google-Smtp-Source: AGRyM1uUqVtaUItLC5GM5dPIqcXaBtnctDbivq8Sa/TY+MZ4zlzxxNsXElMIyQ3R0dNWkSwoY0p+UAWXxA72d7sMMAo=
X-Received: by 2002:a05:6a00:179e:b0:518:9e1d:1cbd with SMTP id
 s30-20020a056a00179e00b005189e1d1cbdmr52012436pfg.12.1657190977288; Thu, 07
 Jul 2022 03:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220704053901.728-1-peterwu.pub@gmail.com> <20220704053901.728-13-peterwu.pub@gmail.com>
 <CAHp75Vciq4M4kVrabNV9vTLLcd1vR=bMe8JLEdAF9MkRTpcB5g@mail.gmail.com>
In-Reply-To: <CAHp75Vciq4M4kVrabNV9vTLLcd1vR=bMe8JLEdAF9MkRTpcB5g@mail.gmail.com>
From:   szuni chen <szunichen@gmail.com>
Date:   Thu, 7 Jul 2022 18:49:26 +0800
Message-ID: <CA+hk2fbm8ppKecVJL6D9rYJizf9baV8mOmwRx6GyO+MKvJ3xBQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/13] leds: flashlight: mt6370: Add Mediatek MT6370
 flashlight support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

Hi Andy,

Thank you for the valuable comment.

Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=9C=
=885=E6=97=A5 =E9=80=B1=E4=BA=8C =E6=B8=85=E6=99=A85:06=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Mon, Jul 4, 2022 at 7:43 AM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
>
> > Add Mediatek MT6370 flashlight support.
>
> ...
>
> > +         This driver can also be built as a module. If so the module
>
> If so,
>
Thank you, I'll fix it in the next version.

> > +         will be called "leds-mt6370-flash.ko".
>
> No ".ko" part.
>
Thank you, I'll fix it in the next version.

> ...
>
> > +#define MT6370_ITORCH_MINUA            25000
> > +#define MT6370_ITORCH_STEPUA           12500
> > +#define MT6370_ITORCH_MAXUA            400000
> > +#define MT6370_ITORCH_DOUBLE_MAXUA     800000
> > +#define MT6370_ISTRB_MINUA             50000
> > +#define MT6370_ISTRB_STEPUA            12500
> > +#define MT6370_ISTRB_MAXUA             1500000
> > +#define MT6370_ISTRB_DOUBLE_MAXUA      3000000
> > +#define MT6370_STRBTO_MINUS            64000
> > +#define MT6370_STRBTO_STEPUS           32000
> > +#define MT6370_STRBTO_MAXUS            2432000
>
> Make units suffix visible, i.e. _US, _uA, etc.
>
Thank you, I'll fix it in the next version.

> ...
>
> > +       if (curr)
> > +               val |=3D MT6370_TORCHEN_MASK;
> > +
> > +
>
> One blank line is enough.
>
Thank you, I'll fix it in the next version.

> ...
>
> > +       /*
> > +        * Due to the current spike when turning on flash,
> > +        * let brightness to be kept by framework.
>
> brightness be
> the framework
>
Thank you, I'll fix it in the next version.

> > +        * This empty function is used to
> > +        * prevent led_classdev_flash register ops check failure.
> > +        */
>
Thank you, I'll fix it in the next version.
> ...
>
> > +       } else {
> > +               ret =3D regmap_update_bits(priv->regmap,
> > +                                        MT6370_REG_FLEDISTRB(led->led_=
no),
> > +                                        MT6370_ISTROBE_MASK, val);
>
> > +               if (ret)
> > +                       return ret;
>
> Dup of the below.
>
Thank you, I'll fix it in the next version.

> > +       }
> > +       return ret;
>
> ...
>
> > +       /*
> > +        * If the flash need to be on,
> > +        * config the flash current ramping up to the setting value
> > +        * Else, always recover back to the minimum one
>
> Missed periods.
>
Thank you, I'll fix it in the next version.

> > +        */
>
> ...
>
> > +       /*
> > +        * For the flash turn on/off, HW ramping up/down time is 5ms/50=
0us
> > +        * respectively.
> > +        */
> > +       if (!prev && curr)
> > +               usleep_range(5000, 6000);
> > +       else if (prev && !curr)
> > +               udelay(500);
>
> Comment doesn't explain why this is suddenly a busy loop operation?
>
For the flash turn on/off, HW ramping up/down waiting time is
5ms/500us, respectively.
The busy loop is for preventing turn on/off in wait time, which will
cause unexpected problems.

If I change the comment to
"For the flash turn on/off, HW ramping up/down waiting time is
5ms/500us, respectively.
Need to wait until HW ramping successfully to prevent the unexpected proble=
m.",
will this meet your expectation?

>
> > +static int mt6370_led_register(struct device *parent, struct mt6370_le=
d *led,
> > +                               struct led_init_data *init_data)
> > +{
> > +       struct v4l2_flash_config v4l2_config =3D {0};
> > +       int ret;
> > +
> > +       ret =3D devm_led_classdev_flash_register_ext(parent, &led->flas=
h,
> > +                                                  init_data);
> > +       if (ret) {
> > +               dev_err(parent, "Couldn't register flash %d\n", led->le=
d_no);
> > +               return ret;
> > +       }
> > +
> > +       mt6370_init_v4l2_flash_config(led, &v4l2_config);
> > +       led->v4l2_flash =3D v4l2_flash_init(parent, init_data->fwnode,
> > +                                         &led->flash, &v4l2_flash_ops,
> > +                                         &v4l2_config);
> > +       if (IS_ERR(led->v4l2_flash)) {
> > +               dev_err(parent, "Failed to register %d v4l2 sd\n", led-=
>led_no);
> > +               return PTR_ERR(led->v4l2_flash);
> > +       }
> > +
> > +       return 0;
> > +}
>
> ...
>
> > +       } else
> > +               val =3D clamp_align(val, MT6370_STRBTO_MINUS, MT6370_ST=
RBTO_MAXUS,
> > +                                 MT6370_STRBTO_STEPUS);
>
> Missed {}
>
Thank you, I'll fix it in the next version.

> > +
> > +
>
> One blank line is enough.
>
Thank you, I'll fix it in the next version.

> --

Yours Sincerely,
Alice
