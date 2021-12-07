Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6159846BBC6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhLGMy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhLGMy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:54:56 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B8BC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 04:51:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B675BCE1A7B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 12:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A8DC341C3;
        Tue,  7 Dec 2021 12:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638881482;
        bh=Lauct6mJnrC0lFeI5SJXPUsWS66dw1/YWLLELZ3IsJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g9jFpGmAW5gdiBdvK6IkgfOnFrhnEH+DuyvS1FznPii4tFUjdTMdbVrmGtuPh3oiJ
         IBeQDVq9xhS4jkAZY03CyRORD1k+iFiBZW9gVIQOqAe6rMD79n2z06AF4i1chUgMn0
         q94iL/85LWs29FWgee26nz2x91P3BAme0s5oqnTTzDZYHwTfddeV5PY0HJdwc8+iHg
         LUs4nCR9KGJb3kjy+3BViSWTiCgdiMTyP8R0am1U8ntWCyhPfN5cLr5BYUqph+UBoH
         JT3xxs0PSFnxnIHA/8TsaAnF9h/S5vT4fEG6aAxuAwuGMt8Oz9e5nA0O2o/xmzQHAr
         SV1UnzQtkCGWw==
Date:   Tue, 7 Dec 2021 12:51:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ameer Hamza <amhamza.mgc@gmail.com>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: test-component: fix null pointer dereference.
Message-ID: <Ya9YxoUqkATCOASh@sirena.org.uk>
References: <20211205204200.7852-1-amhamza.mgc@gmail.com>
 <TYCPR01MB55813B26BB2B3BB6D1E072F2D46C9@TYCPR01MB5581.jpnprd01.prod.outlook.com>
 <20211206092937.GA5609@hamza-OptiPlex-7040>
 <TYCPR01MB5581998AD64AE249C7D86C26D46D9@TYCPR01MB5581.jpnprd01.prod.outlook.com>
 <20211207081522.GA9690@hamza-OptiPlex-7040>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pA7XGybufHONhAT+"
Content-Disposition: inline
In-Reply-To: <20211207081522.GA9690@hamza-OptiPlex-7040>
X-Cookie: Only God can make random selections.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pA7XGybufHONhAT+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 07, 2021 at 01:15:22PM +0500, Ameer Hamza wrote:
> On Mon, Dec 06, 2021 at 11:19:36PM +0000, Kuninori Morimoto wrote:

> > -	const struct test_adata *adata =3D of_id->data;
> > +	const struct test_adata *adata =3D of_device_get_match_data(&pdev->de=
v);

> Thanks, that's a cleaner way. Can you advise how should proceed with
> this since previous patch is already applied. Should I send a updated
> version of patch, e.g., v2 or a new patch.=20

Please send an incremental patch on top of what is already applied as
covered in the message saying the patch was applied.

--pA7XGybufHONhAT+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGvWMUACgkQJNaLcl1U
h9DGOgf8DeE7v3W0DSMKplQPk7WTS8kqB2KvSaa33nkG8xCydpkF1R/KpD/TjwgY
MVjcWFyeNTqZxZUQAfdwhY2ZakLTYNeGdaUAt6A90oZBNkqE2nHe45CZrdYLoIq8
R+DJDVqg81jPkCDg7y1mxLnc1YS86nSLGjBZKN8L8ujdnBWk1XbcG4VLnaTOmUFL
uZGfwris4SWI3zz7ji6CshgOJh6qnTp7t3j8GeR9rzgI/KJGwTx7n3k2IWrGyF6T
kgbLRjgjWnfLGySjBk+Dphbiy4MN/y8CjxPOAplVOmCVs0iIvnxteoh2dar7ZUpR
9WbB9wt0TUtdRZ/34ThpENSpcl6HEQ==
=y9/g
-----END PGP SIGNATURE-----

--pA7XGybufHONhAT+--
