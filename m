Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8DA598297
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 13:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244076AbiHRLym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 07:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244197AbiHRLyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 07:54:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702CB7F12D;
        Thu, 18 Aug 2022 04:54:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22C1EB8203A;
        Thu, 18 Aug 2022 11:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB17C433C1;
        Thu, 18 Aug 2022 11:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660823673;
        bh=OOp4XCPaOSFAdQWQdL7x7S/vwQa/o7fKz+ynmdHyLg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DV2MuYBkRWWKa0Rs0voJoSLDxQUKzzOSYe//JgzHbHdSieYD7vWcHpu2Q8LoPSaI3
         FnZqOspjyW2rNi6V6qpw1SQK2+fwaxpAGvK2k4+LSD9O3ZLiUXeoCq1F54Jjv3OeOF
         NYuTsRPKmmWPX6JVM3bvHxW6aOcu6+OoZgK9EhnW/YuvhBAMoICkRcaP0kJBFre+Dm
         JMxHe1yocZDaGtIZwU2vsmxf55iLt12gUUG2tjGMk5a7ko/bARUZAV7vcn5ZTVqOja
         21TqUfUXsYqq0IH+tl6Opvtn5sB38Fu5rm0QFGx7bKdL0fLyrkFSOyysCuQRPZCgdU
         IeQpBLkC3FoHA==
Date:   Thu, 18 Aug 2022 12:54:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        dri-devel@lists.freedesktop.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-amlogic@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonathan Cameron <jic23@kernel.org>,
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
        Stephen Boyd <sboyd@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
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
Message-ID: <Yv4obo9MUw+Lc+nr@sirena.org.uk>
References: <cover.1660292316.git.mazziesaccount@gmail.com>
 <166057828406.697572.228317501909350108.b4-ty@kernel.org>
 <52d307d7-04f2-89fd-ff4b-9a6c0d247350@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MKmYY9GsmMLl3nVC"
Content-Disposition: inline
In-Reply-To: <52d307d7-04f2-89fd-ff4b-9a6c0d247350@gmail.com>
X-Cookie: Logic is the chastity belt of the mind!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MKmYY9GsmMLl3nVC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 18, 2022 at 02:33:53PM +0300, Matti Vaittinen wrote:
> On 8/15/22 18:44, Mark Brown wrote:

> > [2/7] regulator: Add devm helpers for get and enable
> >        (no commit info)

> I was planning to send out the v3 (where IIO patches are no longer squashed
> into one). I didn't spot the above mentioned patch 2/7 from
> regulator/for-next. I'd just like to get confirmation the 2/7 was not merged
> even though it's mentioned in this mail before re-spinning the series with
> it.

It's not there yet (that's the "no commit info"), but it is queued for
today.

--MKmYY9GsmMLl3nVC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL+KG4ACgkQJNaLcl1U
h9ChKgf+MqQYNLGgZ/WEAylHrK/Uzrw+LnjUXAyMBb/vZjdl3DVYOv+/LtcGpk2B
vMl+H2cT2aA3eF56DroX4dIyRauM8a7w9PNeqKCTRYzdeJ91Vp1q0gOUIbKHxfmu
LJkxtl3b2n7/O7J+OrJ1HljR3z2JxBD4lmqH4+vKKMNwPIh0fn5GAbg8/O2M0yv5
NEJYI6TxlO4FG1bncptZI3H7tlGjV+MAYgemtJlJnLkpiS3OaOfTS6QeDAtgI0QE
oU6UoQtU2ZSP0W/dlLys3zAGz2wI7/vlprZAeabP2UyUWDIRlRN8GjTI/YkwClpr
VsgNrCyAZbv1afHLckm3stj8/Czk8Q==
=mvEp
-----END PGP SIGNATURE-----

--MKmYY9GsmMLl3nVC--
