Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D41B574D28
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238740AbiGNML2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238730AbiGNMLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:11:08 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5B927C;
        Thu, 14 Jul 2022 05:10:05 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B1B9D5C006E;
        Thu, 14 Jul 2022 08:10:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 14 Jul 2022 08:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1657800604; x=1657887004; bh=D7XHW2lpBa
        3ZTgH/W4t9embYc3/p5pA/+qwtSxzA0qc=; b=gT2vjyMISNAlVpK6KBb58APCFo
        2SHGPrqnY/8Gg1KxoJ+ljIDa7Wj7Q9HPLyP//Sz0fzzRu+loj9qrvTLJE6UU1CGW
        WQN/3MXHSdjyyqnTGgmQFmJJegZ8+xm7cORiDTKp4ZX81ENOn6T5Sw/BreCuFmJD
        fKY9SwxueiwrHkn3A0V3wmArA5ZNybEt3WbwzCGdMTgnfpFGgzKPQQFXDhKQ0utp
        TpIW/joHCLyaJ2uW/ryhigvBpNCLZzyVIYPkinEAXgCgCcOo3YY3lnfFBezWZpUv
        Zi4sgXdYqm4pSD08eDGSZFH4leuogQxjQBq80mZGGtoIo+DWoqE823iaG0pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1657800604; x=1657887004; bh=D7XHW2lpBa3ZTgH/W4t9embYc3/p
        5pA/+qwtSxzA0qc=; b=DygIqKVDSB3rTAsVCxidxoQLxEsTRV/j0metHeFG3zGZ
        WgkxwyGnb4n3y/qUi9NMOLC2KMcaR8dgqbHyO8WVeGGdrvA/5aqqcBrzRbX5oMCz
        Ie+DuzWCMFuiI7m1LvjFuBqWXRl2IQqvkBSGAxzWOy4DNUJZNFBNfvuufySRM+z1
        ZCqzzKeR6NSrN89jO1Sy6KkSclmG9DBhACaOS3UMACL9lIHt+lekRzonDbEoJyQk
        qLuXCliFfITIdH/RqxHpfVrur6yYN2rUy0Ivz78ovzvePuH1Lu3wjD3n/EFXKirc
        ro8X49UuUULW5HtBArJC+YZdYpjso67S80UAcpE2CA==
X-ME-Sender: <xms:nAfQYtaL3DEJ9QwEdcbl-ApNga9iUFmopPr1HmwfrIuist6aDbQk-w>
    <xme:nAfQYkbqxyVAzMHy13T5Al7O2y112aTEMC3GZdk4hxWXi4dVigdh37YFO6Km6UMMX
    lG4pgUYyzPFWDMVc-U>
X-ME-Received: <xmr:nAfQYv_7gVZaWHQj_puWp_KNvsMymAfCKCnN_yA7siEtQUVRp-7CTJkOrTWdNKQIVKWUy6IyLF_SlaUVWcvLtbMrxtF91kudHMYesrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejledggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeetfefffefgkedtfefgledugfdtjeefjedvtddtkeetieffjedvgfehheff
    hfevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:nAfQYrrRtlMu83HLa5kqd7j1q0fwGNlTg4vHtvC99ANfcO0JEC38Mw>
    <xmx:nAfQYoosAMXLaGNMSLwo9AqMoETt9CGiXvqR0PPoGoTarWumLHm5kQ>
    <xmx:nAfQYhSPNUUY-mS3WGVwbLj59RWRyiqwSC3xh1Aqgc-ciWTh3qtyKg>
    <xmx:nAfQYkfiMwI4tSrMAHZ__A9EcHFaNaQd7Pd8MpC3sGl3ONsB9vZygg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Jul 2022 08:10:04 -0400 (EDT)
Date:   Thu, 14 Jul 2022 14:10:02 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] drm/modes: Add support for driver-specific named
 modes
Message-ID: <20220714121002.wm6byk6puajnzvmo@houat>
References: <cover.1657788997.git.geert@linux-m68k.org>
 <528b126b3d932bff055ff085e598b91e2e690a4e.1657788997.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="itqpfuzowi2osqrt"
Content-Disposition: inline
In-Reply-To: <528b126b3d932bff055ff085e598b91e2e690a4e.1657788997.git.geert@linux-m68k.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--itqpfuzowi2osqrt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 14, 2022 at 11:04:09AM +0200, Geert Uytterhoeven wrote:
> The mode parsing code recognizes named modes only if they are explicitly
> listed in the internal whitelist, which is currently limited to "NTSC"
> and "PAL".
>=20
> Provide a mechanism for drivers to override this list to support custom
> mode names.
>=20
> Ideally, this list should just come from the driver's actual list of
> modes, but connector->probed_modes is not yet populated at the time of
> parsing.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Like we discussed on IRC, I'm not sure allowing drivers to handle named
modes is the right thing to do.

Named modes in general were a workaround the fact that we were missing
infos in drm_display_mode to describe all the modes.

I think we really should focus on addressing that first, and then
creating some kind of backward compat layer to create an initial DRM
state from a named mode provided on the command line.

Maxime

--itqpfuzowi2osqrt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYtAHmgAKCRDj7w1vZxhR
xQ/aAP9oTKyhWWihhvc4XgJIvP101uSmuw+L0FQuNx3PzZgp4QEAhPIBgTwIgcqj
nYi/57nHkDeCEA5xHbJydUz8v0AyoA4=
=tRFA
-----END PGP SIGNATURE-----

--itqpfuzowi2osqrt--
