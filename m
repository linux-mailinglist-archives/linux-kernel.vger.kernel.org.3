Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B93A46543D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237989AbhLARwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:52:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:32894 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbhLARwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:52:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC918B82071
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 17:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF970C53FCC;
        Wed,  1 Dec 2021 17:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638380957;
        bh=Brk69ITNANm8GtoKP5Z3rUd/O8O8TMXLqjraNs7vWXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b01bWCud5jDr259w60dEanzC7vuitJxiazlBIf4djq4Qj1kMUl6dCmS/XMhONnSXw
         2s1ywsPWkvXhaXI+bws6DttM4XoYscBGvC3iGLbAKv57kCp70Y/F31hEXwfyUsWt7m
         H15HEZf0MkMo2hur8s12IKc0U+3hpOpx1g4vnr5zPvxVgSANHKRxk6huwF2WDPdRkn
         mKS/RFZHLbs33oe7c8/We4cYd2U+CoFw7eupfyFg8VlYEh4qLI+kc+Vvkp6uKQZYnb
         DoDZK4ILq2kRTpXpWbmHBiI6jbxFXu2FKxjUBmBdJghF1wJeLwK5QFzbwuNsx6JjUl
         SsL+o1Z3qBLuQ==
Date:   Wed, 1 Dec 2021 17:49:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     Len Brown <lenb@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] ASoC: amd: Fix dependency for SPI master
Message-ID: <Yae1mPxvy82OfORz@sirena.org.uk>
References: <20211201174307.1399625-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Rl5rCMjYGRvwkRHy"
Content-Disposition: inline
In-Reply-To: <20211201174307.1399625-1-tanureal@opensource.cirrus.com>
X-Cookie: All true wisdom is found on T-shirts.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Rl5rCMjYGRvwkRHy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 01, 2021 at 05:43:06PM +0000, Lucas Tanure wrote:
> Select SPI_MASTER as is using CS35L41 SPI driver

> -	depends on SND_SOC_AMD_ACP5x && I2C
> +	depends on SND_SOC_AMD_ACP5x && I2C && SPI_MASTER

This is a depends not a select (which is good, a select wouldn't be
appropriate here).

--Rl5rCMjYGRvwkRHy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGntZcACgkQJNaLcl1U
h9BPaAf/eSG+AALgRUVHBsCL7mBTlkMMB+SpF0gPhWHYYZb/3RY7ehJmKagYeR1N
79PiIcGmuIRJrgQESqdBva18ZRUKNYCU0pV/QgeUBqYLgoEOUMFLu7C/PN0QTLRO
DxldjkK9419RHw+4MIrUA+JuHCCi9MrsmPl+KhCWShSwNJRVU2HczFxy3nUS2jJB
WApP7Cx5zQDNjQGvKRIRgOO+rrm40h0QRgAjiM2X4RSpwPQyilDFWJPO6snxls3A
rwi/GrKuj/GYz7pQvYaebqwczJYnhdH/v1iNioqHVhLDvzJL/VQ4rdaiFGthAVDa
GOHrisWoarI53pzxugUG7AzBcVWOBQ==
=fKwA
-----END PGP SIGNATURE-----

--Rl5rCMjYGRvwkRHy--
