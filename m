Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DC55A987B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbiIANXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbiIANXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:23:09 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABC2C70;
        Thu,  1 Sep 2022 06:22:37 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 340CA40006;
        Thu,  1 Sep 2022 13:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662038556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8ifoc8MnyGm/HuNv+/zv89Af5DgIhcqdiqhcHduLr50=;
        b=BTLdDhFbobYOXYyaQQqavWqvQPnR8XeoEv/6fccNbi0tFGawF5hE83uKPHFDcFhNKMTETC
        KMlBIoNSgsx/K1VglTyCwrL5Z/yw+RbeSnq0Ex60lrQ2bagSHV9A4xCF0ZcEm9JT2aH7tW
        b6Qg/m3XkXbTIL+fV31kFAHf3HDNdsCyELaH5owcpAHGySnyXk5zmwX2yIlHTJ5wWyca/W
        woglvFaHGgdMk/lsINuf4hYbff05Fb3nRsf/awlYmDT2EQ5PgHC/7/SpScx0ePNVC+VObf
        z6raclMHV7JeX2+GV11jqL3TFHDQHux3gNwHQ1UsqVCsbFfip8cCm/uXDejImw==
Date:   Thu, 1 Sep 2022 15:22:34 +0200
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
Message-ID: <YxCyGgfNVHGIJlMz@aptenodytes>
References: <20220826182803.604563-1-paul.kocialkowski@bootlin.com>
 <20220826182803.604563-7-paul.kocialkowski@bootlin.com>
 <YwkaFC2tm96X5qon@pendragon.ideasonboard.com>
 <YxCqZ8GhiTJlZ8MC@aptenodytes>
 <YxCs4fhx+Qx7uCAF@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="F3YfJxNdUTpcoSsi"
Content-Disposition: inline
In-Reply-To: <YxCs4fhx+Qx7uCAF@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--F3YfJxNdUTpcoSsi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On Thu 01 Sep 22, 16:00, Laurent Pinchart wrote:
> On Thu, Sep 01, 2022 at 02:49:43PM +0200, Paul Kocialkowski wrote:
> > On Fri 26 Aug 22, 22:08, Laurent Pinchart wrote:
> > > On Fri, Aug 26, 2022 at 08:28:03PM +0200, Paul Kocialkowski wrote:
> > > > From: K=C3=A9vin L'h=C3=B4pital <kevin.lhopital@bootlin.com>
> > > >=20
> > > > The Bananapi M3 supports a camera module which includes an OV8865 s=
ensor
> > > > connected via the parallel CSI interface and an OV8865 sensor conne=
cted
> > > > via MIPI CSI-2.
> > > >=20
> > > > The I2C2 bus is shared by the two sensors as well as the (active-lo=
w)
> > > > reset signal, but each sensor has it own shutdown line.
> > >=20
> > > I see a single sensor in this file, am I missing something ?
> >=20
> > Indeed this patch only adds the OV8865, not the OV5640 which is also pr=
esent
> > on the same camera board extension.
> >=20
> > A patch was submitted some time ago adding support for (only) the OV564=
0:
> > https://lore.kernel.org/lkml/20190408165744.11672-7-wens@kernel.org/
>=20
> OK. That's fine, let's just reword the commit message.

Sure.

> > > Sounds like a perfect candidate for an overlay, it could then be merg=
ed
> > > upstream.
> >=20
> > Do we have an upstream place to merge device-tree overlays now?
>=20
> They're accepted in the upstream kernel as far as I know, a git grep for
> /plugin/ in .dts files produces 18 matches.

Oh okay, definitely good to know thanks!

> > I'll check if it's possible to describe both sensors together and actua=
lly
> > be able to select one or the other properly from userspace. Last time I=
 tried
> > this wasn't possible: there's at least the shared reset GPIO used by bo=
th
> > sensors, which cannot be requested by the two drivers in parallel.
> >=20
> > To be honest this is very poor hardware design and it was almost certai=
nly
> > designed with the idea that only one sensor will be configured per boot.
> > See https://wiki.banana-pi.org/Camera and
> > https://drive.google.com/file/d/0B4PAo2nW2KfnOEFTMjZ2aEVGUVU/view?usp=
=3Dsharing
> > for the schematics pdf
>=20
> It's not great indeed, but not that uncommon either (unfortunately). I
> wonder if we need some kind of reset GPIO API, but that would be a hack
> at most I think.

Yeah I don't see any obvious clean solution here.
But that could still be two separate dt overlays for now.

> > > > Signed-off-by: K=C3=A9vin L'h=C3=B4pital <kevin.lhopital@bootlin.co=
m>
> > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > ---
> > > >  arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 102 +++++++++++++++=
++++
> > > >  1 file changed, 102 insertions(+)
> > > >=20
> > > > diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/ar=
m/boot/dts/sun8i-a83t-bananapi-m3.dts
> > > > index 5a7e1bd5f825..80fd99cf24b2 100644
> > > > --- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> > > > +++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> > > > @@ -85,6 +85,30 @@ led-1 {
> > > >  		};
> > > >  	};
> > > > =20
> > > > +	reg_ov8865_avdd: ov8865-avdd {
> > > > +		compatible =3D "regulator-fixed";
> > > > +		regulator-name =3D "ov8865-avdd";
> > > > +		regulator-min-microvolt =3D <2800000>;
> > > > +		regulator-max-microvolt =3D <2800000>;
> > > > +		vin-supply =3D <&reg_dldo4>;
> > > > +	};
> > > > +
> > > > +	reg_ov8865_dovdd: ov8865-dovdd {
> > > > +		compatible =3D "regulator-fixed";
> > > > +		regulator-name =3D "ov8865-dovdd";
> > > > +		regulator-min-microvolt =3D <2800000>;
> > > > +		regulator-max-microvolt =3D <2800000>;
> > > > +		vin-supply =3D <&reg_dldo4>;
> > > > +	};
> > > > +
> > > > +	reg_ov8865_dvdd: ov8865-dvdd {
> > > > +		compatible =3D "regulator-fixed";
> > > > +		regulator-name =3D "ov8865-dvdd";
> > > > +		regulator-min-microvolt =3D <1200000>;
> > > > +		regulator-max-microvolt =3D <1200000>;
> > > > +		vin-supply =3D <&reg_eldo1>;
> > > > +	};
> > >=20
> > > Are those three regulators on the Banana Pi, or on the camera module ?
> >=20
> > That's on the camera module.
> >=20
> > > > +
> > > >  	reg_usb1_vbus: reg-usb1-vbus {
> > > >  		compatible =3D "regulator-fixed";
> > > >  		regulator-name =3D "usb1-vbus";
> > > > @@ -115,6 +139,23 @@ &cpu100 {
> > > >  	cpu-supply =3D <&reg_dcdc3>;
> > > >  };
> > > > =20
> > > > +&csi {
> > > > +	status =3D "okay";
> > > > +
> > > > +	ports {
> > > > +		#address-cells =3D <1>;
> > > > +		#size-cells =3D <0>;
> > > > +
> > > > +		port@1 {
> > > > +			reg =3D <1>;
> > >=20
> > > All of this (except the status =3D "okay") should go to sun8i-a83t.dt=
si.
> > >=20
> > > > +
> > > > +			csi_in_mipi_csi2: endpoint {
> > > > +				remote-endpoint =3D <&mipi_csi2_out_csi>;
> > > > +			};
> > >=20
> > > This too actually, once the issue mentioned in patch 5/6 gets fixed.
> > >=20
> > > > +		};
> > > > +	};
> > > > +};
> > > > +
> > > >  &de {
> > > >  	status =3D "okay";
> > > >  };
> > > > @@ -147,6 +188,36 @@ hdmi_out_con: endpoint {
> > > >  	};
> > > >  };
> > > > =20
> > > > +&i2c2 {
> > > > +	pinctrl-names =3D "default";
> > > > +	pinctrl-0 =3D <&i2c2_pe_pins>;
> > >=20
> > > This looks like a candidate for upstreaming in
> > > sun8i-a83t-bananapi-m3.dts, it shouldn't be in the overlay.
> >=20
> > I2C2 is actually also exported in the PH pins, which is available on th=
e board
> > header, so it's not obvious that using the PE pins should be the defaul=
t.
> >=20
> > The context is that Allwinner SoCs usually have a dedicated I2C control=
ler for
> > cameras, but also route a "generic" I2C controller on the same pins.
>=20
> Out of curiosity, what features do those dedicated camera I2C
> controllers provide, compared to "normal" I2C controllers ?

IIRC there's some feature to send i2c messages synced with the camera inter=
face
vsync signal, to have some kind of hardware atomic mechanism for reconfigur=
ing
a sensor.

Not sure that's very relevant for us and an implementation for it would pro=
bably
just support regular I2C. We can probably achieve simialr results with the
request API.

> > Here that's on the PE14/15 pins. Since we don't have mainline support f=
or this
> > camera-dedicated I2C controller, we end up routing the generic one to t=
he PE
> > pins, which are routed to the camera connector.
>=20
> OK.
>=20
> > In the future we could add support for this camera-dedicated controller=
, which
> > would then allow routing i2c2 to the PH pins independently. This is wha=
t the
> > downstream Allwinner BSP kernel does.
> >=20
> > > > +	status =3D "okay";
> > > > +
> > > > +	ov8865: camera@36 {
> > > > +		compatible =3D "ovti,ov8865";
> > > > +		reg =3D <0x36>;
> > > > +		pinctrl-names =3D "default";
> > > > +		pinctrl-0 =3D <&csi_mclk_pin>;
> > > > +		clocks =3D <&ccu CLK_CSI_MCLK>;
> > > > +		assigned-clocks =3D <&ccu CLK_CSI_MCLK>;
> > > > +		assigned-clock-rates =3D <24000000>;
> > > > +		avdd-supply =3D <&reg_ov8865_avdd>;
> > > > +		dovdd-supply =3D <&reg_ov8865_dovdd>;
> > > > +		dvdd-supply =3D <&reg_ov8865_dvdd>;
> > > > +		powerdown-gpios =3D <&pio 4 17 GPIO_ACTIVE_LOW>; /* PE17 */
> > > > +		reset-gpios =3D <&pio 4 16 GPIO_ACTIVE_LOW>; /* PE16 */
> > > > +
> > > > +		port {
> > > > +			ov8865_out_mipi_csi2: endpoint {
> > > > +				data-lanes =3D <1 2 3 4>;
> > > > +				link-frequencies =3D /bits/ 64 <360000000>;
> > > > +
> > > > +				remote-endpoint =3D <&mipi_csi2_in_ov8865>;
> > > > +			};
> > > > +		};
> > > > +	};
> > > > +};
> > > > +
> > > >  &mdio {
> > > >  	rgmii_phy: ethernet-phy@1 {
> > > >  		compatible =3D "ethernet-phy-ieee802.3-c22";
> > > > @@ -154,6 +225,24 @@ rgmii_phy: ethernet-phy@1 {
> > > >  	};
> > > >  };
> > > > =20
> > > > +&mipi_csi2 {
> > > > +	status =3D "okay";
> > > > +};
> > > > +
> > > > +&mipi_csi2_in {
> > > > +	mipi_csi2_in_ov8865: endpoint {
> > > > +		data-lanes =3D <1 2 3 4>;
> > > > +
> > > > +		remote-endpoint =3D <&ov8865_out_mipi_csi2>;
> > > > +	};
> > > > +};
> > > > +
> > > > +&mipi_csi2_out {
> > > > +	mipi_csi2_out_csi: endpoint {
> > > > +		remote-endpoint =3D <&csi_in_mipi_csi2>;
> > > > +	};
> > > > +};
> > > > +
> > > >  &mmc0 {
> > > >  	pinctrl-names =3D "default";
> > > >  	pinctrl-0 =3D <&mmc0_pins>;
> > > > @@ -327,11 +416,24 @@ &reg_dldo3 {
> > > >  	regulator-name =3D "vcc-pd";
> > > >  };
> > > > =20
> > > > +&reg_dldo4 {
> > > > +	regulator-always-on;
> > >=20
> > > Does it have to be always on ?
> >=20
> > Mhh so I realize the regulators handling here is quite messy.
> > I guess I didn't do such a good review of this patch internally.
> >=20
> > The situation is that the regulators on the camera board all have their
> > enable pin tied to the DLDO4 output, but that would be best described as
> > a vin-supply of the ov8865 regulators above. Their real vin supply is an
> > always-on board-wide power source but I don't think we can represent an=
other
> > regulator acting as enable signal in a better way.
>=20
> That's right. I've modeled that as a parent regulator in the past, even
> if it doesn't reflect the exact hardware topology, it's functionally
> equivalent.

Sounds good, I'll change it that way.

Cheers,

Paul

> > Now beware that the camera board schematics are confusing as they show =
resistors
> > (R17, R18, R19, R20, R23) connecting some power lines together, but the=
y are not
> > populated on the board (I guess the point is to make a variant of the d=
esign
> > without regulators on the camera board and to use ones from the PMU ins=
tead).
> > This probably confused Kevin and I back when this patch was made.
> >=20
> > > > +	regulator-min-microvolt =3D <2800000>;
> > > > +	regulator-max-microvolt =3D <2800000>;
> > > > +	regulator-name =3D "avdd-csi";
> > >=20
> > > Doesn't this belong to the base board .dts ? Same below.
> > >=20
> > > > +};
> > > > +
> > > >  &reg_drivevbus {
> > > >  	regulator-name =3D "usb0-vbus";AVDD-CSI
> > > >  	status =3D "okay";
> > > >  };
> > > > =20
> > > > +&reg_eldo1 {
> > > > +	regulator-min-microvolt =3D <1200000>;
> > > > +	regulator-max-microvolt =3D <1200000>;
> > > > +	regulator-name =3D "dvdd-csi-r";
> > > > +};
> > > > +
> > > >  &reg_fldo1 {
> > > >  	regulator-min-microvolt =3D <1080000>;
> > > >  	regulator-max-microvolt =3D <1320000>;
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--F3YfJxNdUTpcoSsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmMQshoACgkQ3cLmz3+f
v9HxTAgAjmdWywzl+7jrDK8Nag3l86LvLuaNOvzZWsKuyKXKlrbUCzyXI9vk9RHG
XvEXg0RBNVz0iu7PPiIkt+8ErFlXTOlBXSBOGaZluMG2jxdehnufzmU3GW1rTNX/
hwEFIk2MQDCKKSXiGD8F/BKMvHFTA5TI3ImBs884y+PW1lOoskWSNwPK3s9RfYt6
ozHqhutJrWMtHyD04GisOfZmMAhpxZFZcw3Ujw175zqBL7/YM7Jq/x27zYUDzYUm
6lZFGW3fWYn8i3So6eXyoPwKNrzX6k/yKcJCAva6jMV1bqdZJWZo6jkl6iJR9DXH
5KYZRfqTYPFQC5LXWERNf10fLrVMCQ==
=uLmS
-----END PGP SIGNATURE-----

--F3YfJxNdUTpcoSsi--
