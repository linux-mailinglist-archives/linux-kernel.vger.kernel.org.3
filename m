Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EAE5634D2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiGAODw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiGAODv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:03:51 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F8530F44;
        Fri,  1 Jul 2022 07:03:48 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 70A0940011;
        Fri,  1 Jul 2022 14:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656684211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+L8QLajr74iqGSCFKxQfGD00RTWpYu+5/EnCEEB0stg=;
        b=FnOWE9J1W70ff+2EMnfrFI3/sjG8N6x30dDC8EzQKe82aGioLmg0DWlxHFDRZABDeBNCHl
        JuezjGbvMQqG3SksfB0+z2hOTgaVJOGK8ev0PVMjseVoSf9v8IzWplO7pHLULa8rvT9Mwv
        VhgbAAxjsZ2BEEU7Q89LyIM/hcm/G67NZeT43ixQSgOHUTmZX1k0eCZrbjgqS8y5ezqnfx
        OU/xdzCQ1lLb/Oy9f9iZLDhrRbDaMuEl1UVnRan7R+vNYSRmhKY/mTOj1wWn1WLK13Wcjb
        wPdztjBC+lsAL7dvEjd8UkURBXv63DjgylURw46UXbiRtc3cPRREsbMSiFcX9Q==
Date:   Fri, 1 Jul 2022 16:03:27 +0200
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
Subject: Re: [PATCH v4 3/3] ARM: dts: lan966x: Add UDPHS support
Message-ID: <20220701160327.102880e5@bootlin.com>
In-Reply-To: <72a1e572-45d7-de18-8f1f-9035d75b562b@microchip.com>
References: <20220701070928.459135-1-herve.codina@bootlin.com>
        <20220701070928.459135-4-herve.codina@bootlin.com>
        <72a1e572-45d7-de18-8f1f-9035d75b562b@microchip.com>
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

On Fri, 1 Jul 2022 10:56:46 +0000
<Claudiu.Beznea@microchip.com> wrote:

> On 01.07.2022 10:09, Herve Codina wrote:
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
> > index 3cb02fffe716..c98e7075c2b4 100644
> > --- a/arch/arm/boot/dts/lan966x.dtsi
> > +++ b/arch/arm/boot/dts/lan966x.dtsi
> > @@ -458,6 +458,17 @@ cpu_ctrl: syscon@e00c0000 {
> >                         reg =3D <0xe00c0000 0x350>;
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
> I have these compilation warnings:
>=20
>   DTC     arch/arm/boot/dts/lan966x-pcb8291.dtb
> arch/arm/boot/dts/lan966x.dtsi:461.21-470.5: Warning (simple_bus_reg):
> /soc/usb@e0808000: simple-bus unit address format error, expected "200000"
>   DTC     arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
> arch/arm/boot/dts/lan966x.dtsi:461.21-470.5: Warning (simple_bus_reg):
> /soc/usb@e0808000: simple-bus unit address format error, expected "200000"
>   DTC     arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
> arch/arm/boot/dts/lan966x.dtsi:461.21-470.5: Warning (simple_bus_reg):
> /soc/usb@e0808000: simple-bus unit address format error, expected "200000"

I am a bit confused but these warnings do not appear on my side (patches
based on v5.19-rc1).
What is the exact command that leads to these warning ?

Thanks,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
