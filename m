Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5D54B83F3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiBPJQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:16:48 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiBPJQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:16:43 -0500
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6568D2B0486;
        Wed, 16 Feb 2022 01:16:20 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id 0E04B2B00253;
        Wed, 16 Feb 2022 04:16:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 16 Feb 2022 04:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=sMW5oGsMAjE8sYacZZPK8bK9V74GtDB5WcgNvX
        ru24s=; b=BNgKSoKhnZAYurGdmfQYMqQgRY7WcwzM6qtRhyOXSnI6EV0jNiZitP
        EDRDEongZdoW3mJ6Ogi4VmsIhu0A1ZsMQYtl5/Uq2Hu4ecuSU9XQZxyaD5J53FTA
        KIOnWM0lilk7OzBWjt0UBRso0A9yVhGOdFzXhN2M/Hq0z0Ua867Vqw1k2XP/apDg
        GRWaTXMrOt4H78JMD1rmD3mcg2RfyC4pimK/csSWYKj3ZubB1YHClIUQvZZZRagw
        jCW+sKah6lDdL2w/XOLQiXuD141ElduvYf4ELEzgN3P73Fd4iNrSgsrB+QZCVTXb
        WpegGwHSK4FbhFV4j3uuuAWXHW5VfThA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=sMW5oGsMAjE8sYacZ
        ZPK8bK9V74GtDB5WcgNvXru24s=; b=W8jsGwzT+Yw1m8J7dcgYFtdVAW090G4KW
        4Qocovvv/h8eW99lfSdI5nlm6ueQ9uxTW9LqC9/TQaOM/k9PSUcUI5M6tmNv9j22
        hfUWc+0gKgBek3petBoy7+PjKx+6C9lXI2Rl+vWglcuKcO+EwV/VWYByK9EX2u4m
        nDIc7snOBXlOJmPszMXMvqIifwgMCj9T8LZI4+dY9XwLq5TmmIO7AZOD6oErpLti
        eXWZwM9an9phnnBKFvV7BJXcCXw11EEI5s16H4QivNza3vs6uAhLmWOT9Wc+PV+Z
        EzbBkD8B2ot+vaFHguGVWk3UqKw462Yo7E8q32DZ3jhMXOXTm27ig==
X-ME-Sender: <xms:2sAMYnVVB1GrSNedNSgaxljKhleT1nf5ZJjRxsQ04Gya5FWTD5WiRw>
    <xme:2sAMYvmcuJwrv1MC9ObURnR9qnafLVgjkBM9KN-h4luyc8DmeylLmWA6558A6LWff
    P1crRRgPxR2kD7Z2M0>
X-ME-Received: <xmr:2sAMYjbkjjLd58-ty6XVZx1v1y-UCcDyOqWlkLeE0k0VSfn19dc5PDNwCiIEBWWN1sKSd13XNzTTL7ydDMYOl3YahqcM5wY43iN8iOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeeigddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:2sAMYiUbi2LvRVY9XM3Pivjs1-EYWm2iKm6r4H6OoPLOTW_jdYVeCw>
    <xmx:2sAMYhmR_UdmpfpqfqerTIiPnB8Q_D7_mEegA6qMu_REqp2hB94-nQ>
    <xmx:2sAMYvfZRWlUGwi8jJrtvwoqyP6KerYrLY-_lAT4BbXXicS0GD3t0g>
    <xmx:28AMYndY8uihGYKzHCgwh0FzufnQmKxS-Q2kJL8iZo11E5LYZy0-7saIvNw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Feb 2022 04:16:09 -0500 (EST)
Date:   Wed, 16 Feb 2022 10:16:07 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v6 1/6] drm/format-helper: Add
 drm_fb_xrgb8888_to_gray8_line()
Message-ID: <20220216091607.z57rx2prwpto4zsb@houat>
References: <20220214133710.3278506-1-javierm@redhat.com>
 <20220214133710.3278506-2-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vhrqb63pgb4zitfu"
Content-Disposition: inline
In-Reply-To: <20220214133710.3278506-2-javierm@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vhrqb63pgb4zitfu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 14, 2022 at 02:37:05PM +0100, Javier Martinez Canillas wrote:
> Pull the per-line conversion logic into a separate helper function.
>=20
> This will allow to do line-by-line conversion in other helpers that
> convert to a gray8 format.
>=20
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--vhrqb63pgb4zitfu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYgzA1wAKCRDj7w1vZxhR
xYW9AQDARJM708MM1eD72YgWWoV+JiNsuc30ycwryaOjzPlcXgD8Cu1fjn2xdnJr
2d9VDjYTEiv+blK7zEUJ0nWzS0nCFgU=
=z6mf
-----END PGP SIGNATURE-----

--vhrqb63pgb4zitfu--
