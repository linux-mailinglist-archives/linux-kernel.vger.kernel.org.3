Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB84494615
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 04:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358323AbiATDXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 22:23:25 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:48595 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbiATDXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 22:23:24 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JfSWs6x8yz4xmx;
        Thu, 20 Jan 2022 14:23:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642649002;
        bh=x+ViRMIJACXLSqkJmJJjjNHld8f+oujYjCTwU+wJ7PQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FGlmeEjYCPz63o1gWPxK/jk+wBKLQ+rZW1+eLAhT4UY4p6HvwavwcfXz7h7MCt01a
         I83hWe4jVah8mC68ISaiEEZcy4+n02oWqF/ris/XqhI8aTEIwUqthDwO4I2sDq2jzc
         UfbA1QSUUzIrV0c2n72N1pPX5IeCyE5QomEhJg5IGEExvL7qIkw/cMvw0uFGNFidKH
         3cHuiwsTc6QV9NqOv6K0SP68YXK9hMPnAQ+b3jPlNktuG0f8Hry6x3mo5oBEFKGRZP
         KrRtrf4vMvcfaI+5aDqlqZ2Rx0UT+9VgmKTwm+Xc6BNlaYU53uPHNRwCD1A78ToBwZ
         MTdqXzYCEWH3w==
Date:   Thu, 20 Jan 2022 14:23:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Colin Ian King <colin.king@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the gpio-sim tree
Message-ID: <20220120142321.548cc57b@canb.auug.org.au>
In-Reply-To: <20211027213437.2414fb46@canb.auug.org.au>
References: <20211027213437.2414fb46@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ui9SAgWuY2OyFjf7OKWGIKR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ui9SAgWuY2OyFjf7OKWGIKR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 27 Oct 2021 21:34:37 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> After merging the gpio-sim tree, today's linux-next build (htmldocs)
> produced this warning:
>=20
> Documentation/admin-guide/gpio/gpio-sim.rst: WARNING: document isn't incl=
uded in any toctree
>=20
> Introduced by commit
>=20
>   b48f6b466e44 ("gpio: sim: new testing module")

I am still getting this warning.

--=20
Cheers,
Stephen Rothwell

--Sig_/ui9SAgWuY2OyFjf7OKWGIKR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHo1akACgkQAVBC80lX
0GxGXAf/Vk0W0JLK0JDhU5o4HwHLLlWvBJQuGJKaHCuw9h7JWGJTqB9cbLiUr5Nc
V2PN6us1xhZj8uHjRlMzfDX/bUIDgwEi0q9Gt7tkTnmzGDV4MvAiqSP5kfXLCC5h
4FhoudH2+0r9XRsJGEweT4m0H/yz4t98nk9I579SPEx3Dj+kc0FX2HtcanYU4eM+
Il64BhQasvL7SVr9uKTA0wdmRJb8vlCV/T+LLtikps7uqFfPaDo/wQVCkwNbGprD
cq76dPKOLmFYQXzwUiGkwlSY5W9s+eBm5UQC7ahILfxisCD4A0cQHyF8xpuLDSfe
q7k1exvrg1PHCD4fCOru4gz1w6x+gg==
=1AzD
-----END PGP SIGNATURE-----

--Sig_/ui9SAgWuY2OyFjf7OKWGIKR--
