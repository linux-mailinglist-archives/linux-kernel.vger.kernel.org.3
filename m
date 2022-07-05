Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776D25661A7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 05:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbiGEDE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 23:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbiGEDE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 23:04:26 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB326320;
        Mon,  4 Jul 2022 20:04:24 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id c131-20020a1c3589000000b003a19b2bce36so3336833wma.4;
        Mon, 04 Jul 2022 20:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3gfi97VHXQb0hMDVP7dcd95DDAEKDXbwTKBuUKLqi60=;
        b=Jgh6KCsgQsACc+qZQEMqT5beQSjfxF85SYh3mL2w0cOVjpaHYmxNNng2N4AH61f0tD
         I5n88B7r9Ygq+dgAQbzVNpvEMSuzQX+ugy0ic22s0zLkbjydDzN0hfPf4TVyINylHCZ2
         oymKiIxdxo6SZHN3sEjzixDp3jgHW2en3opeaWKf2hus5JcR9obMDXbGAuAt5rSAXoeJ
         NRrOYR7+RtnWr1hUem1RBMRwSNInYxYDxr5cfOsOJ6IrAtoHGGfp8PI1VsUqRRhsRlsv
         6rnCwLr40dugZLwFSg1xIb7DXKf86k32n5i8diYP51j8XYI/yoWJX+etZXS4C/bmWfZp
         /3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3gfi97VHXQb0hMDVP7dcd95DDAEKDXbwTKBuUKLqi60=;
        b=f84pGFeOxYHta/dPERQMrG4a6bp1sqlMkbrtZSDroCfbdFc3fzcX0QBIoB4bBp24Z8
         ZCZYlViJGT+1CZYR+eyneigkhuvUJUOMMc4ClT+BNoVawe8P6eMp60NvNSlfCamT0QOP
         /AFiH9f/rmdyPiGZGVhWnCA+JBU/Xffo4eaz026wWszXvK4BhvTO4pBRJsFnK/Mb42Cf
         TwaAqpngDoBrTr9Bfp/P60rwnD0W+Aaf/r+Vkr1cSapBlh6sJff6WdLIIVMaifWsL+M8
         0nOdKjAZQ9PS8IDOM7qHQRXmlKyDsUvzdqjv3TLqBbTTbRo3whpdOJruFsWVByQSdvxk
         6UsQ==
X-Gm-Message-State: AJIora+y4tzOTALvX3UN4KugFFdf5hSaOgVc6TRkeHpM/ks8RZVxNd62
        Dm8kpCQPW8kjD4xeRQikJ94eVTHy3vCrK1exGh0=
X-Google-Smtp-Source: AGRyM1sFysQU+edwnCpgY0UOTiPGUc1GvI7vdqTIMVrbELfisFfweSHNxugMoBgRI9JA97EEsrgrcpeSb3mVSUSkTTw=
X-Received: by 2002:a05:600c:3505:b0:3a1:9fbb:4d59 with SMTP id
 h5-20020a05600c350500b003a19fbb4d59mr10845852wmq.165.1656990262850; Mon, 04
 Jul 2022 20:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <1655892104-10874-1-git-send-email-u0084500@gmail.com>
 <1655892104-10874-3-git-send-email-u0084500@gmail.com> <Yrm9ObaltUiQUTqS@google.com>
 <CADiBU3802sLTPjrGiaQ-xw-2jep1UXo+t7pYc6bCC4MiJLhOyA@mail.gmail.com>
 <CADiBU3838Mgi3sqv+R_=8g-ROTrbN45AKPaTS_9GCWVDYASMyg@mail.gmail.com>
 <Yr6kVg2OlHkm6+bB@google.com> <CADiBU396poOuzdGABzTazouM5MX=auZ9OdyT_sqWrKnZk3tFRw@mail.gmail.com>
 <CADiBU3_7MmPkfV7-B8rhxFRtZcrJ6BPocXzT4bs3cu36UR5XGw@mail.gmail.com> <YsK44Dp3yZwqPi0H@google.com>
In-Reply-To: <YsK44Dp3yZwqPi0H@google.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 5 Jul 2022 11:04:10 +0800
Message-ID: <CADiBU38M=iTJnsV0_pmQnyjuw_hXrzGLb3pDpSEZ05=eY2iC=Q@mail.gmail.com>
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

Lee Jones <lee.jones@linaro.org> =E6=96=BC 2022=E5=B9=B47=E6=9C=884=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=885:54=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, 04 Jul 2022, ChiYuan Huang wrote:
>
> > Hi, Lee:
> >
> > ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=9C=881=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:56=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > Lee Jones <lee.jones@linaro.org> =E6=96=BC 2022=E5=B9=B47=E6=9C=881=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:38=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > > >
> > > > On Fri, 01 Jul 2022, ChiYuan Huang wrote:
> > > >
> > > > > HI, Lee:
> > > > >
> > > > > ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2022=E5=B9=B46=E6=9C=
=8827=E6=97=A5 =E9=80=B1=E4=B8=80 =E6=99=9A=E4=B8=8A10:56=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > > > >
> > > > > > Lee Jones <lee.jones@linaro.org> =E6=96=BC 2022=E5=B9=B46=E6=9C=
=8827=E6=97=A5 =E9=80=B1=E4=B8=80 =E6=99=9A=E4=B8=8A10:22=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > > > > >
> > > > > > > On Wed, 22 Jun 2022, cy_huang wrote:
> > > > > > >
> > > > > > > > From: ChiYuan Huang <cy_huang@richtek.com>
> > > > > > > >
> > > > > > > > Add Richtek RT5120 PMIC I2C driver.
> > > > > > >
> > > > > > > Why a whole new driver?
> > > > > > >
> > > > > > > How different is this to rt5033?
> > > > > > >
> > > > > > > Looks like this could easily be woven into this existing supp=
ort?
> > > > > > >
> > > > > > It's different with the function domain.
> > > > > > RT5033 is most like as the SubPMIC that includes PMU (battery
> > > > > > charger/gauge/led/few buck and ldo)
> > > > > > RT5120 is a main PMIC with default-on power that follows the bo=
ot on sequence.
> > > > > > RT5120 only integrates regulator and power key report module.
> > > > > >
> > > > > Since I have explained the chip difference, do you still think it=
's
> > > > > better to merge this code into rt5033 mfd?
> > > >
> > > > I think it's okay to group devices which are similar but not exactl=
y
> > > > the same, if they can be.  The integration of this device into the
> > > > other looks trivial to my naive eyes.
> > > >
> > > > A PMIC is a PMIC, main or sub.
> > > >
> > > M.. ok. I will try to group all chip changes like as devices
> > > list/regmap_irq/regmap_config ..., etc.
> > > Treat it as one set of chip config and use 'of_device_get_match_data'
> > > to get the chip config data.
> > >
> > There's a question.
> > As I know, it's not the same chip series.
> > The rt5033 is submitted from Samsung at 2015.
> > The driver data is also defined in header file.
> >
> > Do you still suggest to do the merge?
> > Even in our internal, it's difficult to find a rt5033 EVB for testing.
> >
> > And one more question is the binding. If yes, for the binding, I need t=
o add
> > rt5033 related.....
> >
> > Actually, it's a tough work.
>
> If it's genuinely difficult to integrate, you can keep them separate.
>
Keep it in this patch series and wait for your reviewing.
Hope that I'm not misunderstanding.
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Principal Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
