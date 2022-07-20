Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC4A57B42E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238375AbiGTJsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiGTJst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:48:49 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E39655AF;
        Wed, 20 Jul 2022 02:48:48 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z13so5771235wro.13;
        Wed, 20 Jul 2022 02:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c+pvmwXxIE3jKXaJBEBBqNcZCeI+2ftzet1Ejv5LXxE=;
        b=Bl/Uxa8xKm77kppS+zbyPUqMX6ThytrscVsgl1YNbRNeKe8x3wNYy9xN2LJQgC4b+m
         CVtxDHN3+NlCmmeGfSPK3c/2bgbcIaqjyJ8UOOrc7fgYnHXVJpL9/jlthv7pWdx9kOH1
         LZ8Ke+TTociEGnkw6Kb2NrqYVzWsyeo9vazoQxsfc7PDfRMUmtJMmZ2JjxhubAt8pfFH
         oIQiGQ/fJdWsK3BswigHb/+Qw2e86Dg2TDS2EAHuCLGkXQC7NROzCqqyLHBKgPM7Xxl8
         znyAJjdKjHqrO6ONRWcA3n3b8veOJmnjbOX7I+MBtOPTMpYlt0dx+flde0eKnhS9oZA+
         5LkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c+pvmwXxIE3jKXaJBEBBqNcZCeI+2ftzet1Ejv5LXxE=;
        b=zm/QX45d+Mq9PhohE71568aOFJBPpbFe7wxDQk34r2O2J8cCArx5iVOiwWhmnBxQWz
         e+9/7NCWMYxGOdb450CFH13Xs8+wD2HvMjZk/aK6teRylv4EcO6sf9FL9nfI9X+GuljY
         t3TApFUPaqbN8SzVKt7cmA4B+ge5/uDhjLKArCJBjIARuUMM0OnGD230e8JujxssWXpA
         ncDZooT4JZLS1TApVC5i7jHiDNBp1TW4MU3h9OFf49Gg4IiBfOETKvmE0V1KGvqOUt7G
         Yn46NBlMQ32/2eWQpyrnkCg/4ajf4fEUizgM/0V6jqmusoQFIMh9PPQDNirhY47+Mo8D
         azwA==
X-Gm-Message-State: AJIora9Nws0kRDpeOhHskrMn3R+TY5xMg7/PGShiCuaPk8hajCH7cOxJ
        VllcfJuzXjYnrG+pFKpJr8H1BNSdRGiwZA+0bTU=
X-Google-Smtp-Source: AGRyM1s8IpIYDGuU/DLqKsFdsmyV+rKVmTfi/oduAoH5rNHnTn85/TiMyb4eENWpu+Y5Z15JoqFBASYG/TlH/hH8hGo=
X-Received: by 2002:a05:6000:98b:b0:21d:b70f:2726 with SMTP id
 by11-20020a056000098b00b0021db70f2726mr29986145wrb.237.1658310526656; Wed, 20
 Jul 2022 02:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220715112607.591-1-peterwu.pub@gmail.com> <20220715112607.591-12-peterwu.pub@gmail.com>
 <CAHp75VfyVufzf7CK38BVu_j0B4ax_d1gLAGYDE3H1zaKkuUB=A@mail.gmail.com> <20220720094510.GA29755@cyhuang-hp-elitebook-840-g3.rt>
In-Reply-To: <20220720094510.GA29755@cyhuang-hp-elitebook-840-g3.rt>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 20 Jul 2022 17:48:34 +0800
Message-ID: <CADiBU3_rtVXFX3qdSoc=F-zs9CYiNRmNPOa3RffRJD1Qc5N-bA@mail.gmail.com>
Subject: Re: [PATCH v5 11/13] leds: mt6370: Add MediaTek MT6370 current sink
 type LED Indicator support
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
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        szuni chen <szunichen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=9C=8820=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:45=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Jul 15, 2022 at 08:29:42PM +0200, Andy Shevchenko wrote:
> > On Fri, Jul 15, 2022 at 1:29 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote=
:
> > >
> > > From: ChiYuan Huang <cy_huang@richtek.com>
> > >
> > > The MediaTek MT6370 is a highly-integrated smart power management IC,
> > > which includes a single cell Li-Ion/Li-Polymer switching battery
> > > charger, a USB Type-C & Power Delivery (PD) controller, dual
> > > Flash LED current sources, a RGB LED driver, a backlight WLED driver,
> > > a display bias driver and a general LDO for portable devices.
> > >
> > > In MediaTek MT6370, there are four channel current-sink RGB LEDs that
> > > support hardware pattern for constant current, PWM, and breath mode.
> > > Isink4 channel can also be used as a CHG_VIN power good indicator.
> >
> > ...
> >
> > > +         This driver can also be built as a module. If so the module
> >
> > so, the
> >
> > > +         will be called "leds-mt6370.ko".
> >
> > No ".ko".
> >
> > Why did you ignore these comments? Please go and fix _everywhere_ in
> > your series.
> > It's basically the rule of thumb, if the reviewer gives a comment
> > against an occurrence of something, go through entire series and check
> > if there are other places like commented one and address them all.
> >
> > ...
> >
> > > + * Author: Alice Chen <alice_chen@richtek.com>
> >
> > Strange, the commit message doesn't have a corresponding SoB, why?
> >
> Yes, there're two authors Alice and me.
> I'll correct it in next.
> > ...
> >
> > > +#define MT6370_PWM_DUTY                                31
> > > +#define MT6372_PMW_DUTY                                255
> >
> > Looks like these are limits by hardware?
> > Check with the datasheet if (BIT(x) - 1) makes more sense here.
> >
> > ...
> >
> > > +       switch (led_no) {
> > > +       case MT6370_LED_ISNK1:
> > > +               sel_field =3D F_LED1_DUTY;
> > > +               break;
> > > +       case MT6370_LED_ISNK2:
> > > +               sel_field =3D F_LED2_DUTY;
> > > +               break;
> > > +       case MT6370_LED_ISNK3:
> > > +               sel_field =3D F_LED3_DUTY;
> > > +               break;
> > > +       default:
> > > +               sel_field =3D F_LED4_DUTY;
> >
> > Missed break;
> >
> > > +       }
> >
> > ...
> >
> > > +       switch (led_no) {
> > > +       case MT6370_LED_ISNK1:
> > > +               sel_field =3D F_LED1_FREQ;
> > > +               break;
> > > +       case MT6370_LED_ISNK2:
> > > +               sel_field =3D F_LED2_FREQ;
> > > +               break;
> > > +       case MT6370_LED_ISNK3:
> > > +               sel_field =3D F_LED3_FREQ;
> > > +               break;
> > > +       default:
> > > +               sel_field =3D F_LED4_FREQ;
> >
> > Ditto.
> >
> > > +       }
> >
> > ...
> >
> > > +       switch (led_no) {
> > > +       case MT6370_LED_ISNK1:
> > > +       case MT6370_LED_ISNK2:
> > > +       case MT6370_LED_ISNK3:
> > > +               *base =3D MT6370_REG_RGB1_TR + led_no * 3;
> > > +               break;
> > > +       default:
> > > +               *base =3D MT6370_REG_RGB_CHRIND_TR;
> >
> > Ditto.
> > It seems you dropped them for all switch-cases. It's not goot, please
> > restore them back.
> >
> > > +       }
> >
> > ...
> >
> > > +       u8 val[P_MAX_PATTERNS / 2] =3D {0};
> >
> > { } should suffice
> >
> >
> In the above range selector, we use the 'logic or' to generate the
typo, it's 'below'.
> pattern values.
>
> If to change it from '{0} to '{ }', is it correct?
> > > +       /*
> > > +        * Pattern list
> > > +        * tr1: byte 0, b'[7: 4]
> > > +        * tr2: byte 0, b'[3: 0]
> > > +        * tf1: byte 1, b'[7: 4]
> > > +        * tf2: byte 1, b'[3: 0]
> > > +        * ton: byte 2, b'[7: 4]
> > > +        * toff: byte 2, b'[3: 0]
> > > +        */
> > > +       for (i =3D 0; i < P_MAX_PATTERNS; i++) {
> > > +               curr =3D pattern + i;
> > > +
> > > +               sel_range =3D i =3D=3D P_LED_TOFF ? R_LED_TOFF : R_LE=
D_TRFON;
> > > +
> > > +               linear_range_get_selector_within(priv->ranges + sel_r=
ange,
> > > +                                                curr->delta_t, &sel)=
;
> > > +
> > > +               val[i / 2] |=3D sel << (4 * ((i + 1) % 2));
> > > +       }
> > > +
> > > +       memcpy(pattern_val, val, 3);
> > > +       return 0;
> > > +}
> >
> > ...
> >
> > > +out:
> >
> > out_unlock:
> >
> > > +       mutex_unlock(&priv->lock);
> > > +
> > > +       return ret;
> >
> > ...
> >
> > > +out:
> >
> > Ditto. And so on.
> >
> > > +       mutex_unlock(&priv->lock);
> > > +
> > > +       return ret;
> >
> > ...
> >
> > > +               sub_led =3D devm_kzalloc(priv->dev,
> > > +                                      sizeof(*sub_led) * MC_CHANNEL_=
NUM,
> > > +                                      GFP_KERNEL);
> >
> > NIH devm_kcalloc(). Also check if you really need zeroed data.
> >
> Ok, and after the check, I also need to add one line to set the intensity=
 to 0.
> > > +               if (!sub_led)
> > > +                       return -ENOMEM;
> >
> > ...
> >
> > > +                       ret =3D fwnode_property_read_u32(child, "colo=
r", &color);
> > > +                       if (ret) {
> > > +                               dev_err(priv->dev,
> > > +                                       "led %d, no color specified\n=
",
> > > +                                       led->index);
> > > +                               return ret;
> >
> > return dev_err_probe(...) ; ?
> >
> > Ditto for many places in your entire series.
> >
> > > +                       }
> >
> > ...
> >
> > > +       priv =3D devm_kzalloc(&pdev->dev,
> > > +                           struct_size(priv, leds, count), GFP_KERNE=
L);
> >
> > At least one parameter can be placed on the previous line.
> >
> > > +       if (!priv)
> > > +               return -ENOMEM;
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
