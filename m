Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931EA595E1E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 16:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiHPOL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 10:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbiHPOLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 10:11:23 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9B05C9C2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 07:11:22 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2C0EA5803B6;
        Tue, 16 Aug 2022 10:11:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 16 Aug 2022 10:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1660659082; x=1660666282; bh=hSJbcUfnd7
        qULOS3ijW0b6OV+nlzyadXJ1a4AV3AD5k=; b=TcKgtAX+mpgb0/tjtqkL+Hmef1
        C0cBL3Nv+ZAkcp571t1bLhXkQJB9UidM9tQVYioYkj6BQIYEPmpYdcf723wQOOzt
        UyYPpavIHEujcE9OywXEQgeLQOqa7UCormpYIKu5cLwE0bvqNxlGuogMoEbE6Ls6
        8Y7aTmM3s5agRZrJUilRr8PVzKTN7y/525Jx32+w84ZjJXgCBdxeTHwbwL1X3LqI
        nJldxEDyZ34CdlE+hJv85oNipeugIe+ekl3s3g9L/O7bqNsGFam3JAKgA7W+YkV/
        2tiHHgg9SA6UzxTWaVMqYyNgKWRiiJjKj2FlhkfUuvk55MWOayyDBTEUeb/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660659082; x=1660666282; bh=hSJbcUfnd7qULOS3ijW0b6OV+nlz
        yadXJ1a4AV3AD5k=; b=ca4xMYXemjueWWzN5SlBJA61FWu2c2A8OGAOwkwaKDoT
        rCk5lY8VCYYmXbp0GpTGPuSHgi2ibOHhJbcSwtBk63T6/uMcT5mr/3BDNPLoWhja
        NvFwKBfU1FR9WhfZlgePOfdTFI7JcfuY4RI/NYhud647Al4aonrTxEW2YvMlow5E
        bPQK4IdU2TXRBJOsZKaXdHAWM2VoSMLpDAjvMQL+USFvE1tRu/1Jh3V9NnKAploU
        KZd2dBSlBZ9NdILv+rOKy0juWEGyb/jIXi9DoMW2wRnm7T+lpP35jJrB/cumdfFf
        MCX6QctyDuLKPJncOfQs6/I/26qbltzG627OUvdBkA==
X-ME-Sender: <xms:iKX7YjQMsADeuRoeVvrGSLYt3PtuACX8fjBnbgnrmTXAWLeAY-pn5Q>
    <xme:iKX7YkwG0hW3AzBa9mIzcKuQGgiefBAlkLfqfulNvJxdj_RTjSpz2_-LAwAHq-eci
    kJfs8FrrgIXusjuDZQ>
X-ME-Received: <xmr:iKX7Yo1OhaneH6cpixS7UjkU_9N6WlY-EE34mLbUiCnMKwa9up3au0vEb_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehgedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeljeehgeejudduueevtdekheduffdutdfgueduiedvffdtleejudekvedt
    tdektdenucffohhmrghinhepphhlrgihshhtrghtihhonhdrnhgvthenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhn
    ohdrthgvtghh
X-ME-Proxy: <xmx:iKX7YjCMNOewfeRaFNgVrZjUhIKQquvHL-94rUW8S9MwpArn1-DSkg>
    <xmx:iKX7YsiU1r9Xk1V4oENyc2wb6uSdKopUO3cWRhdcpNcvggqd_j0Biw>
    <xmx:iKX7YnqlT5EHjUVGQbCe__2UvOfWtaW7noVyb3HrchMhSOoOi2IAQQ>
    <xmx:iqX7YnRQw_mEpJvrYLzbDl6KuZMQHJtmp6InvUBCTlRUtTXI0Sl7Tg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Aug 2022 10:11:19 -0400 (EDT)
Date:   Tue, 16 Aug 2022 16:11:16 +0200
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
Message-ID: <20220816141116.5nuszmilqv2exdb3@houat>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <20220728-rpi-analog-tv-properties-v1-5-3d53ae722097@cerno.tech>
 <CAMuHMdWYo7M44uLNhTmJenGDreGALBZ9E48oyBDEeAuL=0h=dw@mail.gmail.com>
 <20220816132040.uwirtjm5yr6rdd3q@houat>
 <CAMuHMdWevP=3af=NneAJEDfOR+sz1thrQEhAQPNGrgitBtLjGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d44byhtxjosx7akc"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWevP=3af=NneAJEDfOR+sz1thrQEhAQPNGrgitBtLjGA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d44byhtxjosx7akc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 16, 2022 at 03:29:07PM +0200, Geert Uytterhoeven wrote:
> Hi Maxime,
>=20
> On Tue, Aug 16, 2022 at 3:20 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > On Fri, Aug 12, 2022 at 03:25:18PM +0200, Geert Uytterhoeven wrote:
> > > > --- a/drivers/gpu/drm/drm_connector.c
> > > > +++ b/drivers/gpu/drm/drm_connector.c
> > > > @@ -1649,11 +1650,40 @@ EXPORT_SYMBOL(drm_mode_create_tv_margin_pro=
perties);
> > > >   * 0 on success or a negative error code on failure.
> > > >   */
> > > >  int drm_mode_create_tv_properties(struct drm_device *dev,
> > > > +                                 unsigned int supported_tv_norms,
> > > >                                   unsigned int num_modes,
> > > >                                   const char * const modes[])
> > > >  {
> > > > +       static const struct drm_prop_enum_list tv_norm_values[] =3D=
 {
> > > > +               { __builtin_ffs(DRM_MODE_TV_NORM_NTSC_443) - 1, "NT=
SC-443" },
> > > > +               { __builtin_ffs(DRM_MODE_TV_NORM_NTSC_J) - 1, "NTSC=
-J" },
> > > > +               { __builtin_ffs(DRM_MODE_TV_NORM_NTSC_M) - 1, "NTSC=
-M" },
> > > > +               { __builtin_ffs(DRM_MODE_TV_NORM_PAL_60) - 1, "PAL-=
60" },
> > > > +               { __builtin_ffs(DRM_MODE_TV_NORM_PAL_B) - 1, "PAL-B=
" },
> > > > +               { __builtin_ffs(DRM_MODE_TV_NORM_PAL_D) - 1, "PAL-D=
" },
> > > > +               { __builtin_ffs(DRM_MODE_TV_NORM_PAL_G) - 1, "PAL-G=
" },
> > > > +               { __builtin_ffs(DRM_MODE_TV_NORM_PAL_H) - 1, "PAL-H=
" },
> > > > +               { __builtin_ffs(DRM_MODE_TV_NORM_PAL_I) - 1, "PAL-I=
" },
> > > > +               { __builtin_ffs(DRM_MODE_TV_NORM_PAL_M) - 1, "PAL-M=
" },
> > > > +               { __builtin_ffs(DRM_MODE_TV_NORM_PAL_N) - 1, "PAL-N=
" },
> > > > +               { __builtin_ffs(DRM_MODE_TV_NORM_PAL_NC) - 1, "PAL-=
Nc" },
> > > > +               { __builtin_ffs(DRM_MODE_TV_NORM_SECAM_60) - 1, "SE=
CAM-60" },
> > > > +               { __builtin_ffs(DRM_MODE_TV_NORM_SECAM_B) - 1, "SEC=
AM-B" },
> > > > +               { __builtin_ffs(DRM_MODE_TV_NORM_SECAM_D) - 1, "SEC=
AM-D" },
> > > > +               { __builtin_ffs(DRM_MODE_TV_NORM_SECAM_G) - 1, "SEC=
AM-G" },
> > > > +               { __builtin_ffs(DRM_MODE_TV_NORM_SECAM_K) - 1, "SEC=
AM-K" },
> > > > +               { __builtin_ffs(DRM_MODE_TV_NORM_SECAM_K1) - 1, "SE=
CAM-K1" },
> > > > +               { __builtin_ffs(DRM_MODE_TV_NORM_SECAM_L) - 1, "SEC=
AM-L" },
> > >
> > > The above are analog standards, with a variable horizontal resolution.
> > >
> > > > +               { __builtin_ffs(DRM_MODE_TV_NORM_HD480I) - 1, "hd48=
0i" },
> > > > +               { __builtin_ffs(DRM_MODE_TV_NORM_HD480P) - 1, "hd48=
0p" },
> > > > +               { __builtin_ffs(DRM_MODE_TV_NORM_HD576I) - 1, "hd57=
6i" },
> > > > +               { __builtin_ffs(DRM_MODE_TV_NORM_HD576P) - 1, "hd57=
6p" },
> > > > +               { __builtin_ffs(DRM_MODE_TV_NORM_HD720P) - 1, "hd72=
0p" },
> > > > +               { __builtin_ffs(DRM_MODE_TV_NORM_HD1080I) - 1, "hd1=
080i" },
> > >
> > > The above are digital standards, with a fixed resolution.
> >
> > Are they?
> >
> > It's not clear to me from looking at nouveau, but I was under the
> > impression that they were modes for a component output, so CEA 770.3. I
> > don't have the spec though, so I can't check.
>=20
> Oh right, I forgot about analog HD over component, where you can use
> other pixel clocks than in the digital standard.
>=20
> > > You seem to have missed "hd1080p"?
> >
> > Nobody is using it. If we ever have a driver that uses it I think we can
> > add it.
>=20
> The PS3 supports 1080p over component
> https://manuals.playstation.net/document/en/ps3/current/settings/videoout=
put.html

Yeah, and iirc the Xbox360 did too, but what I meant by nobody is using
it is that there's no driver using it currently.

> > > In addition, "hd720p", "hd080i", and "hd1080p" are available in both =
50
> > > and 60 (actually 59.94) Hz, while "hd1080p" can also use 24 or 25 Hz.
> >
> > It looks like nouveau only exposes modes for 480p at 59.94Hz, 576p at
> > 50Hz, 720p at 60Hz, 1080i at 30Hz.
>=20
> PS3 supports both 50 and 60 Hz (same link above).

I'm probably wary on this, but I'd rather stay at feature parity for
this series. There's already plenty of occasion to screw up something
that I'd rather not introduce new stuff I haven't been able to test :)

Provided we can easily extend it to support these additional features of
course :)

> > > Either you have to add them here (e.g. "hd720p50" and "hd720p60"), or
> > > handle them through "@<refresh>".  The latter would impact "[PATCH v1
> > > 09/35] drm/modes: Move named modes parsing to a separate function", as
> > > currently a named mode and a refresh rate can't be specified both.
> >
> > I think the former would make more sense. It simplifies a bit the
> > parser, and we're going to use a named mode anyway.
> >
> > > As "[PATCH v1 34/35] drm/modes: Introduce the tv_mode property as a
> > > command-line option" uses a separate "tv_mode" option, and not the ma=
in
> > > mode name, I think you want to add them here.
> >
> > It's a separate story I think, we could have a named mode hd720p50,
> > which would be equivalent to 1280x720,tv_mode=3Dhd720p
>=20
> So where's the field rate in "1280x720,tv_mode=3Dhd720p"?

Yeah, sorry I meant 1280x720@50,tv_mode=3Dhd720p

Maxime

--d44byhtxjosx7akc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYvulhAAKCRDj7w1vZxhR
xRqFAP9pwwQpb8+R6FlV8bX+bcumZKNtNkKkAhuExyLKeM9jUQD/R5nsZHxJ1FG/
iUbuVwP8spLqjciAMIaurbVBaZgL+AU=
=dDk8
-----END PGP SIGNATURE-----

--d44byhtxjosx7akc--
