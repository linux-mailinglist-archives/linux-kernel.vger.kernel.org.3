Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF6B48AB83
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349140AbiAKKfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:35:48 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:37589 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237429AbiAKKfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:35:47 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 1F3EB3201D6A;
        Tue, 11 Jan 2022 05:35:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 11 Jan 2022 05:35:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=C70fNH5CPE9iPEBfj3a2q6jOs5D
        PgbWlIGPRvpsnGpk=; b=CqgGaFDjIY0m0VaGwkopkPgYL5j2EmkyE0gcSCaaTlp
        wKT32RpY+q7nptbrjSq8te6Qh06DbM3fMI2CW5tZazeKCk6HQJHi80mvsaD7aWXD
        R/vIsx/s6XJnt1djb9ccSMuFd3IZ7IsqutFHgJAYlbJFhCwfc7shu/9eSZvoHeyC
        u1MaJDRKe9FixOp1I27jSI5Edrrxp5iACqHt00i7WK7aUe7ET0ZuYWfX7ytHEexe
        FVRlFeNvGjEphxyR3a3giOvKIRO/pz/jgybQaDxRh5/ujJRZkubC0EwQEr7rAkxx
        ZwPHA2ctWNNHqi5J10ynOV3yDOQfKiLn1H0MjaV4RVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=C70fNH
        5CPE9iPEBfj3a2q6jOs5DPgbWlIGPRvpsnGpk=; b=ScOGdcTh3n217vd4/2qhVN
        RaiGRAwZoWgedy2Vwzdr1kEwEo3MzPDJ9h9P8O+nYinTwCWHr9nl7qFklvWM/2sX
        jSQdLl0m70BS/504dUMMD6MJ1exLwvU1Xb+BkK2gkJpcYhPzykHFcsIShnzhBGZB
        6Sdn+SbTWIHBXIr7uUXj7hBWjhXDUileeur/5F+gC1Q0c8UL90BkR+JdTFtDpT8g
        7kCG/kbR3H2L/Ljgd8Ty1Ku/b7woVb+QZ5mxAHPnamgQEWjfnkbHkJ9ujzmf3rFx
        u+n2VFnK4teqKRoDF+JF+AB2V1ORSCHBdE6drKhYXxo9kYA+yBnLSI/OQsj+AbzQ
        ==
X-ME-Sender: <xms:gV3dYXZdVR76VC4IZt_ErxoX6X_BbRXRfK4fNyF_S-G962w0LUCBFg>
    <xme:gV3dYWbrDmHcC2wuzIQoNsFNxd0jbOD_QZCZ1T2IbTdaedzPZEulx7OLiwIXubvSu
    9bRpyzdUXX5zfhtVD0>
X-ME-Received: <xmr:gV3dYZ82QCiBtRI_XmDTau6Yqwof2wjSXgK-cSCChZ9w1o3dri6NEVlGJ_5Pt1iJ9a-ejRtrf8ZvUDNtS7cWtIscYjq-2OaEpR_0m5E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudehfedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomhepofgrgihimhgvucftihhprghrugcuoehmrgigihhmvgestggv
    rhhnohdrthgvtghhqeenucggtffrrghtthgvrhhnpeelkeeghefhuddtleejgfeljeffhe
    ffgfeijefhgfeufefhtdevteegheeiheegudenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:gV3dYdqH4VUbKqN2IfiXxaNBT1iEqZJ2qosMWaxPlU9OQOo9uCNYkg>
    <xmx:gV3dYSp4ULaBn9_ecV0KXXF6xW-hr3BspNVYz8THNLYCn9A38w2XkA>
    <xmx:gV3dYTSC15_UP-HGMtpI51TrfykuqgEWbI4UeKgN1ZuBZJqKx4vnJg>
    <xmx:gV3dYbkTdnO1i3jOWKT3rm8mW7aKfkVN1T7BQDnU9ACy2xX5e6gfgQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jan 2022 05:35:44 -0500 (EST)
Date:   Tue, 11 Jan 2022 11:35:42 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     conleylee@foxmail.com
Cc:     robh@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] sun7i-a20-marsboard.dts: add marsboard-a20 support
Message-ID: <20220111103542.f7ilg2ugqklpztr5@houat>
References: <YdS1GVkRopRSoD5S@robh.at.kernel.org>
 <tencent_13C536D91764B05D794CBCF3156C963E6C0A@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sout5ynpa3sillfi"
Content-Disposition: inline
In-Reply-To: <tencent_13C536D91764B05D794CBCF3156C963E6C0A@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sout5ynpa3sillfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 05, 2022 at 10:45:50AM +0800, conleylee@foxmail.com wrote:
> From: conley <conleylee@foxmail.com>

This should be your full name in the author and signed-off-by

> ARM dts: sun7i: Add Marsboard A20 board
>=20
> This patch add support for Marsboard A20 board.
>=20
> The Marsboard A20 is a A20 based SBC with 1G RAM, 8G Flash, micro SD
> card slot , SATA socketm 10/100 ethernet, HDMI port, 4 USB2.0 ports, 2
> USB2.0 OTG, USB WIFI(RTL8188EU) with antenna.
>=20
> Change since v1.
>   - Spearate biddings and dts as two patches.
>   - use SPDX tag

And the changelog should be after the --- below

> Signed-off-by: conley <conleylee@foxmail.com>
> ---
>  arch/arm/boot/dts/Makefile                |   1 +
>  arch/arm/boot/dts/sun7i-a20-marsboard.dts | 183 ++++++++++++++++++++++
>  2 files changed, 184 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-marsboard.dts
>=20
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 0de64f237cd8..4628a2617313 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1219,6 +1219,7 @@ dtb-$(CONFIG_MACH_SUN7I) +=3D \
>  	sun7i-a20-icnova-swac.dtb \
>  	sun7i-a20-lamobo-r1.dtb \
>  	sun7i-a20-linutronix-testbox-v2.dtb \
> +	sun7i-a20-marsboard.dtb \
>  	sun7i-a20-m3.dtb \
>  	sun7i-a20-mk808c.dtb \
>  	sun7i-a20-olimex-som-evb.dtb \
> diff --git a/arch/arm/boot/dts/sun7i-a20-marsboard.dts b/arch/arm/boot/dt=
s/sun7i-a20-marsboard.dts
> new file mode 100644
> index 000000000000..7ab6aa30fee6
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun7i-a20-marsboard.dts
> @@ -0,0 +1,183 @@
> +// SPDX-License-Identifier: LGPL-2.1+

The license for DT files is usually a dual-license with GPL and MIT,
which would be:

SPDX-License-Identifier: (GPL-2.0+ OR MIT)

You can't link to a DT, so GPL and LGPL should be equivalent here, and
MIT is useful for other projects (like the *BSD) that reuse the DT.

> +/*
> + * Copyright 2021 Conley Lee
> + * Conley Lee <conleylee@foxmail.com>
> + */
> +
> +/dts-v1/;
> +#include "sun7i-a20.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	model =3D "HAOYU Electronics Marsboard A20";
> +	compatible =3D "haoyu,a20-marsboard", "allwinner,sun7i-a20";

Is there multiple boards called marsboard?

If not, then the compatible should be haoyu,marsboard.

The file name should be sun7i-a20-haoyu-marsboard too.

> +	aliases {
> +		serial0 =3D &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +
> +	hdmi-connector {
> +		compatible =3D "hdmi-connector";
> +		type =3D "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint =3D <&hdmi_out_con>;
> +			};
> +		};
> +	};
> +};
> +
> +&ahci {
> +	target-supply =3D <&reg_ahci_5v>;
> +	status =3D "okay";
> +};
> +
> +&codec {
> +	status =3D "okay";
> +};
> +
> +&cpu0 {
> +	cpu-supply =3D <&reg_dcdc2>;
> +};
> +
> +&de {
> +	status =3D "okay";
> +};
> +
> +&ehci0 {
> +	status =3D "okay";
> +};
> +
> +&ehci1 {
> +	status =3D "okay";
> +};
> +
> +&gmac_mii_pins {
> +	pins =3D "PA0", "PA1", "PA2",
> +	"PA3", "PA4", "PA5", "PA6",
> +	"PA7", "PA8", "PA9", "PA10",
> +	"PA11", "PA12", "PA13", "PA14",
> +	"PA15", "PA16", "PA17";
> +};

Why do you need that node?

Maxime

--sout5ynpa3sillfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYd1dfgAKCRDj7w1vZxhR
xe42AP9VUyF7fobdQbT84XUB5rRI8jsk0Qd3ylEnJi8o6x/ZJwD/aGPZA3nbCM3X
vC7aIZq4+vymd4F4ECnTcydLXPdK6gw=
=7MD+
-----END PGP SIGNATURE-----

--sout5ynpa3sillfi--
