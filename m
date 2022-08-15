Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA04A593351
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiHOQdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiHOQdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:33:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753BA14D2A;
        Mon, 15 Aug 2022 09:33:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39891B80EF0;
        Mon, 15 Aug 2022 16:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E692C433D6;
        Mon, 15 Aug 2022 16:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660581199;
        bh=kBOMgsseA60cqKb8ZaWTeKRcdiuM8BBVMgx3WGOT2Vw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rmTxXiWdCfaKxjfeSH/wn3LpbaEYrRaZCw1f92jgSGWCcG2dAITp6jUamOj/9Et5l
         NLxQdQJ6bRwiBMzF3WOgxKy/ruO+5WFA5KyvFSSpRu6Jp4vPceQTBAGYsxJnkRaDiF
         VQs4HiAFoB6wMNroGRnPP1YIk98jhwB97kSZHSmw+l5iAPSEtqIYeHeV+2kguNbDCh
         OMOaadd3jKZLNLo5Ra4binpuaeeuHjzws48ygCy26/f3fh0/Z6Z2lPNoKbe/MHMGoD
         GRXNAh75/ymq45hZtYg5HjEKzu7bs/86N8gD/EMtnzrZtzuqtoEpW8lvyZOhjfQys0
         rKBQntmgxyAVw==
Date:   Mon, 15 Aug 2022 17:33:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
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
Message-ID: <Yvp1Qkuh7xfeb/B2@sirena.org.uk>
References: <cover.1660292316.git.mazziesaccount@gmail.com>
 <166057828406.697572.228317501909350108.b4-ty@kernel.org>
 <YvpsRbguMXn74GhR@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EyxHVb4W1IFNOeWj"
Content-Disposition: inline
In-Reply-To: <YvpsRbguMXn74GhR@pendragon.ideasonboard.com>
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


--EyxHVb4W1IFNOeWj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 15, 2022 at 06:54:45PM +0300, Laurent Pinchart wrote:

> - With devres, you don't have full control over the order in which
>   resources will be released, which means that you can't control the
>   power off sequence, in particular if it needs to be sequenced with
>   GPIOs and clocks. That's not a concern for all drivers, but this API
>   will creep in in places where it shouldn't be used, driver authours
>   should really pay attention to power management and not live with the
>   false impression that everything will be handled automatically for
>   them. In the worst cases, an incorrect power off sequence could lead
>   to hardware damage.

I basically agree with these concerns which is why I was only happy with
this API when Matti suggested doing it in a way that meant that the
callers are unable to access the regulator at runtime, this means that
if anyone wants to do any kind of management of the power state outside
of probe and remove they are forced to convert to the full fat APIs.
The general ordering concern with devm is that the free happens too late
but for the most part this isn't such a concern with regulators, they
might have delayed power off anyway due to sharing - it's no worse than
memory allocation AFAICT.  Given all the other APIs using devm it's
probably going to end up fixing some bugs.

For sequencing I'm not convinced it's much worse than the bulk API is
anyway, and practically speaking I expect most devices that have
problems here will also need more control over power anyway - it's
certainly the common case that hardware has pretty basic requirements
and is fairly tolerant.

> - Powering regulators on at probe time and leaving them on is a very bad
>   practice from a power management point of view, and should really be
>   discouraged. Adding convenience helpers to make this easy is the wrong
>   message, we should instead push driver authors to implement proper
>   runtime PM.

The stick simply isn't working here as far as I can see.

--EyxHVb4W1IFNOeWj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL6dUIACgkQJNaLcl1U
h9BS1Qf/aJ5FfSf2ZpgAnj2K1EYyJTQAf5hxweM6P8/UPf0PG25qZnrQ04w2KT+U
J0dyFRSYl6wQbpFV7qxu5fLJC4OGjrDvyUmF+FgpX4qXSZYWhspqlsH73vA5olJB
JssncwLyZQcX9kCua0RpN2NZ0+L7PAywvZ87c+2Ss00YkuS4GSE3CmeK3AhmHYfP
4sjjQuZeLgAF3KmoG8ImBJh+a9aRORWWmvVboZ4reeEkMfnIC37kD92wTH6+ubec
Rink1Toz39UYEOFWWLMmC9VkRDTunn4JGF6ei4tDrxADrV2aCJ+05N5wV7N0Eg/D
37fKiGeyHN4cc64BVj5NW6aFp6UfgQ==
=aGMq
-----END PGP SIGNATURE-----

--EyxHVb4W1IFNOeWj--
