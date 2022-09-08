Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755B35B1C90
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiIHMQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiIHMQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:16:39 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE56AA4B2A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:16:32 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id EA3332B05A0A;
        Thu,  8 Sep 2022 08:16:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 08 Sep 2022 08:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1662639386; x=1662646586; bh=KrUSQEGonb
        AlAjJjGy+o4W945brRN+Avg2umBhBnQI0=; b=FDJ+i06umqUPBluRJ7zeRUbZGi
        N7jURhZXBmo5/S/Usa0N7J90mrtZzUzd9Nnaqc/FSn/y2WncCNW0R/moHpGLsUYL
        C5HWH/06WmYBIrzd3wE8FfKvD0KP4va0BIHvH8EF3nQZlPPz05ZBTb7yXqScAKuO
        2cUl3GXynvvp+pozPGU+71VCeJvYCtvKDI5tFdQJ+tdXHAMzBJCwHKqsE0lKu/Pr
        A8ao6EFdwHVEEFLchW5crqmZTnlYgKcXUd/7CLSB+FPVSiwYJTLsjONLCGGyUb5y
        BFn+4WlR1jtVnr0gwwa1yiUURtwxTD5yuFucnCU7kZFiAss3Xjxn5XHd3GhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662639386; x=1662646586; bh=KrUSQEGonbAlAjJjGy+o4W945brR
        N+Avg2umBhBnQI0=; b=qSbjZbSSlScqRRb2KD+nkNMWqkO7dm28pU786LY/qda/
        20Ta+Fxd1Nfb9NVVgPzUZ5oXSwIVH75WHvntED+kLxclil5DY0Pe1OLJHK/OlyA0
        gpWzwt0FgxfMKod2+RxptaSG392n33NPqK/rCJPfYeu9E9KTI49qaIpha15PJwFe
        n2fe8C/IedfcplqCjGsd87uRarm6rQxfP3WAZPBWsXbWbMkI3xxUOfRjmg/XKIdV
        wfYk/382pZzKgJ+qRyqYgkzd+uFzaBZ1CidqctyDK7PR+nulsm3G8tT4B47TdQdK
        yfTTbwtCbOcgqMJqt0PLyEhVSx/hdOjbLulLGn2KOQ==
X-ME-Sender: <xms:Gd0ZYx-VJ_n8fwhNzqeinW9zRoOJIB3yBBBoJyfyI0tFQTcYQ_FvOg>
    <xme:Gd0ZY1t0XkgJ6p7z-6oK4s3Ru034OpDPdtxoRb1VE7LajPBjrkGKfmnncnLXy9nN8
    7Ck7iK31cV8Qbo7GtE>
X-ME-Received: <xmr:Gd0ZY_CkBdJCltHOl2jashFOaN-V8z3B7N42MUSuy5gtYWjK0NmyFuSuXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtvddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeetudffhfdtieeuleeivdevgeefvdfggfejuefhtdekueetfeduhfejfeej
    veegueenucffohhmrghinhepmhhouggvrdhimhdpghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegt
    vghrnhhordhtvggthh
X-ME-Proxy: <xmx:Gd0ZY1dGuvC2jLOJEshGqp-NA3ciXfOKnk7LWOZHvBKJlbHTDeS6kw>
    <xmx:Gd0ZY2Ph-WCqb7jAUhuUX7FJ_U8LaQhIzBiUa8BIUZN0-z70FI8IZA>
    <xmx:Gd0ZY3mFDu01G1S9U0_8Ss8uXVSawJwGIIWaxxMzuTa6inA22MpeFA>
    <xmx:Gt0ZY7ZmPog5GvP-mfXxmuJC3nvvPwh0VCe2U2NDnNmf_Ik9E6bz7qwRem4>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Sep 2022 08:16:25 -0400 (EDT)
Date:   Thu, 8 Sep 2022 14:16:23 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Mateusz Kwiatkowski <kfyatek@gmail.com>
Cc:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Karol Herbst <kherbst@redhat.com>,
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
Subject: Re: [PATCH v2 32/41] drm/vc4: vec: Convert to the new TV mode
 property
Message-ID: <20220908121623.m6n2zyk3aratb6ag@houat>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-32-459522d653a7@cerno.tech>
 <199cf4b3-8ace-e047-3050-b810cf0c6b63@tronnes.org>
 <20220908112312.hlb7mzneuxnethhr@houat>
 <aa510ec2-a72d-364b-424e-816872ab6923@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tdggbbxhdgn6r5uy"
Content-Disposition: inline
In-Reply-To: <aa510ec2-a72d-364b-424e-816872ab6923@gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tdggbbxhdgn6r5uy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 08, 2022 at 01:31:34PM +0200, Mateusz Kwiatkowski wrote:
> W dniu 08.09.2022 o 13:23, Maxime Ripard pisze:
> > Hi Noralf,
> >
> > On Tue, Aug 30, 2022 at 09:01:08PM +0200, Noralf Tr=F8nnes wrote:
> >>> +static const struct drm_prop_enum_list tv_mode_names[] =3D {
> >>
> >> Maybe call it legacy_tv_mode_enums?
> >>
> >>>
> >>> +=A0=A0 =A0{ VC4_VEC_TV_MODE_NTSC, "NTSC", },
> >>>
> >>> +=A0=A0 =A0{ VC4_VEC_TV_MODE_NTSC_J, "NTSC-J", },
> >>>
> >>> +=A0=A0 =A0{ VC4_VEC_TV_MODE_PAL, "PAL", },
> >>>
> >>> +=A0=A0 =A0{ VC4_VEC_TV_MODE_PAL_M, "PAL-M", },
> >>
> >> If you use DRM_MODE_TV_MODE_* here you don't need to translate the val=
ue
> >> using the switch statement in get/set property, you can use the value
> >> directly to get/set tv.mode.
> >
> > I'm sorry, I'm not quite sure what you mean by that. If we expose the
> > DRM_MODE_TV_MODE_* properties there, won't that change the values the
> > userspace will need to use to set that property?
>=20
> I'd just like to point out that if numerical values of these enums are yo=
ur
> concern, then you're (or perhaps I am ;) already breaking this by adding =
new
> modes in patch 33/41 in this series.
>=20
> And the values (and names!) added by that patch (33/41) don't match those
> currently used by the downstream version
> (https://github.com/raspberrypi/linux/blob/rpi-5.15.y/drivers/gpu/drm/vc4=
/vc4_vec.c).
> If any userspace software is manipulating this property, it's most likely
> targeting the downstream code. But since you're not aiming for consistenc=
y with
> that, I was under the impression that compatibility isn't a concern.

I'm not really concerned about the compatibility with the downstream
tree, if only because you already broke that compatibility with your
patch :)

So you're right, I'll reorganize that patch to keep the backward
compatibility.

Maxime

--tdggbbxhdgn6r5uy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYxndFwAKCRDj7w1vZxhR
xZzpAQDu6178QjxcwYvkevzAeo7PrIc0OnYrnwJMv32MTXR4eQEAk5vzF3oEW4ES
B3YR/wi67B2CLlhZDDEHOYE/bL80EQ8=
=fmem
-----END PGP SIGNATURE-----

--tdggbbxhdgn6r5uy--
