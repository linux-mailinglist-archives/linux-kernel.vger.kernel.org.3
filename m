Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646D94AEE58
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbiBIJmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:42:16 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiBIJmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:42:08 -0500
X-Greylist: delayed 345 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 01:42:00 PST
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEE6C002B58;
        Wed,  9 Feb 2022 01:41:59 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 99E935801CF;
        Wed,  9 Feb 2022 03:49:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 09 Feb 2022 03:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=vgV93o7ZWfva8IcoGzKI+O88Ef4tmR0y2ADzl2
        si4ls=; b=QYr5QPWTS+b1BNf5Bvx48ApqtrmXpfGeYlQIgUK37KwW6UCBHvTzOU
        fEkXdCA+Sg5WCcWW8IJzCRYXOwBTlTohwrUVtf2mEVcnXOxXNmNu74Cy3OmSgtgZ
        WzFY+ttBP+JTTZzgwStoGZ//+rMpm7+Jx9TYxIkalGqGOBy3SClSrzlmQbFS6nXf
        AZVe2/5zAceMscYv8Yh4S9hIh1Rf04ZZjopFYICWCUBR5TWuXamgkuj1/2X/SAHo
        TaLbA7MdzeyVF5gM//MBEypBb9O07mA6ZZDOgLkNBC+zsABiXuqsDz9wC4x07kR3
        OocmsCnXXP18mKBFo2gQJGxe49vZ9VWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=vgV93o7ZWfva8IcoG
        zKI+O88Ef4tmR0y2ADzl2si4ls=; b=DPjoYL7FAcFkvTrUiBXK5Y6W4cxxZVJMf
        hlYEhIf7MTbVtSCa3BDazDElg6R8Jblongmrx+HpK/g57dnnAtHNVbgm/lIgdPeA
        dgARQP6VAYTpYtk1o1v2/rsxZ1/Gno0pNg9+onHfoUM0gsQ/q65O3cf6IE3ujmEs
        NaMGlvP1tr6Sx2LhfrS650e6Ib8Pixpt9PutoOoGA98UtJZRr6GJMatvAy99KKy/
        QocstKVp0QGXF6Fzl+Qb8NNNKq7+zn3xRpX7KfpVAmgI4GLnamm3iYSkYEAZJ9I1
        MceY2Ca8uT5IKG3D4ONIoGmfkk8t4mHtSumXCCA2UTA0CPlMj96kg==
X-ME-Sender: <xms:BoADYtJ_GuPX4qNVokXEIe371o5cNHXjAa8D32kjRaxuLrMpt30JjA>
    <xme:BoADYpI0rbqFe_-NvKBhCGl4ZOE9aBN3w88UNr_4HLGbsWSw6Z6N-7ZTab9SiuO2l
    OK00x7MkhLnq8MNMkw>
X-ME-Received: <xmr:BoADYlvm8iImlX3xn4kL8c4g--RDCRwCyXtWeMk5Mp-46n2hCSqgaVJfgmNRrn7uESe5whtMRirmtPMrzAz0dtq0Jy4x6nALf9OyXxY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheekgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepuddvudfhkeekhefgffetffelgffftdehffduffegveetffehueeivddvjedv
    gfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:BoADYuZCKafGeSZa3_TYhIPOk7ArU0Nc2VyWikmXXCJ0JB80ldLVGA>
    <xmx:BoADYkbk95pyimwHi5E4tTY7RO7ZlYkD3Lv7c5jXWEVUuCqU8qoSpA>
    <xmx:BoADYiCyEViiPuSyNPDaH0Bu3an2T1TJ-wuMTvrSYOs2qLaj0_3R0A>
    <xmx:B4ADYuvguaWiMPEfJTHOaQlECxnmsR_lk70DPLCTrBKwl_KqMp386w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Feb 2022 03:49:10 -0500 (EST)
Date:   Wed, 9 Feb 2022 09:49:08 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Sui Jingfeng <15330273260@189.cn>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        suijingfeng <suijingfeng@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v6 1/3] drm/lsdc: add drm driver for loongson display
 controller
Message-ID: <20220209084908.kub4bs64rzhvpvon@houat>
References: <20220203082546.3099-1-15330273260@189.cn>
 <20220203082546.3099-2-15330273260@189.cn>
 <20220203085851.yqstkfgt4dz7rcnw@houat>
 <11ac5696-29e3-fefa-31c0-b7b86c88bbdc@189.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r77g3wuskrctnvhb"
Content-Disposition: inline
In-Reply-To: <11ac5696-29e3-fefa-31c0-b7b86c88bbdc@189.cn>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r77g3wuskrctnvhb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 04, 2022 at 12:04:19AM +0800, Sui Jingfeng wrote:
> > > +/* Get the simple EDID data from the device tree
> > > + * the length must be EDID_LENGTH, since it is simple.
> > > + *
> > > + * @np: device node contain edid data
> > > + * @edid_data: where the edid data to store to
> > > + */
> > > +static bool lsdc_get_edid_from_dtb(struct device_node *np,
> > > +				   unsigned char *edid_data)
> > > +{
> > > +	int length;
> > > +	const void *prop;
> > > +
> > > +	if (np =3D=3D NULL)
> > > +		return false;
> > > +
> > > +	prop =3D of_get_property(np, "edid", &length);
> > > +	if (prop && (length =3D=3D EDID_LENGTH)) {
> > > +		memcpy(edid_data, prop, EDID_LENGTH);
> > > +		return true;
> > > +	}
> > > +
> > > +	return false;
> > > +}
> >
> > You don't have a device tree binding for that driver, this is something
> > that is required. And it's not clear to me why you'd want EDID in the
> > DTB?
>=20
> 1) It is left to the end user of this driver.
>=20
> The downstream motherboard maker may use a dpi(XRGB888) or LVDS panel
> which don't have DDC support either, doing this way allow them put a
> EDID property into the dc device node in the DTS. Then the entire system =
works.
> Note those panel usually support only one display mode.

I guess it depends on what we mean exactly by the user, but the DTB
usually isn't under the (end) user control. And the drm.edid_firmware is
here already to address exactly this issue.

On the other end, if the board has a static panel without any DDC lines,
then just put the timings in the device tree, there's no need for an
EDID blob.

> 2) That is for the display controller in ls2k1000 SoC.
>=20
> Currently, the upstream kernel still don't have GPIO, PWM and I2C driver =
support
> for LS2K1000 SoC.
>=20
> How dose you read EDID from the monitor without a I2C driver?
>=20
> without reading EDID the device tree support, the screen just black,
> the lsdc driver just stall.=A0With reading EDID from device tree support
> we do not need=A0a i2c driver to light up the monitor.
>=20
> This make lsdc drm driver work on various ls2k1000 development board
> before I2C driver and GPIO driver and PWM backlight driver is upstream.
>=20
> I have many local private dts with the bindings,=A0those local change jus=
t can not
> upstream at this time, below is an example.

The device tree is a platform description language. It's there to let
the OS know what the hardware is, but the state of hardware support in
the said OS isn't a parameter we have to take into account for a new
binding.

If you don't have any DDC support at the moment, use the firmware
mechanism above, or add fixed modes using drm_add_modes_noedid in the
driver, and leave the DT out of it. Once you'll gain support for the
EDID readout in the driver, then it'll just work and you won't need to
change the DT again.

> 3) Again, doing this way is for graphic environment bring up.
>=20
> &lsdc {
>=20
> =A0=A0=A0 output-ports =3D <&dvo0 &dvo1>;
> =A0=A0 =A0#address-cells =3D <1>;
> =A0=A0 =A0#size-cells =3D <0>;
> =A0=A0 =A0dvo0: dvo@0 {
> =A0=A0 =A0=A0=A0=A0 reg =3D <0>;
>=20
> =A0=A0 =A0=A0=A0=A0 connector =3D "dpi-connector";
> =A0=A0 =A0=A0=A0=A0 encoder =3D "none";
> =A0=A0 =A0=A0=A0=A0 status =3D "ok";
>=20
> =A0=A0 =A0=A0=A0=A0 display-timings {
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 native-mode =3D <&mode_0_1024x600_60>;
>=20
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 mode_0_1024x600_60: panel-timing@0 {
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 clock-frequency =3D <51200000>;
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 hactive =3D <1024>;
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 vactive =3D <600>;
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 hsync-len =3D <4>;
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 hfront-porch =3D <160>;
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 hback-porch =3D <156>;
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 vfront-porch =3D <11>;
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 vback-porch =3D <23>;
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 vsync-len =3D <1>;
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 };
>=20
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 mode_1_800x480_60: panel-timing@1 {
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 clock-frequency =3D <30066000>;
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 hactive =3D <800>;
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 vactive =3D <480>;
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 hfront-porch =3D <50>;
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 hback-porch =3D <70>;
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 hsync-len =3D <50>;
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 vback-porch =3D <0>;
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 vfront-porch =3D <0>;
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 vsync-len =3D <50>;
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 };
> =A0=A0 =A0=A0=A0=A0 };
> =A0=A0 =A0};
>=20
> =A0=A0 =A0dvo1: dvo@1 {
> =A0=A0 =A0=A0=A0=A0 reg =3D <1>;
>=20
> =A0=A0 =A0=A0=A0=A0 connector =3D "hdmi-connector";
> =A0=A0 =A0=A0=A0=A0 type =3D "a";
> =A0=A0 =A0=A0=A0=A0 encoder =3D "sil9022";
>=20
> =A0=A0 =A0=A0=A0=A0 edid =3D [ 00 ff ff ff ff ff ff 00 1e 6d 54 5b 0b cc =
04 00
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 =A002 1c 01 03 6c 30 1b 78 ea 31 35 a5 55 4=
e a1 26
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 =A00c 50 54 a5 4b 00 71 4f 81 80 95 00 b3 0=
0 a9 c0
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 =A081 00 81 c0 90 40 02 3a 80 18 71 38 2d 4=
0 58 2c
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 =A045 00 e0 0e 11 00 00 1e 00 00 00 fd 00 3=
8 4b 1e
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 =A053 0f 00 0a 20 20 20 20 20 20 00 00 00 f=
c 00 4c
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 =A047 20 46 55 4c 4c 20 48 44 0a 20 20 00 0=
0 00 ff
> =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 =A000 38 30 32 4e 54 43 5a 39 38 33 37 39 0=
a 00 35 ];
>=20
> =A0=A0 =A0=A0=A0=A0 status =3D "ok";
> =A0=A0 =A0};
> };

Yeah, this needs to be documented with a YAML schema

Maxime

--r77g3wuskrctnvhb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYgOABAAKCRDj7w1vZxhR
xcqQAPoCO8RFsMQiG+M3oN0lyPINEsdnoV/2E/pqd1QmY9SjDwD/f0/v/7Gyn07K
3BH4a+6ABQn5SdVLCtguKDVlqnIa8QQ=
=b18p
-----END PGP SIGNATURE-----

--r77g3wuskrctnvhb--
