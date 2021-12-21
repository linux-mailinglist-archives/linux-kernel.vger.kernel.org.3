Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF2947C3EF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 17:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbhLUQhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 11:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbhLUQhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 11:37:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22128C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 08:37:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E062CB816D8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 16:37:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41791C36AE9;
        Tue, 21 Dec 2021 16:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640104648;
        bh=/2QdsJ4aOSotVXYGkHkh4VCzzsPM9XdShE24gwxfsOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CC9cG3lBfzZoWTVa7wFP2d+F9Tx6CZ6YQ5MPhtoBIi4WcvQtiwNjcXFJ3MpMPvwdX
         bY+Tea8P842ynpBqEZKGwupW4Pj6fY/yt+jP3B4REtzTKxGlFPbpUV8RLXkI7lQ/oI
         9AzPnl87SsFIzqTulVIcjwcXWe9SWnsACTUrqehshDdbFhAfRuS9TX/9+7MjnpGPkf
         DH7yK7N7X/BdaS2eFNFPR1CyrcwhXB3fqYoQX+g9TzXSIyEkb9E8ohvuAFAWHSjPoQ
         NCfmkCPUq9+wEGKj3OpNGFlKvGCpJihiu3GQG5oPw3olD3N5O2TvZWHyaSCAU2jHId
         moAs8Rta0UTbA==
Date:   Tue, 21 Dec 2021 16:37:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Cc:     alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com,
        Alexander.Deucher@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@intel.com>,
        =?iso-8859-1?Q?P=E9ter?= Ujfalusi 
        <peter.ujfalusi@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Bard Liao <bard.liao@intel.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] ASoC: SOF: AMD: simplify return status handling
Message-ID: <YcICwuOpBjuDNipC@sirena.org.uk>
References: <20211221161814.236318-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J7/dWMoLwRCr9/a+"
Content-Disposition: inline
In-Reply-To: <20211221161814.236318-1-AjitKumar.Pandey@amd.com>
X-Cookie: knowledge, n.:
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J7/dWMoLwRCr9/a+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 21, 2021 at 09:48:07PM +0530, Ajit Kumar Pandey wrote:
> Just return 0; on success.
>=20
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@intel.com>
> Reviewed-by: P=E9ter Ujfalusi <peter.ujfalusi@linux.intel.com>
> ---

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

--J7/dWMoLwRCr9/a+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHCArwACgkQJNaLcl1U
h9Bnkgf/R8VlhUYZw6VQS/5uDmJ/934PiphVvshWFpwsNAtInZRH2cmASDgUM495
6Xp4uSX4fn/NlNjQuRbuRWIWrO8/+c9cIMRugogtFNsYHrfj7nVdUdEu1Hi4KwnP
kRWyTIaf+ESCBnvgLbk+6Bvy4/3sc3Vb5z1H9HtZoFkG8RCNDTKk5p0IqdSsf2Ub
sqtQ1XY6eHbNtWnYszt8yr2bSzhyYqebzjKcfFIUxw4GpTtlxaXPBIV1l/104nca
CyurCNiv8u3mFx9hWiNa/4LnpbAMYEPgUK5QaIsIf50b+tOSBaiYTmRdBbsBeB7t
HZQITiJKyI2xYhR/q0i9IApJtS5Dqg==
=GxDx
-----END PGP SIGNATURE-----

--J7/dWMoLwRCr9/a+--
