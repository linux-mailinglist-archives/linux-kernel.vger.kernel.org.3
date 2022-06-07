Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE27754027B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344132AbiFGPcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344133AbiFGPcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:32:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8489CF5049
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 08:32:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 206586173D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 15:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386CBC34114;
        Tue,  7 Jun 2022 15:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654615919;
        bh=QtPDEZX/lUfNyNYpzZuzDGKK7QYK9lQFJFWIUzzL46Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pz1ddRm8iFdRXLn63GZu1ddshUSiTpxMayzVNrE29pXwYA6xHXt2as8MWdrTi65td
         DloXlUv4VDQPa9NRZhm/0SK5f2YnJP1W+wr9cxRyWsIa5qVaP4BTE2rVhh8W7mwMGo
         K67SNesIvMVyGPP2YgRbFCwusuN1CAEfkMfHeBXrwGzZNFKVAQCj3dxchRGuqzIA53
         M+6WblmWyy01eHEaw5wvWqYchWLXlqujYXiYgDSMCqo9l6gbZxUEbI8bQ54tf4XPVZ
         BmA/Tkkjl2WKfd9ZE/y/Y8mOnqMwY2WFUkoDZapmAgwLYz/ujsvplD/K2TLYWuwN/n
         hwE4QSpypk56g==
Date:   Tue, 7 Jun 2022 16:31:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bleung@chromium.org,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [PATCH 1/3] regulator: cros-ec: Use common cros_ec_command()
Message-ID: <Yp9vadmTaNw3YCk4@sirena.org.uk>
References: <20220606201825.763788-1-pmalani@chromium.org>
 <20220606201825.763788-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iS67pudl3y0J6t1x"
Content-Disposition: inline
In-Reply-To: <20220606201825.763788-2-pmalani@chromium.org>
X-Cookie: Where's SANDY DUNCAN?
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iS67pudl3y0J6t1x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 06, 2022 at 08:18:01PM +0000, Prashant Malani wrote:
> Reduce code duplication by using the common cros_ec_command() function
> instead of the locally defined variant.

Acked-by: Mark Brown <broonie@kernel.org>

--iS67pudl3y0J6t1x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKfb2kACgkQJNaLcl1U
h9AQPQf/Uu+gE9kC6MRHTBinks+o8ic/dH/a5B8gt3pikQzakcC39YMx1/e2mXtI
rkOUD/bKMEOvWFDSs9U/91kf1cBFwpsET/yII6b3xIpdAz77TsdAfIIRWRbnuKf9
Y0/JtU9Zh7Li6gwPjiT6fzCDcFJ+v/QlpnWzuLfNVNQ5tCbAxOOIoh2DvqR8KnKy
mmJKuo8uueBLmos4auWEjbSq3VHceFnMzqDoXeja5Ttkl6B0iEHkY6NrboTS3XTb
FVJcyi4iD1sRYCf2wopwpkYzLcgDMghu9HaRAUOM73kORH/SDUa23c6jk9SQBKIf
RgEUErtk/VKy5NfC6yGW8kZWg2J5WA==
=cPRA
-----END PGP SIGNATURE-----

--iS67pudl3y0J6t1x--
