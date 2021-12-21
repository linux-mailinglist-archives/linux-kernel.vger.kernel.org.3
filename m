Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B2847C58D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240759AbhLURzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:55:39 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60392 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240727AbhLURzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:55:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63C56B8181C;
        Tue, 21 Dec 2021 17:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F40C36AE9;
        Tue, 21 Dec 2021 17:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640109336;
        bh=11+OOrOy+QxOSlW36IgdACCcHI4Q+D72iaqrukirtrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BtSmvSd2/jW204QLdtidI0J4ozoAfeq9RpamCDzJ0+2s1P5+ELfIoer1uA1n04Ixe
         dI4vhLywtR+pTSrmfCjwChuHL+kkGbh6z/6pOXgY3k0kR2H70TO5tevQfvvCKZ+ipP
         GhdQ9QBE10Ab65RGHoeCEYpURrm/tLhpjMZY2h27YM2ukN9i6vpDMaHtwFz7DowWPm
         e4ChEce7P+BclogSzUWTh387z9gvBfZruDAnO2dPnB0SfOMB2ssPAoJV17ln+dBWSY
         E00er5o3+kyJ/VhKzv1w5fXU9d/6GpE3/GuPyQzhPgkSrFOjQnZq0ymx2qVZ74SZnt
         Ae4vSlbMC03IQ==
Date:   Tue, 21 Dec 2021 17:55:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, perex@perex.cz,
        tiwai@suse.com, stephan@gerhold.net, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 2/2] ASoC: Add AK4375 support
Message-ID: <YcIVEgTOuzKRoGdh@sirena.org.uk>
References: <20211220193725.2650356-1-vincent.knecht@mailoo.org>
 <20211220193725.2650356-2-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fBIqR1sn4Hlue0Mg"
Content-Disposition: inline
In-Reply-To: <20211220193725.2650356-2-vincent.knecht@mailoo.org>
X-Cookie: knowledge, n.:
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fBIqR1sn4Hlue0Mg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 20, 2021 at 08:37:25PM +0100, Vincent Knecht wrote:

> +	SOC_ENUM("DACL Signal Invert", ak4375_invl_enum),
> +	SOC_ENUM("DACR Signal Invert", ak4375_invr_enum),

These should really be a "DAC Signal Invert Switch" control rather than
an enum - really it's an on/off control for inversion.  Other than that
the driver looks good so I'm going to go ahead and apply, please send an
incremental patch fixing this issue.

--fBIqR1sn4Hlue0Mg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHCFRIACgkQJNaLcl1U
h9BR1Af+NrdhRclUC9F2gH4p4RpkuDfU0uVKoWvRectyEkS+IxVIVZn5K883FaBY
jeRP3uBYm8C9GD68NOeq/So3Nh+oi7W1RycbtvMPMHtIvmDk4NFCWfSxhdH+hNLI
JiQW1bupwiS5TQBNSoD9Xx2B3i4Yw2FSHUSDDYT3IyxTs83Ya5UVWSV0R5OhWYoi
yQY6uDqjsS/4m7YHpuBHNpxrB+TSUJZsGq1OCHdEXhktGhMvYbHNA9ZWkBmg3PIi
yg16BkTfJEjiHEcjgBPz7OBdH0yO9cm28GURU2jhRoe1jai6MMNYqjVijEbVVVuR
mqaKDfkp4KmKgZwhc2y+2ec8qHJkZQ==
=HTjc
-----END PGP SIGNATURE-----

--fBIqR1sn4Hlue0Mg--
