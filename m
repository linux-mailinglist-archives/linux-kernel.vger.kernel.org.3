Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8A548E75D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 10:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239909AbiANJVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 04:21:42 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:49907 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239888AbiANJVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:21:41 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id F16575C015E;
        Fri, 14 Jan 2022 04:21:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 14 Jan 2022 04:21:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=LVuWgQRc563L3/r1+iI9nxax4f2
        nc/VLMDaRC9JcLpw=; b=CQ4jXpl1t15/jcBKOPBcMGL05ZbTMKQojBQ0GbcFNBd
        D+scSXXtJkoj8/KfRdu/Ppxxeq4I50BQl89GEBHg5yjsLanjtzsPgOVZIGSq98m/
        FFNcHwKGVETpYi2c30eOoQArrgQ4U7YkAos5sm9PiXi56ivnoGWzJdEe8ydaN5bN
        mTpZDWoR3L7MPmy8QlYni4xaA5OHPXr9OEBpA6j8FMOawoacdeCBvgfSJhbFyNCY
        aJj+lwtny8tHR4cDyB0WVKaqwZMZs2DG/d+1lP8snB03lVzhckMLL79RiKhADl+q
        DyY2Ru+APjbUvhS3k5Bu8P+dVPQA9G5RLfvBSUKj0XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=LVuWgQ
        Rc563L3/r1+iI9nxax4f2nc/VLMDaRC9JcLpw=; b=lz+fRBjWNRP1kDuqjr7/6q
        0MYz5Ns83HScUzYdLlJHFlw9xv4wC2nMM5np9/vNZlDkSe4aUBJ9WCWYBvn/G2xk
        7O6478iyMiIPtfKKtpPmt7p+JQkR0FYOvihKTQGuiXEzgqtfEhcqGlUf0817lpyz
        BDO4UB5nCCoiic1wmNJh8gQKnGe7pGu4HjbLy23t+FKTon9MkzShbQewEEjDnFsm
        leYz0o7Svad0hErhHH1DlMk2Rj8uy+ref2rgwNdoy/vCtxbpZFJ8g29VD9A8WELK
        IeeHxPy/v1EZbrfcwZyTRmndWTTkZoP6Qc4jgJhMQekhPRLpXzsgNnBY2o39hi1A
        ==
X-ME-Sender: <xms:pEDhYYU32NgEyjDBxTaua4dTd4UF8SYRwFt9OTXI3qxrkXJl9u-Z0Q>
    <xme:pEDhYck9g2ITV_sQutacFVSpEJ0icuOR9D9sjsY-9Hl2S1h2H2xS3q1KGjg1r0UW0
    tMTimBv7WmvpvgIAg4>
X-ME-Received: <xmr:pEDhYcY8EBYBnoipBHdyGbjYppg-st4qJf0jI1O9_C7gjilKm8edREmX6XHVCZBhUJJ996-cOhrlbyoJ5USF4EKFWHffNh08-5y7c0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrtdehgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:pEDhYXUw7_piFJa1PnROF8a-w1VcwNOWfyQHWwhd4AdR6SnANsiGtQ>
    <xmx:pEDhYSmEgBtP0iISDTAPKuggCsGZcx0Fb7-XXP8J5-WdYj7LwkZR9A>
    <xmx:pEDhYce3JxEHZuok14FP9wSOOSt8J3xBER4ESFOlGpi9dBQfKl1kzQ>
    <xmx:pEDhYUivru-6GLxuCgTR0rhmW8zB4oi09zlL41QWflaJfX9GDL1eZA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jan 2022 04:21:40 -0500 (EST)
Date:   Fri, 14 Jan 2022 10:21:39 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Conley Lee <conleylee@foxmail.com>
Cc:     wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] sun7i-a20-haoyu-marsboard.dts: add marsboard-a20
 support
Message-ID: <20220114092139.eecdrmonsrvjuitb@houat>
References: <tencent_DC7B4D416B69D6D6789356010B5B9647C606@qq.com>
 <20220112031347.2492813-1-conleylee@foxmail.com>
 <tencent_00147CCBB6C9A0A0830DCE43F25DBC40A505@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cw4mmidoewi6oeca"
Content-Disposition: inline
In-Reply-To: <tencent_00147CCBB6C9A0A0830DCE43F25DBC40A505@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cw4mmidoewi6oeca
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 12, 2022 at 11:13:46AM +0800, Conley Lee wrote:
> Add sun7i-a20-haoyu-marsboard.dts to support haoyu marsboard a20 SBC

A description of the board would be nice

> Signed-off-by: Conley Lee <conleylee@foxmail.com>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/sun7i-a20-haoyu-marsboard.dts    | 183 ++++++++++++++++++
>  2 files changed, 184 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-haoyu-marsboard.dts
>=20
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 0de64f237cd8..5f1602d62927 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1219,6 +1219,7 @@ dtb-$(CONFIG_MACH_SUN7I) +=3D \
>  	sun7i-a20-icnova-swac.dtb \
>  	sun7i-a20-lamobo-r1.dtb \
>  	sun7i-a20-linutronix-testbox-v2.dtb \
> +	sun7i-a20-haoyu-marsboard.dtb \

This should be ordered alphabetically

>  	sun7i-a20-m3.dtb \
>  	sun7i-a20-mk808c.dtb \
>  	sun7i-a20-olimex-som-evb.dtb \
> diff --git a/arch/arm/boot/dts/sun7i-a20-haoyu-marsboard.dts b/arch/arm/b=
oot/dts/sun7i-a20-haoyu-marsboard.dts
> new file mode 100644
> index 000000000000..4c6c6ae0c459
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun7i-a20-haoyu-marsboard.dts
> @@ -0,0 +1,183 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
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
> +
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

See my comment on v3

Maxime

--cw4mmidoewi6oeca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYeFAowAKCRDj7w1vZxhR
xfMSAQCORSOVuXj7dX8+CrwJRPl/Es3bmoRvUwX4JnNOkiJgIQEAxEb7aQFRPKqG
nu+uMGT3V4istscivueMjZjp1DW6XA8=
=rZVi
-----END PGP SIGNATURE-----

--cw4mmidoewi6oeca--
