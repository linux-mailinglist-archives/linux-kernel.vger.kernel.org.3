Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24595A212D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 08:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245089AbiHZGrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 02:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245151AbiHZGrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 02:47:16 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701C9D291C
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 23:46:54 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id AE6495801D4;
        Fri, 26 Aug 2022 02:46:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 26 Aug 2022 02:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1661496410; x=1661503610; bh=GDI1p03KIm
        VlfJybKQmUVUO7IOmo/SYqjAdeD+YEJlU=; b=kCGkvMU71YpuR26/BKv0WV1a8b
        HFbSpBa/AZvbeZIWSFNRmNXoz2q2vhGz0rySdhoz44mNNocXjRG1c14i1Y+F7n5h
        khGLctRYXvDyDUaCX3/TmOKGntJ3dN6hfgChVT5gyPCE86HKR7hr9xgOAv8j6lBT
        +LbtcVKIN8zD/4fhLAOM5Rvh4KkKHvwUKeff4bYQD8U2+oszeErGrhpQIaQf1WLE
        k0nC9C8EfvsvsWjz32WHx3SEEKR6Tp/89mJ92XfpIGVEHTapg1T46i87PI+LpJrE
        RMX4qLx5RWeXXU5yWBHcFxsL/OkjrdmyXnUY2+Kc7eN6XM3EPkBeNv2rhcjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1661496410; x=1661503610; bh=GDI1p03KImVlfJybKQmUVUO7IOmo
        /SYqjAdeD+YEJlU=; b=v5dH7JbPy1IjrkFwNE91odQ9Pi2I1YbQg3CGPgZH5DNO
        PgS+UZwQI/9OIN3Mw+BswZMVY2PPrtphpUQ6SBehjCfhh+2siZ3Iflf53yf2gevY
        NRl0YUaJGBhFbnLLx3bIQn7923tn9oZuGG1lX38tW7IghHSLhccydpTz0QyPgfle
        w+BDa+BXIGvR6rp1T0xTjVg4qIbmditFP7NSonQ2ZoRoOZxAirvao0PF18843l6H
        QkCKw5hV4HXdoivMKM1u38gkuHb60F5gyv+vLagdPu1UlMBwltx3/qhJSSBZX4Sr
        DPzLhMHIJouKzESjiHxDBss0Prtt9IWN0WyxfkUmBw==
X-ME-Sender: <xms:WWwIY6mWhwXyPvQHW9ng4gRF2i8k9txnwlR4YLWfR_rEd2UYjS5uLQ>
    <xme:WWwIYx0Y2eUBmPlog9hpI4LEX3PhrJNmCQkvyv0aWUUwuPte5HOiJbpLcRCeRFMzv
    rHAJ9FFcA2EAaDUj2A>
X-ME-Received: <xmr:WWwIY4qqNUGA5fPGP-gEIC6fDCMnhKUpiDTQYs74jmirZVGwXgiiHaZuzjY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejgedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepjeevfeehfeekieffgeevleevtefgffefkedtfeeuhfettdegjeehgfeg
    udffffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:WWwIY-kELSNkvT5OTKcPcBlLosMsWuRTQ1p2ap0ODb2uF_14bohidg>
    <xmx:WWwIY40xpD1KNavaFfgWv5DNg2kdPM95OVtb9Q8-suNNSx9qlAVNeg>
    <xmx:WWwIY1tjUDiMWUKCyprecgvVaV4VN0ZOjmFvzEKNh-1_nPrhWsGLHg>
    <xmx:WmwIY2k5gsHGbCQV212q7BtOW0FaBUG9v5-0MZJUDbO7gD54xN_nXw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Aug 2022 02:46:48 -0400 (EDT)
Date:   Fri, 26 Aug 2022 08:46:46 +0200
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
Subject: Re: [PATCH v1 34/35] drm/modes: Introduce the tv_mode property as a
 command-line option
Message-ID: <20220826064646.ug2djacis7whybpd@houat>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <20220728-rpi-analog-tv-properties-v1-34-3d53ae722097@cerno.tech>
 <eedb1a86-c1fb-cc76-2a43-4ed349d7d826@tronnes.org>
 <20220824154543.bdtpz2evwzsjrdrz@houat>
 <3cc08f9d-9f01-b771-c16f-ea95acd7e7cd@tronnes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dmczm7av6szyde4h"
Content-Disposition: inline
In-Reply-To: <3cc08f9d-9f01-b771-c16f-ea95acd7e7cd@tronnes.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dmczm7av6szyde4h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 25, 2022 at 02:41:27PM +0200, Noralf Tr=F8nnes wrote:
> Den 24.08.2022 17.45, skrev Maxime Ripard:
> > Hi Noralf,
> >=20
> > On Sat, Aug 20, 2022 at 10:18:47PM +0200, Noralf Tr=F8nnes wrote:
> >> Den 29.07.2022 18.35, skrev Maxime Ripard:
> >>> Our new tv mode option allows to specify the TV mode from a property.
> >>> However, it can still be useful, for example to avoid any boot time
> >>> artifact, to set that property directly from the kernel command line.
> >>>
> >>> Let's add some code to allow it, and some unit tests to exercise that=
 code.
> >>>
> >>> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> >>>
> >>
> >> In the subject it says "tv_mode property", but the property is called
> >> "tv norm", so the option should be tv_norm?
> >=20
> > Yeah... I don't know. mode is taken but it's obviously the best name. So
> > I went with norm to avoid the (internal) conflict but I left mode for
> > the user facing property.
> >=20
> > I'm not sure what's best here, or maybe we can pick another name entire=
ly?
> >=20
>=20
> Why not just call it "tv mode" or even better "TV Mode". The state
> member can be called tv_mode, but the mode_config member will need a
> temporary name until the "mode" property is removed. tv_tv_mode or maybe
> connector_tv_mode?

Yeah, that seems like a good idea. Would legacy_tv_mode work for you?

> But IMO, if there are no users of this property, adding it should have a
> drm maintainers ack.

Yep, of course :)

Maxime

--dmczm7av6szyde4h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYwhsVgAKCRDj7w1vZxhR
xagcAQCspBwGYBSb/ilXsoY7WZaVorZ+0k/rDn3zQOob2qwY7wD+IadLV+q7Qw9q
D1RIs0Z4w2lGo0vSFi33xoW6p6/S6wk=
=qZ8U
-----END PGP SIGNATURE-----

--dmczm7av6szyde4h--
