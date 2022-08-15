Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B4B592C0B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242393AbiHOKlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 06:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242547AbiHOKku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 06:40:50 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA5C25C4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 03:40:47 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4CAB758024F;
        Mon, 15 Aug 2022 06:40:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 15 Aug 2022 06:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1660560046; x=1660567246; bh=xZdyFzkGwx
        NMaSQo9f1nE23W8o0Knxs8zi25rNE/F+g=; b=K0y9jdKT7Kqzfipo6DBG31ePNj
        Fb0wyla4+TvyGQ/KrNeInN+6WERTOM9Nyjd3dYIhJfCozuQXBgY+BKkPTqQpHGOW
        2d7TWIlHQYfRafW2TQFflIOgPgCruZcXThcmkSWzd+41bi/FeV9bhRku3kkA8k+U
        jV4xFniD75iqFZYiDWBnTiHMCcuvb2AhkPg5iGdwlF9XB8Lua7lDzCOAkRW42IU3
        AXJmWiEuQyhGdCTnodHHzf3lItiiLT1Z0VrFFnGZrguStTTk/yDH11eO6AtR49za
        3jQ++ef7BBrPi2IuxaaDvS571gfD8ScZvA4gZYeWAjlIyeUdzn4MeHKPyfQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660560046; x=1660567246; bh=xZdyFzkGwxNMaSQo9f1nE23W8o0K
        nxs8zi25rNE/F+g=; b=KuELks6dtpN1WqhnN7uKXV+ed912oj+rJmyd1lNhf2CZ
        c/+JIhTQpRs9odLjPNmpgNH2T7eaqsJB+TSTK/UI83wcb+EFSY6zmMcfrbkZLCPj
        Tf6Gsg6+yzuwW25e8dKfs168TxSpyRDzA1KZ9HRku8dgyryvYtIXJ3sPkqQiCqwq
        ufocVBlrbMIyCs0gZmbuUJKnLFKXljZRBd8w1Puuudvmy/mJdWFphZD5HOlQcoGa
        6BpmTZR4CGaTiHWiocmSG8dqh2hTnOhm0CATBtm/hq7K5W6gPRP5GGPZ4B3HqgY3
        Ri/U1F28EdCPwNgmrsydQYAQwCHwsyCPsyhkugX8Wg==
X-ME-Sender: <xms:rCL6YhbbYH_kqaDn4cLbM_M0B9mDmlCm5zrZzg36ARp-nL9_ISA6mw>
    <xme:rCL6YoYoUZVON99FeMGEiNDuROvTBBhIhEGoEUCy-9iobL4dzdtHVVxJ8QS3ps1pi
    xVvKLd4fJrwa_-n1g4>
X-ME-Received: <xmr:rCL6Yj_93gSWPrkTEC3bWOTeTokDGtEeg0XtGHXA3Ud3Av6Ba9-bAPDfls-X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehvddgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejveefheefkeeiffegveelveetgffffeektdefuefhtedtgeejhefggedu
    ffffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:rCL6YvrZb8d-70a2yCKLG23pvQYKghlC03ajxx8SGoIbIft-vVGjwg>
    <xmx:rCL6YsovMmOaDx-QoWNCODYJdhrHPFwrWAdwZt8KTlLJ2hWCVa1ngA>
    <xmx:rCL6YlRxbA4IVIfJXPfh5Oy9TI_xAgceXYr5NZwtlneMgj9nqxc6lg>
    <xmx:riL6YlY4P3xtxIziMyH_eBPDfULxza36rNr2CLomIy3NS99U_2Afww>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 06:40:43 -0400 (EDT)
Date:   Mon, 15 Aug 2022 12:40:41 +0200
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
Subject: Re: [PATCH v1 06/35] drm/connector: Only register TV mode property
 if present
Message-ID: <20220815104041.6ymspbhpjdxg2aoe@houat>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <20220728-rpi-analog-tv-properties-v1-6-3d53ae722097@cerno.tech>
 <d96df677-a1a7-ae49-bda6-abad025dc974@tronnes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dvyzowdjas7acdtu"
Content-Disposition: inline
In-Reply-To: <d96df677-a1a7-ae49-bda6-abad025dc974@tronnes.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dvyzowdjas7acdtu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 08, 2022 at 02:49:08PM +0200, Noralf Tr=F8nnes wrote:
> Den 29.07.2022 18.34, skrev Maxime Ripard:
> > The drm_create_tv_properties() will create the TV mode property
> > unconditionally.
> >=20
> > However, since we'll gradually phase it out, let's register it only if =
we
> > have a list passed as an argument. This will make the transition easier.
> >=20
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> >=20
>=20
> I don't understand why this makes the transition easier, but if you
> think so:

So the basic idea behind this series was to introduce the new property,
gradually convert the old drivers to the new one, and finally remove the
old one.

In order to keep the backward compatibility, we need to add to the
drivers some custom get/set_property hook to expose the old property and
fill the new one if needed.

That means that each driver would have to create the old property, which
will conflict with that code

Maxime

--dvyzowdjas7acdtu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYvoiqQAKCRDj7w1vZxhR
xaybAQC2LtyY3MToe9xoyVgcLBOfo1ql+NWQtjIn17TggFlnRgEAr4/9dmteOoOs
AoYm/Hq80I2UIc7K4NZgCJX6MSwZCQ4=
=bqI2
-----END PGP SIGNATURE-----

--dvyzowdjas7acdtu--
