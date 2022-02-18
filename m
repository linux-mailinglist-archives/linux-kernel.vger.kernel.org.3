Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F404BBA34
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 14:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbiBRNkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 08:40:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbiBRNkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 08:40:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559D829693B;
        Fri, 18 Feb 2022 05:39:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 565B7B82655;
        Fri, 18 Feb 2022 13:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E581EC340E9;
        Fri, 18 Feb 2022 13:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645191594;
        bh=JrR432I7cA1vR/uBn4vGgwP2TjT6ks8f4bdU08JhWsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lJ//ZNaes6o8CA0ILewcC+ibPD5n7tUX5InzgWMSuZ3SbZGVxAVMKjedw/pcTW5bU
         At8UGuukZc1lfQO4O5+YHukdH7qmJxqgn3ud1vQ+uVrba/Ny5lNUEo2owqNpEXm+hl
         yZpDCmqOStL7apsebexaa4wCioP4eT0B1pcgMUTntHa6G/Y9tksKoB/h6JvbnTtlZC
         lIpgqDUobpCLWkw4mXZ5jdQXDvjZP0iY8FnrVA/sznKM0po8/SxTJZfPHD5hMySh14
         OxliCud0DYB8sCEuehSsbR0TMZrmBeKxky/McphWU0gcXLVRUcpmZNw/h2nQWI41Ro
         rkpf37GDJIqwg==
Date:   Fri, 18 Feb 2022 13:39:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Feb 17
Message-ID: <Yg+hpgB4EOp9DNOA@sirena.org.uk>
References: <20220217205133.6c4d9ebb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lYG+e5TOqvXe4x73"
Content-Disposition: inline
In-Reply-To: <20220217205133.6c4d9ebb@canb.auug.org.au>
X-Cookie: Check here if tax deductible.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lYG+e5TOqvXe4x73
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 17, 2022 at 08:51:33PM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> News: there will be no linux-next releases from Friday Feb 18 until
> Friday Feb 25 inclusive.

I'll try to provide cover from Monday as usual, I'm on holiday myself
today so not likely to be anything today.

--lYG+e5TOqvXe4x73
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIPoaYACgkQJNaLcl1U
h9BuIAf6AlJq1zuvLI9jibjVCNcc1OuK/Xf7CIbTau89FDMLspb0YY6zWoda+nRU
yPOt+lL6eysq9HobVZCi4CGW6++wkMd2zLG7ly0OBcRm39AZadE+ZIopbDFhc/Pd
EKfI/14aHwKQRW1oDd4CfSWNmxD/Fm8tgixpVEJ43u/1PHqjAo8jkadH/P4Q/Lbi
5bO+7zSJIO3v2QOkVX4ZLW5HD6wWle2QoMEEQFW5z5JlNESN6XRgyTIQGLlU4Dwm
OyiMALVpxludWo1GmEfjaTdxhjN0/4wu04XH+slM5Ln6rs7BnfRM00lGyZyNa5H4
wcBSjiJ6t7vjKqQsJrR9bzDAvCLUGQ==
=prjD
-----END PGP SIGNATURE-----

--lYG+e5TOqvXe4x73--
