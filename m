Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC60953B8C2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 14:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbiFBMHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 08:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbiFBMHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 08:07:21 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A56B1EBEEB;
        Thu,  2 Jun 2022 05:07:20 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id i185so4597249pge.4;
        Thu, 02 Jun 2022 05:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XwcwX6loUblFTwI5Bhmlqw2TBVsxdFoQXDJc3TovI80=;
        b=k7esYmpY4T8Q9KWtH0jxmxeHnbiHqRF3LqvsK/4Ug3Jqt1gx+19gOZth9lZtzHsVKs
         z65zFnDsir6/cGI09w4DESfFBhn0W5yFwcDHUhGt52REfaoXr8Lc3VEDfnfNLuP0/o4D
         QhmI2Ziwo2TGGYdyx1kXgJ3Stahlm838VXMAuafTcApdKShsfEtVjX9TkbD+0Bn3YGXN
         cu4WTkIfORLzLsRbi8XMZ5t129tM/R0mlJLffyFB4beE1GnzDQtiOj8V92AdJoeaUJkr
         MOUy0Z8FtpbwiXb1/kULCSN9k82OaEpM+B4qbR683RScjbId31DRofz7DKXeQlDpP1zH
         wMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XwcwX6loUblFTwI5Bhmlqw2TBVsxdFoQXDJc3TovI80=;
        b=tgW3x3fSz6AnxVIFHcR9qdnnwznVBAKmjKHiAwjYxffPQ9R4q7YZraQlvtEZdSP1tW
         qkHxAWOf68VL8RQ2oHHCQPl6eusjYqfZKJsc190xid659GVlBNnnSbiTeojuHbuJZcgM
         li5B/2xYlvdjS0DIACwmTUKAXQGhQFHMkF8o9BWjMHMndH9Xsnmr7eKH1BhAaVc5NMmB
         D+6MgkXL3TitcqSlmpsNyIBOGzmd1lmwaKNILSyt4fjKCjocM3GR86+FssmIh4q7g3Ie
         HTtLQ9aqvgNCPRLwh0Sd3/9jgtH2IWMmU5NK83DSdccNoewua0dUVC3omDMuk1Su1+ra
         pnaA==
X-Gm-Message-State: AOAM531ksrFcw+pauIm8rdZe83w1GjWhIxp0jmF/kniDugr2fTIpPwrl
        StoZIvmv2FyccOu7w3aUAdyUARBkG/O0xM5IhMs=
X-Google-Smtp-Source: ABdhPJwLN3JLAZweJSj8I9PDnQ5t3UDnCmJ6jzOmk2NgYlJRjY/uTSAVQc8mkFdLPGGc+2hlm0r13u/yFcGFZ+aEYy0=
X-Received: by 2002:a63:2c15:0:b0:3f6:6a5f:8f0a with SMTP id
 s21-20020a632c15000000b003f66a5f8f0amr3954364pgs.76.1654171639739; Thu, 02
 Jun 2022 05:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220531102809.11976-1-peterwu.pub@gmail.com> <20220531102809.11976-8-peterwu.pub@gmail.com>
 <CAHp75VdUQqihr=AX-wEUD05jY1ReL63hMCL+eaqmjkN8CsS_Vg@mail.gmail.com>
In-Reply-To: <CAHp75VdUQqihr=AX-wEUD05jY1ReL63hMCL+eaqmjkN8CsS_Vg@mail.gmail.com>
From:   szuni chen <szunichen@gmail.com>
Date:   Thu, 2 Jun 2022 20:07:08 +0800
Message-ID: <CA+hk2fasiriGHepNjsnPCqTMJOgAEbVHACmWrDRZY7cHPcOQqA@mail.gmail.com>
Subject: Re: [PATCH 07/14] leds: flashlight: mt6370: Add Mediatek MT6370
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
        Helge Deller <deller@gmx.de>, cy_huang@richtek.com,
        alice_chen@richtek.com, chiaen_wu@richtek.com,
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

Thank you for the valuable suggestion.

Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B46=E6=9C=
=881=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:57=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Tue, May 31, 2022 at 1:32 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
> >
> > From: Alice Chen <alice_chen@richtek.com>
> >
> > Add Mediatek MT6370 flashlight support
>
> Same comments about the commit message.
>
> ...
>
> > +#include <linux/platform_device.h>
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
>
> + blank line?
Thanks, this will be refined in the new version.
>
> > +#include <media/v4l2-flash-led-class.h>
>
> + blank line
Thanks, this will be refined in the new version.
>
> > +enum {
> > +       MT6370_LED_FLASH1,
> > +       MT6370_LED_FLASH2,
> > +       MT6370_MAX_LEDS
> > +};
>
> ...
>
> > +       struct mt6370_led *led =3D container_of(fl_cdev, struct mt6370_=
led,
> > +                                             flash);
>
> > +       struct mt6370_led *led =3D container_of(fl_cdev, struct mt6370_=
led,
> > +                                             flash);
>
> Make a helper out of this
>
>   #define to_mt637_led()  container_of()
>
> and reuse.
Thanks, this will be refined in the new version.
>
> ...
>
> > +       /*
> > +        * For the flash turn on/off, HW rampping up/down time is 5ms/5=
00us,
>
> ramping
>
> > +        * respectively
>
> Period!
Thanks, this will be refined in the new version.
>
> > +        */
>
> ...
>
> > +       const char * const states[] =3D { "off", "keep", "on" };
> > +       const char *str;
> > +       int ret;
> > +
> > +       if (!fwnode_property_read_string(init_data->fwnode,
> > +                                        "default-state", &str)) {
> > +               ret =3D match_string(states, ARRAY_SIZE(states), str);
> > +               if (ret < 0)
> > +                       ret =3D STATE_OFF;
> > +
> > +               led->default_state =3D ret;
> > +       }
>
> fwnode_property_match_string()?
Sorry, but I think the use of this function is different from my target.
I want to read the string of the "default-state" property and figure
out if the string is in the states array.
But the fwnode_property_match_string aimed to figure out if the state
in the property array.
One is a property array and another one is a state array.
>
> ...
>
> > +       if (!count || count > MT6370_MAX_LEDS) {
> > +               dev_err(&pdev->dev,
> > +               "No child node or node count over max led number %lu\n"=
, count);
> > +               return -EINVAL;
>
> return dev_err_probe(...);
Thanks, will refine in the new version
>
> > +       }
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
Sincerely,
Alice Chen
