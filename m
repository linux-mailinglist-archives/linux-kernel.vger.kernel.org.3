Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB6D53E8D1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbiFFJWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiFFJWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:22:32 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBD56599
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:22:30 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 93D2132002FB;
        Mon,  6 Jun 2022 05:22:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 06 Jun 2022 05:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1654507348; x=1654593748; bh=Xw4lnTY/et
        JsJAGDFGc3jcxrakgTZHGFztPy9C0RzDM=; b=qxiiLfWULeAPQo8wYKlgqESjFG
        6TGaZfecQYvAdffjoLWu9YG0TrJovLyO7ylqUihe6F61QahAqc0BAVqRy4Ucxxy4
        DrxmKAJLMzMOgbfXVoP+AHuvh6QztQtYmBw4ibyH0LST0wlJmazaMMxuzMvSoMta
        s3YBZb5JA644H4gnTon7TvG0pEfMZV9xrjpkm9Fh5FlMYGpn3gpkemo5Yyq+KG2a
        LlhxrUovfCmLEph0pA7McLE9e/u+JYiDvoyXB723FRFYjBvXw6hEHQpzrDaGkgeo
        kittXLPBx1KAA5i5K9YN2Y0eVrcEGROCfDa21n8f+jMnK1plVMDohSYuZlDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1654507348; x=1654593748; bh=Xw4lnTY/etJsJAGDFGc3jcxrakgT
        ZHGFztPy9C0RzDM=; b=PEwqST23OMlAUNHFqMxHnAJfKU40BvEfscyGrQViseSX
        px/VVlVaH+85i1wn8bN9DA7pxQX5/Rxm5Zmo/ntfQmPFTukTpi+NRnAX23o72TF7
        V5KBmBp5lnVpSAoYMAIQP4CCa0XL9IhN2Sg5yPHxMzUheZ50BpYNaZwKXLw3TRaY
        TatwtKg9n/tMw8K4WTrtjSx4mQPhRPBSpekrPd+o9PdJ31SSjUsTWQQAn34Wq4Fg
        3ph9Q0957ns9Xr+D4pChkbEj8qG/pzqR8cC4c4tuZpOy9lGyxyjLnLIQKjlfA86L
        xz32lzWRe/283rcsK4w7GAZCkCsNYQ1UvgN0yUkovA==
X-ME-Sender: <xms:U8edYg2cRD82UHQxi1oxy42mFBVxzggZweD4Nwu3WAAIGVxZDDk4dQ>
    <xme:U8edYrE7XP7dBoaKUXxX-NGMjWuj3IvRvSuBjLHp7VkS6IB6S_Jx1TqjU0a0A6t8x
    PfYVE0mSmsk6TPrQCk>
X-ME-Received: <xmr:U8edYo7IcqcQ_YmKavdRNLFx3FiGjQf09ogJ_6Q8UX9yCopdZPW4avJhuyJQuJy7Bcjqz-_p53wK5pjg2dshDTVfA7tk8pRTitZScAE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddtvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejgeeiveevvdfgffeftdevuefhheduveejieefgeejveeuhfetkeelgfev
    teefffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:U8edYp1k2rdN6LO_i3E36JF8vVN-xX-clV_1IrYu677gipX0WUG4dA>
    <xmx:U8edYjGpYaHBOxOiONoCqdCg9oObmTyUyKXtkVsge35Si535KTsYBA>
    <xmx:U8edYi-sqWw1vD9L4j8_KtpIJF59CU6yj1bz7VspQPAy4co9HE1VKA>
    <xmx:VMedYr_puFd5iP3itjaz9la2pq6V6Vbt4L3B8XB-XInrG1Gjccl17g>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jun 2022 05:22:26 -0400 (EDT)
Date:   Mon, 6 Jun 2022 11:22:25 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Roman Stratiienko <r.stratiienko@gmail.com>
Cc:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        wens@csie.org, airlied@linux.ie, Daniel Vetter <daniel@ffwll.ch>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, megi@xff.cz,
        Roman Stratiienko <roman.o.stratiienko@globallogic.com>
Subject: Re: [PATCH] drm/sun4i: sun8i: Add support for pixel blend mode
 property
Message-ID: <20220606092225.yxyw77mtuqpbmd35@houat>
References: <20220605154731.17362-1-roman.o.stratiienko@globallogic.com>
 <4714286.GXAFRqVoOG@jernej-laptop>
 <CAGphcdniPFdqgLcpUc88ak9GzNaCvmj_TDVYTOe2bXto-Y12FQ@mail.gmail.com>
 <20220606092006.4bgxibmayv44juox@houat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ycmmdvpgrnhgi2cu"
Content-Disposition: inline
In-Reply-To: <20220606092006.4bgxibmayv44juox@houat>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ycmmdvpgrnhgi2cu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 06, 2022 at 11:20:06AM +0200, Maxime Ripard wrote:
> On Mon, Jun 06, 2022 at 11:17:20AM +0300, Roman Stratiienko wrote:
> > Hello Jernej,
> >=20
> > Thank you for having a look.
> >=20
> > =D0=B2=D1=81, 5 =D0=B8=D1=8E=D0=BD. 2022 =D0=B3. =D0=B2 23:37, Jernej =
=C5=A0krabec <jernej.skrabec@gmail.com>:
> > >
> > > Dne nedelja, 05. junij 2022 ob 17:47:31 CEST je Roman Stratiienko nap=
isal(a):
> > > > Allwinner DE2 and DE3 hardware support 3 pixel blend modes:
> > > > "None", "Pre-multiplied", "Coverage"
> > > >
> > > > Add the blend mode property and route it to the appropriate registe=
rs.
> > > >
> > > > Note:
> > > > "force_premulti" parameter was added to handle multi-overlay channel
> > > > cases in future changes. It must be set to true for cases when more
> > > > than 1 overlay layer is used within a channel and at least one of t=
he
> > > > overlay layers within a group uses premultiplied blending mode.
> > >
> > > Please remove this parameter. It's nothing special, so it can be easi=
ly added
> > > once it's actually needed. For now, it only complicates code.
> >=20
> > I would prefer keeping it if you do not have any strong opinion against=
 it.
> >=20
> > I am working now on exposing all overlays, so it will be needed soon an=
yway.
>=20
> KMS assumes pre-multiplied alpha anyway, so we shouldn't need a
> parameter to force it: we're always going to force it.

My bad, I got confused with your other patch.

Still, I agree with Jernej, if it's not needed it only complicates the
code for no particular reason. If you need it at some point in the
future, add it then. Otherwise, it's hard to reason about, since we
don't know what are the expectations that those future patches will
bring.

Maxime

--ycmmdvpgrnhgi2cu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYp3HUQAKCRDj7w1vZxhR
xQ7JAPwOH2WywNctfCg4rbYtCxC02Owlfgb33BXYypx4Py8rtQEAp7OVVf9HelNl
uO4X3n7onqZVEW/knsWlXLnynOLuLgo=
=oSp3
-----END PGP SIGNATURE-----

--ycmmdvpgrnhgi2cu--
