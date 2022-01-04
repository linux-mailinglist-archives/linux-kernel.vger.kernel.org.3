Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10C0484408
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbiADPBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:01:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42572 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiADPBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:01:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D21F2B81614
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 15:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2CBC36AED;
        Tue,  4 Jan 2022 15:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641308464;
        bh=wCYKl8HbAjB3pp9BNkTP2Ru1EwIirs5CBVCUZdD7ZS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DEjGuVGCCiV2hhzrTyu5w6cT20zmchrG5CkT5WZfOmfs+whyq7NsKxZnkGx12vpPk
         y49mxvWs1KkJYAIil08529UyWwYBdBSb4Epl8uVpRMY2LuvzZldEISnc+tXauBX5tw
         Iuf9XIWUiEuKrghw104N5aNP4gtu/XqEG4S2oRL76ufW8bh1k2qjvzVZB1OUR0rmpI
         BAUv0yCSyqO5lhwtaFymzxxJvriRP+cC9D6KLjQzLu9I1LB4wkodmAXgsARGINGx1o
         1HpWHF5CLrmq39fVP9xXjhhpYjv67LSTScAUQjBOFDragSj/axLi8oI3OiJMZnlSjR
         /dBHcDLfVaPug==
Date:   Tue, 4 Jan 2022 15:00:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "cgel.zte@gmail.com" <cgel.zte@gmail.com>
Cc:     lgirdwood@gmail.com, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] drivers/regulator: remove redundant ret variable
Message-ID: <YdRhK55op7XzJAuj@sirena.org.uk>
References: <20220104104139.601031-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5Sx7lbAcr290ea0T"
Content-Disposition: inline
In-Reply-To: <20220104104139.601031-1-chi.minghao@zte.com.cn>
X-Cookie: Many pages make a thick book.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5Sx7lbAcr290ea0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 04, 2022 at 10:41:39AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
>=20
> Return value from regmap_update_bits() directly instead
> of taking this in another redundant variable.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--5Sx7lbAcr290ea0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHUYSsACgkQJNaLcl1U
h9Cz9gf+Jguh5RAvwtAq1ZZhx9QN4sxPnzcsOzGnkE+J0ovjiN/tTj4cNGD8Bhme
De7mYFsFY9gAyMD9iqc2ruHwrh7cVTlz5nGeA+WBljF+UxcDDHul6s1MG+yvmSXn
8+Oauy3QRj0mliWQZzTVQM5kBzLWhoClw10YtgBHgNFcIYms1zVrFUAY5NrnPdn2
ECqpZciLMNCBExN5GS5NoX5vj9FwlqgFQT1+udpcFkECmZ6CO4zAxUWWZ1Eo9PJ2
Gim0Ea8dcbjkJmXY0zyG8kbkWW2ZULebdWHanxJpFL9Z7yFeJgJmfGeYR1cQd5si
zW/HbdD83eqnRx4NP06Ecv/9NZTXMg==
=7l8d
-----END PGP SIGNATURE-----

--5Sx7lbAcr290ea0T--
