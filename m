Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91BB48E9BB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 13:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbiANMLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 07:11:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56890 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiANMLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 07:11:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 123E6B825EE;
        Fri, 14 Jan 2022 12:11:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C46C36AEA;
        Fri, 14 Jan 2022 12:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642162307;
        bh=xWVNg8jYF+xmMkDX8x7QzixVZI1jpIDE8FBOyg3doJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sUR+ztBTAE69/p/bB2/5zzJr8kmdF93CJ+S0fKeuD8rRyGONFmGjN/5CeMYevXhc9
         XR0LIXw3vb0G+2HLyk2j6+nxs+NOx75Oq/XrUn9U/3WryYJja6wrefOE/6em+5V/HU
         r1SICpAwxWdmVwXcOOAkZ/GcGncS4QaGjXtmDTzHSAEp7Yckxn/tdvHtMFNyx21NU7
         Vyoc9rnzBQSVxmC9oLvjdy3qjPybah3ZWQD9TwQ08qchzP9GT7Gxjd7vmkLIM29+oK
         UyfS0i1iZLY6D9FsM6pSjoz2sKiPuASdLJXf1j4qMZqG02ZhODpOKbc5kjpJaKQG0t
         CJCuuDvyrIALw==
Date:   Fri, 14 Jan 2022 12:11:42 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Beer <daniel.beer@igorinstitute.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Liu <andy-liu@ti.com>,
        Derek Simkowiak <derek.simkowiak@igorinstitute.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: add bindings for TI TAS5805M.
Message-ID: <YeFoftcUwRvyShvB@sirena.org.uk>
References: <61dccc5c.1c69fb81.9af91.0df6@mx.google.com>
 <Yd29tk6ZJgDFDvVI@sirena.org.uk>
 <20220111184700.GA10070@nyquist.nev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hIzfZ7Gg0S+Hgd8w"
Content-Disposition: inline
In-Reply-To: <20220111184700.GA10070@nyquist.nev>
X-Cookie: Two percent of zero is almost nothing.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hIzfZ7Gg0S+Hgd8w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 12, 2022 at 07:47:00AM +1300, Daniel Beer wrote:

> If you think it's still inappropriate to supply the configuration in the
> device-tree, do you have any suggestions?

As I said load it like other coefficient data - the simplest thing
initially would be loading it as firmware.

--hIzfZ7Gg0S+Hgd8w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHhaH0ACgkQJNaLcl1U
h9Aczwf/VbbhZslWnff3lIqK3COnyjw9mmcFxD7wuNGaKP3GiLu3ziqqAjwiyn9U
hWSbhglTJul037W/Fg+irWXaMNAUPsv2lcMecyAbfuphY2M2IUIy6nDmkmio+Rm6
qp4sUe2MhwJiHh2xEI2VMFTxWJHBKi4y1Xhh+S06GXdmrGnE7mCjFMO9kRUOQSwm
sHY8n5RHhr/1ZW/j07BwsHcLMWwBqMCMUsMyRGE7WVGmrIIJ6MT05eV24hTvtOLR
K4g6i+RfMKp6DWG9c/yhEWmt3wILRR7DWkhnVW75bn9IZ7NragWBVLyRQdg+gr8e
CJNwhRSrUrQrm8+EUrYpeVSxjY8SxQ==
=Zh1A
-----END PGP SIGNATURE-----

--hIzfZ7Gg0S+Hgd8w--
