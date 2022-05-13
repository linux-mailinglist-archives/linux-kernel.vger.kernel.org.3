Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E60F525D21
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378129AbiEMIQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378139AbiEMIQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:16:07 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9203E08D;
        Fri, 13 May 2022 01:16:01 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E421B5C00E4;
        Fri, 13 May 2022 04:15:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 13 May 2022 04:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1652429758; x=1652516158; bh=iY9shFm2Us
        jfmpTTWu209xlXSoo1/kSVXTPhcXMt7H8=; b=uin/nZOFrMN1r3HNuWHmdoGaY3
        c7FRaFuahQzKICW7+sXgp7uFRCf6nfBbRUC6qoTalXEwERQDkdkm7pagYWNswuw7
        LNxbo+qZaPwNQWQBe4UD/pa0/5IoQLjJGGqHzdPFS//WrmNObBk5kg4UD8dlWr/s
        CUslx4dgQvclORi4IeQlr3Tm4oc0WaWGVdI2slV/+YF8x6V1eENUEKYA3bRz57tj
        TfcECEiFUusehtJwjbUxQEZ4QysRJ8QwJKFP7rykSE9QTWUHG3BQnSQp0xzthQHa
        HIPmKNxHqkJW23T41yni9Mj06EuRNv+7Z9Kp/JMulYcVeI3Hl95cp7JyPpGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1652429758; x=
        1652516158; bh=iY9shFm2UsjfmpTTWu209xlXSoo1/kSVXTPhcXMt7H8=; b=O
        txrF9ODGUXG/fJtjc68Vnrim6/M1IT/RwWsCEySKTH8NljzFVFci1v7iph3xmYtx
        c7sKXNXwSd++avrklkfvgHcZNGjdwzsi6UcGVq/5CEfgB/2mY4mX9q/2FUv1HWU8
        Pb+GixFh6C3nstMt8eaYFh3ffM3V2T4jLxtW35M8XlDPYU7qPsgYWl9RDaLIJROa
        CbYlWFlaw8/ZrrQla1EfOUZExY2A4KQrAqq3W4JsJWCDvYA84nBncpI4P8SG6J4D
        lHFE5GszS0h4kpy+BqfeY3yggQ3BSfZ+fVOTe+Z+WUjIckkNr+CRhkAj990Z6rVW
        VmsskET9xHuMYMrQYk3IQ==
X-ME-Sender: <xms:vhN-YnzcTbiG27OA1P756RmfHM36QMyh2GbPglNVLKRCLCEHu2uq0A>
    <xme:vhN-YvRkhH9BwLlPOx8QRN7jf92VpTobhpxfQWGAqOcBSJtwVHK1MT-rDutm82D40
    iZNGMiTEMA8MgLv7vU>
X-ME-Received: <xmr:vhN-YhWMYt7HzFou5fAtMcaZpPf5vdSCxQSEMqfVhuNH40O3fQ5LAhsP1aa20IbPC-ykUDQY-3BD8K9qeErac540TeJirNVivc5-jpc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgeelgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepjeegieevvedvgffffedtveeuhfehudevjeeifeegjeevuefhteeklefgveet
    feffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:vhN-YhjvD9iHhT3MCWCWXIOgSYkkmG4VszRZ6srvl6FsfPPn-lFEeQ>
    <xmx:vhN-YpAh_MXz6ykwmHJo5lKK4dmGhEE0K2HORfkronBnAyiL3aAI0w>
    <xmx:vhN-YqJGKCQSQn1CNJ2aj9yeVbcZ2iGt7sNu-lIazufNsEwnqS85Iw>
    <xmx:vhN-YtsF32_EoAfbvgYEHEPNRszMbjIu0XZBBYwB-cSTa1mWk1UzRA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 May 2022 04:15:58 -0400 (EDT)
Date:   Fri, 13 May 2022 10:15:56 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     qianfan <qianfanguijin@163.com>
Cc:     linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ARM: dts: sun8i-r40: Add "cpu-supply" node for
 sun8i-r40 based board
Message-ID: <20220513081556.knd3tf6pangfblh3@houat>
References: <20220512071858.10805-1-qianfanguijin@163.com>
 <20220512071858.10805-2-qianfanguijin@163.com>
 <20220513073849.cu4jzykefat2sepg@houat>
 <1352b9d7-5219-af09-948b-6462def39ea5@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ocbjtkvxhxhj7iii"
Content-Disposition: inline
In-Reply-To: <1352b9d7-5219-af09-948b-6462def39ea5@163.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ocbjtkvxhxhj7iii
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 13, 2022 at 03:48:50PM +0800, qianfan wrote:
>=20
>=20
> =E5=9C=A8 2022/5/13 15:38, Maxime Ripard =E5=86=99=E9=81=93:
> > Hi,
> >=20
> > On Thu, May 12, 2022 at 03:18:58PM +0800, qianfanguijin@163.com wrote:
> > > From: qianfan Zhao <qianfanguijin@163.com>
> > >=20
> > > sun8i-r40 actived cpufreq feature now, let's add "cpu-supply" node on
> > > board.
> > >=20
> > > Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
> > > ---
> > >   arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 4 ++++
> > >   arch/arm/boot/dts/sun8i-r40-feta40i.dtsi          | 4 ++++
> > >   arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts          | 4 ++++
> > >   arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts | 4 ++++
> > >   4 files changed, 16 insertions(+)
> > >=20
> > > diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch=
/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> > > index a6a1087a0c9b..4f30018ec4a2 100644
> > > --- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> > > +++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> > > @@ -113,6 +113,10 @@ &ahci {
> > >   	status =3D "okay";
> > >   };
> > > +&cpu0 {
> > > +	cpu-supply =3D <&reg_dcdc2>;
> > > +};
> > > +
> > This will break bisection on those boards. Indeed, you added the OPPs on
> > the first patch, and if you only apply that patch, the boards in the
> > second patch will be missing their CPU regulator. The kernel will then
> > ramp up the frequency to the highest OPP, but will not change the
> > voltage, resulting in a crash.
>
> This is a good point and I will merge those two patch.

That's not what I meant to say. Those two patches are great separated.
You can invert them though.

> > There's a similar issue for all the boards that don't have a regulator
> > in the first place.
> >=20
> > The way we worked around this for the other SoCs is to have a DTSI with
> > the OPPs with a frequency higher than what U-Boot boots with (1008MHz?),
> > and only include that DTSI on boards that have a CPU regulator hooked i=
n.
>
> Is this really necessary? It seems like every board based on sun8i-r40
> have a cpu regulator.

This probably won't be the case whenever someone starts a new design,
and then they'll face random crashes for no apparent reason, and waste a
lot of time in the process.

Whereas the alternative is that you would be missing some OPPs,
something that is fairly easy to figure out.

Maxime

--ocbjtkvxhxhj7iii
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYn4TvAAKCRDj7w1vZxhR
xXVzAQCYS/y6GVik1wq99/10xFtsQVwNbQDTafNgKQRW8bpSxwD+Ohmf/aYmi5JZ
QfgJA4DF5q5bvX0nina8Y7KiVSMVSQ0=
=x+9H
-----END PGP SIGNATURE-----

--ocbjtkvxhxhj7iii--
