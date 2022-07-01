Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE27562C47
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbiGAHJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiGAHJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:09:18 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93A6677DC;
        Fri,  1 Jul 2022 00:09:16 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B45174000F;
        Fri,  1 Jul 2022 07:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656659355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PCiZVwpMAjyrnNZLMZl/YtqChDHV1AvFsK2kkBxNj8Q=;
        b=jMoucgK6yX2WKScAnFiD+VFa53pnvw1EHQOQIx0hPWAYVVyTx/aLdZvkJTZVCrVVTxURgL
        DVOwKogX0EUXhjqye4hOpQyTcgUl0mh/7JHUQRmCmOSB7gYoJDaUllJ/5wMHCOXgaBRDSv
        pO76jxy/f3mNXbEex9enTUY5eTxKJCZOWYKEd/7AaNTepx6skSgpcpn7IcxQOaxmm+y2+A
        xwLYjQxMGQChWE0gPzU9wrncRGDMiitCU0F3ENjjVtwa9m+pTAGhjZAwPoNfRGix2FngVw
        WEW4gssTQR4bq0OY4QpE19htaCIYtpt8ch8w4qnEa/sleRcV7DUeB7KBrWeGog==
Date:   Fri, 1 Jul 2022 09:09:09 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     <Claudiu.Beznea@microchip.com>
Cc:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <Horatiu.Vultur@microchip.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 3/3] ARM: dts: lan966x: Add UDPHS support
Message-ID: <20220701090909.50654cb4@bootlin.com>
In-Reply-To: <f4f14941-6839-5691-b2d1-adb049118a4d@microchip.com>
References: <20220525071036.223396-1-herve.codina@bootlin.com>
        <20220525071036.223396-4-herve.codina@bootlin.com>
        <f4f14941-6839-5691-b2d1-adb049118a4d@microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On Thu, 30 Jun 2022 09:31:00 +0000
<Claudiu.Beznea@microchip.com> wrote:

> On 25.05.2022 10:10, Herve Codina wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >=20
> > Add UDPHS (the USB High Speed Device Port controller) support.
> >=20
> > The both lan966x SOCs (LAN9662 and LAN9668) have the same UDPHS
> > IP. This IP is also the same as the one present in the SAMA5D3
> > SOC.
> >=20
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  arch/arm/boot/dts/lan966x.dtsi | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/lan966x.dtsi b/arch/arm/boot/dts/lan966x=
.dtsi
> > index 7d2869648050..e086df741f99 100644
> > --- a/arch/arm/boot/dts/lan966x.dtsi
> > +++ b/arch/arm/boot/dts/lan966x.dtsi
> > @@ -196,6 +196,17 @@ watchdog: watchdog@e0090000 {
> >                         status =3D "disabled";
> >                 };
> >=20
> > +               udc: usb@e0808000 {
> > +                       compatible =3D "microchip,lan9662-udc",
> > +                                    "atmel,sama5d3-udc";
> > +                       reg =3D <0x00200000 0x80000>,
> > +                             <0xe0808000 0x400>;
> > +                       interrupts =3D <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
> > +                       clocks =3D <&clks GCK_GATE_UDPHS>, <&nic_clk>;
> > +                       clock-names =3D "pclk", "hclk";
> > +                       status =3D "disabled";
> > +               };
> > + =20
>=20
> This doesn't apply clean on top of v5.19-rc1. Can you check and resend?

Sure,
I am going to send a rebased version of this series.

Thanks,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
