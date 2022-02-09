Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D1D4AF652
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236046AbiBIQQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbiBIQQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:16:34 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55D6C061355;
        Wed,  9 Feb 2022 08:16:33 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 55B10580226;
        Wed,  9 Feb 2022 11:16:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 09 Feb 2022 11:16:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=7l18+A7I5YFiWg0p9PkixroHILub5lbAvAQ1vB
        vv8Uo=; b=rh+9welRULADuU5aha4PERLHpZl33qUtqdALGbaIP9mTI7TQ+eo8eF
        miWZrMZWid0JtfWMhZnN3RKLIG7f/sr/Aw3ZOLT8j4IKQaLwkZUltNyd9t0jLqst
        RhIu4E+0UuNVUesjkZ4RdIpUZjawkPxBD1Cq6EUj/6wGEmVDxaWyPTNQrhIWazXf
        WRSAHVDwNHtAxHKV3gfmUnPgSFVCkeICEsWIVoObWoHVVosfy8MXOMR19flkMeJp
        km2whvXTtCq1pTkDOoBsgJLbX9y+zIdxlPonWhukmPgDV5hNbkAdrCd+HpE9JUrE
        qJET5/PXv8fqUlnYrrINFuMbC+O9dQRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=7l18+A7I5YFiWg0p9
        PkixroHILub5lbAvAQ1vBvv8Uo=; b=PGbURF4biYbiO947WTkEUQIeX3jvMdjNj
        /jzJB7fDQjxR0WXxEQu/HiuSAABW3cUWDzqlaO8vlpEXYI/qzCO33UICgcxQqFIk
        EQT3sXIxs0Rmu+mU3KPqHDffdN+iCIW9dMcq+C7fn6BDdYZ79wzqOqRt4WX/Tn3V
        V668KLc85EI6F+u/VYDLOqDxUagunIevcgUhctm8g6ONKNHklxRUqx2nT2KPA3iL
        haYn+s9vE08e15Jo5W++qmVxzK3h73QplcQaPj5jy0cja15g+GC0PtMB1/63ZlWW
        Fq8GxrI4VAlZI5zXdeB8CLjMANA2IvCrNaynH8f7unmL1de5k38DQ==
X-ME-Sender: <xms:3OgDYmdX27H2h5ghkvtFjpHAZ7gWDF6rE9Ll52vJc-4eIFw9TwmSHw>
    <xme:3OgDYgPd1PfzEPNQh6NZ-_1xB3Da4mYgn-H2w9iI7ipXMzTIvHVOSJWkLMcnSEAae
    nhsOSbBOzq7N_lp2m4>
X-ME-Received: <xmr:3OgDYngkVxRM-FSts7H4_hrit6sngi7Hurq09b7trt8gsQE3eyjI7RIR6oQedvm9zWKo6vwKyA7K-Iwrhgg5sacNpMkuPrlV9Jh2uCE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheelgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:3OgDYj_DYec5cHAi3Wdn2ZHQQzI5iNB0huioEgm5IF7M2Dtevq8NOg>
    <xmx:3OgDYiuAYjbFD3bYKwQEFs5V3dO06aM-7XZNdQkbnsQ-2VQCNWnH_Q>
    <xmx:3OgDYqHQoZl3it15r0dfFwQ4DpqH9SrjWLVtb3VoqF1aMgOYreLP6A>
    <xmx:3ugDYqRDRAjYxWoFVyh9pE0ilLGHWnKsGK0ixsTX6FX3vdmbdpclRg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Feb 2022 11:16:27 -0500 (EST)
Date:   Wed, 9 Feb 2022 17:16:24 +0100
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
Message-ID: <20220209161624.42ijbnhanaaari46@houat>
References: <20220203082546.3099-1-15330273260@189.cn>
 <20220203082546.3099-2-15330273260@189.cn>
 <20220203085851.yqstkfgt4dz7rcnw@houat>
 <11ac5696-29e3-fefa-31c0-b7b86c88bbdc@189.cn>
 <20220209084908.kub4bs64rzhvpvon@houat>
 <84bfb2fc-595c-3bae-e8a0-c19ccbcfcfd8@189.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uxe4dlurlg6xpvsg"
Content-Disposition: inline
In-Reply-To: <84bfb2fc-595c-3bae-e8a0-c19ccbcfcfd8@189.cn>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uxe4dlurlg6xpvsg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 09, 2022 at 10:38:41PM +0800, Sui Jingfeng wrote:
> On 2022/2/9 16:49, Maxime Ripard wrote:
> > On Fri, Feb 04, 2022 at 12:04:19AM +0800, Sui Jingfeng wrote:
> > > > > +/* Get the simple EDID data from the device tree
> > > > > + * the length must be EDID_LENGTH, since it is simple.
> > > > > + *
> > > > > + * @np: device node contain edid data
> > > > > + * @edid_data: where the edid data to store to
> > > > > + */
> > > > > +static bool lsdc_get_edid_from_dtb(struct device_node *np,
> > > > > +				   unsigned char *edid_data)
> > > > > +{
> > > > > +	int length;
> > > > > +	const void *prop;
> > > > > +
> > > > > +	if (np =3D=3D NULL)
> > > > > +		return false;
> > > > > +
> > > > > +	prop =3D of_get_property(np, "edid", &length);
> > > > > +	if (prop && (length =3D=3D EDID_LENGTH)) {
> > > > > +		memcpy(edid_data, prop, EDID_LENGTH);
> > > > > +		return true;
> > > > > +	}
> > > > > +
> > > > > +	return false;
> > > > > +}
> > > > You don't have a device tree binding for that driver, this is somet=
hing
> > > > that is required. And it's not clear to me why you'd want EDID in t=
he
> > > > DTB?
> > > 1) It is left to the end user of this driver.
> > >=20
> > > The downstream motherboard maker may use a dpi(XRGB888) or LVDS panel
> > > which don't have DDC support either, doing this way allow them put a
> > > EDID property into the dc device node in the DTS. Then the entire sys=
tem works.
> > > Note those panel usually support only one display mode.
> > I guess it depends on what we mean exactly by the user, but the DTB
> > usually isn't under the (end) user control. And the drm.edid_firmware is
> > here already to address exactly this issue.
> >=20
> > On the other end, if the board has a static panel without any DDC lines,
> > then just put the timings in the device tree, there's no need for an
> > EDID blob.
>=20
> Loongson have a long history of using PMON firmware, The PMON firmware
> support flush the dtb into the the firmware before grub loading the kerne=
l.
> You press 'c' key, then the PMON will give you a shell. it is much like a
> UEFI shell. Suppose foo.dtb is what you want to pass to the vmlinuz.
> Then type the follow single command can flush the dtb into the PMON firmw=
are.
>=20
> |load_dtb /dev/fs/fat@usb0/foo.dtb|
>=20
> For our PMON firmware, it**is**  totally under developer/pc board maker's=
 control.
> You can flush whatever dtb every time you bootup until you satisfied.
> It(the pmon firmware) is designed to let downstream motherboard maker and=
/or
> customers to play easily.
>=20
> Support of reading EDID from the dtb is really a feature which downstream
> motherboard maker or customer wanted. They sometimes using eDP also whose
> resolution is not 1024x768. This is out of control for a graphic driver
> developer like me.

And, to reinstate, we already have a mechanism to set an EDID, and if it
wasn't an option, the DT is not the place to store an EDID blob.

> And drm.edid_firmware have only a few limited resolution which is weak.

You're wrong. There's no limitation, it's just as limited as your
solution. You put the same thing, you get the same thing out of it. The
only difference is where the data are coming from.

> I will consider to adding drm.edid_firmware support, thanks.

It just works if you use drm_get_edid.

> > > 2) That is for the display controller in ls2k1000 SoC.
> > >=20
> > > Currently, the upstream kernel still don't have GPIO, PWM and I2C dri=
ver support
> > > for LS2K1000 SoC.
> > >=20
> > > How dose you read EDID from the monitor without a I2C driver?
> > >=20
> > > without reading EDID the device tree support, the screen just black,
> > > the lsdc driver just stall.=A0With reading EDID from device tree supp=
ort
> > > we do not need=A0a i2c driver to light up the monitor.
> > >=20
> > > This make lsdc drm driver work on various ls2k1000 development board
> > > before I2C driver and GPIO driver and PWM backlight driver is upstrea=
m.
> > >=20
> > > I have many local private dts with the bindings,=A0those local change=
 just can not
> > > upstream at this time, below is an example.
> > >=20
> > > The device tree is a platform description language. It's there to let
> > > the OS know what the hardware is, but the state of hardware support in
> > > the said OS isn't a parameter we have to take into account for a new
> > > binding.
> > >=20
> > > If you don't have any DDC support at the moment, use the firmware
> > > mechanism above, or add fixed modes using drm_add_modes_noedid in the
> > > driver, and leave the DT out of it. Once you'll gain support for the
> > > EDID readout in the driver, then it'll just work and you won't need to
> > > change the DT again.
> > >=20
> The resolution will be 1024x768, it will also add a lot modes which may
> not supported by the specific panel. Take 1024x600 as an example,
> Both drm_add_modes_noedid() and firmware mechanism above will fail.
>=20
> Because the user supply EDID only and manufacturer of some strange panel
> supply EDID only.

It's fairly easy to address: if the panel has some EDID, make the driver
able to read it; if it doesn't, describe the mode in the DT.

And if you want to be nice to your users, the firmware can even patch
the DT at boot time to add the necessary bits based on whatever info it
has, it doesn't have to be static.

Maxime

--uxe4dlurlg6xpvsg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYgPo2AAKCRDj7w1vZxhR
xX2hAQCFBpPUVg+YWCWprMYUwKiTpfSb5woXiIamuO1Ug9hNpgEA+0eOM+pFy8/c
z2yBO3amcIMYaRuP2KhGeztwlJyv1Qc=
=fsrj
-----END PGP SIGNATURE-----

--uxe4dlurlg6xpvsg--
