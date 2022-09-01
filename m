Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBD35A975F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiIAMuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbiIAMtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:49:53 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74B5E44;
        Thu,  1 Sep 2022 05:49:47 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E630D40009;
        Thu,  1 Sep 2022 12:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662036586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LLjeDHGimLQUxXbTACnXVBtEQbYwP8b9e1Fg0R+UKC4=;
        b=iOqWi9lfxGhbmHbv6uAQlMsC7xBGNHlRWXZboZHVTQFGlknMBUTZ7tm8qK7yzt9MRWIl3z
        4j9j8zXRB/gf7stojrsdml6xrrTqJo1yfJ7217v6MURiBg8n8/9jhPcu7g02/NJ419TEpr
        Aqwjd3vzf5s9bPuzCPpPksxYhBidLnUedejex59S+jaKH3iiXmiAVutkPIbAdVEXaNZfgj
        gWl0v5taNTyhHDIuJhWf/tvg6gFwnNVdl5+RhNOOCfpMkchABlkOChp6F4M7rU3Cp9t9o0
        38QOSoPMEd3Tn0QD6avLjxRZ7ddx9aESBD6JLZkniprCvmmsdWkoOD7PZqy59g==
Date:   Thu, 1 Sep 2022 14:49:43 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?utf-8?B?S8OpdmluIEwnaMO0cGl0YWw=?= <kevin.lhopital@bootlin.com>
Subject: Re: [PATCH NOT FOR MERGE v5 6/6] ARM: dts: sun8i: a83t: bananapi-m3:
 Enable MIPI CSI-2 with OV8865
Message-ID: <YxCqZ8GhiTJlZ8MC@aptenodytes>
References: <20220826182803.604563-1-paul.kocialkowski@bootlin.com>
 <20220826182803.604563-7-paul.kocialkowski@bootlin.com>
 <YwkaFC2tm96X5qon@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rp38fnbGK/Yr/phy"
Content-Disposition: inline
In-Reply-To: <YwkaFC2tm96X5qon@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rp38fnbGK/Yr/phy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

Thansk for the review,

On Fri 26 Aug 22, 22:08, Laurent Pinchart wrote:
> Hi Paul and K=C3=A9vin,
>=20
> Thank you for the patch.
>=20
> On Fri, Aug 26, 2022 at 08:28:03PM +0200, Paul Kocialkowski wrote:
> > From: K=C3=A9vin L'h=C3=B4pital <kevin.lhopital@bootlin.com>
> >=20
> > The Bananapi M3 supports a camera module which includes an OV8865 sensor
> > connected via the parallel CSI interface and an OV8865 sensor connected
> > via MIPI CSI-2.
> >=20
> > The I2C2 bus is shared by the two sensors as well as the (active-low)
> > reset signal, but each sensor has it own shutdown line.
>=20
> I see a single sensor in this file, am I missing something ?

Indeed this patch only adds the OV8865, not the OV5640 which is also present
on the same camera board extension.

A patch was submitted some time ago adding support for (only) the OV5640:
https://lore.kernel.org/lkml/20190408165744.11672-7-wens@kernel.org/

> Sounds like a perfect candidate for an overlay, it could then be merged
> upstream.

Do we have an upstream place to merge device-tree overlays now?

I'll check if it's possible to describe both sensors together and actually
be able to select one or the other properly from userspace. Last time I tri=
ed
this wasn't possible: there's at least the shared reset GPIO used by both
sensors, which cannot be requested by the two drivers in parallel.

To be honest this is very poor hardware design and it was almost certainly
designed with the idea that only one sensor will be configured per boot.
See https://wiki.banana-pi.org/Camera and
https://drive.google.com/file/d/0B4PAo2nW2KfnOEFTMjZ2aEVGUVU/view?usp=3Dsha=
ring
for the schematics pdf

> > Signed-off-by: K=C3=A9vin L'h=C3=B4pital <kevin.lhopital@bootlin.com>
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 102 +++++++++++++++++++
> >  1 file changed, 102 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/bo=
ot/dts/sun8i-a83t-bananapi-m3.dts
> > index 5a7e1bd5f825..80fd99cf24b2 100644
> > --- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> > +++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> > @@ -85,6 +85,30 @@ led-1 {
> >  		};
> >  	};
> > =20
> > +	reg_ov8865_avdd: ov8865-avdd {
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "ov8865-avdd";
> > +		regulator-min-microvolt =3D <2800000>;
> > +		regulator-max-microvolt =3D <2800000>;
> > +		vin-supply =3D <&reg_dldo4>;
> > +	};
> > +
> > +	reg_ov8865_dovdd: ov8865-dovdd {
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "ov8865-dovdd";
> > +		regulator-min-microvolt =3D <2800000>;
> > +		regulator-max-microvolt =3D <2800000>;
> > +		vin-supply =3D <&reg_dldo4>;
> > +	};
> > +
> > +	reg_ov8865_dvdd: ov8865-dvdd {
> > +		compatible =3D "regulator-fixed";
> > +		regulator-name =3D "ov8865-dvdd";
> > +		regulator-min-microvolt =3D <1200000>;
> > +		regulator-max-microvolt =3D <1200000>;
> > +		vin-supply =3D <&reg_eldo1>;
> > +	};
>=20
> Are those three regulators on the Banana Pi, or on the camera module ?

That's on the camera module.

> > +
> >  	reg_usb1_vbus: reg-usb1-vbus {
> >  		compatible =3D "regulator-fixed";
> >  		regulator-name =3D "usb1-vbus";
> > @@ -115,6 +139,23 @@ &cpu100 {
> >  	cpu-supply =3D <&reg_dcdc3>;
> >  };
> > =20
> > +&csi {
> > +	status =3D "okay";
> > +
> > +	ports {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +
> > +		port@1 {
> > +			reg =3D <1>;
>=20
> All of this (except the status =3D "okay") should go to sun8i-a83t.dtsi.
>=20
> > +
> > +			csi_in_mipi_csi2: endpoint {
> > +				remote-endpoint =3D <&mipi_csi2_out_csi>;
> > +			};
>=20
> This too actually, once the issue mentioned in patch 5/6 gets fixed.
>=20
> > +		};
> > +	};
> > +};
> > +
> >  &de {
> >  	status =3D "okay";
> >  };
> > @@ -147,6 +188,36 @@ hdmi_out_con: endpoint {
> >  	};
> >  };
> > =20
> > +&i2c2 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&i2c2_pe_pins>;
>=20
> This looks like a candidate for upstreaming in
> sun8i-a83t-bananapi-m3.dts, it shouldn't be in the overlay.

I2C2 is actually also exported in the PH pins, which is available on the bo=
ard
header, so it's not obvious that using the PE pins should be the default.

The context is that Allwinner SoCs usually have a dedicated I2C controller =
for
cameras, but also route a "generic" I2C controller on the same pins.
Here that's on the PE14/15 pins. Since we don't have mainline support for t=
his
camera-dedicated I2C controller, we end up routing the generic one to the PE
pins, which are routed to the camera connector.

In the future we could add support for this camera-dedicated controller, wh=
ich
would then allow routing i2c2 to the PH pins independently. This is what the
downstream Allwinner BSP kernel does.

> > +	status =3D "okay";
> > +
> > +	ov8865: camera@36 {
> > +		compatible =3D "ovti,ov8865";
> > +		reg =3D <0x36>;
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&csi_mclk_pin>;
> > +		clocks =3D <&ccu CLK_CSI_MCLK>;
> > +		assigned-clocks =3D <&ccu CLK_CSI_MCLK>;
> > +		assigned-clock-rates =3D <24000000>;
> > +		avdd-supply =3D <&reg_ov8865_avdd>;
> > +		dovdd-supply =3D <&reg_ov8865_dovdd>;
> > +		dvdd-supply =3D <&reg_ov8865_dvdd>;
> > +		powerdown-gpios =3D <&pio 4 17 GPIO_ACTIVE_LOW>; /* PE17 */
> > +		reset-gpios =3D <&pio 4 16 GPIO_ACTIVE_LOW>; /* PE16 */
> > +
> > +		port {
> > +			ov8865_out_mipi_csi2: endpoint {
> > +				data-lanes =3D <1 2 3 4>;
> > +				link-frequencies =3D /bits/ 64 <360000000>;
> > +
> > +				remote-endpoint =3D <&mipi_csi2_in_ov8865>;
> > +			};
> > +		};
> > +	};
> > +};
> > +
> >  &mdio {
> >  	rgmii_phy: ethernet-phy@1 {
> >  		compatible =3D "ethernet-phy-ieee802.3-c22";
> > @@ -154,6 +225,24 @@ rgmii_phy: ethernet-phy@1 {
> >  	};
> >  };
> > =20
> > +&mipi_csi2 {
> > +	status =3D "okay";
> > +};
> > +
> > +&mipi_csi2_in {
> > +	mipi_csi2_in_ov8865: endpoint {
> > +		data-lanes =3D <1 2 3 4>;
> > +
> > +		remote-endpoint =3D <&ov8865_out_mipi_csi2>;
> > +	};
> > +};
> > +
> > +&mipi_csi2_out {
> > +	mipi_csi2_out_csi: endpoint {
> > +		remote-endpoint =3D <&csi_in_mipi_csi2>;
> > +	};
> > +};
> > +
> >  &mmc0 {
> >  	pinctrl-names =3D "default";
> >  	pinctrl-0 =3D <&mmc0_pins>;
> > @@ -327,11 +416,24 @@ &reg_dldo3 {
> >  	regulator-name =3D "vcc-pd";
> >  };
> > =20
> > +&reg_dldo4 {
> > +	regulator-always-on;
>=20
> Does it have to be always on ?

Mhh so I realize the regulators handling here is quite messy.
I guess I didn't do such a good review of this patch internally.

The situation is that the regulators on the camera board all have their
enable pin tied to the DLDO4 output, but that would be best described as
a vin-supply of the ov8865 regulators above. Their real vin supply is an
always-on board-wide power source but I don't think we can represent another
regulator acting as enable signal in a better way.

Now beware that the camera board schematics are confusing as they show resi=
stors
(R17, R18, R19, R20, R23) connecting some power lines together, but they ar=
e not
populated on the board (I guess the point is to make a variant of the design
without regulators on the camera board and to use ones from the PMU instead=
).
This probably confused Kevin and I back when this patch was made.

> > +	regulator-min-microvolt =3D <2800000>;
> > +	regulator-max-microvolt =3D <2800000>;
> > +	regulator-name =3D "avdd-csi";
>=20
> Doesn't this belong to the base board .dts ? Same below.
>=20
> > +};
> > +
> >  &reg_drivevbus {
> >  	regulator-name =3D "usb0-vbus";AVDD-CSI
> >  	status =3D "okay";
> >  };
> > =20
> > +&reg_eldo1 {
> > +	regulator-min-microvolt =3D <1200000>;
> > +	regulator-max-microvolt =3D <1200000>;
> > +	regulator-name =3D "dvdd-csi-r";
> > +};
> > +
> >  &reg_fldo1 {
> >  	regulator-min-microvolt =3D <1080000>;
> >  	regulator-max-microvolt =3D <1320000>;
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--rp38fnbGK/Yr/phy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmMQqmcACgkQ3cLmz3+f
v9GDFQf/VQ+p3Xw3yW2ohEmut7L4XdltqMO4frDEo6VgTcy5w0Xf0jpm7KVVv9Bz
aPl77g81aEpNwSIcFOaKv4N0pLCHTpxj03KjWK2vvjGT9bkmILakeMg1dq1QLDjd
ngyr6Prxg8pNOtr7zGjpr0S2RSiztuQ/iuDcv7d+Ky/1E1QKAvnllkoeIs9JcWHm
xDxK1XwIb06PcC5ZPHy4KkxC/Ek8dbAOio/bmf9tXE89Cx04nPMyqACTV6FPlDaS
LP10oNKaUdGZxs/QMs/Lp84R5yDlFE9m8ISDr4suixGqdzd6CzMpCXw/8qW8oE9D
hX6ce4EJHKbclBUy8yd5i+ZRHHaCbw==
=elp2
-----END PGP SIGNATURE-----

--rp38fnbGK/Yr/phy--
