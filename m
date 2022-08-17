Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FD1596AB0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbiHQHyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiHQHx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:53:58 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2831E19283
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:53:58 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 75D7F2B0647A;
        Wed, 17 Aug 2022 03:53:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 17 Aug 2022 03:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1660722834; x=1660730034; bh=H7AMF4kZE2
        hOLEr28TVkQrVEDPRpXPajEymRGpT0zuY=; b=VekMXPHqujdEVZpBIpN79E+lff
        1H4NFvjSrep9AFQbJUTuRXgh+NaV8q1zMs/5fTBGWFQG/nhnGjgxCZpTLcbaO2qk
        yVKq5W21fIJ9S0XmxRG1PwTEGV2zqCSbfuaiKrwDA8pZYKlXFxqbI033TvlvMnjl
        H4bqWQwFR4UD33MEt0/0htul9s0JX1UilhvUiJu+xr+sECciKyrjwITasOapHnkE
        t/oC9LFiNxRcylIgLbETNXkRy+xdOO6cATUoD3/J9M2TMDIvJYGZ7CSP/Zg9V81l
        X1yD9HhnGOU2lvRbVZhSUIjMteOIMlH7yR4KA7Pqf62rp6KvBAnvIUDWYbUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660722834; x=1660730034; bh=H7AMF4kZE2hOLEr28TVkQrVEDPRp
        XPajEymRGpT0zuY=; b=fM8BqqoCCmnHUEEV4QhP1Xvmbfp/msYYVT77ftKhx5IR
        29ftNAgDXPWu67vBjBfmHJqlUPQm0psZpTW41ELXNNaeApmxA46qI6EzN7NwGngn
        /OLMWHMeMYWIoW7BbhjcqECv9h4HWSks1q03kjR22NHiIIJOlD4y+OWv3HARgqQs
        w/kIz6HscEPj3PD944TsbMktD7Nbu9ZdLdSJVV7AtyFiIUorX2RZuyrCnYuQlypU
        7Fhz5gTgemp4FqiSIBcmVWy0Zr3veReOCjC0AxbsGRejUQcy436aC4pY0lv0m7Pu
        4s+SgpUdF/3g0q5BkxKzCfEl0HAD/34vZfmtuZq8Cw==
X-ME-Sender: <xms:kZ78YmU8KAGJLFcYMDQSS8pgZqxptw9N-PgMq1JOHfWOC4-oVrMGrQ>
    <xme:kZ78YimRdi_yVT8NngQEvi90JqKCrgtAk4XVX9oiLCsK9bFsWA1T1cCqkHIVSxMIE
    889tniyxK8bGRiulZY>
X-ME-Received: <xmr:kZ78Yqb8EhO8iXCsixF6nzx98hxId96DRgIqIl34ojgGbEtV8gL5lqbYmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehhedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepteefffefgfektdefgfeludfgtdejfeejvddttdekteeiffejvdfgheeh
    fffhvedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:kZ78YtUi_k-2n9qOML_KW-3BlyEf4zMTK8RPeLiYT8uvG94O6XLbDw>
    <xmx:kZ78Ygn3H3Fvzsbm3dQjc-U_RwYV1eqiO3X4OhcNtuOeUd5zc_r2sQ>
    <xmx:kZ78YifhwO143SUZ4cb2EPKMWXAQGmcJyNz9H_4sL21a2s80E4CSKA>
    <xmx:kp78YiVtdOHOoRRJiJOWnhBAJaV6sekXMscUNymMrAa9IAOesMH7WB3c7rA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Aug 2022 03:53:53 -0400 (EDT)
Date:   Wed, 17 Aug 2022 09:53:51 +0200
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
Subject: Re: [PATCH v1 04/35] drm/modes: Introduce 480i and 576i modes
Message-ID: <20220817075351.4xpsqdngjgtiqvob@houat>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <20220728-rpi-analog-tv-properties-v1-4-3d53ae722097@cerno.tech>
 <CAMuHMdUrwzPYjA0wdR7ADj5Ov6+m03JbnY8fBYzRYyWDuNm5=g@mail.gmail.com>
 <20220816132636.3tmwqmrox64pu3lt@houat>
 <CAMuHMdUNLPbjs=usYQBim5FxsrC1oJLuF+3JB7auzHHRoOqavQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ctmqbrja2753ufff"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUNLPbjs=usYQBim5FxsrC1oJLuF+3JB7auzHHRoOqavQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ctmqbrja2753ufff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 16, 2022 at 05:00:38PM +0200, Geert Uytterhoeven wrote:
> Hi Maxime,
>=20
> On Tue, Aug 16, 2022 at 3:26 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > On Fri, Aug 12, 2022 at 03:18:58PM +0200, Geert Uytterhoeven wrote:
> > > On Fri, Jul 29, 2022 at 6:35 PM Maxime Ripard <maxime@cerno.tech> wro=
te:
> > > > Multiple drivers (meson, vc4) define the analog TV 525-lines and 62=
5-lines
> > > > modes in the drivers.
> > >
> > > Nit: strictly speaking these are not analog modes, but the digital
> > > variants (ITU-R BT.656 and DVD-Video D1) of NTSC and PAL, using a
> > > 13.5 MHz sampling frequency for pixels.
> > >
> > > In analog modes, the only discrete values are the number of lines, and
> > > the frame/field rate (fixing the horizontal sync rate when combined).
> > >
> > > The number of (in)visible pixels per line depends on the available
> > > bandwidth.  In a digital variant (which is anything generated by a
> > > digital computer system), the latter depends on the pixel clock, which
> > > can wildly differ from the 13.5 MHz used in the BT.656 standard. (e.g.
> > > Amiga uses 7.09/14.19/28.38 MHz (PAL) or 7.16/14.32/28.64 MHz (NTSC)).
> > >
> > > So I think we probably need some way to generate a PAL/NTSC-compatible
> > > mode based not only on resolution, but also on pixel clock.
> >
> > This would also fix the comments made by Jani and Thomas, so I quite
> > like the idea of it.
> >
> > I'm struggling a bit to find how would could implement this though.
> >
> > From what you were saying, I guess the prototype would be something like
> >
> > struct drm_display_mode *drm_create_analog_mode(unsigned int pixel_cloc=
k,
> >                                                 unsigned int lines,
> >                                                 unsigned int frame_rate)
> >
> > But I have zero idea on what the implementation would be. Do you have
> > some resources for this you could point me to?
>=20
> Horizontally, I think you should calculate left/right margins and
> hsync length to yield timings that match those for the BT.656 PAL/NTSC
> modes.  I.e. when a 640x512 mode with a pixel clock of 14 MHz is
> requested, you want to calculate left', right', and hslen' for
>=20
> | <---- left' ---> | <- 640 pixels -> | <---- right' ---> | <--- hslen' -=
-> |
>                         @ 14 MHz
>=20
> so they match the timings for left, right, and hslen for
>=20
> | <--- left ---> | <--- 720 pixels ---> | <--- right ---> | <--- hslen --=
-> |
>                         @ 13.5 MHz
>=20
> As 640 pixels @ 14 MHz are less wide than 720 pixels @ 13.5 MHz,
> you want to make sure to align the center of the visible part.

So I guess in that example if we want to center it, left =3D=3D right and
left' =3D=3D right'? What about the sync length?

> Vertically, it's simpler, as the number of lines is discrete.
> You do have to take into account interlace and doublescan, and
> progressive modes with 262/312 lines.

So we only have to deal with 525 and 625 lines total (without taking
interlace and doublescan into account), right?

I guess we still have the same question, we probably want to center it,
so top =3D=3D bottom, but what about the vsync length?

Maxime

--ctmqbrja2753ufff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYvyejwAKCRDj7w1vZxhR
xcu6AP93cHMTNRRfPsacynbiMt5NcO8eI/W3VyqQnewI23mFIQEA2IRU57HVlr7Q
XOvH5VN6C7Xaplea0Zs4gC+zyOmyLwo=
=MlUC
-----END PGP SIGNATURE-----

--ctmqbrja2753ufff--
