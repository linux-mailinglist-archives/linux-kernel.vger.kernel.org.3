Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BFA52EC41
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346989AbiETMhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiETMhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:37:32 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0655F8C5;
        Fri, 20 May 2022 05:37:31 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9BF98FF802;
        Fri, 20 May 2022 12:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653050249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WKwb1xLxCKHxo8kAUv0MtGuwurU5vlydm6P3+DNROh4=;
        b=l1f6zb6+GSbPTbWj42ElyYGLAOZKQx2M9xqWd+ieBlHSzmFo3aXx/ZqXctiDFGskM+Ez1H
        xMTSUcOwgdMAuos1ERIEoYjZM1SQOPXUIIvLX/aj9mBM7HnK2fAWTnW1o/H64SKZm2ss9p
        nSJEQLe/EZafTHiTY4mtYE/7AD988/9Pq2WqCS+JCsAZ6/+cHA90jLevilumLWZ2eIO2k5
        YNtg7YfcjKbkn+TI4+b5vl/aXFW1VieMOVMPXO2EoAfR0vQYBqLNoNgEfhEKuXGuevdC3Q
        hHRHJ+/DEkh3h/2aMzgtW4wty+JV2YHauQvA6S4ZgF3WH8OWUITMpxm79SyTCQ==
Date:   Fri, 20 May 2022 14:37:26 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 3/3] ARM: dts: lan966x: Add UDPHS support
Message-ID: <20220520143726.6dd324fb@bootlin.com>
In-Reply-To: <2945e445-3453-a45f-7d3d-3b07bf350b47@linaro.org>
References: <20220513105850.310375-1-herve.codina@bootlin.com>
        <20220513105850.310375-4-herve.codina@bootlin.com>
        <2945e445-3453-a45f-7d3d-3b07bf350b47@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof, Sergei

On Fri, 13 May 2022 14:54:26 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 13/05/2022 12:58, Herve Codina wrote:
> > Add UDPHS (the USB High Speed Device Port controller) support.
> > The UDPHS IP present in the lan966x SOC is the same as the one
> > present in the SAMA5D3 SOC
> >=20
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  arch/arm/boot/dts/lan966x.dtsi | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/lan966x.dtsi b/arch/arm/boot/dts/lan966x=
.dtsi
> > index 7d2869648050..4c09f3166d27 100644
> > --- a/arch/arm/boot/dts/lan966x.dtsi
> > +++ b/arch/arm/boot/dts/lan966x.dtsi
> > @@ -211,6 +211,17 @@ can0: can@e081c000 {
> >  			status =3D "disabled";
> >  		};
> > =20
> > +		udc: udphs@e0808000 { =20
>=20
> Generic node names, so it looks like usb. For example HCD schema
> requires it. I am not sure which bindings are used here, but anyway once
> they might require usb...
>=20

HCD are related to the Host controller.
Here we are talking about a device.

In existing bindings related to USB device (or OTG as an OTG can be a
host or a device) on several SOCs, we can find:
- usb1: gadget@fffa4000
- usb_otg: usb@1c13000
- usb: usb@47400000
- udc: usb@13040000
- usb_otg_hs: usb_otg_hs@4a0ab000


So I will change to
  udc: usb@e0808000

Is that ok for you ?

Regards,
Herve

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
