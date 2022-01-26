Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB49D49CD58
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242571AbiAZPLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:11:13 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:41317 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235639AbiAZPLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:11:12 -0500
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Jan 2022 10:11:12 EST
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id 81CD72B00208;
        Wed, 26 Jan 2022 10:03:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 26 Jan 2022 10:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=363jpJ0V67cDO7FAMEOtGl2A24kAON00HpHRu9
        2RgGs=; b=kMrn98kg7LOAc/WRS3kN/kfn+gYSa8Wvf5oScoGf/3dB3x8BjsUqxO
        +AlHGvA9I1KYfy2w7bIFS5joCo/YHvkcmc4HHitB4UBB2Kf2OoTMdyzN44WdT6Yx
        rFmNXI+DNDVkycWLt5yMgwv9z8RvSSkz7NzOXNciIqCAxEQJgzmTY0FNOns//KJR
        GJY0w8vyCDJruetuurOAR06gYtDoCdR7UmzuMdYOMvMhFd/1mfvEu3UkxRSAJ7wa
        YySKuINueWRA6pJxA0ehx54buL2Jk0Kj1Wf7yRVo+cu+GZQoxKhR4iWGGAACgias
        bvT+ry7hITMwLrepf8TEah7qK0O1SoTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=363jpJ0V67cDO7FAM
        EOtGl2A24kAON00HpHRu92RgGs=; b=B/1+Vhf/+o4GEjuR1m4q70N6zcupLwYuc
        utwfUeng6BvHkj6Oy+oEzwoJN5ROcdDuFdONRroDZW1OUjton8DgkAICozqZ9sHz
        TByiKh2f1PkF+9N5TJn16vOy4BMXzG4vTLxbhbVPH6hh1y3dbWiV0B4zKewylwd9
        ntUxREauSS/7UYBTV9ykO67aGTMfEBKe+fE6tbjjp+r7sTltdbktCapWV61M+hzM
        MDwS6fPfbm9DBZ9YUbvcBgtVPXonRurOW6+eIqQTytE4Gkb9SQxiqG9qmPUdPCrI
        0PXpiTkTgU9unOvB/Y2QVGKfrtxWvTbvbkTl0xJP1MD71VZEt9shw==
X-ME-Sender: <xms:zWLxYSN8ropnb3tZC_Hjfl4QtOvIbkfk6BA6fFivXK9NSM6Vw2PKxw>
    <xme:zWLxYQ9pDOLIqL8o2xA0ljlgK3OFiZLZGUYH37sY6YINScThWE6krNVo-Q4PGfad1
    Z7DzC1p5WjSfO7qXks>
X-ME-Received: <xmr:zWLxYZSN4DjbOpqqLR4WCE5SPLwfL-MjUe4Jx_t1rIh8Wh0OfUrhdNoPdl9B6H4pzZ5nVCpnE_WVmoNg5eF3y31yB-wPakZBedVbpw0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfedugdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeevveefffduveeitdegtefhhfetueffteefffdvheevvdehteethedvleffgfej
    vdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:zmLxYSusIhh4xpXBUCen-INlq7NzEISkXNp3kRjKOflMEKJ5Ah1bkw>
    <xmx:zmLxYae0Wasg7tVanuwMhwqJAgNmNUnI0hjrpfy_hO95-4OA_XCmpA>
    <xmx:zmLxYW2RWmoJldRwm4UsIFnsDd1a3ZTgdayj0VkDLUnbMm9EHCpmhQ>
    <xmx:z2LxYQ0FeiI0WDJRFa8ucT5Ll1xDMNW-RLSofYBqBGk1OCsPHd8NL352ZTA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jan 2022 10:03:41 -0500 (EST)
Date:   Wed, 26 Jan 2022 16:03:38 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, lukasz@jany.st,
        mchehab@kernel.org, naush@raspberrypi.com, robh@kernel.org,
        tomi.valkeinen@ideasonboard.com
Subject: Re: [RFC PATCH v2 4/7] media: bcm2835-unicam: Add support for for
 CCP2/CSI2 camera interface
Message-ID: <20220126150338.j6bep2v5wmi3xnnq@houat>
References: <20220121081810.155500-1-jeanmichel.hautbois@ideasonboard.com>
 <20220121081810.155500-5-jeanmichel.hautbois@ideasonboard.com>
 <YeySvkxEfpzTj+pC@pendragon.ideasonboard.com>
 <0212af6d-a5de-05bb-161b-4271692dee59@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="on6ulyuqio35z6hz"
Content-Disposition: inline
In-Reply-To: <0212af6d-a5de-05bb-161b-4271692dee59@ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--on6ulyuqio35z6hz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 26, 2022 at 03:21:40PM +0100, Jean-Michel Hautbois wrote:
> On 23/01/2022 00:26, Laurent Pinchart wrote:
> > > +struct unicam_device {
> > > +	struct kref kref;
> > > +
> > > +	/* V4l2 specific parameters */
> > > +	struct v4l2_async_subdev asd;
> > > +
> > > +	/* peripheral base address */
> > > +	void __iomem *base;
> > > +	/* clock gating base address */
> > > +	void __iomem *clk_gate_base;
> > > +	/* lp clock handle */
> > > +	struct clk *clock;
> > > +	/* vpu clock handle */
> > > +	struct clk *vpu_clock;
> > > +	/* vpu clock request */
> > > +	struct clk_request *vpu_req;
> >=20
> > Not used (and that may be a problem).
>=20
> In the original linux-rpi tree, there is this portion of code in
> unicam_start_streaming:
>=20
> dev->vpu_req =3D clk_request_start(dev->vpu_clock, MIN_VPU_CLOCK_RATE);
> if (!dev->vpu_req) {
> 	unicam_err(dev, "failed to set up VPU clock\n");
> 	goto error_pipeline;
> }
>=20
> ret =3D clk_prepare_enable(dev->vpu_clock);
> if (ret) {
> 	unicam_err(dev, "Failed to enable VPU clock: %d\n", ret);
> 	goto error_pipeline;
> }
>=20
> And this is used as this because it depends on the non-merged series "clk:
> [PATCH v2 0/3] clk: Implement a clock request API" [1]
>=20
> [1]: https://lore.kernel.org/all/20210914093515.260031-1-maxime@cerno.tec=
h/
>=20
> That's why I modified the code and called:
> clk_set_min_rate(dev->vpu_clock, UNICAM_MIN_VPU_CLOCK_RATE);

I assume this would depend on the framerate and resolution though?

> Dave, is it ok or do we need absolutely the clock request API ?

The main issue is that clk_set_min_rate will never scale the clock back
if you (or the HVS) don't have those constraints anymore. So you
eventually make the clock run at the maximum you'll ever need all the
time (which would be around 500MHz in our case).

The clock request API was an attempt at making the clock scale back to
its minimum when we no longer needed it. The current discussion points
towards changing the behavior of clk_set_min_rate:

https://lore.kernel.org/linux-clk/20220125141549.747889-1-maxime@cerno.tech/

So it looks like we won't need the clk_request API after all.

Maxime

--on6ulyuqio35z6hz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYfFiygAKCRDj7w1vZxhR
xdfXAQCarLQAdpwfxO5Jb9U7xXxxxeMYjmaLBjYqqCwcxeevpgEArH2HxByy/UWC
mIUewELV3aqNR2Ii+BmPLCeY4FU03gw=
=hcXf
-----END PGP SIGNATURE-----

--on6ulyuqio35z6hz--
