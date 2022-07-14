Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDB45748E7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbiGNJ2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiGNJ20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:28:26 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3022C666;
        Thu, 14 Jul 2022 02:27:45 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-31d7db3e6e5so10752277b3.11;
        Thu, 14 Jul 2022 02:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eoEUqCQ0HzWcRS/EEisE9qpbq5xcTJ7+l4FqGraIDiM=;
        b=Ld+ADuIcLOILCqHSVmutQbx0yNCzFYK+d1CfgjosNRjzv4la0za1LrNxPVbXKyGrBU
         plEeNvs9LuKtBpdK2m8TdIf5+YpouBnaZ9Vsy9DWCZQPgh7oBlkDpas1TKNSR2vAuZ/m
         ORq+hpDzjNbMh57lvUku8daA4iIIz1ZvXj/KjuJUO8f4GYx3HxMDS3SJKg0sxPO5bA1n
         KdTdyIG7yt7UXNPxNXnsFgVEMla/Hw7WsDWj9pGpxJIEBu4dM2YsIkBZZHbP1tv7Iw1s
         /UceXFWGcqnbfJelCGnMi9F2w99ZJ8EasltdyIOX+aD94fVjhuHVUAYCDxWNBrPm1xlZ
         NyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eoEUqCQ0HzWcRS/EEisE9qpbq5xcTJ7+l4FqGraIDiM=;
        b=E4tvnZILOXCcRDzTvq7MkhVAeunrJYCn7/BCiAjX3twkqYrczkm7nwD/MzgagOv4VY
         wyLIbtIebU8BMG0vP9au76ByBj5i4J6pNx0y+aiKOk2H1LM4YOWqKNYv12WF+97pOgtO
         zdBK7d4kbHke0DviCwLC5p1oJluSENyZazKdt6l45qSDGpbM6W6pPPx0wcRSjEhhGSuF
         JUyd8W4pZNXrh3rkTYhzGw4BifxUw1pqzuwHgu+wAQQF1VUGTV/31i6FT1yKq5yBdEfc
         I60wxm8XjdzUr5hkIuv0eGEa6qOLAxt6TEnD6h/cMXZNZcUaad3AVYIE66Hf2gV7sjrd
         JM5A==
X-Gm-Message-State: AJIora+W4OO7HknhU7CFgQWzvIiFWG6i7HJWfFCYB1OFvfBOCXUeYFIf
        lduDnzWFV5B4tUJypqeSRtwqPVGUfmwvtLJ5Do0=
X-Google-Smtp-Source: AGRyM1vfgn4gESJkQheSbCNETjn+vwZk7ww5qzlDRalqVBynMRD8SYo6G8iLMHpByXaVRHoDkU+ZiCki5RU9ApOFE6k=
X-Received: by 2002:a81:72c4:0:b0:31c:b309:c4e8 with SMTP id
 n187-20020a8172c4000000b0031cb309c4e8mr8841348ywc.520.1657790864413; Thu, 14
 Jul 2022 02:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220704053901.728-1-peterwu.pub@gmail.com> <20220704053901.728-14-peterwu.pub@gmail.com>
 <CAHp75VdwEc9AW1w8ejsxkw+sBTF1dumd99QyzTY9BZaXiViRWQ@mail.gmail.com>
 <CABtFH5K-2+2hbpvpq2nPE5AsznkQxZF2r3MVC64Q39DJhVuUtA@mail.gmail.com>
 <CAHp75VevDwdAKLYEWJgnMDvzuPuFibLuVqH-GKazEOT76wM6_A@mail.gmail.com> <CABtFH5LT1Ct_9-B_XRrGwYFmL5kGS6KHR7dNVyUO5z4sTy_6oA@mail.gmail.com>
In-Reply-To: <CABtFH5LT1Ct_9-B_XRrGwYFmL5kGS6KHR7dNVyUO5z4sTy_6oA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Jul 2022 11:27:07 +0200
Message-ID: <CAHp75VcU_9Ao2CoqiUDZHqhVOjEMZor+hctPp3YYP4HOjYLDUg@mail.gmail.com>
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

On Thu, Jul 14, 2022 at 9:13 AM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=
=9C=8813=E6=97=A5 =E9=80=B1=E4=B8=89 =E6=99=9A=E4=B8=8A8:07=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > On Wed, Jul 13, 2022 at 12:53 PM ChiaEn Wu <peterwu.pub@gmail.com> wrot=
e:
> > > Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B47=
=E6=9C=885=E6=97=A5 =E9=80=B1=E4=BA=8C =E6=B8=85=E6=99=A85:14=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > > On Mon, Jul 4, 2022 at 7:43 AM ChiaEn Wu <peterwu.pub@gmail.com> wr=
ote:

Please, once again, remove unneeded context when replying!
^^^^^^^

...

> > > > > +               prop_val =3D (ilog2(roundup_pow_of_two(prop_val))=
 + 1) >> 1;
> > > >
> > > > Isn't something closer to get_order() or fls()?
> > >
> > > I will revise it to "(get_order(prop_va * PAGE_SIZE) + 1) / 2" and
> > > this change is meet your expectations??
> >
> > Nope. Try again. What about fls()?
>
> I have tried two methods so far, as follows
> -------------------------------------------------------------
> /*
>  * prop_val =3D  1      -->  1 steps --> b'00
>  * prop_val =3D  2 ~  4 -->  4 steps --> b'01
>  * prop_val =3D  5 ~ 16 --> 16 steps --> b'10
>  * prop_val =3D 17 ~ 64 --> 64 steps --> b'11
> */

So, for 1 --> 0, for 2 --> 1, for 5 --> 2, and for 17 --> 3.
Now, consider x - 1:
0  ( 0 ) --> 0
1  (2^0) --> 1
4  (2^2) --> 2
16 (2^4) --> 3
64 (2^6) --> ? (but let's consider that the range has been checked already)

Since we take the lower limit, it means ffs():

  y =3D (ffs(x - 1) + 1) / 2;

Does it work for you?

> // 1. use fls() and ffs() combination
> prop_val =3D ffs(prop_val) =3D=3D fls(prop_val) ? fls(prop_val) >> 1 :
> (fls(prop_val) + 1) >> 1;
>
> // 2. use one line for-loop, but without fls()
> for (i =3D --prop_val, prop_val =3D 0; i >> 2 * prop_val !=3D 0; prop_val=
++);
> -------------------------------------------------------------
> Do these changes meet your expectations??

No, this is ugly. Yes, I understand that a bit arithmetics is hard...

--=20
With Best Regards,
Andy Shevchenko
