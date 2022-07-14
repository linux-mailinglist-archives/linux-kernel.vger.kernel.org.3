Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8C357495A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiGNJoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238243AbiGNJoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:44:25 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E96211A0F;
        Thu, 14 Jul 2022 02:44:24 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2ef5380669cso11207607b3.9;
        Thu, 14 Jul 2022 02:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zQfNaPBMj9qupXp4mDqBN3FvXkuDRylRWUn+zvSSLGM=;
        b=oUdjAR6phW8mBTe5eDzj0QeWXcrYu1dSSLOGdISEQbBbC80E3nnO2FEXxGYAf5RiXM
         qwCt3mFNhcwCVxxKFv95OoQ0lQSZxF92XMKvQIcmRpKoj31iWTGkf6owEnJ4SKyFwH0k
         JauEuOFAu1eKjoPKsewxkkdItYHKrSID6UH/riAytvkcYOvK7wJWfdXGd7YOn2ZlGDPx
         UknY6TlQhPMD62NXaNa84SFcZnW0ErJAIVlOFo4CQxO3vJ5UK7w+Chs6Xo+IjKurYNSH
         WqV07lOMcczIHACgOGIOzTx9kcVs99te0vmj/tlI8+bxgqMwN7h4K7I2B72mfGLzkJ4i
         gQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zQfNaPBMj9qupXp4mDqBN3FvXkuDRylRWUn+zvSSLGM=;
        b=2IDATPUV3G1XUlJtbtTM/xKl0j703c9YOSnfV3GKddxJ4lPihMz21mMbCrTnI7cVUt
         PlvTJ5i8etYQnPm9iJL1QCZwmpJwmQ9bXR1WN374T3YNLpc3qt5/ve/mnn2rPHnZMgEl
         Cw7U5xNraEMtyLdYa0YuEkXpkbCS4HVKLnqiwkzsA+Ko79/ZYWHExD1I89xHL40s4+ln
         MEsvOgsd+J1yAhvgcrfcP4xAdocH4Cm4u7au8wU66lAC089+TDhnE23KDVvfIQJtJiFb
         NA2ACoBkfJSRr4/5veO5SADFDogaH5k1B13iOS3G+TfXLa7TraLCkweEExxVH4e6oPem
         Y/+Q==
X-Gm-Message-State: AJIora94Q2UfK832rlallO3kczk0rIDqvHwZch5lVcEWV/Ig1/AyRdTf
        KTAp/dW4h3mDmodhEmdwj1QKj+Pf18CBY4WIE7A=
X-Google-Smtp-Source: AGRyM1tGq8KvNtgJfDDwwfnd/uLdaBM71GAdhz/B4s7iJ7PIRrr3jUFpxSU8W+abEjc+p3ioRN+vN34Iicys3Eb13K4=
X-Received: by 2002:a81:4986:0:b0:31d:388b:d08d with SMTP id
 w128-20020a814986000000b0031d388bd08dmr8542894ywa.185.1657791863639; Thu, 14
 Jul 2022 02:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220704053901.728-1-peterwu.pub@gmail.com> <20220704053901.728-14-peterwu.pub@gmail.com>
 <CAHp75VdwEc9AW1w8ejsxkw+sBTF1dumd99QyzTY9BZaXiViRWQ@mail.gmail.com>
 <CABtFH5K-2+2hbpvpq2nPE5AsznkQxZF2r3MVC64Q39DJhVuUtA@mail.gmail.com>
 <CAHp75VevDwdAKLYEWJgnMDvzuPuFibLuVqH-GKazEOT76wM6_A@mail.gmail.com>
 <CABtFH5LT1Ct_9-B_XRrGwYFmL5kGS6KHR7dNVyUO5z4sTy_6oA@mail.gmail.com> <CAHp75VcU_9Ao2CoqiUDZHqhVOjEMZor+hctPp3YYP4HOjYLDUg@mail.gmail.com>
In-Reply-To: <CAHp75VcU_9Ao2CoqiUDZHqhVOjEMZor+hctPp3YYP4HOjYLDUg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Jul 2022 11:43:46 +0200
Message-ID: <CAHp75VeMP4zDMmGfdya5Y1C0Hkb7=jeOQGE_HqyDdZcmd_Uyyg@mail.gmail.com>
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

On Thu, Jul 14, 2022 at 11:27 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Jul 14, 2022 at 9:13 AM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
> > Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=
=9C=8813=E6=97=A5 =E9=80=B1=E4=B8=89 =E6=99=9A=E4=B8=8A8:07=E5=AF=AB=E9=81=
=93=EF=BC=9A

...

> > I have tried two methods so far, as follows
> > -------------------------------------------------------------
> > /*
> >  * prop_val =3D  1      -->  1 steps --> b'00
> >  * prop_val =3D  2 ~  4 -->  4 steps --> b'01
> >  * prop_val =3D  5 ~ 16 --> 16 steps --> b'10
> >  * prop_val =3D 17 ~ 64 --> 64 steps --> b'11
> > */
>
> So, for 1 --> 0, for 2 --> 1, for 5 --> 2, and for 17 --> 3.
> Now, consider x - 1:
> 0  ( 0 ) --> 0
> 1  (2^0) --> 1
> 4  (2^2) --> 2
> 16 (2^4) --> 3
> 64 (2^6) --> ? (but let's consider that the range has been checked alread=
y)
>
> Since we take the lower limit, it means ffs():
>
>   y =3D (ffs(x - 1) + 1) / 2;
>
> Does it work for you?

It wouldn't, because we need to use fls() against it actually.

So,
0..1   (-1..0)   --> 0
2..4   (1..3)   --> 1
5..16  (4..15)  --> 2
17..64 (16..63) --> 3

y =3D x ? ((fls(x - 1) + 1) / 2 : 0;


--=20
With Best Regards,
Andy Shevchenko
