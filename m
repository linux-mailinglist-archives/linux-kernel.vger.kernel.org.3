Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AA05AFDBB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiIGHl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiIGHlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:41:53 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72629C507
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 00:41:44 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id D52402B05879;
        Wed,  7 Sep 2022 03:41:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 07 Sep 2022 03:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1662536499; x=1662543699; bh=y/msntKdqi
        pj+ejDnjeq3oXEB7xQmRBAGIlH51MmHWE=; b=0ASl9C6mR2JMJ57u2qgHquxhFK
        iVA9dUYYNSoFW3HVkNKZTO+8uwr9a6Fj/JbJcHJ3sW/n4A+fv3twntq80py1N6BE
        TpdZw+aiJmEkIHDX78ZTWAaJl6+A/0AIkRL5jt5lHLxZCRuVNN9az3kImEy7bjDu
        e9cIkIQnKAeGumwknFXlG5Zw0pz7R0jRuRT48BBz6Q0nNJmpyFDXyy2ZX+NIRq1G
        ROApjkaFKXrWyLKH14m6Y5qp6EGXB8IaImBNbHd/uCeTEordLWBhom6z4Ri6itQM
        7fG5hj2twZnUtCscGT2JLGiszHJg8h9XBHn+VznC3VJR+b8azpY3jOft/5Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662536499; x=1662543699; bh=y/msntKdqipj+ejDnjeq3oXEB7xQ
        mRBAGIlH51MmHWE=; b=L7sJEzcOhJLtRU29J81qbMFqhlCjRJ78s+lS4UkTN35I
        mJ0ztQLKKLJsrVEmIs48j/0LyEA3sCSpi72I0BuU7xVK0Or+3uS6y7/jgdaf59j+
        MoNvxjgy/YvUIeaJJ2Sh3OD/opeWrHcGakOpugY5VhbxAw1NrljjLYlVdBz9POHR
        FUr/Slrji681XDD7wpxX1Myr7vbMNpJcQxhMq2ZMdPAWMSBXIgFI2HPFZnydsmnx
        WRR3+gtE8IQn7MZqb0OHDYsSVsRGIt1n5LChPQEIzjlhI2/keF07pgA+UektVb7b
        I82sQwfu8yD9/o2Qvfb+cT5mzadzvWwcovM18ENhTQ==
X-ME-Sender: <xms:MksYYwVncUW7PiRwsQFP8Pl6tYZ1h8QmNxnjxyY4ozlLumGybwZpvQ>
    <xme:MksYY0l3aQpfy5ttitwFK-w0hMvekCDHdDZ5VaoZNQ_Yt_LAoMf2bjR7jARKOUAnP
    uPV-d3sgR8SCM3HbIw>
X-ME-Received: <xmr:MksYY0a4v2y0W68OkCY4zBJrOjgZ0zB4oLEn029t2UKbqg2ue_ilVwrMYIE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdelledguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepheeuudefieehudeludevuefgtddvgffggefhleffvddvvdfgudeilefh
    heeiiefgnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordht
    vggthh
X-ME-Proxy: <xmx:MksYY_XFm2aTYEbFlm97pwKepkddGu_vuJOTn8OXbiLuYiAynDx7yw>
    <xmx:MksYY6krTdQCeRcWWqpLiNfwWtdXBIOctTEM-1jU4em_YlNGFbTMoA>
    <xmx:MksYY0cJyAjD2i8fl7D5nwp3Qo4cV5yRVJfXU12_PTIfe6NTPLT7Jw>
    <xmx:M0sYY41lA31tNqmg20VQfh6esnzeLlCyNcIb8YWnzI4_LJFDLNpmDWSz62A>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Sep 2022 03:41:37 -0400 (EDT)
Date:   Wed, 7 Sep 2022 09:41:34 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Samuel Holland <samuel@sholland.org>,
        Karol Herbst <kherbst@redhat.com>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Emma Anholt <emma@anholt.net>, Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, Dom Cobley <dom@raspberrypi.com>,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        linux-sunxi@lists.linux.dev,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 36/41] drm/sun4i: tv: Merge mode_set into atomic_enable
Message-ID: <20220907074134.36yysxrnnpty4ngw@houat>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-36-459522d653a7@cerno.tech>
 <10138422.nUPlyArG6x@kista>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hs4qhyrj3xkup6mv"
Content-Disposition: inline
In-Reply-To: <10138422.nUPlyArG6x@kista>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hs4qhyrj3xkup6mv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 06, 2022 at 10:04:32PM +0200, Jernej =C5=A0krabec wrote:
> Dne ponedeljek, 29. avgust 2022 ob 15:11:50 CEST je Maxime Ripard napisal=
(a):
> > Our mode_set implementation can be merged into our atomic_enable
> > implementation to simplify things, so let's do this.
>=20
> Are you sure this is a good thing in long term? What if user wants to cha=
nge=20
> mode? Unlikely, but why not.

It doesn't change anything feature-wise: whenever the mode is changed on
the CRTC, the encoder is going to be disabled and enabled.

It's disabled here:
https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/drm_atomic_h=
elper.c#L1064

And enabled here:
https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/drm_atomic_h=
elper.c#L1403

With drm_atomic_crtc_needs_modeset() being defined here:
https://elixir.bootlin.com/linux/latest/source/include/drm/drm_atomic.h#L10=
49

Maxime

--hs4qhyrj3xkup6mv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYxhLLgAKCRDj7w1vZxhR
xc3fAQCln8DK77u9XIhbZwrlXlxRZD8r9dSaa/Wm+6VIuvo9WAEA/N2B7TOwCRYY
WZhwLuKago4QDcoZHalP5O1dmFuJ9wE=
=RBGO
-----END PGP SIGNATURE-----

--hs4qhyrj3xkup6mv--
