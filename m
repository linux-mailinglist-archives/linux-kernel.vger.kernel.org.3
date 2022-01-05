Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53724485077
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbiAEJ5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:57:07 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:36127 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbiAEJ5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:57:05 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JTPz33N5vz4xd4;
        Wed,  5 Jan 2022 20:57:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641376623;
        bh=VTmX2R4HSdwFz82qEnB2fsXtHFPWqJiaom/H53uprwo=;
        h=Date:From:To:Cc:Subject:From;
        b=Sm71md3JTbA7KNKorEWwNxCHD4nooZV+OuhS5B7qT0irTiXnhsaBhczMzrFQaqUeU
         Pcf1E7inimjHjRrWnGRriZAWDI5fhy83E77z6M3vXxVWusQOk7VzYjBeqM8V0Jw3OY
         d35AzX2EvN7bl2BXJHU4D7bVb5CxyomAJ1pTU/TkaiXnDi9l3Fx4qRwXzvgx4WaIhu
         yZjetOHZVkJGeHZWEnRRP5cholwBc1E+FIWGXZQSqLOidaeNnjk0/z0uFoGVyR969c
         lZupnfnDwevAI9AFmuPzQD/j9+0aBhaRb7iUdGxlDD+mrUjwDTzuM8Xo8RpEz7230A
         b530WH8gQCNxg==
Date:   Wed, 5 Jan 2022 20:57:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the libata tree
Message-ID: <20220105205702.557f492a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cyIgUkYJcOUF91vIkkN31PH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cyIgUkYJcOUF91vIkkN31PH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  b3a1ea642b5f ("ata: sata_dwc_460ex: drop DEBUG_NCQ")
  8fb32f1d555c ("ata: libata: tracepoints for bus-master DMA")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/cyIgUkYJcOUF91vIkkN31PH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHVa24ACgkQAVBC80lX
0GwU/gf/R7sBWyqf45tNw4mRhUmmJ7jWxe6VHd/JYU+RSzSUEZJLuCH2Cy5sNm9W
+rbIbtPXE/DBj9hHy2J8f8ZfETRHJhVWYH+/uuch1RmOrUurx16U3fITgwOCV0NQ
aTw2m/TGoGoIBJuWVcq2iSky+sWQNnqJjFFd5Cx5lxc6/YMO/1zmmItm4hnnf5kq
aLPHkTkPndGJ1bWqDQ7ljbP3aHv8C00KH1Z5ZnZu0tbkoc2x3O9qyMY6Lu2AzHfS
s9U8GB6QJIIp7cM5SVwe6q8Z1D+D3lMsQ/qeXgILUKr4ogbSig+izomXl2KGw8S/
ZkXlgCWTOd3KKo1CHsjJW8nr69b8jg==
=00vV
-----END PGP SIGNATURE-----

--Sig_/cyIgUkYJcOUF91vIkkN31PH--
