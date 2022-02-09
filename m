Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513E44AF4AD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbiBIPEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiBIPEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:04:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470D6C06157B;
        Wed,  9 Feb 2022 07:04:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4ACE60B08;
        Wed,  9 Feb 2022 15:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F26C340E7;
        Wed,  9 Feb 2022 15:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644419044;
        bh=OxnEbtpnNFTYIu0BVdh7jdMb60KGrJ11+9ijMRm7QQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nxDhMquQF59QKp+QuO0kF+kKQ6+lvZX2uBlSaQy5z3gsM3whNZxYZkIMRCuPxNE07
         6+qnqrvRvzRqaDkpMc7nc8qZaUWQKLEShNgwLNyz+WA73LKKHcdcJMsFBrUMZ8C1zz
         e/XKiZySMFerHQSW6mkxTE3Kw5DMq8h/lVfFf1e+WOJX3t7cHGgTmyNgy8TxeLQ7Pw
         ZTEO2QOaAlG7KzPqXbHRxxz5M14AoSTxuULGqu0hVNUMX8yMhgwP6Gl9C/Zx8M8pH7
         pryKYD+kDTl2wn/ZNOzyNRod0UvOtuEjfrz1XVz6CPVWTYwDGcKBGYscZxTCnv6hM+
         TtEGy5DrrYTrg==
Date:   Wed, 9 Feb 2022 15:03:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 3/7] drm: Add driver for Solomon SSD130X OLED displays
Message-ID: <YgPX3WZRvnWBuV18@sirena.org.uk>
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209090314.2511959-4-javierm@redhat.com>
 <YgPE8Z7HxU2wv7J/@sirena.org.uk>
 <d1025530-90e1-fbc5-c06b-f62ed83f2f19@redhat.com>
 <YgPOKf1QcOCtTisx@sirena.org.uk>
 <561e1f22-2741-b414-0267-14587d59d5de@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ma0oporxTU2ZNkw8"
Content-Disposition: inline
In-Reply-To: <561e1f22-2741-b414-0267-14587d59d5de@redhat.com>
X-Cookie: Disc space -- the final frontier!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ma0oporxTU2ZNkw8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 09, 2022 at 03:50:13PM +0100, Javier Martinez Canillas wrote:
> On 2/9/22 15:22, Mark Brown wrote:
> > On Wed, Feb 09, 2022 at 03:17:06PM +0100, Javier Martinez Canillas wrot=
e:

> >> I guess in that case what we should do then is to just have a regulator
> >> fixed as the vbat-supply in the Device Tree, that's regulator-always-o=
n.

> > Generally I'd suggest labelling things with whatever the supply is
> > called in the board's schematics/documentation, that tends to make
> > things clearer and easier to follow.

> The display controller datasheet and schematics mention VBAT as the power
> supply but the documentation says that it's just connected to VCC and the
> label in the display says VCC.

> But I understand why the Device Tree binding and fbdev driver used VBAT
> since that's what the documentation mentions.

What is "the documentation" in this context and how is that distinct
=66rom the datasheet for the display controller?  In general the consumer
driver should be using the name from the datasheet and the regulator
itself should get a regulator-name reflecting the name in the schematic.

> > It is depressingly common to see broken code here, unfortunately
> > graphics drivers seem like one of the most common offendors.

> I'll include a patch for the existing DT binding and mark the vbat-supply
> property as required. Probably we won't be able to change the fbdev driver
> without causing regressions, and I'm not interested in that driver anyway=
s.

There should be little danger of causing regressions given that a dummy
regualtor will be provided when one is missing.

--Ma0oporxTU2ZNkw8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmID19wACgkQJNaLcl1U
h9CAzAf8CKPiD+lXXdh149xtC2P3tLmYf9/NzL3nAnYwK1PqDyJNNfWCgJ6UfoI2
JcXfedd8YDCRodJiw0OaMn44AILruUKsMh+cHHtEUkBbyPj14DvHLoYvtlW/97sW
5/eq5WpXC8v915Ma5H0u2wh5KdBeYzgTDKO2bqHRr756SRcqg82DcwO6U3tO55Fg
GY3VwTJL/hykLaOdM8gtbLbM0k/C5jcADmhKUMCMX7Dc9hyHa11opAopTliZosXl
GoknKBDa22oFsXArV7sSMiIfVz3WMaG8Z4P0RSAhzZv+e2O7sgwL42dWpio99Y1/
xpxV3/ZObW+lY3SpInYdffOcEFHgEQ==
=sOLR
-----END PGP SIGNATURE-----

--Ma0oporxTU2ZNkw8--
