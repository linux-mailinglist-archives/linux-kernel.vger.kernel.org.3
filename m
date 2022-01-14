Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097C448E751
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbiANJUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:20:13 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:50949 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230124AbiANJUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:20:12 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id CEBBF5C0184;
        Fri, 14 Jan 2022 04:20:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 14 Jan 2022 04:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=cxGeAwcSjcL8VU9JBG8vAUhRx6Y
        PVJOrfbXubDbWanA=; b=GiHP/4JAs1XrQ6axffzBCNgHu0qz4spwcBfwkQy6SpM
        C1J1qpWuGJbiGUZCYTD6zInKzxjxrPYMRnHQbMueQ8ccxTwMuqpXcCeO9Zlirji6
        BokB3R8NkfWADVVQh8H7fd1Q2SXU/2UfRLwamdn0Kpf8vNkIi/L+OiyRsluen8wX
        h6HMCjwi9SkUGB3s3EDipFbRDBBDQH5BMMiIDDrhH5SeVxiEriYaAkvrJ1cb8JAk
        SiiH9NtlWOxU8VN5dTF2ljbK32KKNSqK29RP8BKIceG4LBHpevx9hRauAflJRjvA
        S82NTfmR45xtUBPBKklzf54UCGZ4lKCf0wZ4i+O5ZzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=cxGeAw
        cSjcL8VU9JBG8vAUhRx6YPVJOrfbXubDbWanA=; b=Z1tk1s5kejmw7oqN2ssnIA
        SBMwLcxtBgqz7+4gIK15HuYaHbcZoouETgjpuXSLE1eQ2pUVUQFiQBNF003Tb5lU
        9gJEjlOgf4FglgIXyBHaWfjm+unAE/dZd9k6rmh7hYD9RepTyZPKC0qoZco8PKIn
        OLqupUWnFdSHTwzS7X+HSvaNLTtY4e4TMMQ4VsZTkTeucj29AvVVWfj58DzdFtY0
        lVeoQ1jgSyDNwQSKU3fLSb7vMfxUIC76kGPeWgRGTgnQwlUaKdLlweGodGA0OV1g
        QQrbZlB3GZz490XndfTAR5p7r/JBdopDg4DBKSVEKvdMpCGLITWpjxc3GR1qCiwA
        ==
X-ME-Sender: <xms:SkDhYRwAAru-usMpKBcphJ7tBHQJc0AOwTEdkVGnoV8JqjVbKjWMbw>
    <xme:SkDhYRRQuRUJVU2XtfSpMvgWqwrMUkbk4odRhWMYYbTzCgPGD30IWkj8Li6-LNGkq
    eqfo-QNbFXfQbi1w2w>
X-ME-Received: <xmr:SkDhYbVoqd_JYJld7CyFjUYCTlwMJJzFLV7Lwcbi_Gx0670GwASdhpcSHcRAh6uspAQ83gJi703IxaOfQ2TEnRdNO6jSjvlfhD_pkDk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrtdehgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeeutdfgjeeuudehvefgvedvtedtudelfffgffekledtffekgedukeejueevieeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:SkDhYTif8zAmN1dJofEoHml8n-pF-qD9lWymPyDYK9NvTTOefR8zhQ>
    <xmx:SkDhYTDfqkyWg0Jer-uD0uPUMeytnYaN6AGu3X55gdzPrp7WMQWW0Q>
    <xmx:SkDhYcLDbAqqZT20fZvtbMTAvh6caW26ifN9uK7GNZzC8curZAD-bw>
    <xmx:S0DhYe-JGsyQKNNExG-i_XoEUzbEh3xX4sfppov243Qzzg5k7KLl6g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jan 2022 04:20:10 -0500 (EST)
Date:   Fri, 14 Jan 2022 10:20:07 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Conley Lee <conleylee@foxmail.com>
Cc:     robh@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] sun7i-a20-marsboard.dts: add marsboard-a20 support
Message-ID: <20220114092007.7nf5m5cunbifmo5d@houat>
References: <YdS1GVkRopRSoD5S@robh.at.kernel.org>
 <tencent_13C536D91764B05D794CBCF3156C963E6C0A@qq.com>
 <20220111103542.f7ilg2ugqklpztr5@houat>
 <tencent_361798B1357958BC1B1694977A6C9935CD0A@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7wslry4pvqogojtw"
Content-Disposition: inline
In-Reply-To: <tencent_361798B1357958BC1B1694977A6C9935CD0A@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7wslry4pvqogojtw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 12, 2022 at 10:37:55AM +0800, Conley Lee wrote:
> On 01/11/22 at 11:35=E4=B8=8A=E5=8D=88, Maxime Ripard wrote:
> > Date: Tue, 11 Jan 2022 11:35:42 +0100
> > From: Maxime Ripard <maxime@cerno.tech>
> > To: conleylee@foxmail.com
> > Cc: robh@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
> >  linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v2 1/2] sun7i-a20-marsboard.dts: add marsboard-a20
> >  support
> >=20
> > Hi,
> >=20
> > On Wed, Jan 05, 2022 at 10:45:50AM +0800, conleylee@foxmail.com wrote:
> > > From: conley <conleylee@foxmail.com>
> >=20
> > This should be your full name in the author and signed-off-by
> >=20
> > > ARM dts: sun7i: Add Marsboard A20 board
> > >=20
> > > This patch add support for Marsboard A20 board.
> > >=20
> > > The Marsboard A20 is a A20 based SBC with 1G RAM, 8G Flash, micro SD
> > > card slot , SATA socketm 10/100 ethernet, HDMI port, 4 USB2.0 ports, 2
> > > USB2.0 OTG, USB WIFI(RTL8188EU) with antenna.
> > >=20
> > > Change since v1.
> > >   - Spearate biddings and dts as two patches.
> > >   - use SPDX tag
> >=20
> > And the changelog should be after the --- below
> >=20
> > > Signed-off-by: conley <conleylee@foxmail.com>
> > > ---
> > >  arch/arm/boot/dts/Makefile                |   1 +
> > >  arch/arm/boot/dts/sun7i-a20-marsboard.dts | 183 ++++++++++++++++++++=
++
> > >  2 files changed, 184 insertions(+)
> > >  create mode 100644 arch/arm/boot/dts/sun7i-a20-marsboard.dts
> > >=20
> > > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > > index 0de64f237cd8..4628a2617313 100644
> > > --- a/arch/arm/boot/dts/Makefile
> > > +++ b/arch/arm/boot/dts/Makefile
> > > @@ -1219,6 +1219,7 @@ dtb-$(CONFIG_MACH_SUN7I) +=3D \
> > >  	sun7i-a20-icnova-swac.dtb \
> > >  	sun7i-a20-lamobo-r1.dtb \
> > >  	sun7i-a20-linutronix-testbox-v2.dtb \
> > > +	sun7i-a20-marsboard.dtb \
> > >  	sun7i-a20-m3.dtb \
> > >  	sun7i-a20-mk808c.dtb \
> > >  	sun7i-a20-olimex-som-evb.dtb \
> > > diff --git a/arch/arm/boot/dts/sun7i-a20-marsboard.dts b/arch/arm/boo=
t/dts/sun7i-a20-marsboard.dts
> > > new file mode 100644
> > > index 000000000000..7ab6aa30fee6
> > > --- /dev/null
> > > +++ b/arch/arm/boot/dts/sun7i-a20-marsboard.dts
> > > @@ -0,0 +1,183 @@
> > > +// SPDX-License-Identifier: LGPL-2.1+
> >=20
> > The license for DT files is usually a dual-license with GPL and MIT,
> > which would be:
> >=20
> > SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >=20
> > You can't link to a DT, so GPL and LGPL should be equivalent here, and
> > MIT is useful for other projects (like the *BSD) that reuse the DT.
> >=20
> > > +/*
> > > + * Copyright 2021 Conley Lee
> > > + * Conley Lee <conleylee@foxmail.com>
> > > + */
> > > +
> > > +/dts-v1/;
> > > +#include "sun7i-a20.dtsi"
> > > +#include "sunxi-common-regulators.dtsi"
> > > +
> > > +#include <dt-bindings/gpio/gpio.h>
> > > +#include <dt-bindings/interrupt-controller/irq.h>
> > > +
> > > +/ {
> > > +	model =3D "HAOYU Electronics Marsboard A20";
> > > +	compatible =3D "haoyu,a20-marsboard", "allwinner,sun7i-a20";
> >=20
> > Is there multiple boards called marsboard?
> >=20
> > If not, then the compatible should be haoyu,marsboard.
> >=20
> > The file name should be sun7i-a20-haoyu-marsboard too.
> >=20
> > > +	aliases {
> > > +		serial0 =3D &uart0;
> > > +	};
> > > +
> > > +	chosen {
> > > +		stdout-path =3D "serial0:115200n8";
> > > +	};
> > > +
> > > +	hdmi-connector {
> > > +		compatible =3D "hdmi-connector";
> > > +		type =3D "a";
> > > +
> > > +		port {
> > > +			hdmi_con_in: endpoint {
> > > +				remote-endpoint =3D <&hdmi_out_con>;
> > > +			};
> > > +		};
> > > +	};
> > > +};
> > > +
> > > +&ahci {
> > > +	target-supply =3D <&reg_ahci_5v>;
> > > +	status =3D "okay";
> > > +};
> > > +
> > > +&codec {
> > > +	status =3D "okay";
> > > +};
> > > +
> > > +&cpu0 {
> > > +	cpu-supply =3D <&reg_dcdc2>;
> > > +};
> > > +
> > > +&de {
> > > +	status =3D "okay";
> > > +};
> > > +
> > > +&ehci0 {
> > > +	status =3D "okay";
> > > +};
> > > +
> > > +&ehci1 {
> > > +	status =3D "okay";
> > > +};
> > > +
> > > +&gmac_mii_pins {
> > > +	pins =3D "PA0", "PA1", "PA2",
> > > +	"PA3", "PA4", "PA5", "PA6",
> > > +	"PA7", "PA8", "PA9", "PA10",
> > > +	"PA11", "PA12", "PA13", "PA14",
> > > +	"PA15", "PA16", "PA17";
> > > +};
> >=20
> > Why do you need that node?
>
> 1. There are two boards called marsboard, another one is based on
>    sun4i-a10.

Ok

> 2. About the gmac_mii_pins node: the pin PA17 is connected to PHY
>    as EXTERR signal on sun7i-a20-marsboard, it's different from=20
>    the definetion in dtsi.

The A20-Olinuxino-Micro has the same thing then, please do it like they did.

Maxime

--7wslry4pvqogojtw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYeFAQwAKCRDj7w1vZxhR
xZpLAQDgx17qKKn50MvjPu2w1aATa9Rzu2Yicq3GzM8ucVVOmgD+IWqqfFJb3jee
necOjJSqyC04y6SGC6pFW1YSRAv4tgs=
=wfqu
-----END PGP SIGNATURE-----

--7wslry4pvqogojtw--
