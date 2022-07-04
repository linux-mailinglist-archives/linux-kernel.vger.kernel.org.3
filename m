Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A65565212
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbiGDKWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiGDKVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:21:39 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0345712627;
        Mon,  4 Jul 2022 03:19:23 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B22D220000D;
        Mon,  4 Jul 2022 10:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656929962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mh0Nhj24sgh2TKJWV5KlgEWJWx+38u9hSCW1uBlX7mk=;
        b=c4hXa5HR+Jt9+TXulYqwL+pt7blwXoqaHyaPXuNvYUy/wvL4oJYhMDvQc/GO5Uwcf9oOzA
        54gpSsZOHX/xLbkTJ9TlnCeKJh+es6u3/Z8+U+0JZY42Qde/wf0csfbCYUswTVLnrzmmdJ
        4CkKsOD+iqUbHNzDAYyzopRfC79cn4Ha9lrRbTAhX4gK7eI6E65LlofptOgrCZvr0K4KpY
        s0kgncOCXnnv1r2XrQeQPeQumKfYIfUvWkloGK0F6khaC+HlYtmez3HXBife0Td7ZJla1x
        IFrWR5f9V6f4jaeFe9K5daB7Oxbt5Uch58VWKjWLHRVIPTwIsTRLaJm+2ctxew==
Date:   Mon, 4 Jul 2022 12:19:16 +0200
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
Message-ID: <20220704121916.3156f644@bootlin.com>
In-Reply-To: <32790e6f-e708-ceee-e17f-1b09c909c991@microchip.com>
References: <20220701070928.459135-1-herve.codina@bootlin.com>
        <20220701070928.459135-4-herve.codina@bootlin.com>
        <72a1e572-45d7-de18-8f1f-9035d75b562b@microchip.com>
        <20220701160327.102880e5@bootlin.com>
        <32790e6f-e708-ceee-e17f-1b09c909c991@microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On Mon, 4 Jul 2022 05:41:33 +0000
<Claudiu.Beznea@microchip.com> wrote:

> On 01.07.2022 17:03, Herve Codina wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >=20
> > Hi Claudiu,
> >=20
> > On Fri, 1 Jul 2022 10:56:46 +0000
> > <Claudiu.Beznea@microchip.com> wrote:
> >  =20
> >> On 01.07.2022 10:09, Herve Codina wrote: =20
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you kno=
w the content is safe
> >>>
> >>> Add UDPHS (the USB High Speed Device Port controller) support.
> >>>
> >>> The both lan966x SOCs (LAN9662 and LAN9668) have the same UDPHS
> >>> IP. This IP is also the same as the one present in the SAMA5D3
> >>> SOC.
> >>>
> >>> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> >>> ---
> >>>  arch/arm/boot/dts/lan966x.dtsi | 11 +++++++++++
> >>>  1 file changed, 11 insertions(+)
> >>>
> >>> diff --git a/arch/arm/boot/dts/lan966x.dtsi b/arch/arm/boot/dts/lan96=
6x.dtsi
> >>> index 3cb02fffe716..c98e7075c2b4 100644
> >>> --- a/arch/arm/boot/dts/lan966x.dtsi
> >>> +++ b/arch/arm/boot/dts/lan966x.dtsi
> >>> @@ -458,6 +458,17 @@ cpu_ctrl: syscon@e00c0000 {
> >>>                         reg =3D <0xe00c0000 0x350>;
> >>>                 };
> >>>
> >>> +               udc: usb@e0808000 {
> >>> +                       compatible =3D "microchip,lan9662-udc",
> >>> +                                    "atmel,sama5d3-udc";
> >>> +                       reg =3D <0x00200000 0x80000>,
> >>> +                             <0xe0808000 0x400>;
> >>> +                       interrupts =3D <GIC_SPI 76 IRQ_TYPE_LEVEL_HIG=
H>;
> >>> +                       clocks =3D <&clks GCK_GATE_UDPHS>, <&nic_clk>;
> >>> +                       clock-names =3D "pclk", "hclk";
> >>> +                       status =3D "disabled";
> >>> +               };
> >>> + =20
> >>
> >> I have these compilation warnings:
> >>
> >>   DTC     arch/arm/boot/dts/lan966x-pcb8291.dtb
> >> arch/arm/boot/dts/lan966x.dtsi:461.21-470.5: Warning (simple_bus_reg):
> >> /soc/usb@e0808000: simple-bus unit address format error, expected "200=
000"
> >>   DTC     arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb
> >> arch/arm/boot/dts/lan966x.dtsi:461.21-470.5: Warning (simple_bus_reg):
> >> /soc/usb@e0808000: simple-bus unit address format error, expected "200=
000"
> >>   DTC     arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt-8g.dtb
> >> arch/arm/boot/dts/lan966x.dtsi:461.21-470.5: Warning (simple_bus_reg):
> >> /soc/usb@e0808000: simple-bus unit address format error, expected "200=
000" =20
> >=20
> > I am a bit confused but these warnings do not appear on my side (patches
> > based on v5.19-rc1).
> > What is the exact command that leads to these warning ? =20
>=20
> Oh, and the set of commands I'm using:
> make sama7_defconfig
> make menuconfig + enable CONFIG_SOC_LAN966
> make W=3D1 dtbs

I have the warnings.
They are present with 'W=3D1' set.

I remove them and send a v5.

Thanks,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
