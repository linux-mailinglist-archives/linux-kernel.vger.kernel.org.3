Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FB9595211
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 07:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiHPFbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 01:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiHPFa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 01:30:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106141E0F45;
        Mon, 15 Aug 2022 15:07:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5837B811C1;
        Mon, 15 Aug 2022 22:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DE2C433B5;
        Mon, 15 Aug 2022 22:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660601266;
        bh=7yW4D4Jr+GwP+dL8bSYKzTZ6Vx8kkiE7EcnoGyP8Vh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uGSvNd4EV/iKCG9xuv/NuL0wUEPyTOXe4dGEfb36EKNtmW7Yrk4D28+3A2W6rz7np
         vnJ5Bz6il26/cO+xSbchp7Unh3LfVSjGWZIyAOjHJmfKdIu/zIQuUHlOoLaRXNrpLU
         EvZQ45i6fdrm9fR5izg3RpHaVzHZUhSzHCOijXiwAs3KOuFh0+boQ4TildPz2mAXId
         MzSfYwK9QO5cWQIuI+W7EcKFgMWzy/7x7xOXSniSYIXaj9fPlSpASJbfwQIpl7oZMl
         j1tNrmiH89nPEZ2chBnnA78u2OXQEjvr0Wbkb8feNgx0F11Jq7oz6P5tfZaczr5TuE
         H+1q+hp23/fjg==
Date:   Mon, 15 Aug 2022 23:07:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        dri-devel@lists.freedesktop.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-amlogic@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Michael Turq uette <mturquette@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-hwmon@vger.kernel.org, linux-clk@vger.kernel.org,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Robert Foss <robert.foss@linaro.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        David Airlie <airlied@linux.ie>, linux-iio@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/7] Devm helpers for regulator get and enable
Message-ID: <YvrDp32/TknqV05t@sirena.org.uk>
References: <cover.1660292316.git.mazziesaccount@gmail.com>
 <166057828406.697572.228317501909350108.b4-ty@kernel.org>
 <YvpsRbguMXn74GhR@pendragon.ideasonboard.com>
 <Yvp1Qkuh7xfeb/B2@sirena.org.uk>
 <YvqV9Mq6I3gXQaf2@pendragon.ideasonboard.com>
 <20220815205857.308B1C433D6@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VUoPU3p+8USLMiyu"
Content-Disposition: inline
In-Reply-To: <20220815205857.308B1C433D6@smtp.kernel.org>
X-Cookie: We have ears, earther...FOUR OF THEM!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VUoPU3p+8USLMiyu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 15, 2022 at 01:58:55PM -0700, Stephen Boyd wrote:
> Quoting Laurent Pinchart (2022-08-15 11:52:36)
> > On Mon, Aug 15, 2022 at 05:33:06PM +0100, Mark Brown wrote:
> > > On Mon, Aug 15, 2022 at 06:54:45PM +0300, Laurent Pinchart wrote:

> > > > - With devres, you don't have full control over the order in which
> > > >   resources will be released, which means that you can't control the
> > > >   power off sequence, in particular if it needs to be sequenced with
> > > >   GPIOs and clocks. That's not a concern for all drivers, but this API
> > > >   will creep in in places where it shouldn't be used, driver authours
> > > >   should really pay attention to power management and not live with the
> > > >   false impression that everything will be handled automatically for
> > > >   them. In the worst cases, an incorrect power off sequence could lead
> > > >   to hardware damage.

> I think the main issue is that platform drivers are being asked to do
> too much. We've put the burden on platform driver authors to intimately
> understand how their devices are integrated, and as we all know they're

This is for the regulator API, it's mainly for off SoC devices so it's
not a question of understanding the integration of a device into a piece
of silicon, it's a question of understanding the integration of a chip
into a board which seems reasonably in scope for a chip driver and is
certainly the sort of thing that you'd be talking to your customers
about as a silicon vendor.

> The basic idea is that drivers should be focused on what they're
> driving, not navigating the (sometimes) complex integration that's
> taking place around them. When a device driver probe function is called
> the device should already be powered on. When the driver is
> removed/unbound, the power should be removed after the driver's remove
> function is called. We're only going to be able to solve the power
> sequencing and ordering problem by taking away power control and
> sequencing from drivers.

That is a sensible approach for most on SoC things but for something
shipped as a separate driver there's little point in separating the
power and clocking domain driver from the device since there's typically
a 1:1 mapping.  Usually either it's extremely simple (eg, turn
everything on and remove reset) but some devices really need to manage
things.  There's obviously some edge cases in SoC integration as well
(eg, the need to manage card supplies for SD controllers, or knowing
exact clock rates for things like audio controllers) so you need some
flex.

--VUoPU3p+8USLMiyu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL6w6YACgkQJNaLcl1U
h9Dj/Qf+Irhly4mQ6388aBof87f+fRZyTpfRbk1B1J89HNrKzDUxTc8jId0ibmOh
XP6CnxFT1ppn79ZTYaYepg5Gj95WFKW5W+ZJHwuG8LXfkbUu4hBYRufm+/CxYoxG
x4ZwtE3q1fA3zcCiTUsAYldU2zuNucCo+p/GRSHc3khhEEDepTmKF8Ifvt7EjMvx
YzoIDe3t68bxJ0qO+nlndzie3mI8drGHfU5pr/BZroJY6WMlhG8InmyNpaYb5Wj+
TzNpM7qWZFvYzEXTe6Dd3lBBcBiWaW3P2KcFKdysY2Kcc0+HTiQVxjgn5pjLQa9R
3+8IJudr63VwjCEgMbDPRxVG7Ht+9Q==
=CRju
-----END PGP SIGNATURE-----

--VUoPU3p+8USLMiyu--
