Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311BC5831CF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 20:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235892AbiG0SRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 14:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbiG0SQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 14:16:58 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD399D54;
        Wed, 27 Jul 2022 10:17:21 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BBFC7240008;
        Wed, 27 Jul 2022 17:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1658942240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pD+6JsLJZ79rYHRmRP+N5CK2RU/2PPAI0GVGYlpGjrI=;
        b=MHkMXCFzwyOhigfD3fOn/vHnUXWQXKZE5lLCgbSY5U8ix16n/ghnZwBhOS+nVxy+zcd+YN
        xh2QTLt6dA0cersxQauh43bC5S5ngrf5x7/qiIb1WaMuZKUlzVkvb7PBPbmWhBxLiMVUxh
        4vs3wo7kGjJTOvyzsbgyvSyzTnCsjcPkaJ9ir6lo1FIHgqCXrqYJJWMBzDVP46DKWB/KiA
        S1ScOD4yFDYf4mWZmcX8xXjEeD6XeU11fhenGaq4gmuMlYH02ehjR6RSXRS/Pt0h7mrx3V
        BqNqd25Nx4wU99qo0qnilMKa2h9JHH++LS03z8YvKbw3F90k0scqinCZzjnxYw==
Date:   Wed, 27 Jul 2022 19:17:15 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH RFC v3 1/8] of: Mark interconnects property supplier as
 optional
Message-ID: <YuFzG9SykSHw1bVe@aptenodytes>
References: <20220302211100.65264-1-paul.kocialkowski@bootlin.com>
 <20220302211100.65264-2-paul.kocialkowski@bootlin.com>
 <YiaTfsMDs7RGob2N@robh.at.kernel.org>
 <CAGETcx9u9RO_5nSp+=qgwDGY=jL_Q1hAcj+RfVN=q-H_8iuT4w@mail.gmail.com>
 <20220727120631.iefzititedahdsdt@houat>
 <CAGETcx_o=L+Ku9CPGbQW2wS15etvi+ofkKZ0K=C7imP4=JcXeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YI4hFKeTpPz6LydI"
Content-Disposition: inline
In-Reply-To: <CAGETcx_o=L+Ku9CPGbQW2wS15etvi+ofkKZ0K=C7imP4=JcXeQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YI4hFKeTpPz6LydI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed 27 Jul 22, 09:06, Saravana Kannan wrote:
> On Wed, Jul 27, 2022 at 5:06 AM Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > Hi,
> >
> > On Mon, Mar 07, 2022 at 07:34:22PM -0800, Saravana Kannan wrote:
> > > On Mon, Mar 7, 2022 at 3:21 PM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > +Saravana
> > > >
> > > > On Wed, Mar 02, 2022 at 10:10:53PM +0100, Paul Kocialkowski wrote:
> > > > > In order to set their correct DMA address offset, some devices re=
ly on
> > > > > the device-tree interconnects property which identifies an
> > > > > interconnect node that provides a dma-ranges property that can be=
 used
> > > > > to set said offset.
> > > > >
> > > > > Since that logic is all handled by the generic openfirmware and d=
river
> > > > > code, the device-tree description could be enough to properly set
> > > > > the offset.
> > > > >
> > > > > However the interconnects property is currently not marked as
> > > > > optional, which implies that a driver for the corresponding node
> > > > > must be loaded as a requirement. When no such driver exists, this
> > > > > results in an endless EPROBE_DEFER which gets propagated to the
> > > > > calling driver. This ends up in the driver never loading.
> > > > >
> > > > > Marking the interconnects property as optional makes it possible
> > > > > to load the driver in that situation, since the EPROBE_DEFER retu=
rn
> > > > > code will no longer be propagated to the driver.
> > > > >
> > > > > There might however be undesirable consequences with this change,
> > > > > which I do not fully grasp at this point.
> > >
> > > Temporary NACK till I get a bit more time to take a closer look. I
> > > really don't like the idea of making interconnects optional. IOMMUs
> > > and DMAs were exceptions. Also, we kinda discuss similar issues in
> > > LPC. We had some consensus on how to handle these and I noted them all
> > > down with a lot of details -- let me go take a look at those notes
> > > again and see if I can send a more generic patch.
> > >
> > > Paul,
> > >
> > > Can you point to the DTS (not DTSI) file that corresponds to this?
> > > Also, if it's a builtin kernel, I'd recommend setting
> > > deferred_probe_timeout=3D1 and that should take care of it too.
> >
> > For the record, I also encountered this today on next-20220726 with this
> > device:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/arch/arm/boot/dts/sun5i.dtsi#n775
> >
> > The driver won't probe without fw_devlink=3Doff
>=20
> Really? I basically ended up doing what I mentioned in my original
> reply. next-20220726 should have my changes that'll make sure
> fw_devlink doesn't block any probe (it'll still try to create as many
> device links as possible) after 10s (default deferred probe timeout).
> Can you try to find more info on why it's not probing?
> <debugfs>/devices_deferred should give more details.

By the way last time I checked the initial issue that I reported appeared t=
o be
fixed by the patch (Extend deferred probe timeout on driver registration).

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--YI4hFKeTpPz6LydI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmLhcxsACgkQ3cLmz3+f
v9FD3Qf/f9BJLCBNeLkg1/FJs/uq8AROdDgAOOIp6h0jojREfp9mzOJZLiwolT2a
cibrCYabq1rvssN9wI0S5i57IRa3ZcUEdZTu8th5zLPMKv96o0iFcp0DjoAQ1K2A
mvhRcdI7q6tFhAEMoDbJjmRg1qCpCMpVmW0B+PQcafq5K2y0TpnxLjeEUdRrmjxY
M8Ddn1Ui6Ymne0Rj3Io4f4jxDIm5WQTFk+iYA6OcaA490loeYI9CfvCqx8NDyJF+
1e92FYkmpTyvgi48Diqs2k7VGooJ1pjsMVYqlFAtz3DYFUh/i/nCaVAk6RNOicqU
Dz0DKgon9pUOsbZjFCSd6jiWpjTu9Q==
=ncXW
-----END PGP SIGNATURE-----

--YI4hFKeTpPz6LydI--
