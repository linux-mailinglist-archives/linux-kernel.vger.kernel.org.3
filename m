Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980A5595AE2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiHPLyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbiHPLyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:54:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08E0A4063;
        Tue, 16 Aug 2022 04:31:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66ABFB816A7;
        Tue, 16 Aug 2022 11:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9B8C433C1;
        Tue, 16 Aug 2022 11:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660649502;
        bh=DNGxZGCzNE/W9SNa3AOcpRXwEUSzLHawjI4GPUOozEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ibyaO5o/Nr/cFFgJEL7PPVekFs+0Q3USPuDu3QwvW87IXj9cmqYanCsbSmFkhICCI
         /bS/xCmD23/cb+FBxGnzpVz3kjeVAkO2lYjT75WQKNF5axNhVAwouihZTg6FbLvEAY
         J4D9uKaJlitqM9D4ZYgx+VikKjvj7peGJBkuhBXKCVwCi46fJVtOhi63JN8hMrZFCH
         UkfZ0SYPO3LlM1dZqhAEgMC/gX42n3x6mQYJi/OWry/0M9xvDVAnxC5iuOOswm5mZI
         QOIIYWVpSbd9EF5OhCbydJMADpl7C+bCAHQspCqNHYt9riKK17LZaBtj0TiuX1S5h2
         kfxfjwbz6D43A==
Date:   Tue, 16 Aug 2022 12:31:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Kevin Hilman <khilman@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
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
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Robert Foss <robert.foss@linaro.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        David Airlie <airlied@linux.ie>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: (subset) [PATCH v2 0/7] Devm helpers for regulator get and enable
Message-ID: <YvuAE0Y3QbAf9Zh/@sirena.org.uk>
References: <166057828406.697572.228317501909350108.b4-ty@kernel.org>
 <YvpsRbguMXn74GhR@pendragon.ideasonboard.com>
 <Yvp1Qkuh7xfeb/B2@sirena.org.uk>
 <YvqV9Mq6I3gXQaf2@pendragon.ideasonboard.com>
 <20220815205857.308B1C433D6@smtp.kernel.org>
 <Yvq33T+XCduoqv7Z@pendragon.ideasonboard.com>
 <YvrO+velKdYdGVve@sirena.org.uk>
 <57c312b3-ca5b-6efb-6356-43b6513a0c88@gmail.com>
 <YvtzJw3jmocM0JFi@sirena.org.uk>
 <bb590e14-f99b-5bfb-414b-a45ca77045c2@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GRi4H55EvexP+ViS"
Content-Disposition: inline
In-Reply-To: <bb590e14-f99b-5bfb-414b-a45ca77045c2@fi.rohmeurope.com>
X-Cookie: A bachelor is an unaltared male.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GRi4H55EvexP+ViS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 16, 2022 at 11:06:21AM +0000, Vaittinen, Matti wrote:

> I wonder if writing such 'release callbacks' is compulsory? I mean, if I=
=20
> was writing a driver to some new (to me) subsystem and was required to=20
> write an explicit release-callback for a resource - then it'd surely=20
> rang a bell about potentially double freeing stuff with devm. Especially=
=20
> if the doc stated the callback can be called after the driver has been=20
> detached.

Generally yes, thoguh people can and do leave them blank and it's easy
enough to do some cleanup in there that assumes that the device is still
present and not think the device might've gone away especially if the
hardware isn't practically hotpluggable.

--GRi4H55EvexP+ViS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL7gBIACgkQJNaLcl1U
h9AzDwf9HyzkouCr6DLxGa2jy+krXW2whkKczGUewYVjLonIovCKJI3OKOOMeqaZ
rggHFUZDlyHpe4f23sQn190TBdngSGLYf1nrOt1WMUf3vCkLA05c7RcsGPCZdlGm
TaL1HglUSxZ6Mce97JyRZ3k3Uw28ImBl0LWx3nunXvOqv6UUjs0cc0NdiGSD3JEA
q7cLUiSYA4BzPVJg8bAXNNgXRdqY08D9aqih79uT+vgmcurosxM9InLGjKWb4xRw
UlVPhgqtHOGKTfgLfNuPG7s+nSv91LUEf43AMjI0HE92IutdyHoYhleNfB5V7kAU
vbqH3vEZToSso212DUSGKfURUbqHBg==
=2bTO
-----END PGP SIGNATURE-----

--GRi4H55EvexP+ViS--
