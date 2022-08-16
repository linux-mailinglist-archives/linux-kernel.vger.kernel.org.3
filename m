Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38B3595FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 17:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbiHPPy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 11:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbiHPPyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 11:54:39 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0580D6B8DB
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:50:03 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3BB98580406;
        Tue, 16 Aug 2022 11:50:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 16 Aug 2022 11:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1660665002; x=1660672202; bh=uDbm7d0qwz
        4pvPmD2wfHPxR0S82D7wURNJkfQ0Lpz5Y=; b=GrGNwQalKlm7CiiXRQTu6nzxia
        lNKtaztECVkRYFzsHTJHj89rIUrFwmUoIAoU6cJBFaQWmYAlSbs72tAWQNugKR+5
        fy+pwZh3Pqnf77LvpxJwQMVxPIbzko1in8QqqTq+UPfeY7lLQ6biUGk+L9cIViw3
        dlBa7d4wAJ899T83CjTK5L7HCpXJ5hC3P6SAxNxLTbsJG7r6j1XtwIzmSAmBAgPr
        qHeDdfI0vnQoZTewzKMqqWeuXReBK/uE0n87Tj4Q2TA8nkk/GBNIuSLi6uDX55cJ
        LYMS8tDRI5GSus2De0i/aGfUAR1eGlY2dNy8FrY4rsX149VV+f/y+gH7PIzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660665002; x=1660672202; bh=uDbm7d0qwz4pvPmD2wfHPxR0S82D
        7wURNJkfQ0Lpz5Y=; b=UN35GHbGXMmB42WjDX7dQmoYxakSQnjIoMD8v58QKWSK
        l1U/RN4AoVWqPbmEc7+QW6Ic0R2k1xYqYZ+ABLRAQngyQ9CPunkrW3XlEW8TBiOV
        QByLAPrEXFfZnpGVKsbOJZ+UkxHiAO2fVeFfFONW9TgbKjGpp7uSThAzOcUmdYxS
        +LSivv2AfFmQKzXkIlbUUS9Jp+NLTsMY/1dJT04GjGqSWVI20Ip9yyK4Ly8N8Qln
        CVKvXnIdTAPHDZxe68Noi6reLm5fzRbYKoISeOPTFcSSx1VXm0Hrs57BU9wDJ67l
        vP4NRKjx5E2vJmRENMpSu+7tSrtHjEKTvf9UR4bn6w==
X-ME-Sender: <xms:p7z7YvWgoNrTPVlF091lQmiOGp0_-rnmiTWXAjM2vdj3cAg8qjbQKw>
    <xme:p7z7YnnC0oYCO0Fas4pAOneqx8Kv0fVU9-535wQ_bLn_El-PCQBcBHtUx8ff9DWPv
    3W9YJgwOHqat-hYysc>
X-ME-Received: <xmr:p7z7YrbbYe_EjXLt8SwM-1CQRz41ek1Bh4RaQduH7e4kEnS8r6vLZdbt__Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehgedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeetfefffefgkedtfefgledugfdtjeefjedvtddtkeetieffjedvgfehheff
    hfevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:p7z7YqV8u3zjGwpyFN9h4ZerxWD9iD-890iBPzSDfxmvewlX2yP7RA>
    <xmx:p7z7YpkUMMgT4Y3SmDtzAe42LdqQr_uEi7fiHCNYE81r9tqXWmjBbw>
    <xmx:p7z7YnfX7JrTZsCzX9iW8-Z1i2O_nxMGIfLKZGuQYRVb2fiQ227MFA>
    <xmx:qrz7YrVZSph2gnyH9vEwdblGdGfop_tCyNPS_3YKedhfZsCPGGXCrA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Aug 2022 11:49:59 -0400 (EDT)
Date:   Tue, 16 Aug 2022 17:49:56 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-sunxi@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Dom Cobley <dom@raspberrypi.com>
Subject: Re: [PATCH v1 05/35] drm/connector: Add TV standard property
Message-ID: <20220816154956.pkdpxmmw27mia5ix@houat>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <20220728-rpi-analog-tv-properties-v1-5-3d53ae722097@cerno.tech>
 <CAMuHMdWYo7M44uLNhTmJenGDreGALBZ9E48oyBDEeAuL=0h=dw@mail.gmail.com>
 <20220816132040.uwirtjm5yr6rdd3q@houat>
 <CAMuHMdWevP=3af=NneAJEDfOR+sz1thrQEhAQPNGrgitBtLjGA@mail.gmail.com>
 <20220816141116.5nuszmilqv2exdb3@houat>
 <CAMuHMdXq_xGPx46bdnUFGDiG4kcgdxtXaRGTucFd3TRq8353dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="txot7fjmru2r6vem"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXq_xGPx46bdnUFGDiG4kcgdxtXaRGTucFd3TRq8353dg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--txot7fjmru2r6vem
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 16, 2022 at 04:43:44PM +0200, Geert Uytterhoeven wrote:
> > > > > Either you have to add them here (e.g. "hd720p50" and "hd720p60")=
, or
> > > > > handle them through "@<refresh>".  The latter would impact "[PATC=
H v1
> > > > > 09/35] drm/modes: Move named modes parsing to a separate function=
", as
> > > > > currently a named mode and a refresh rate can't be specified both.
> > > >
> > > > I think the former would make more sense. It simplifies a bit the
> > > > parser, and we're going to use a named mode anyway.
> > > >
> > > > > As "[PATCH v1 34/35] drm/modes: Introduce the tv_mode property as=
 a
> > > > > command-line option" uses a separate "tv_mode" option, and not th=
e main
> > > > > mode name, I think you want to add them here.
> > > >
> > > > It's a separate story I think, we could have a named mode hd720p50,
> > > > which would be equivalent to 1280x720,tv_mode=3Dhd720p
> > >
> > > So where's the field rate in "1280x720,tv_mode=3Dhd720p"?
> >
> > Yeah, sorry I meant 1280x720@50,tv_mode=3Dhd720p
>=20
> Above you said "I think the former would make more sense", so that
> should be "1280x720,tv_mode=3Dhd720p50"?

No, 720p at 50Hz would be either hd720p50 or 1280x720@50,tv_mode=3Dhd720p
and 60Hz would be hd720p60 or 1280x720@60,tv_mode=3Dhd720p

Maxime

--txot7fjmru2r6vem
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYvu8pAAKCRDj7w1vZxhR
xeBJAQDkJDuBb9NT3t74aPA6633aiSdZ5T/VyRAsiD1bq7XLFgD/ZVFyws0xlUf2
pztAVRTUkSu7seGcOJ3pPbEwOnqabwU=
=6Lb9
-----END PGP SIGNATURE-----

--txot7fjmru2r6vem--
