Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFAF592CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241509AbiHOImT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiHOImR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:42:17 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADD5DF3C
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 01:42:16 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id C12EA58060D;
        Mon, 15 Aug 2022 04:42:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 15 Aug 2022 04:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1660552935; x=1660560135; bh=jCLrmollLV
        DyqBu3wvulbaV3RNTNZ05rEx9CXO/Wmng=; b=tKIVdEkVutMMGoXB1seo7kuBWK
        mf+hhbPhGWrfbcicTvnvCvjVJk7gsTTkcvO8a106wcix/T3U60GBkelVJcHblTbP
        OlBFZkWU2EEQ9q8mVomOeKdsnf5qzG7ufJMwoSRLUHs6/IDDMKf8hdhcS10QrW2r
        OtRX4PKWtpr1AG8rtvul5sZfhOU7MBDY4JGWHQ29DuKN9BNurNR5L/35gONxPXTL
        FV/NZ4JS9yrNQfGLZgzYL7lkQKod0tgoxzHc+aMxyDGXnKFw76HgjvDo9MffGLWh
        o75gtZUrIH8e3F9VZY7sX7uHh+eEPceRz6M4BRPiMYE6VQzKRUEj9TyZI6oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660552935; x=1660560135; bh=jCLrmollLVDyqBu3wvulbaV3RNTN
        Z05rEx9CXO/Wmng=; b=r1ZBLTTA0UF3TVxHv0Ro7SCOCq58S55oqD7QUtGH+vhH
        FGGjdkz2apuLRHGUbfTBfOaZ1SRkrWh/MCb8cG02BHzJRI8qOp/HdK8sDw8+/WUf
        RcDs+fVw41JmZ5hLjx62gFh0wfGAXuhlMoVEid7XevlykQNrwZ8VJ0wNEx/URmed
        KZxkR3uPVUyzs1wEX3cSd5v+yCGMdrdiWtsYpKJSrfxcYiYXK4yGuuLHzFI2xKAR
        kwWQqiwiednwZYFxhGuuEf5npdMC9lL/POObijvw4blQPMV8p53Gq7T5S6Qvksjf
        arefGU1nLY9zXHruU/4mfeHhpQlO8j4HDCwI8tIbsg==
X-ME-Sender: <xms:5wb6Yo6uSgy9V_wCTwDItSNLQkrgXOEpmEdqgG_K4Iwvepr-u03kaQ>
    <xme:5wb6Yp4CfqtAPzj1R_h29As0lyTS2SHHjsCO0MloFD_PZ-pqVssBU0q32bdKbKGvU
    hBaJofOAes3skdFwz4>
X-ME-Received: <xmr:5wb6YndpCaCei1grbEclLb1z76cp0_KS9Y9WQ32nphaOQnceet5miPbMnaPJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehvddgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpedtleekjeeiudefvdfhieffteelhfeivdeliefgieeugffhvdelieffjeei
    geetjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:5wb6YtI9WknQMrj9jETz1rq_OVBPpy146jAhGHFUkBIqYjxcIzZZzA>
    <xmx:5wb6YsLC0qTtwe95dqHtzni0_Q6ernDecboPcKiNpK7oMP46sLY6oQ>
    <xmx:5wb6YuzUddC4peJo4BV_M_Q6eIvx3xP67DLzL2HKiCS6D1ivqClffA>
    <xmx:5wb6Ys4nsDgwW8o5Zj5KrVI64qTW7uISKFM-KZQW-CtfDFNW4jQhag>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 04:42:14 -0400 (EDT)
Date:   Mon, 15 Aug 2022 10:42:13 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Dom Cobley <dom@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-amlogic@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 08/35] drm/client: Add some tests for
 drm_connector_pick_cmdline_mode()
Message-ID: <20220815084213.olcvp6qhmhhykz6t@houat>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <20220728-rpi-analog-tv-properties-v1-8-3d53ae722097@cerno.tech>
 <14d698dc-172c-773f-7ea1-7101b9f5b77f@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rlnnmrn6tqqsyh2j"
Content-Disposition: inline
In-Reply-To: <14d698dc-172c-773f-7ea1-7101b9f5b77f@suse.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rlnnmrn6tqqsyh2j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Tue, Aug 02, 2022 at 12:14:29PM +0200, Thomas Zimmermann wrote:
> Am 29.07.22 um 18:34 schrieb Maxime Ripard:
> > drm_connector_pick_cmdline_mode() is in charge of finding a proper
> > drm_display_mode from the definition we got in the video=3D command line
> > argument.
> >=20
> > Let's add some unit tests to make sure we're not getting any regressions
> > there.
> >=20
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> >=20
> > diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm=
_client_modeset.c
> > index bbc535cc50dd..ee6b8f193c24 100644
> > --- a/drivers/gpu/drm/drm_client_modeset.c
> > +++ b/drivers/gpu/drm/drm_client_modeset.c
> > @@ -1237,3 +1237,7 @@ int drm_client_modeset_dpms(struct drm_client_dev=
 *client, int mode)
> >   	return ret;
> >   }
> >   EXPORT_SYMBOL(drm_client_modeset_dpms);
> > +
> > +#ifdef CONFIG_DRM_KUNIT_TEST
> > +#include "tests/drm_mode_test.c"
> > +#endif
>=20
> Including source files is somewhat ugly, prolongs compile times and could
> even interfere with the actual source code. Can we do this in some other
> way?

Yeah, this irks me a bit as well, but it's the preferred way of doing it
according to the kunit doc:
https://www.kernel.org/doc/html/latest/dev-tools/kunit/usage.html#testing-s=
tatic-functions

> I suggest to add the tests here and export them for use in the test case.
> Something like
>=20
> #ifdef CONFIG_DRM_KUNIT_TEST
> static drm_mode_res_1920_1080_60()
> {
>   ...
> }
>=20
> struct kunit_case drm_mode_tests[] =3D {
>   drm_mode_res_1920_1080_60
> };
> EXPORT_SYMBOL(drm_mode_tests);
> #endif
>=20
> This would add the tests next to the tested code, but leave the test driv=
er
> in drm_mode_test.c.

The test suite is fairly small for now, but if we end up with dozens of
tests like what is there for the command line parser (which could happen
for that kind of functions), I'm very afraid that the original source
file will become unreadable, while this has the advantage to keep the
original file readability.

Maxime

--rlnnmrn6tqqsyh2j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYvoG5QAKCRDj7w1vZxhR
xc0mAQDuFbvOznqy7wPFfo7D22siO3vakpbi8JYCjof/aUhSWQEAh1/POG4ZPo9G
5liKYUHEyb8jsiIsA5GvnKqbiUcWNQw=
=hjzk
-----END PGP SIGNATURE-----

--rlnnmrn6tqqsyh2j--
