Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE61467C9F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 18:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382337AbhLCRh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 12:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343518AbhLCRh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 12:37:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCCDC061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 09:34:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 989A1B828D6
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 17:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E2AC53FAD;
        Fri,  3 Dec 2021 17:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638552870;
        bh=WHTBc4bgkCtBeEhRXEgFiz4s5kKd4i8rh+TOXdUqZJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GVrlZDTQZV7r3Hi+G/5SPgmOHvHCCsgPx3SiNvOWU1VkhlHEnR9KCf8MzUvbROnvQ
         pGMDwShFgRbunhVW76WvIYMb4g7cMJ+XveF7oR7X78f5IyscuWVvQ/MvyVIVtDKRUn
         3Kesbb0/K6VxIfmcpZzVmL+7wIcePSbGA5jBFOTPvi0BtYoHFQs0wW+0w3NzKrhjyU
         0Tc75DoN8dJM54SsIDmomSdwSoTjU3sGyQMMRVDnM2+2f4F+1SQK7J1E5X/D4nT5Pz
         WhbxH60D0VJc3DMFt7LVUyqRhZSfAVyYY2UYryqyVmGDSKX3HFGvR6zaAfiDYE147a
         4CivT/QABHpAA==
Date:   Fri, 3 Dec 2021 17:34:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com,
        festevam@gmail.com, nicoleotsuka@gmail.com, perex@perex.cz,
        kuninori.morimoto.gx@renesas.com, michael@amarulasolutions.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, tiwai@suse.com,
        bkylerussell@gmail.com
Subject: Re: [RFC patch 0/5] Support BCLK input clock in tlv320aic31xx
Message-ID: <YapVH3b9urxvngWG@sirena.org.uk>
References: <20211119153248.419802-1-ariel.dalessandro@collabora.com>
 <163762561675.2471742.16439171676950432106.b4-ty@kernel.org>
 <6a2ff1f0-ebd9-be6d-9b2c-5704edd7c25d@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0HmQJ345lS0f+Xyw"
Content-Disposition: inline
In-Reply-To: <6a2ff1f0-ebd9-be6d-9b2c-5704edd7c25d@collabora.com>
X-Cookie: Don't get mad, get interest.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0HmQJ345lS0f+Xyw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 03, 2021 at 02:25:17PM -0300, Ariel D'Alessandro wrote:
> On 11/22/21 9:00 PM, Mark Brown wrote:

> > If any updates are required or you are submitting further changes they
> > should be sent as incremental updates against current git, existing
> > patches will not be replaced.

> I gotta send a fix for one of the patches. So, should it be a new
> incremental patch or I can still send a patchset v2?

See above.

--0HmQJ345lS0f+Xyw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGqVR8ACgkQJNaLcl1U
h9BVOgf/XdVufglD/qP9remM5BJT0aYWhxGy2k/SnulImK+rVelJFADnkoCZr+tr
acRDTwVyTzcLaXjqzLy18Q5EyBKOan9TBayKNN3kiv60LMacGJZ3Vh+1A31tMns/
qxnKMQ2yOHQp+43Fy5l446Q8gNVfSbBSnr6uhuPXrLqPadPfvm8h7o0o/aqr1q+x
lBu9YRqlZLwtuCOv80lgGtoCjstbLlAcPZqgnzX3VKu76H83cfHjLk+n2s4PO3Uw
q76pYz7sxKaWLJlLw+2DLN2Yf1S3JD7rTHxXhohtrGQFnoAd0wOcD36ezRRERVux
b7lFaTv8PgmD40D1j+UIWK1CRm6kQA==
=nhC3
-----END PGP SIGNATURE-----

--0HmQJ345lS0f+Xyw--
