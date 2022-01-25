Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A094F49BE94
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbiAYWdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:33:42 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:55937 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbiAYWdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:33:12 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jk1pB4qZGz4xdl;
        Wed, 26 Jan 2022 09:33:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643149986;
        bh=4N5QEyxMjjwZITic1lYF0XkgVn9dsIlL0PsrC3TOMHo=;
        h=Date:From:To:Cc:Subject:From;
        b=L02PQ8pCXcMps5P7QIe5ola+But/eUFTITsxdmJ3adm3d+d/f8UJEZBYo9ahf8NoW
         BXfICohdsogLlQpCdjrTjGQn7FuOu6Kwmmlx/sp6CH/CCtY6mbstli8wpmh97zCM3E
         bhpKQ0KLXsZSWhqFOs98s+nixxdCO+3ATPAR1UoMmmMlS8bt7FyOZoj1dtIRGF2C6A
         fTFiDU6kpmx5tUDa01fGYzZsh9N+Q3kD4QJULzaI4sByECRpbkYSt0nbwPsCnL2lSV
         7csDDekaISwpRWsGWutj3zGzo42fMEp6NfLNIJF5UDy5UeS0H7Mvu7U8CS/p4tVTBp
         RMA5XsY/f2nsw==
Date:   Wed, 26 Jan 2022 09:33:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the samsung-krzk
 tree
Message-ID: <20220126093305.5726fcbb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/p5Q/XEB/c8t.Pm0IKDvOYcv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/p5Q/XEB/c8t.Pm0IKDvOYcv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  1f22c720691e ("Revert "arm64: dts: fsd: Add initial device tree support"")
  191448a71471 ("Revert "arm64: dts: fsd: Add initial pinctrl support"")

are missing a Signed-off-by from their author and committer.

Reverts are changes too and so should be signed off and have reasonable
("why did we do this?") changelogs.

--=20
Cheers,
Stephen Rothwell

--Sig_/p5Q/XEB/c8t.Pm0IKDvOYcv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHweqEACgkQAVBC80lX
0Gx10wf/RZM9esQhP2tnVjq+YvXAw+l0pZmPJS31cHltX9HJl5Qmu3qe8mMCkuLf
BgL3cTrrjyBaBGtEN68vffkeOxlVMD28dU0b2tydnSWYH+2FWckiGUIhGJ4oCpA0
ItxlQt8UWJ+sRpSAQazqBxp7vyicSSTeISkpwukzUKw8/MGoyRvLsaxS+9h1pLpM
k6AsZ3IYVGBaWwCQf+Go1sKogjaBHPKzOAEpj9uT8x0I7ipRx/4u3Pt/8a2royHF
Yn9Sbqfr4h5fgPirtlVUKBwf2MfxaDIk9G+Bd+u8e39Z0mlvW8+oJvGbBQ1MUrL5
X4XpScUH+eZCbEipYDAlEEoMhpOlLQ==
=/k5Y
-----END PGP SIGNATURE-----

--Sig_/p5Q/XEB/c8t.Pm0IKDvOYcv--
