Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C292E574A61
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237685AbiGNKQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiGNKQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:16:37 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C4F120A5;
        Thu, 14 Jul 2022 03:16:36 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id y195so2487074yby.0;
        Thu, 14 Jul 2022 03:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DAB/V2thJrX7oNWAiw69xQ9s2yER1z6zgaPEDVTbARY=;
        b=WzDjqq1pRDiX/e0JhdlBpio8zOrckRWFWYoqqx6oFzHppl1HXZKC0K0Vo9UvICBDx4
         1IgGFxPhaOdHa0ijcMRnAWpg15ZqdMXn+A4AN+KbbyLfV+DLK/zGUswdeyoa6I/gMSWB
         mLZcWexKeicX3ZsiBj8qG9KhT504M9qLDNPa+/3b4OVXUQmkey6iL5NUBSkO06Ql9xqx
         7ABvX+TuwC6gjV6lZglt+ptPstfpEqlr1Yg9+65NKMHYYSOzn23aEysk+sSCVoQV5iL6
         RIo+DgXA1m8aiBJ1aC+G2pOf803m52JzwysZxxKXTmLKrJdLDZZrFNf6ymvczZtUZHNx
         NC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DAB/V2thJrX7oNWAiw69xQ9s2yER1z6zgaPEDVTbARY=;
        b=zd0TXa3ccyOwBBJjB+uQo+lzRSumxdbxEoV3qr/dCPj55C2RbbWDifNraEZm609qu0
         w1QvJbffkV2WGGFkjggR4ZRI0Tb5w1O8PyrBoZcfILoHtN8621+mLzP6989YbrOaEFir
         XVdMdrDPw4bN+fOZUSGWg4HmivMQHFqmU6w+5orxmrTaC4c+2fM+YtzsBVSNF/Wi8NYL
         zznjtl6dwodcR2TGJwEpaCJ4RMMC2X6LYD3DhYvl+TfKTX+s9KRWu2yfxJ0cNZboDLHb
         406SMFaviorzsXpObR8aQyJZSrubJhNBovqSc6d1tS74oC9wALA3XxgOSKHH1TJO/HaA
         DYOw==
X-Gm-Message-State: AJIora9n0DiigPni0fiNksHx987JPA6i7BH6qczxLrbSgkVRddkU6fGm
        F9LhETRK4YMzSYuT6VG4aA0vySQCwqAg8E2ZLTw=
X-Google-Smtp-Source: AGRyM1tsa04XdX6EoBLAKq/4vJYddIuWfRGN796P9MIbmkVyYowmMMx33Ee2ini1a+JW/8CzKBWdXOgF/S8Hwfl8jYQ=
X-Received: by 2002:a05:6902:686:b0:66e:627f:4d29 with SMTP id
 i6-20020a056902068600b0066e627f4d29mr7320510ybt.385.1657793795448; Thu, 14
 Jul 2022 03:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220704053901.728-1-peterwu.pub@gmail.com> <20220704053901.728-14-peterwu.pub@gmail.com>
 <CAHp75VdwEc9AW1w8ejsxkw+sBTF1dumd99QyzTY9BZaXiViRWQ@mail.gmail.com>
 <CABtFH5K-2+2hbpvpq2nPE5AsznkQxZF2r3MVC64Q39DJhVuUtA@mail.gmail.com>
 <CAHp75VevDwdAKLYEWJgnMDvzuPuFibLuVqH-GKazEOT76wM6_A@mail.gmail.com>
 <CABtFH5LT1Ct_9-B_XRrGwYFmL5kGS6KHR7dNVyUO5z4sTy_6oA@mail.gmail.com>
 <CAHp75VcU_9Ao2CoqiUDZHqhVOjEMZor+hctPp3YYP4HOjYLDUg@mail.gmail.com> <CAHp75VeMP4zDMmGfdya5Y1C0Hkb7=jeOQGE_HqyDdZcmd_Uyyg@mail.gmail.com>
In-Reply-To: <CAHp75VeMP4zDMmGfdya5Y1C0Hkb7=jeOQGE_HqyDdZcmd_Uyyg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Jul 2022 12:15:58 +0200
Message-ID: <CAHp75VdXGJtPd_oZPGkS1=DoWjFYxbQu_7Vtfj547QQkpz2KNA@mail.gmail.com>
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

On Thu, Jul 14, 2022 at 11:43 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Jul 14, 2022 at 11:27 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Jul 14, 2022 at 9:13 AM ChiaEn Wu <peterwu.pub@gmail.com> wrote=
:
> > > Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B47=
=E6=9C=8813=E6=97=A5 =E9=80=B1=E4=B8=89 =E6=99=9A=E4=B8=8A8:07=E5=AF=AB=E9=
=81=93=EF=BC=9A

...

> > >  * prop_val =3D  1      -->  1 steps --> b'00
> > >  * prop_val =3D  2 ~  4 -->  4 steps --> b'01
> > >  * prop_val =3D  5 ~ 16 --> 16 steps --> b'10
> > >  * prop_val =3D 17 ~ 64 --> 64 steps --> b'11
> >
> > So, for 1 --> 0, for 2 --> 1, for 5 --> 2, and for 17 --> 3.
> > Now, consider x - 1:
> > 0  ( 0 ) --> 0
> > 1  (2^0) --> 1
> > 4  (2^2) --> 2
> > 16 (2^4) --> 3
> > 64 (2^6) --> ? (but let's consider that the range has been checked alre=
ady)
> >
> > Since we take the lower limit, it means ffs():
> >
> >   y =3D (ffs(x - 1) + 1) / 2;
> >
> > Does it work for you?
>
> It wouldn't, because we need to use fls() against it actually.
>
> So,
> 0..1   (-1..0)   --> 0
> 2..4   (1..3)   --> 1
> 5..16  (4..15)  --> 2
> 17..64 (16..63) --> 3
>
> y =3D x ? ((fls(x - 1) + 1) / 2 : 0;

Okay, I nailed it down, but Daniel is right, it's simpler to have just
conditionals.

y =3D x >=3D2 ? __fls(x - 1) / 2 + 1 : 0;


--
With Best Regards,
Andy Shevchenko
