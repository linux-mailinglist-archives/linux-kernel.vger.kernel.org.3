Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4133A56508D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiGDJPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiGDJO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:14:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03770BC3E;
        Mon,  4 Jul 2022 02:14:55 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id s1so12501804wra.9;
        Mon, 04 Jul 2022 02:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Yc4lYWwzEOzXTvm8qWxOUdmsNeEUzr98rKILhdcSP3c=;
        b=dADAT3F3oDXchB4cPDwVEhVt7H1zHQeWzAfcL5bsqsLXd3HMdhmFnAEoEuazs3GIel
         puP2n4cAPXgfL2o0tRZKrrOl4sCUKYCcaD9P/ZYlCPg3hjgl1LUpy9YvB/LAnJjOfa7O
         R5gVtbMFH4a0o1hdDmi4oGD+zlHrXz5tuQFaAcpzNp70PBXhrbv/QxjOAvk+a49tZxzC
         8R1XI9ZqcfsFAn45/oNvC7mt+FiPrKkzulEyPIixkYX+Dx73udeAV1aARwYyuATbDjp0
         POBaxrFiMzf+Llzy6/qayqbe5cj5ZeyiEiGzCzp8kxVUylAnG2IB7pQhy2p3iziec3YZ
         +1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Yc4lYWwzEOzXTvm8qWxOUdmsNeEUzr98rKILhdcSP3c=;
        b=zzXkDRZj9HHfpDbEsjvtBw2oguiqlXsrOC/5Aq7yYfxizClbqIDUiB7S/mxO1Ar1wj
         HOZ8nhFC/44NsgXnrbVOwQB3LM0k0JrsXhckpG2DGnsjw/ywHMWno/ki0OpJ333K2GJd
         I4MR9AAxljIjiv+iY8MmvU0oIhJThKxsueckN4o3esifc3a2yCI9yS+skDyMU9RmigW4
         ZRLQR5ed4TIpDO6KZWwtGyA1lPphGXIrRejJ8vHpEtqGFnpze3pxi+C3/4TVIZ4NEJDT
         rl2qm8fCRUo24snqncbRMskWKIqq+RnJ2gyxbxSBdhfPQjQtLsKw9OFTw9pfHyZh7ru/
         r9/Q==
X-Gm-Message-State: AJIora9796VwwxjONgcyREo7UJmZh08WACHUf+CF64xPn646+BM21sOW
        CkOrkrIb+2ceXcrkvuoXsmhDPb/YuvLNGrVB6hk=
X-Google-Smtp-Source: AGRyM1vCPUyNA+nFhTXDc7wYqahvznxwTVhF4YLMHCSyKk2h1OxUqgzQyfDddA7JfsLDA7eO5RGZ9wqjioeMB2GTZJs=
X-Received: by 2002:adf:f043:0:b0:21d:6a90:f3e6 with SMTP id
 t3-20020adff043000000b0021d6a90f3e6mr3711342wro.277.1656926093427; Mon, 04
 Jul 2022 02:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <1655892104-10874-1-git-send-email-u0084500@gmail.com>
 <1655892104-10874-3-git-send-email-u0084500@gmail.com> <Yrm9ObaltUiQUTqS@google.com>
 <CADiBU3802sLTPjrGiaQ-xw-2jep1UXo+t7pYc6bCC4MiJLhOyA@mail.gmail.com>
 <CADiBU3838Mgi3sqv+R_=8g-ROTrbN45AKPaTS_9GCWVDYASMyg@mail.gmail.com>
 <Yr6kVg2OlHkm6+bB@google.com> <CADiBU396poOuzdGABzTazouM5MX=auZ9OdyT_sqWrKnZk3tFRw@mail.gmail.com>
In-Reply-To: <CADiBU396poOuzdGABzTazouM5MX=auZ9OdyT_sqWrKnZk3tFRw@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Mon, 4 Jul 2022 17:14:41 +0800
Message-ID: <CADiBU3_7MmPkfV7-B8rhxFRtZcrJ6BPocXzT4bs3cu36UR5XGw@mail.gmail.com>
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

Hi, Lee:

ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=9C=881=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:56=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Lee Jones <lee.jones@linaro.org> =E6=96=BC 2022=E5=B9=B47=E6=9C=881=E6=97=
=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:38=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Fri, 01 Jul 2022, ChiYuan Huang wrote:
> >
> > > HI, Lee:
> > >
> > > ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2022=E5=B9=B46=E6=9C=882=
7=E6=97=A5 =E9=80=B1=E4=B8=80 =E6=99=9A=E4=B8=8A10:56=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > > >
> > > > Lee Jones <lee.jones@linaro.org> =E6=96=BC 2022=E5=B9=B46=E6=9C=882=
7=E6=97=A5 =E9=80=B1=E4=B8=80 =E6=99=9A=E4=B8=8A10:22=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > > > >
> > > > > On Wed, 22 Jun 2022, cy_huang wrote:
> > > > >
> > > > > > From: ChiYuan Huang <cy_huang@richtek.com>
> > > > > >
> > > > > > Add Richtek RT5120 PMIC I2C driver.
> > > > >
> > > > > Why a whole new driver?
> > > > >
> > > > > How different is this to rt5033?
> > > > >
> > > > > Looks like this could easily be woven into this existing support?
> > > > >
> > > > It's different with the function domain.
> > > > RT5033 is most like as the SubPMIC that includes PMU (battery
> > > > charger/gauge/led/few buck and ldo)
> > > > RT5120 is a main PMIC with default-on power that follows the boot o=
n sequence.
> > > > RT5120 only integrates regulator and power key report module.
> > > >
> > > Since I have explained the chip difference, do you still think it's
> > > better to merge this code into rt5033 mfd?
> >
> > I think it's okay to group devices which are similar but not exactly
> > the same, if they can be.  The integration of this device into the
> > other looks trivial to my naive eyes.
> >
> > A PMIC is a PMIC, main or sub.
> >
> M.. ok. I will try to group all chip changes like as devices
> list/regmap_irq/regmap_config ..., etc.
> Treat it as one set of chip config and use 'of_device_get_match_data'
> to get the chip config data.
>
There's a question.
As I know, it's not the same chip series.
The rt5033 is submitted from Samsung at 2015.
The driver data is also defined in header file.

Do you still suggest to do the merge?
Even in our internal, it's difficult to find a rt5033 EVB for testing.

And one more question is the binding. If yes, for the binding, I need to ad=
d
rt5033 related.....

Actually, it's a tough work.
> > > > > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > > > > ---
> > > > > >  drivers/mfd/Kconfig  |  12 +++++
> > > > > >  drivers/mfd/Makefile |   1 +
> > > > > >  drivers/mfd/rt5120.c | 125 +++++++++++++++++++++++++++++++++++=
++++++++++++++++
> > > > > >  3 files changed, 138 insertions(+)
> > > > > >  create mode 100644 drivers/mfd/rt5120.c
> >
> > --
> > Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> > Principal Technical Lead - Developer Services
> > Linaro.org =E2=94=82 Open source software for Arm SoCs
> > Follow Linaro: Facebook | Twitter | Blog
