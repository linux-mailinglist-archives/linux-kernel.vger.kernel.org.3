Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D49465857
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 22:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbhLAV3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 16:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbhLAV3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 16:29:22 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1732C061574;
        Wed,  1 Dec 2021 13:26:00 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J4Bw31rmTz4xR5;
        Thu,  2 Dec 2021 08:25:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638393955;
        bh=l1KmvRSkwAIO19TXrVPs4rOSlEyA8mk0Q/IO3ryBP88=;
        h=Date:From:To:Cc:Subject:From;
        b=EbmsKuD+qpJ+oK61yAfp6yPVxtMAVqToacfsz4YbQUhs7VEcAIvsjqFBZUgneuCF1
         asInEhTiraz0VPpBG330uVCDtTr1zuYawKfBN/m0bFluS33iZVezw0u9q/WvP3y/i/
         eCbj3C4b9+reCxLxsJAICI0sLBI39kj3Bx1MP4THSPhL4gNTEYu3mbUXwfLcNlHwzn
         n2+tD5zPMHz/4OmwMVVEUI8wSSSviS2mhbYgCxFBcYzxI0skDMPMDtuw/Yo7RNKB2G
         k6GPlSFOYvx8cbSflvQcVSrrOqDBH3B+vlY8TIqBNJuNgm1u2yfwYnE8sonH3taUIk
         4hYrJ5kTvI2ZA==
Date:   Thu, 2 Dec 2021 08:25:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the sound-asoc tree
Message-ID: <20211202082554.2c370ddd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5GiFcOVlywo7dSLCA/lsK3h";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5GiFcOVlywo7dSLCA/lsK3h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  043c0a6278ca ("firmware: cs_dsp: Move lockdep asserts to avoid potential =
null pointer")

Fixes tag

  Fixes: fb2f364fb5b9 ("firmware: cs_dsp: Add lockdep asserts to interface =
functions")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 5065cfabec21 ("firmware: cs_dsp: Add lockdep asserts to interface fu=
nctions")

--=20
Cheers,
Stephen Rothwell

--Sig_/5GiFcOVlywo7dSLCA/lsK3h
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGn6GIACgkQAVBC80lX
0Gzj9gf+J2Uqn5h3hVqOHQ3maNgx9N4jfIQAh8v/nCe3OhERyABLiQhrsljWsMD1
TkHYJP+yVtpy0KI/tLyC7vOQLKE67zeEWAxt3EiqVwuyizdWKtg2jf3Lsb9btDiU
k/3Mf0FOS2sv3l4WvtCm3UItpGLcGsBoQ/E9sqhAm7ucJWAczWUFK2Z5hh1KfyXw
fSv+LRYVDvTjseTAcrcf8G8YOyXU5B6qIeTHPBTZNx1sZctn+wAGAWKt9PKJAVAD
UDcjG42uqj9SDMqRIgy5mLUeRlOYDq5ozUaYulcyV9t53fhACqQstESTMU1dqDDJ
kXa9Cp/K7lFB9telkDp51wOJjFIDfg==
=QiCp
-----END PGP SIGNATURE-----

--Sig_/5GiFcOVlywo7dSLCA/lsK3h--
