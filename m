Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F954AF3F2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbiBIOWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbiBIOWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:22:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CE2C06157B;
        Wed,  9 Feb 2022 06:22:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3821B821B2;
        Wed,  9 Feb 2022 14:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F33C340E7;
        Wed,  9 Feb 2022 14:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644416560;
        bh=B9M1QUhxyzDTyJUIvoDWD9clUCcq5ypjGHdIH9Y1XLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ezvszam4JzxtWGTKTkn/z46tgYiIjF3YOhh0B3WAQBr1/xZ0J65eNGDIolA1fKD+b
         1IcX9L3OzFYxjaDx9+OxdLcMsmVzfESU7kUhh2DCBJVZLbbGlylD+VF5Hhh7mtv0Rs
         hMTC5ZKeOzWEKK2h40tAsJAJv6pGBOtppAywQjflflU6jB3Q/0ymDNwWMW0/NYFcgR
         GPaJq5cseks1dx+RyBWt4ecCsHyye5IV+bClPHtsb12pPuOUim1MjI6GmlORh9nr5v
         2oJRiEgz6ATGL/WK2LpcFIRuNqPeAY4XcIqvgAGR16ngz4EX685CB7HnezczqX2y0J
         wKTe2eYKcX0Qg==
Date:   Wed, 9 Feb 2022 14:22:33 +0000
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
Message-ID: <YgPOKf1QcOCtTisx@sirena.org.uk>
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209090314.2511959-4-javierm@redhat.com>
 <YgPE8Z7HxU2wv7J/@sirena.org.uk>
 <d1025530-90e1-fbc5-c06b-f62ed83f2f19@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wE80BzLpWir2bphU"
Content-Disposition: inline
In-Reply-To: <d1025530-90e1-fbc5-c06b-f62ed83f2f19@redhat.com>
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


--wE80BzLpWir2bphU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 09, 2022 at 03:17:06PM +0100, Javier Martinez Canillas wrote:
> On 2/9/22 14:43, Mark Brown wrote:

> > Unless the device supports power being physically omitted regulator
> > usage should not be optional, it's just more code and a recipie for poor
> > error handling.

> The device has a VCC pin but in most cases this is just connected to a
> power provided by the board in its pinout header. For example, I've it
> connected to a rpi4 3.3v pin.

That sounds like a very common configuration.

> I guess in that case what we should do then is to just have a regulator
> fixed as the vbat-supply in the Device Tree, that's regulator-always-on.

Generally I'd suggest labelling things with whatever the supply is
called in the board's schematics/documentation, that tends to make
things clearer and easier to follow.

> The old ssd1307fb fbdev driver also had this as optional and I wanted to
> keep the new driver as backward compatible. But I understand now that is
> not describing the hardware properly by making this regulator optional.

It is depressingly common to see broken code here, unfortunately
graphics drivers seem like one of the most common offendors.

--wE80BzLpWir2bphU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIDzigACgkQJNaLcl1U
h9CIRgf9GQgvRGky+AHIz+3b4Xh9ynU6oo2+aA7UEZoXXO9GUqpQSYRbnyQ/agr3
FLnQfZ5r2/cRZlLAQLFv2MTfOCGD8gLiUctqlD37tLPXg8lwbDvbMblhskQ5PFMn
wMFyobAOlaSQnA9EuQSF33dk2esmhsxAPo3kSw3YMlpqCmp3/feYC7FwfkImDH3b
FGgL2JY9UbffMtY6kstb/WihsMhlXRP6Hj6Zch6J2vVmB+Nvn9nEMvwpWcvk9YkD
KzzzDggasIowid6/iHYMKQ2oNhTZoUXezRWXANvYJF5NpqIwe4BWGmt9Sk5eu+X5
opACYR+EewGRuXZAqeTmM2VIeYm8Uw==
=kMLR
-----END PGP SIGNATURE-----

--wE80BzLpWir2bphU--
