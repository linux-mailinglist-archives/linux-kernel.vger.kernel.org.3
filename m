Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC34C46A5BA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 20:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345170AbhLFThg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 14:37:36 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:51396 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240539AbhLFThf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:37:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8114ECE17BC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 19:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7E6C341C2;
        Mon,  6 Dec 2021 19:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638819243;
        bh=MpNp33FRQt4X5JC52WOHMDRVybEDW8+FSs2zS4j+/qM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TOKi7z1VGDcAd98bcg5mvwK4V8bEtX5bFYS0R1zi2o7YQ58CWN8QgkKAeUaNmiJrS
         VXNn3dVeePVrXUnynjSy3KOVXVLeKzGCVX/vzGunofyc+6UqsKyiPou1WYtbUuBE5B
         LSgcr17CRLpDsB9IqxF7AcEnFIpm4WYCDJmH0/9UMQIE/67vw4WOWXV7WTEuEYEuu5
         H1Ez83GiOGu/ZyYIWatfaG/keyy4TNXu/GEUbF4D/ql5AGCcJE0dXqPE6r6LdLnVLz
         HRWKMxR4N/4qWtaSvkwu0JOmyX0jDHfCe3BARi6LTQIszlg+VHqYLKLBzRtKNtimeS
         4L0zJEqD6wpDw==
Date:   Mon, 6 Dec 2021 19:33:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com, thomas.petazzoni@bootlin.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] ASoC: soc-core: add the driver component name to the
 component struc
Message-ID: <Ya5lplIoyhKsqFmZ@sirena.org.uk>
References: <20211206095920.40552-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FM2QS3cTpx8xgnOf"
Content-Disposition: inline
In-Reply-To: <20211206095920.40552-1-kory.maincent@bootlin.com>
X-Cookie: You will soon forget this.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FM2QS3cTpx8xgnOf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 06, 2021 at 10:59:20AM +0100, Kory Maincent wrote:

> If a non i2c driver register two components the function will return the
> same "device_name" for both components. This could cause unexpected issue,
> in my case it is a debugfs error which tries to create two directory with
> the same component name.

Why is one device registering multiple components in the first place?

--FM2QS3cTpx8xgnOf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGuZaYACgkQJNaLcl1U
h9AR0ggAgWCzMNYbiu5GrIrZ6Ce6pNfcrP5Sq9aSOJ6aPayUDqd6mmqIznyjzChJ
sLCG0AwUUZ/+Ek2Jks4Mt5Js1Wk1bkhncPBcqPzc5OMt5t5YzC1o/zzCsLUetJky
3Bf3EShBgFxg4mI9Z+sygUJeXLTL16lZaxl2chcqRgaHDJyV21zyaFJ9F6I0grin
vmfdjOX+yIACSN1oNyXN847EmGojT0gSUEb3jJGmQqJ0MJ6vkHHsQ0xgNyCKg9Cr
Q1AobyIHm7GIqbdHVm/c29gOLUsSOgdS5/+Y3i2ljsa9wao7U/V5sn33u9eMm2s1
W/InZtDSBrvIovF9PDLRgv4CJLHsTg==
=pKKX
-----END PGP SIGNATURE-----

--FM2QS3cTpx8xgnOf--
