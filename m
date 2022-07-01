Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4634C5630C7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiGAJ4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiGAJ4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:56:17 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2427C74DCB;
        Fri,  1 Jul 2022 02:56:16 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c13so2251541eds.10;
        Fri, 01 Jul 2022 02:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bSK5YfoZwCXwkULWVh7uTnuiTWCdHyPzN8Uo8aQIwuI=;
        b=MpnRS2WGAMXjw/f5eFw/cm1ESr3K0ONH/W6phu40t7UzRPIj72paEcOT9BFX0KaUw8
         o4+D/EikvH8VgljOXcuw7mnIHrz1ZIfMAaAVVqFu7TUp2DicnPoDD01GqxQtt3IMM/8F
         XbdR7fvH6ATs24+5X6S4BOuu7LnHmmthGOc13pSgJO1LltGUur/IL7z379JcfWj2cKeQ
         64sGtGpBf4PqtFYuEjnoSHar2ZvZJlscF4W86NZ2qdLqyS2p/5OeWqqEfPNv2fySoRPc
         yuYYXgH0tJPSdpjzDcxIIr6Z7GH8RLSNnbgxhfaYq00oI00z8CTz+ECyeAplYFRjPFMC
         qHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bSK5YfoZwCXwkULWVh7uTnuiTWCdHyPzN8Uo8aQIwuI=;
        b=k77aIRv3xaUpKJkZ0u95XMOlaiWGXzHPynSyGQpYKuIIbEwYlMyZQ9CnN4Ifc9ajaX
         6gO4ysnD7GnePYvhvIl+/9+eEeDvUlZn64PSHMWJPRQMoT01v8aCTr3/ymtCb5JFp7OE
         qBp2koEJIPnCpicTawwfVbTgobdCAsDKJdAkfCwwuxPMDNz+2/5hefrhEG410pOG6rni
         dP4q4oSrKZnQxh93gxWUC9ZVx9RFgmoF3och73V+dET5zu/XN235M8sPWpB1TuUvs1xl
         iXNgHsSTh4vHnjMh5klKCwt0j5q5XOz+Blf7lcNh/VvmC/fg7vGLoRUpn377fHPsQd6p
         RFZg==
X-Gm-Message-State: AJIora9eAvT8TeOPgWKHmK/NayF1QNJYDhU4XvfG8rCes4MWjzThKEDf
        kBR7KywfUS0Z9C0TZqo4AKSSoHgLKFDtvFruHjyzrlWMomc=
X-Google-Smtp-Source: AGRyM1sTIw3tTlyImwoh4qrwr7WEcgMjJ4bbk9FzKTMVaiOUyz3jY8oWaEk+SYYD/6k+RQraBRzcw8oVEJ0ES5Ghc4Q=
X-Received: by 2002:a05:6402:358c:b0:435:9daf:e825 with SMTP id
 y12-20020a056402358c00b004359dafe825mr17697800edc.375.1656669374541; Fri, 01
 Jul 2022 02:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <1655892104-10874-1-git-send-email-u0084500@gmail.com>
 <1655892104-10874-3-git-send-email-u0084500@gmail.com> <Yrm9ObaltUiQUTqS@google.com>
 <CADiBU3802sLTPjrGiaQ-xw-2jep1UXo+t7pYc6bCC4MiJLhOyA@mail.gmail.com>
 <CADiBU3838Mgi3sqv+R_=8g-ROTrbN45AKPaTS_9GCWVDYASMyg@mail.gmail.com> <Yr6kVg2OlHkm6+bB@google.com>
In-Reply-To: <Yr6kVg2OlHkm6+bB@google.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Fri, 1 Jul 2022 17:56:02 +0800
Message-ID: <CADiBU396poOuzdGABzTazouM5MX=auZ9OdyT_sqWrKnZk3tFRw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mfd: rt5120: Add Richtek PMIC support
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>, dmitry.torokhov@gmail.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones <lee.jones@linaro.org> =E6=96=BC 2022=E5=B9=B47=E6=9C=881=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:38=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, 01 Jul 2022, ChiYuan Huang wrote:
>
> > HI, Lee:
> >
> > ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2022=E5=B9=B46=E6=9C=8827=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E6=99=9A=E4=B8=8A10:56=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > >
> > > Lee Jones <lee.jones@linaro.org> =E6=96=BC 2022=E5=B9=B46=E6=9C=8827=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E6=99=9A=E4=B8=8A10:22=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > > >
> > > > On Wed, 22 Jun 2022, cy_huang wrote:
> > > >
> > > > > From: ChiYuan Huang <cy_huang@richtek.com>
> > > > >
> > > > > Add Richtek RT5120 PMIC I2C driver.
> > > >
> > > > Why a whole new driver?
> > > >
> > > > How different is this to rt5033?
> > > >
> > > > Looks like this could easily be woven into this existing support?
> > > >
> > > It's different with the function domain.
> > > RT5033 is most like as the SubPMIC that includes PMU (battery
> > > charger/gauge/led/few buck and ldo)
> > > RT5120 is a main PMIC with default-on power that follows the boot on =
sequence.
> > > RT5120 only integrates regulator and power key report module.
> > >
> > Since I have explained the chip difference, do you still think it's
> > better to merge this code into rt5033 mfd?
>
> I think it's okay to group devices which are similar but not exactly
> the same, if they can be.  The integration of this device into the
> other looks trivial to my naive eyes.
>
> A PMIC is a PMIC, main or sub.
>
M.. ok. I will try to group all chip changes like as devices
list/regmap_irq/regmap_config ..., etc.
Treat it as one set of chip config and use 'of_device_get_match_data'
to get the chip config data.

> > > > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > > > ---
> > > > >  drivers/mfd/Kconfig  |  12 +++++
> > > > >  drivers/mfd/Makefile |   1 +
> > > > >  drivers/mfd/rt5120.c | 125 +++++++++++++++++++++++++++++++++++++=
++++++++++++++
> > > > >  3 files changed, 138 insertions(+)
> > > > >  create mode 100644 drivers/mfd/rt5120.c
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Principal Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
