Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DA04B83EA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiBPJQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:16:56 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbiBPJQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:16:53 -0500
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2E1F5C;
        Wed, 16 Feb 2022 01:16:39 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id 525D92B00254;
        Wed, 16 Feb 2022 04:16:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 16 Feb 2022 04:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=KmLufUqjfQqxm6ppQfPseUWWMvRBMQWSjJ2fxH
        Ea95o=; b=RynjBkf0aoz7dpCZiMdPAwwk7pGxP/1UM/fIa7V6rxYOfeOuZ4SF+G
        KrvrWm5ovKdDJx82/Ur63J0ARcjvOTpPBhjmJEIEtsGFAz1k7VBcm3PQ53JKoE8+
        VcGK9sEKL7YKORCcMxRpHONPGHdU+PuMQNpywaTdY4mw7TLOD9Z814rq3j8BAQEy
        U+xE8ZzinU2nMXAJubpZ3bXV2WBmDNTDwsfSFrvhm+q7WyRJXtXrRE5LBSnYfBca
        3RWtAXd0EoQnygywtp/tF439iSVAlEp8WEE7MTHeve2dlmV4tFxeOKOiH+QTvzZk
        LsbWdY6DSoPe/3T3Jacm7n9V9k4giNwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=KmLufUqjfQqxm6ppQ
        fPseUWWMvRBMQWSjJ2fxHEa95o=; b=aGWFJVn3MWfexkpqzW1/dgFAvUkAGpC21
        lvGoOqDFaSizQF+Mw7gTo8Drsox6K+5XkA7NSw28JmaKlgcOmy8S52IAD02SrKwP
        tsybvgy+TcBRLzzUm+JO9L5Gna170wi3R5BcRM+1fS0erNPw1X5gXPvpW8zXw30q
        JjgN8T7KgbgAFQJzhCDdcQHJHEP8yybx9D8bt04lrfQ0BRYQzU0CLC21W8dI1jD/
        gt8cFhbufXGj+J9OM0/FhATwZjzN1nN1u79kbjsXkVD400RdVrlo0sRyvA6KDfai
        CjT/g37/SmDhf5vJv/r7L7hZ7b/hyg5Ei0nSf50CkssEFRXxFTbzQ==
X-ME-Sender: <xms:9cAMYnZTNcL5cYjSfr9Qirtwf1RbLx6s2l6XxsQfOaVilRlV7AhzOQ>
    <xme:9cAMYmapbiZT9rOCWUUQrE9ZzHwWikbAsK-UiqHgC9yH5g-rWxA1PGhgufMyC7izI
    4u9541zNH4EvVmceJQ>
X-ME-Received: <xmr:9cAMYp8cuF5JBtQSKTqfifqL9rJ4b8Zrth45rZpCWWi6ire7dtFQqmMOF-Xm6TIWBZBoUxR-S82G_TPbfVxQp9xw5zABCKef0AmJSS8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeeigddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:9cAMYtp1kkf1JcPRDykfszYh9a8VHS5YO3iWm4o8e1G02G3-GkE6pQ>
    <xmx:9cAMYirOefxpguEGSRn48v7xnhquaJpxZ7zkX0yn6--Ypag8nWBdzQ>
    <xmx:9cAMYjQgteovdM-6n6TBO7Moj0dREdo0U4bDJrz5ASfEiykIcxSuBw>
    <xmx:9cAMYvSnY1ibb2x6e66fkHah9zP6z8MWviyNlQqNMEK7V_dP0SsW8aWNLlQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Feb 2022 04:16:37 -0500 (EST)
Date:   Wed, 16 Feb 2022 10:16:35 +0100
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
Subject: Re: [PATCH v6 2/6] drm/format-helper: Add
 drm_fb_xrgb8888_to_mono_reversed()
Message-ID: <20220216091635.6me7zh4l6p6qvoqz@houat>
References: <20220214133710.3278506-1-javierm@redhat.com>
 <20220214133710.3278506-3-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yxsysjzabnrzwwaz"
Content-Disposition: inline
In-Reply-To: <20220214133710.3278506-3-javierm@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yxsysjzabnrzwwaz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 14, 2022 at 02:37:06PM +0100, Javier Martinez Canillas wrote:
> Add support to convert from XR24 to reversed monochrome for drivers that
> control monochromatic display panels, that only have 1 bit per pixel.
>=20
> The function does a line-by-line conversion doing an intermediate step
> first from XR24 to 8-bit grayscale and then to reversed monochrome.
>=20
> The drm_fb_gray8_to_mono_reversed_line() helper was based on code from
> drivers/gpu/drm/tiny/repaper.c driver.
>=20
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--yxsysjzabnrzwwaz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYgzA8wAKCRDj7w1vZxhR
xYXoAQC0KgnDTZ6PH4yXe5+8eUvWmGjolaAycOwLCERdzSU4qgEA/zDW4/QUB06G
t9KCewGFlLs4cC3d/otfJcY1WbHkYgI=
=rKR/
-----END PGP SIGNATURE-----

--yxsysjzabnrzwwaz--
