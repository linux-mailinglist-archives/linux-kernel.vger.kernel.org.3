Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3AB595237
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 07:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiHPFwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 01:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiHPFwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 01:52:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B31413B891;
        Mon, 15 Aug 2022 15:56:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D631612D4;
        Mon, 15 Aug 2022 22:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDF4C433C1;
        Mon, 15 Aug 2022 22:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660604165;
        bh=xMmA6oKgbgUn6m+9eT6q7pbLR6zVbVy796oIUBAaC34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F9SlKgjQLmKKrMBqJ3vvsBrd/Yrlq/4jXbrxweWPj+yty8ovPhmdnEnTIWpGowipZ
         ECHdt+y2tO9y8qZfE+f+YPkED7huG/w9HkviixPVFvChrzkt8yQHvMo9O2VEBMNnzT
         JrgsR7XULrWGVBkNhntK/xnHOk7eDkZMlqsrXDiqjhP0aUimZ6hEjHJq68SJqJNXZ8
         Mn7TB54t7gXDP09+nIigfo9+G8xUNeiGZ8KoKq/3xI0hTgVnGoFpEhhQ4uxC2ZsnD5
         nbKSi9SZujYbs+PUjccW7ijsGglrXKDh+DVk9PUS1QTRrpf9KPISuwCizKTspA2CBS
         QyObtjpXNSFrg==
Date:   Mon, 15 Aug 2022 23:55:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
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
Message-ID: <YvrO+velKdYdGVve@sirena.org.uk>
References: <cover.1660292316.git.mazziesaccount@gmail.com>
 <166057828406.697572.228317501909350108.b4-ty@kernel.org>
 <YvpsRbguMXn74GhR@pendragon.ideasonboard.com>
 <Yvp1Qkuh7xfeb/B2@sirena.org.uk>
 <YvqV9Mq6I3gXQaf2@pendragon.ideasonboard.com>
 <20220815205857.308B1C433D6@smtp.kernel.org>
 <Yvq33T+XCduoqv7Z@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4yZYFMFbpCwRNWoh"
Content-Disposition: inline
In-Reply-To: <Yvq33T+XCduoqv7Z@pendragon.ideasonboard.com>
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


--4yZYFMFbpCwRNWoh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 16, 2022 at 12:17:17AM +0300, Laurent Pinchart wrote:
> On Mon, Aug 15, 2022 at 01:58:55PM -0700, Stephen Boyd wrote:

> > The basic idea is that drivers should be focused on what they're
> > driving, not navigating the (sometimes) complex integration that's
> > taking place around them. When a device driver probe function is called
> > the device should already be powered on.

> No. ACPI does that in many cases, and that's a real bad idea. There are
> devices that you do *not* want to power up on probe. I'm thinking, for
> example, about camera sensors that have a privacy LED that will light up
> when the sensor is powered up. You don't want it to flash on boot. There
> are also other use cases related to fault tolerance where you want
> drivers to initialize properly and only access the device later.

I don't think it's an either/or thing in terms of approach here - we
need a range of options to choose from.  ACPI is totally fine and solves
real problems for the systems it targets, the problems we see with it
are mainly that it has a very strong system abstraction and doesn't cope
well when things go outside that coupled with the fact that Windows long
ago decided that board files were totally fine for papering over any
problems so people haven't worked on standardisation where they should.
Some SoCs like to do similar things with their power controller cores.

Conversely for example with many (but not all) SoC IPs the mechanics of
the system integration and range of options available are such that
dealing with them is kind of out of scope of the driver, but they're
often very repetitive over any given SoC so there is a benefit in
pushing things into power domains rather than having the driver for the
IP manage everything.  We need to be able to be flexible so we can find
the best idioms to represent the different systems in front of us rather
than trying to force all systems into a single idiom.

> These devres helpers go in the exact opposite direction of what we
> should be doing, by telling driver authors it's totally fine to not
> implement power management. Why don't we just drop error handling and go
> back to the big kernel lock in that case ? That was much easier to
> program too.

Sometimes it's totally fine to not worry, at least at a first pass.
Perhaps you're more concerned with real time, perhaps your system
doesn't provide control for the relevant resources.  Sometimes the
savings are so negligable that it's questionable if doing the power
manageement is an overall power saving.

> You will very quickly see drivers doing this (either directly or
> indirectly):

> probe()
> {
> 	devm_clk_get_enabled();
> 	devm_regulator_get_enable();
> }

> Without a devres-based get+enable API drivers can get the resources they
> need in any order, possibly moving some of those resource acquisition
> operations to different functions, and then have a clear block of code
> that enables the resources in the right order. These devres helpers give
> a false sense of security to driver authors and they will end up
> introducing problems, the same way that devm_kzalloc() makes it
> outrageously easy to crash the kernel by disconnecting a device that is
> in use.

TBH I think the problem you have here is with devm not with this
particular function.  That's a different conversation, and a totally
valid one especially when you start looking at things like implementing
userspace APIs which need to cope with hardware going away while still
visible to userspace.  It's *probably* more of a subsystem conversation
than a driver one though, or at least I think subsystems should try to
arrange to make it so.

--4yZYFMFbpCwRNWoh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL6zvkACgkQJNaLcl1U
h9BEBgf/WTDdAdcRZ8SC6FxARw3vM71UeFKkIqUwBU+PYuhgUK2NBJXqpbKPrtVC
yhBxnG6LjbPlUdTmuHr7/VqE4w4fNgcbxFZcYvfbmC/oBSNtHkHDEQSOC8CTi5Ud
BhNvQSBIa3+a6oHsz1yPIG8kL5noW4VKMVNiRuvR+6X8cSrXhZpk8GJLLWM0zBzX
99KnGDVttgaVcftUhxYXdmdeGIIU2t9DH5HaUG3txWB3IuuRlyJxBPY1mCNfjXl2
xZXp0tLQFshCLqDSYsTQbS8X+xDNxeBSG8hbWEDfvFHxX/YYBUAb3nZ4+npTcaVl
gZBIzTYNJg5nvwsv+0jghdLDxGTLnQ==
=WE6e
-----END PGP SIGNATURE-----

--4yZYFMFbpCwRNWoh--
