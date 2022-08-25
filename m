Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE205A1365
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238284AbiHYOWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbiHYOWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:22:41 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC034ADCF9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:22:39 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id AD0985802EA;
        Thu, 25 Aug 2022 10:22:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 25 Aug 2022 10:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1661437356; x=1661444556; bh=RV6+m2/IKb
        pNbL3HnR/lfcPmXYFzOBcMOHuOZs1FFyw=; b=CoblA8c/dnDMqygK3KshyENrTM
        fgwrKQXIdYl00cHPmW0wVRXvGhEchAKnHak9wTrZ6EfJoH9YiDWAvp9oDp07Y9sh
        OCZR6oXWF32en10uhsYJ9W8pgGr38sx5CQY4s4LIRa0cTcUsgTGLXebcK/pPwaaY
        1uy3XCwk9EF+RexMg09Q1HPP9Ou7E2GAj81nbnQAnG66FLwNZ1YAr2BtEojJm8X1
        KEE0Ho5Xc+S0HTVtusXPrBBqgDv9fX+hm2x9nqZapuPIdhzwcys+lhP90xyQykyO
        LgQ3kDAK49zHpLe7zq36mmE9vYTA48A49w6gBZfKI2Sun5Y/C46VoJ91YpQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1661437356; x=1661444556; bh=RV6+m2/IKbpNbL3HnR/lfcPmXYFz
        OBcMOHuOZs1FFyw=; b=1PElorIivv3D3E2Mtug4cGsBBBJnlc7vsnd4WXFjzT31
        ovdC1Vq8l+4ZlV4/f0pCFGOZbczdPMICmJXeALmDpHygU6bmWSpg+0Hap/CBpc+d
        qotUptK8G4kZ2vUnk9nIQYXhUcwioVRuAL1SWNlQfNhyHumuAtl+ODAvc4JVjTuh
        4wSKb/bEMXZVq2SqYIzgqVyQtvEdz3UNbUlfWzn3EkOjMaOQ6CfkC84L0RA/SHFE
        /krvVs/w1gPleAbJ2DwLdX9l8ZVk761KsN9BUO69GQBLvwkQDgtWm4LMboWPvpUG
        gBYI+340H+o1H7DodoQmB25GR7dSXroyrITqcLzn9w==
X-ME-Sender: <xms:rIUHY2yh60Mi5u6ajiw4CedkuXPivu_kAm2BnrvS4nuy4cL631jadw>
    <xme:rIUHYyTf4F3loMDCft_qY_V9MVnmi_9Rk-q916taI4AghgIF35IxUVntDCQMyMonx
    fCqccYDGInEN6W5D54>
X-ME-Received: <xmr:rIUHY4WyyeXKH9A_r_pqFP-Tgxb_GzgK-qopajLDCLr4nTbMnEJcfUzNIHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejfedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeljeeugfegveetleevkeetffegudevieetieeugeeugeeivddtjeejvdef
    feetgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:rIUHY8jswzoS4PJSLbnlzLHBEnUsTo1_QsEBnuImvDqrsQcsoWlGRg>
    <xmx:rIUHY4BFywCbEVwtuLs-2MGOeEvVD1jQWslkPmAKZj1VcYam89kWgQ>
    <xmx:rIUHY9Iz5IlFuF9jYxe3a-sJm8pP6FgK3Bkp6fUwE8z6N0vwu33i-Q>
    <xmx:rIUHY6zhSdc7OGetpahmgv3J2Pd83tE7OL0PYhg5A5rkAlwx4Cm7vQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Aug 2022 10:22:35 -0400 (EDT)
Date:   Thu, 25 Aug 2022 16:22:33 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Dom Cobley <dom@raspberrypi.com>
Subject: Re: [PATCH v1 35/35] drm/modes: Introduce more named modes
Message-ID: <20220825142233.po6yh5outlhwih73@houat>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <20220728-rpi-analog-tv-properties-v1-35-3d53ae722097@cerno.tech>
 <ba36ab96-962e-2b99-30fd-f62d51e06b47@tronnes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ymrrl4zdj4mfkoha"
Content-Disposition: inline
In-Reply-To: <ba36ab96-962e-2b99-30fd-f62d51e06b47@tronnes.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ymrrl4zdj4mfkoha
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 21, 2022 at 06:16:15PM +0200, Noralf Tr=F8nnes wrote:
>=20
>=20
> Den 29.07.2022 18.35, skrev Maxime Ripard:
> > Now that we can easily extend the named modes list, let's add a few more
> > analog TV modes that were used in the wild, and some unit tests to make
> > sure it works as intended.
> >=20
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> >=20
> > diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> > index 3634ac9f787d..09ed5ce7746d 100644
> > --- a/drivers/gpu/drm/drm_modes.c
> > +++ b/drivers/gpu/drm/drm_modes.c
> > @@ -1853,7 +1853,9 @@ struct drm_named_mode {
> > =20
> >  static const struct drm_named_mode drm_named_modes[] =3D {
> >  	{ "NTSC", &drm_mode_480i, DRM_MODE_TV_NORM_NTSC_M, },
> > +	{ "NTSC_J", &drm_mode_480i, DRM_MODE_TV_NORM_NTSC_J, },
> >  	{ "PAL", &drm_mode_576i, DRM_MODE_TV_NORM_PAL_B, },
> > +	{ "PAL_M", &drm_mode_480i, DRM_MODE_TV_NORM_PAL_M, },
>=20
> Please use a dash instead of an underscore to keep it consistent with
> what's used elsewhere.

Yeah, I tried not to use it since I didn't want to cripple the parser
with bad heuristics, but Geert has done a much better job than my
attempts here:
https://lore.kernel.org/dri-devel/2eb205da88c3cb19ddf04d167ece4e16a330948b.=
1657788997.git.geert@linux-m68k.org/

I've taken that patch in, renamed the modes and we already have unit
tests in other patches to cover that part of the parser.

> I tried to use PAL and set the connector as connected, but that didn't
> work: video=3DComposite-1:PALe
>=20
> Is this a bug and it should work or should it be phrased differently?

I'm not sure. We never supported something like that so far, because the
expectation is that if it starts with a letter, it's a named mode. Thus
the named mode is PALe in your case, which doesn't match.

I'm not even sure what would be a good heuristic to support it, since
interpreting any e, E, or D as the last letter seems like a recipe for
disaster when some modes might legitimately end with e or d.

> It would have been nice to get a warning in the log if the parser fails
> to understand.
>=20
> This very verbose version did work:
> video=3DComposite-1:720x576@50ie,tv_mode=3DPAL-B

I think that's what we should be using in that case.

Maxime

--ymrrl4zdj4mfkoha
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYweFqQAKCRDj7w1vZxhR
xV/2AQCEOkXsmNlZMo+QfkCyGaznRmqYioamDTNeMIZ2vMGfKQD/SIdv50hSYVi7
cHftkdI6Lpbb3uTtIrSd+FFDTn/z7wM=
=miGi
-----END PGP SIGNATURE-----

--ymrrl4zdj4mfkoha--
