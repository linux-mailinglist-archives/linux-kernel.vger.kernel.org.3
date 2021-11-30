Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E0F463B87
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240240AbhK3QVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:21:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48722 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243932AbhK3QVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:21:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24F7BB81A56
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 16:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40918C53FC7;
        Tue, 30 Nov 2021 16:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638289057;
        bh=MZnl0m0UlSGNeDrL9sapE0g2YD1NMkMtPnbDj8SAK+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gg3STzay0QZRm3E9SW2UXSNlJlPrWOia6C2DHwbH1gviANhFaHenZJqyzTQYr1+Vz
         AejGr4duQzTULR+N9JM1fw3I3ymCYe0u6flainBkcRjTfvx7y22R+se3M9eODLib9l
         rwlp+udvw6zUlE9MnUY2JRgCxQhEtXPkJv3CS/nY9/OU2g8YoRlI5+nGsZjr5AU072
         5B7xQbXWt51P5fvjmRt/dZ8QE83Y2cOyMO5d27dlgsrZ1jGFDciQsV32pboynjoQuD
         eoxJuNN9GFXLU6/A3Sbv0v65I6T6Lm6H24uJxMLd9JUkEC/vHpKjCK3r77fMjQ0nwD
         LbE0nOayjqZFQ==
Date:   Tue, 30 Nov 2021 16:17:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: qdsp6: q6routing: Fix return value from
 msm_routing_put_audio_mixer
Message-ID: <YaZOnJIrl2bO98mL@sirena.org.uk>
References: <20211130160414.21616-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="reGMIgm/lItL/shk"
Content-Disposition: inline
In-Reply-To: <20211130160414.21616-1-srinivas.kandagatla@linaro.org>
X-Cookie: Check your local listings.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--reGMIgm/lItL/shk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 30, 2021 at 04:04:14PM +0000, Srinivas Kandagatla wrote:
> msm_routing_put_audio_mixer() can return incorrect value in various scenarios.
> Fix this, so that change notifications are sent correctly.

This really isn't a good commit message - I can't tell what the change
is supposed to fix or how it fixes it.  Which values in which scenarios
are incorrect in what way?

--reGMIgm/lItL/shk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGmTpwACgkQJNaLcl1U
h9DZWQgAhJmvaqN0eGrzB9U7ieeGabIcljlgUyilqA/VqDFY67InjYGqepeftVTD
Ku5SexhDIBYUC4VyY3aLpdmezxPMV5K7FOpnQoqrHMmyB9HT0EOWariE5DML5Dyj
C5vnHJklRawGk8pTUQWVRi0PW9thM4Bh1XyFqaP4JTutrpQbjv4cP5s+KNwlVKnO
o7zc+f3aD8QhgidTIHSgN3DRaD7/w8VcxhpoKINuHyTcPz8bjA+qeTiGCmqSbuqe
3uVpANXD1JboUIKXfgErBeQJWKCRBOHxYI3FZaeTdO1XlwLK+VpTfXM7TZv6g7uP
ZjntZxXtF6ytmDCYvP1rytMj5KLzfA==
=2i4Y
-----END PGP SIGNATURE-----

--reGMIgm/lItL/shk--
