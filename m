Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17D84DAADA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 07:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353972AbiCPGt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 02:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353971AbiCPGty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 02:49:54 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5EF61A26;
        Tue, 15 Mar 2022 23:48:41 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id j5so1157779qvs.13;
        Tue, 15 Mar 2022 23:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wv4xOcohgxB2rcpOadFZd1tb06qySnmM9ccCl9Yyqj4=;
        b=nYe5TEmYh6niKxfONifnKGvIcSQmOtaJ8Z4VCnu2YMF7avZMly8S9Ps/A5lKZfLKl9
         hGld75lrU1HFwdrRlyjxz2zP31IjDw9DC0IjN4k7fiUWDm5DxbTN8sB7U/xbTEoeJGMG
         Ig1kCTIhGsgzAFDPi+q20fMzggc5s81o8zxPN+D1fSJSPj4hV/nXB3dKMIdS9myG7jQE
         o3hFf2C56vXtzFDRaYkD2C7HXH4pYoCLpNBLWKPErt061ejNIf5BdhL37yDkiO/OvRaU
         qVA661KzN6V+LHrsGVK4MrQPgMAg+uBLNdyETJnTeYd4AeNt4qO4OAq1U7FK/3ukVWKk
         56rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wv4xOcohgxB2rcpOadFZd1tb06qySnmM9ccCl9Yyqj4=;
        b=xzmr7cf5fPtdddnT4u1m9Bu1e5dQX3/GzibswLDRTU9t4CUkVP7HA5o6XuKLv3San6
         /5G7c7Wx5erZ8q3Z1lVbXAmBQqthh8StY0woCw6A9ggLbuaAyQnLoivLxRtCxF/4HW8l
         Us3roRQ+Ccx3G1/PqfPH/rx5o/BSZYIQ7q3m5s3H2zrC27xUWV51BXyX0WSORRYgce0U
         9tt9YW34AlyFyJ+5NpTyZ4X0ehsWV3ETK1kLykD+ydOqY/oQAvpio4C61tXMQDcLGrOa
         twtyC8p/TDxbye7J6BUR8vN1TRAHaTdSX4BK1hbfe4IMJdVaD7zIIFNrr4o2n1Hkks9N
         KAuw==
X-Gm-Message-State: AOAM532Tmqtiuvgho3S4m7HCgIIdVVhzAPmRyX/fhYJ0xoSaVMcxzh5i
        xa+ZKEklU9pmG4564B+1ygMAAYTBd1Q5qXn13RU=
X-Google-Smtp-Source: ABdhPJypIDVtIyhHXcLq0gpsbUGLh0QGS3aZkhQ+YGRXFTWVv3K2b8PNbmEyPrSfZucfIhxMEwopbRaH0uk6cw7scq0=
X-Received: by 2002:a0c:e781:0:b0:42c:4e4f:a6db with SMTP id
 x1-20020a0ce781000000b0042c4e4fa6dbmr23382485qvn.107.1647413320521; Tue, 15
 Mar 2022 23:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220315160149.3617-1-arinc.unal@arinc9.com> <20220315173204.GA14220@alpha.franken.de>
In-Reply-To: <20220315173204.GA14220@alpha.franken.de>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 16 Mar 2022 07:48:29 +0100
Message-ID: <CAMhs-H-+TF5HEzWsCsou2Wa9cSzgSVhHW6aHiXa=8mEe+rTbxQ@mail.gmail.com>
Subject: Re: [PATCH v2] mips: dts: ralink: add MT7621 SoC
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, NeilBrown <neil@brown.name>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        erkin.bozoglu@xeront.com, linux-staging@lists.linux.dev,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Tue, Mar 15, 2022 at 6:32 PM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> On Tue, Mar 15, 2022 at 07:01:50PM +0300, Ar=C4=B1n=C3=A7 =C3=9CNAL wrote=
:
> > The MT7621 system-on-a-chip includes an 880 MHz MIPS1004Kc dual-core CP=
U,
> > a 5-port 10/100/1000 switch/PHY and one RGMII.
> >
> > Add the devicetrees for GB-PC1 and GB-PC2 devices which use MT7621 SoC.
> >
> > Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> > Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> > v2: fix a tiny grammar mistake, add Sergio's acked-by.
> >
> > This patch does changes on top of commit dcd520af4eac ("staging:
> > mt7621-dts: fix cpuintc and fixedregulator dtc warnings, fix xhci") whi=
ch
> > is currently applied on gregkh/staging.git staging-next branch.
> >
> > ---
> >  MAINTAINERS                                           |  7 +++++++
> >  arch/mips/boot/dts/ralink/Makefile                    |  4 ++++
> >  .../mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts     |  0
> >  .../mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts     |  0
> >  .../mips/boot/dts/ralink}/mt7621.dtsi                 |  0
> >  arch/mips/ralink/Kconfig                              |  5 +++++
> >  drivers/staging/Kconfig                               |  2 --
> >  drivers/staging/Makefile                              |  1 -
> >  drivers/staging/mt7621-dts/Kconfig                    | 11 -----------
> >  drivers/staging/mt7621-dts/Makefile                   |  5 -----
> >  drivers/staging/mt7621-dts/TODO                       |  5 -----
> >  11 files changed, 16 insertions(+), 24 deletions(-)
> >  rename drivers/staging/mt7621-dts/gbpc1.dts =3D> arch/mips/boot/dts/ra=
link/mt7621-gnubee-gb-pc1.dts (100%)
> >  rename drivers/staging/mt7621-dts/gbpc2.dts =3D> arch/mips/boot/dts/ra=
link/mt7621-gnubee-gb-pc2.dts (100%)
> >  rename {drivers/staging/mt7621-dts =3D> arch/mips/boot/dts/ralink}/mt7=
621.dtsi (100%)
> >  delete mode 100644 drivers/staging/mt7621-dts/Kconfig
> >  delete mode 100644 drivers/staging/mt7621-dts/Makefile
> >  delete mode 100644 drivers/staging/mt7621-dts/TODO
>
> Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thanks, Thomas!!

Best regards,
    Sergio Paracuellos
>
> --
> Crap can work. Given enough thrust pigs will fly, but it's not necessaril=
y a
> good idea.                                                [ RFC1925, 2.3 =
]
