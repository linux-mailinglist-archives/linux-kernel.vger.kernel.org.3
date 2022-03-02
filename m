Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695874CB290
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiCBWvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiCBWvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:51:06 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7029863BC0;
        Wed,  2 Mar 2022 14:50:12 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id bt3so3140090qtb.0;
        Wed, 02 Mar 2022 14:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w/QeTGizctCe/lCvmDH1b/DvToPpxOQCqRpfxZuWv28=;
        b=afkxXKmP4vgQGD2EE5HprQH2X5UgEcVUkXVmApWi5dntSCUUp3EaVbVDV9STJR8z59
         D5N0AieGgMKi3GyCkx2a8Ks2SsJ67PPkisdxWEQAXzqTvkVEz8JUwswyS6Dg/86N3JoF
         88bjGJMQTFVAibzkb8Gj7zZaqx9EHHkREazbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w/QeTGizctCe/lCvmDH1b/DvToPpxOQCqRpfxZuWv28=;
        b=X4aDWNzTC7Tx6oMlflXU/ad0daBAuiOKHqDssZgeGz1o2+2kEIl2WZbBOpry+346o0
         bwyFPW/7x+hlAwtzhUKDzv0oIiUdOfS+A71+fLZxTHFNIj+m7QjNs9lVXR23h6JAAQD1
         mMcxEeZTtPtJPBfznYABF3+YSZVD+USabRdYOtC15i3BdeLKseefewPzggmiuTYv00WE
         osPnA1cLMxTKTPaZM7fwFQ0ceRq9GGBm64juE3zY4I83puJJlcAmGP7sHZjQqoAppXpn
         3Hk/txKOwIyKIJRPx5VvEVW/o2MG3H7wHDtketKbKkS83yNdL/dT19yhCrA5+JJDzkne
         FLcw==
X-Gm-Message-State: AOAM533xZcBvdCaKa9mI5mFTQLwtwVBmC4R//n6zvT3aP8vfvMiZPVKn
        W4Ss2SctRcpSWOQNWRdnP6M/fLWbzrVNwzsvzOM=
X-Google-Smtp-Source: ABdhPJwcRIUuSCOa0NIMdNnY7uIfvSl3sBRNTtNc09Jy3EHvdAiMXNhsdMI3cg/+3wWITyoi069ULAwsRr28IETf5DQ=
X-Received: by 2002:ac8:5b82:0:b0:2cf:232d:b1f8 with SMTP id
 a2-20020ac85b82000000b002cf232db1f8mr25803033qta.58.1646261351104; Wed, 02
 Mar 2022 14:49:11 -0800 (PST)
MIME-Version: 1.0
References: <20220302173114.927476-1-clg@kaod.org> <20220302173114.927476-11-clg@kaod.org>
 <CACPK8XeDBCMCEO4=w7qUQxsYiFUDKPAuBhXW5Sr6=UHM_GRsWA@mail.gmail.com>
In-Reply-To: <CACPK8XeDBCMCEO4=w7qUQxsYiFUDKPAuBhXW5Sr6=UHM_GRsWA@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 2 Mar 2022 22:48:58 +0000
Message-ID: <CACPK8Xd6VJLuWsvSjYrQ-y=yS+yR7vjdWECfsd2W9_J7e09K-A@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] ARM: dts: aspeed: Enable Dual SPI RX transfers
To:     =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc:     linux-spi@vger.kernel.org,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 at 22:45, Joel Stanley <joel@jms.id.au> wrote:
>
> On Wed, 2 Mar 2022 at 17:31, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >
> > All these controllers support at least Dual SPI. Update the DTs.
> >
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>
> Thanks. I'll apply this to the aspeed tree now.
>
> Did you also have a patch to add a second flash chip to the AST2400 FMC?

That was a reference to the discussion on the openbmc list with Tao. I
was mistaken; the flash chips are there, but they lack the
spi-max-frequency property.

>
> > ---
> >  arch/arm/boot/dts/aspeed-g4.dtsi | 6 ++++++
> >  arch/arm/boot/dts/aspeed-g5.dtsi | 7 +++++++
> >  arch/arm/boot/dts/aspeed-g6.dtsi | 8 ++++++++
> >  3 files changed, 21 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspee=
d-g4.dtsi
> > index 9ae67e83cf60..31e6569db97e 100644
> > --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> > +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> > @@ -64,27 +64,32 @@ fmc: spi@1e620000 {
> >                         flash@0 {
> >                                 reg =3D < 0 >;
> >                                 compatible =3D "jedec,spi-nor";
> > +                               spi-rx-bus-width =3D <2>;
> >                                 spi-max-frequency =3D <50000000>;
> >                                 status =3D "disabled";
> >                         };
> >                         flash@1 {
> >                                 reg =3D < 1 >;
> >                                 compatible =3D "jedec,spi-nor";
> > +                               spi-rx-bus-width =3D <2>;
> >                                 status =3D "disabled";
> >                         };
> >                         flash@2 {
> >                                 reg =3D < 2 >;
> >                                 compatible =3D "jedec,spi-nor";
> > +                               spi-rx-bus-width =3D <2>;
> >                                 status =3D "disabled";
> >                         };
> >                         flash@3 {
> >                                 reg =3D < 3 >;
> >                                 compatible =3D "jedec,spi-nor";
> > +                               spi-rx-bus-width =3D <2>;
> >                                 status =3D "disabled";
> >                         };
> >                         flash@4 {
> >                                 reg =3D < 4 >;
> >                                 compatible =3D "jedec,spi-nor";
> > +                               spi-rx-bus-width =3D <2>;
> >                                 status =3D "disabled";
> >                         };
> >                 };
> > @@ -100,6 +105,7 @@ flash@0 {
> >                                 reg =3D < 0 >;
> >                                 compatible =3D "jedec,spi-nor";
> >                                 spi-max-frequency =3D <50000000>;
> > +                               spi-rx-bus-width =3D <2>;
> >                                 status =3D "disabled";
> >                         };
> >                 };
> > diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspee=
d-g5.dtsi
> > index c3e0a8e13c8a..29bf017899b6 100644
> > --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> > +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> > @@ -66,18 +66,21 @@ flash@0 {
> >                                 reg =3D < 0 >;
> >                                 compatible =3D "jedec,spi-nor";
> >                                 spi-max-frequency =3D <50000000>;
> > +                               spi-rx-bus-width =3D <2>;
> >                                 status =3D "disabled";
> >                         };
> >                         flash@1 {
> >                                 reg =3D < 1 >;
> >                                 compatible =3D "jedec,spi-nor";
> >                                 spi-max-frequency =3D <50000000>;
> > +                               spi-rx-bus-width =3D <2>;
> >                                 status =3D "disabled";
> >                         };
> >                         flash@2 {
> >                                 reg =3D < 2 >;
> >                                 compatible =3D "jedec,spi-nor";
> >                                 spi-max-frequency =3D <50000000>;
> > +                               spi-rx-bus-width =3D <2>;
> >                                 status =3D "disabled";
> >                         };
> >                 };
> > @@ -93,12 +96,14 @@ flash@0 {
> >                                 reg =3D < 0 >;
> >                                 compatible =3D "jedec,spi-nor";
> >                                 spi-max-frequency =3D <50000000>;
> > +                               spi-rx-bus-width =3D <2>;
> >                                 status =3D "disabled";
> >                         };
> >                         flash@1 {
> >                                 reg =3D < 1 >;
> >                                 compatible =3D "jedec,spi-nor";
> >                                 spi-max-frequency =3D <50000000>;
> > +                               spi-rx-bus-width =3D <2>;
> >                                 status =3D "disabled";
> >                         };
> >                 };
> > @@ -114,12 +119,14 @@ flash@0 {
> >                                 reg =3D < 0 >;
> >                                 compatible =3D "jedec,spi-nor";
> >                                 spi-max-frequency =3D <50000000>;
> > +                               spi-rx-bus-width =3D <2>;
> >                                 status =3D "disabled";
> >                         };
> >                         flash@1 {
> >                                 reg =3D < 1 >;
> >                                 compatible =3D "jedec,spi-nor";
> >                                 spi-max-frequency =3D <50000000>;
> > +                               spi-rx-bus-width =3D <2>;
> >                                 status =3D "disabled";
> >                         };
> >                 };
> > diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspee=
d-g6.dtsi
> > index 1ad05dde19d2..ce93c56a21a7 100644
> > --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> > +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> > @@ -106,18 +106,21 @@ flash@0 {
> >                                 reg =3D < 0 >;
> >                                 compatible =3D "jedec,spi-nor";
> >                                 spi-max-frequency =3D <50000000>;
> > +                               spi-rx-bus-width =3D <2>;
> >                                 status =3D "disabled";
> >                         };
> >                         flash@1 {
> >                                 reg =3D < 1 >;
> >                                 compatible =3D "jedec,spi-nor";
> >                                 spi-max-frequency =3D <50000000>;
> > +                               spi-rx-bus-width =3D <2>;
> >                                 status =3D "disabled";
> >                         };
> >                         flash@2 {
> >                                 reg =3D < 2 >;
> >                                 compatible =3D "jedec,spi-nor";
> >                                 spi-max-frequency =3D <50000000>;
> > +                               spi-rx-bus-width =3D <2>;
> >                                 status =3D "disabled";
> >                         };
> >                 };
> > @@ -133,12 +136,14 @@ flash@0 {
> >                                 reg =3D < 0 >;
> >                                 compatible =3D "jedec,spi-nor";
> >                                 spi-max-frequency =3D <50000000>;
> > +                               spi-rx-bus-width =3D <2>;
> >                                 status =3D "disabled";
> >                         };
> >                         flash@1 {
> >                                 reg =3D < 1 >;
> >                                 compatible =3D "jedec,spi-nor";
> >                                 spi-max-frequency =3D <50000000>;
> > +                               spi-rx-bus-width =3D <2>;
> >                                 status =3D "disabled";
> >                         };
> >                 };
> > @@ -154,18 +159,21 @@ flash@0 {
> >                                 reg =3D < 0 >;
> >                                 compatible =3D "jedec,spi-nor";
> >                                 spi-max-frequency =3D <50000000>;
> > +                               spi-rx-bus-width =3D <2>;
> >                                 status =3D "disabled";
> >                         };
> >                         flash@1 {
> >                                 reg =3D < 1 >;
> >                                 compatible =3D "jedec,spi-nor";
> >                                 spi-max-frequency =3D <50000000>;
> > +                               spi-rx-bus-width =3D <2>;
> >                                 status =3D "disabled";
> >                         };
> >                         flash@2 {
> >                                 reg =3D < 2 >;
> >                                 compatible =3D "jedec,spi-nor";
> >                                 spi-max-frequency =3D <50000000>;
> > +                               spi-rx-bus-width =3D <2>;
> >                                 status =3D "disabled";
> >                         };
> >                 };
> > --
> > 2.34.1
> >
