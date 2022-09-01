Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564205A995B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbiIANqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiIANqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:46:44 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBC0A1B4;
        Thu,  1 Sep 2022 06:46:41 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F10ED200009;
        Thu,  1 Sep 2022 13:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662040000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z+IoeLIttfGVq/Jw3XCWgYvSa9STOAuApvqnqOTVmwk=;
        b=cLBzQiDULiEGUYluSucZ4RvChnII5m1GSP4VcbA3QUKeau+mlH/ISqDnp8WFbvVYLBHD4K
        XdKPYXxfrZ2FCQzLG0zJvDmexcWmFYB24Gu7VXfl0Fpr/3SDamagdhlXaXNS/3KbcQfdXu
        z3VRb525hGSnJ39gbCL9BXeqwCXRWzL2VKZQzuqwNZCPSE0wpLmMe7de+JiIEQ1gRVeNBj
        vQ7+WvYRgz36o5zEyaCc0To2qxAvEtTd84BpeKPmSSIgxTTvkiJ7m5HqCFrc32DrFX69cb
        qksZQc+vKWjU8ya1h4dOJ42fBwFBqSiwpCxmIV5KGupCn72mVXCkr32KEfmXrg==
Date:   Thu, 1 Sep 2022 15:46:37 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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
Message-ID: <YxC3vQsQ0nurKtfG@aptenodytes>
References: <20220826182803.604563-1-paul.kocialkowski@bootlin.com>
 <20220826182803.604563-7-paul.kocialkowski@bootlin.com>
 <YwkaFC2tm96X5qon@pendragon.ideasonboard.com>
 <YxCqZ8GhiTJlZ8MC@aptenodytes>
 <YxCs4fhx+Qx7uCAF@pendragon.ideasonboard.com>
 <YxCyGgfNVHGIJlMz@aptenodytes>
 <CAPY8ntD4EScbUC1kQCOqdPO_jF8gHKH6cjXpBkRW=AYsZSf=yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0ZAfyiXF723ioNHR"
Content-Disposition: inline
In-Reply-To: <CAPY8ntD4EScbUC1kQCOqdPO_jF8gHKH6cjXpBkRW=AYsZSf=yQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0ZAfyiXF723ioNHR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Thu 01 Sep 22, 14:34, Dave Stevenson wrote:
> Hi Laurent and Paul
>=20
> On Thu, 1 Sept 2022 at 14:23, Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> >
> > Hi Laurent,
> >
> > On Thu 01 Sep 22, 16:00, Laurent Pinchart wrote:
> > > On Thu, Sep 01, 2022 at 02:49:43PM +0200, Paul Kocialkowski wrote:
> > > > On Fri 26 Aug 22, 22:08, Laurent Pinchart wrote:
> > > > > On Fri, Aug 26, 2022 at 08:28:03PM +0200, Paul Kocialkowski wrote:
> > > > > > From: K=C3=A9vin L'h=C3=B4pital <kevin.lhopital@bootlin.com>
> > > > > >
> > > > > > The Bananapi M3 supports a camera module which includes an OV88=
65 sensor
> > > > > > connected via the parallel CSI interface and an OV8865 sensor c=
onnected
> > > > > > via MIPI CSI-2.
> > > > > >
> > > > > > The I2C2 bus is shared by the two sensors as well as the (activ=
e-low)
> > > > > > reset signal, but each sensor has it own shutdown line.
> > > > >
> > > > > I see a single sensor in this file, am I missing something ?
> > > >
> > > > Indeed this patch only adds the OV8865, not the OV5640 which is als=
o present
> > > > on the same camera board extension.
> > > >
> > > > A patch was submitted some time ago adding support for (only) the O=
V5640:
> > > > https://lore.kernel.org/lkml/20190408165744.11672-7-wens@kernel.org/
> > >
> > > OK. That's fine, let's just reword the commit message.
> >
> > Sure.
> >
> > > > > Sounds like a perfect candidate for an overlay, it could then be =
merged
> > > > > upstream.
> > > >
> > > > Do we have an upstream place to merge device-tree overlays now?
> > >
> > > They're accepted in the upstream kernel as far as I know, a git grep =
for
> > > /plugin/ in .dts files produces 18 matches.
> >
> > Oh okay, definitely good to know thanks!
> >
> > > > I'll check if it's possible to describe both sensors together and a=
ctually
> > > > be able to select one or the other properly from userspace. Last ti=
me I tried
> > > > this wasn't possible: there's at least the shared reset GPIO used b=
y both
> > > > sensors, which cannot be requested by the two drivers in parallel.
> > > >
> > > > To be honest this is very poor hardware design and it was almost ce=
rtainly
> > > > designed with the idea that only one sensor will be configured per =
boot.
> > > > See https://wiki.banana-pi.org/Camera and
> > > > https://drive.google.com/file/d/0B4PAo2nW2KfnOEFTMjZ2aEVGUVU/view?u=
sp=3Dsharing
> > > > for the schematics pdf
> > >
> > > It's not great indeed, but not that uncommon either (unfortunately). I
> > > wonder if we need some kind of reset GPIO API, but that would be a ha=
ck
> > > at most I think.
> >
> > Yeah I don't see any obvious clean solution here.
> > But that could still be two separate dt overlays for now.
>=20
> Just to throw the idea out there, (ab)use the regulator API so that
> they share a regulator-gpio device that claims that GPIO.
> When either sensor requests the regulator, the reset line will get
> pulled to the appropriate state.

Yeah I guess that would solve the single-gpio/multiple-users issue.
But besides abusing one of the regulators for the job, that would also make
it hard to respect the power sequence of the sensor.

I think I would be happier with a dedicated GPIO reset driver that consumes=
 a
single GPIO and provides as many GPIOs as needed with a behavior similar to
a reset controller: go out of reset as soon as one of the provided GPIOs
requests it and get back to reset as soon as all the provided GPIOs need
reset.

It's a bit weird but maybe that's legit enough to make its way upstream.

Paul

>   Dave
>=20
> > > > > > Signed-off-by: K=C3=A9vin L'h=C3=B4pital <kevin.lhopital@bootli=
n.com>
> > > > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > > > ---
> > > > > >  arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 102 +++++++++++=
++++++++
> > > > > >  1 file changed, 102 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arc=
h/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> > > > > > index 5a7e1bd5f825..80fd99cf24b2 100644
> > > > > > --- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> > > > > > +++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> > > > > > @@ -85,6 +85,30 @@ led-1 {
> > > > > >                 };
> > > > > >         };
> > > > > >
> > > > > > +       reg_ov8865_avdd: ov8865-avdd {
> > > > > > +               compatible =3D "regulator-fixed";
> > > > > > +               regulator-name =3D "ov8865-avdd";
> > > > > > +               regulator-min-microvolt =3D <2800000>;
> > > > > > +               regulator-max-microvolt =3D <2800000>;
> > > > > > +               vin-supply =3D <&reg_dldo4>;
> > > > > > +       };
> > > > > > +
> > > > > > +       reg_ov8865_dovdd: ov8865-dovdd {
> > > > > > +               compatible =3D "regulator-fixed";
> > > > > > +               regulator-name =3D "ov8865-dovdd";
> > > > > > +               regulator-min-microvolt =3D <2800000>;
> > > > > > +               regulator-max-microvolt =3D <2800000>;
> > > > > > +               vin-supply =3D <&reg_dldo4>;
> > > > > > +       };
> > > > > > +
> > > > > > +       reg_ov8865_dvdd: ov8865-dvdd {
> > > > > > +               compatible =3D "regulator-fixed";
> > > > > > +               regulator-name =3D "ov8865-dvdd";
> > > > > > +               regulator-min-microvolt =3D <1200000>;
> > > > > > +               regulator-max-microvolt =3D <1200000>;
> > > > > > +               vin-supply =3D <&reg_eldo1>;
> > > > > > +       };
> > > > >
> > > > > Are those three regulators on the Banana Pi, or on the camera mod=
ule ?
> > > >
> > > > That's on the camera module.
> > > >
> > > > > > +
> > > > > >         reg_usb1_vbus: reg-usb1-vbus {
> > > > > >                 compatible =3D "regulator-fixed";
> > > > > >                 regulator-name =3D "usb1-vbus";
> > > > > > @@ -115,6 +139,23 @@ &cpu100 {
> > > > > >         cpu-supply =3D <&reg_dcdc3>;
> > > > > >  };
> > > > > >
> > > > > > +&csi {
> > > > > > +       status =3D "okay";
> > > > > > +
> > > > > > +       ports {
> > > > > > +               #address-cells =3D <1>;
> > > > > > +               #size-cells =3D <0>;
> > > > > > +
> > > > > > +               port@1 {
> > > > > > +                       reg =3D <1>;
> > > > >
> > > > > All of this (except the status =3D "okay") should go to sun8i-a83=
t.dtsi.
> > > > >
> > > > > > +
> > > > > > +                       csi_in_mipi_csi2: endpoint {
> > > > > > +                               remote-endpoint =3D <&mipi_csi2=
_out_csi>;
> > > > > > +                       };
> > > > >
> > > > > This too actually, once the issue mentioned in patch 5/6 gets fix=
ed.
> > > > >
> > > > > > +               };
> > > > > > +       };
> > > > > > +};
> > > > > > +
> > > > > >  &de {
> > > > > >         status =3D "okay";
> > > > > >  };
> > > > > > @@ -147,6 +188,36 @@ hdmi_out_con: endpoint {
> > > > > >         };
> > > > > >  };
> > > > > >
> > > > > > +&i2c2 {
> > > > > > +       pinctrl-names =3D "default";
> > > > > > +       pinctrl-0 =3D <&i2c2_pe_pins>;
> > > > >
> > > > > This looks like a candidate for upstreaming in
> > > > > sun8i-a83t-bananapi-m3.dts, it shouldn't be in the overlay.
> > > >
> > > > I2C2 is actually also exported in the PH pins, which is available o=
n the board
> > > > header, so it's not obvious that using the PE pins should be the de=
fault.
> > > >
> > > > The context is that Allwinner SoCs usually have a dedicated I2C con=
troller for
> > > > cameras, but also route a "generic" I2C controller on the same pins.
> > >
> > > Out of curiosity, what features do those dedicated camera I2C
> > > controllers provide, compared to "normal" I2C controllers ?
> >
> > IIRC there's some feature to send i2c messages synced with the camera i=
nterface
> > vsync signal, to have some kind of hardware atomic mechanism for reconf=
iguring
> > a sensor.
> >
> > Not sure that's very relevant for us and an implementation for it would=
 probably
> > just support regular I2C. We can probably achieve simialr results with =
the
> > request API.
> >
> > > > Here that's on the PE14/15 pins. Since we don't have mainline suppo=
rt for this
> > > > camera-dedicated I2C controller, we end up routing the generic one =
to the PE
> > > > pins, which are routed to the camera connector.
> > >
> > > OK.
> > >
> > > > In the future we could add support for this camera-dedicated contro=
ller, which
> > > > would then allow routing i2c2 to the PH pins independently. This is=
 what the
> > > > downstream Allwinner BSP kernel does.
> > > >
> > > > > > +       status =3D "okay";
> > > > > > +
> > > > > > +       ov8865: camera@36 {
> > > > > > +               compatible =3D "ovti,ov8865";
> > > > > > +               reg =3D <0x36>;
> > > > > > +               pinctrl-names =3D "default";
> > > > > > +               pinctrl-0 =3D <&csi_mclk_pin>;
> > > > > > +               clocks =3D <&ccu CLK_CSI_MCLK>;
> > > > > > +               assigned-clocks =3D <&ccu CLK_CSI_MCLK>;
> > > > > > +               assigned-clock-rates =3D <24000000>;
> > > > > > +               avdd-supply =3D <&reg_ov8865_avdd>;
> > > > > > +               dovdd-supply =3D <&reg_ov8865_dovdd>;
> > > > > > +               dvdd-supply =3D <&reg_ov8865_dvdd>;
> > > > > > +               powerdown-gpios =3D <&pio 4 17 GPIO_ACTIVE_LOW>=
; /* PE17 */
> > > > > > +               reset-gpios =3D <&pio 4 16 GPIO_ACTIVE_LOW>; /*=
 PE16 */
> > > > > > +
> > > > > > +               port {
> > > > > > +                       ov8865_out_mipi_csi2: endpoint {
> > > > > > +                               data-lanes =3D <1 2 3 4>;
> > > > > > +                               link-frequencies =3D /bits/ 64 =
<360000000>;
> > > > > > +
> > > > > > +                               remote-endpoint =3D <&mipi_csi2=
_in_ov8865>;
> > > > > > +                       };
> > > > > > +               };
> > > > > > +       };
> > > > > > +};
> > > > > > +
> > > > > >  &mdio {
> > > > > >         rgmii_phy: ethernet-phy@1 {
> > > > > >                 compatible =3D "ethernet-phy-ieee802.3-c22";
> > > > > > @@ -154,6 +225,24 @@ rgmii_phy: ethernet-phy@1 {
> > > > > >         };
> > > > > >  };
> > > > > >
> > > > > > +&mipi_csi2 {
> > > > > > +       status =3D "okay";
> > > > > > +};
> > > > > > +
> > > > > > +&mipi_csi2_in {
> > > > > > +       mipi_csi2_in_ov8865: endpoint {
> > > > > > +               data-lanes =3D <1 2 3 4>;
> > > > > > +
> > > > > > +               remote-endpoint =3D <&ov8865_out_mipi_csi2>;
> > > > > > +       };
> > > > > > +};
> > > > > > +
> > > > > > +&mipi_csi2_out {
> > > > > > +       mipi_csi2_out_csi: endpoint {
> > > > > > +               remote-endpoint =3D <&csi_in_mipi_csi2>;
> > > > > > +       };
> > > > > > +};
> > > > > > +
> > > > > >  &mmc0 {
> > > > > >         pinctrl-names =3D "default";
> > > > > >         pinctrl-0 =3D <&mmc0_pins>;
> > > > > > @@ -327,11 +416,24 @@ &reg_dldo3 {
> > > > > >         regulator-name =3D "vcc-pd";
> > > > > >  };
> > > > > >
> > > > > > +&reg_dldo4 {
> > > > > > +       regulator-always-on;
> > > > >
> > > > > Does it have to be always on ?
> > > >
> > > > Mhh so I realize the regulators handling here is quite messy.
> > > > I guess I didn't do such a good review of this patch internally.
> > > >
> > > > The situation is that the regulators on the camera board all have t=
heir
> > > > enable pin tied to the DLDO4 output, but that would be best describ=
ed as
> > > > a vin-supply of the ov8865 regulators above. Their real vin supply =
is an
> > > > always-on board-wide power source but I don't think we can represen=
t another
> > > > regulator acting as enable signal in a better way.
> > >
> > > That's right. I've modeled that as a parent regulator in the past, ev=
en
> > > if it doesn't reflect the exact hardware topology, it's functionally
> > > equivalent.
> >
> > Sounds good, I'll change it that way.
> >
> > Cheers,
> >
> > Paul
> >
> > > > Now beware that the camera board schematics are confusing as they s=
how resistors
> > > > (R17, R18, R19, R20, R23) connecting some power lines together, but=
 they are not
> > > > populated on the board (I guess the point is to make a variant of t=
he design
> > > > without regulators on the camera board and to use ones from the PMU=
 instead).
> > > > This probably confused Kevin and I back when this patch was made.
> > > >
> > > > > > +       regulator-min-microvolt =3D <2800000>;
> > > > > > +       regulator-max-microvolt =3D <2800000>;
> > > > > > +       regulator-name =3D "avdd-csi";
> > > > >
> > > > > Doesn't this belong to the base board .dts ? Same below.
> > > > >
> > > > > > +};
> > > > > > +
> > > > > >  &reg_drivevbus {
> > > > > >         regulator-name =3D "usb0-vbus";AVDD-CSI
> > > > > >         status =3D "okay";
> > > > > >  };
> > > > > >
> > > > > > +&reg_eldo1 {
> > > > > > +       regulator-min-microvolt =3D <1200000>;
> > > > > > +       regulator-max-microvolt =3D <1200000>;
> > > > > > +       regulator-name =3D "dvdd-csi-r";
> > > > > > +};
> > > > > > +
> > > > > >  &reg_fldo1 {
> > > > > >         regulator-min-microvolt =3D <1080000>;
> > > > > >         regulator-max-microvolt =3D <1320000>;
> > >
> > > --
> > > Regards,
> > >
> > > Laurent Pinchart
> >
> > --
> > Paul Kocialkowski, Bootlin
> > Embedded Linux and kernel engineering
> > https://bootlin.com

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--0ZAfyiXF723ioNHR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmMQt70ACgkQ3cLmz3+f
v9GFGQf9FQD7iR4VyS2u/b8CFia00cS4tJ7UuNM5Yiw247b42HxusZ6zPfC4PyDt
vpF86nrIYSJWQOFRay0c7wriqyqrSfdqC7Su40PQFyJoiDJ63R/aQxjG7mNUc2UI
Gf9P6iIFc9Bar1uH2utpzDTO3wHuXsA13kkDI2yfyk3PJpuBs3fLvnt5Uj7n58N9
JkfdvY2MOUoDfrJ7pDnb63uIV8WcLNxjFAaPaHeB4VF18OotCvU18KYzkG+EUQ8b
dCf44uTn9qlB8ufcu04UV6m8A1Kk+mN/ZImMbdHv3pCXpisxbdMi9ETJ3+fqu5KK
bJ9GJMIWyqW1QhBdrsnVoJ/vrosMBg==
=X0ZG
-----END PGP SIGNATURE-----

--0ZAfyiXF723ioNHR--
