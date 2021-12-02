Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38699466B3D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 21:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349003AbhLBVAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 16:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345809AbhLBVA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 16:00:27 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC61EC06174A;
        Thu,  2 Dec 2021 12:57:04 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J4pDD272jz4xQs;
        Fri,  3 Dec 2021 07:57:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638478620;
        bh=0PAr8wWe6Bdnv5vkhGJRjhD1FludTl0fDq+P9WhuSVs=;
        h=Date:From:To:Cc:Subject:From;
        b=HX6HDiKhJr7y5MisOxgJ3HzA+kwbh1xfn4de2DQrt4szf0jvctTcEemvmco+hMDhY
         Rpt7W0+SHJ0D3DMhOKsOi+08qtN/AV/KOxYMG7MiLwmhH4MmyluxrkBrL8XIU4YCuF
         90dnpRdSeeJMbNdx3bc1WOKSrADdO47eH9uZiclCQOOTNMIwkxE/qHbf4Kpp16/+En
         BUpR3YTAs4csAFlzd3OQfd7Zt6vAIlof1ggjYGIK/V6uvT+50R++VTiAEvv4saROtK
         c3HMfr9PeKPDF9sadXN2ZRCJYqW1QMl4Ztx0LukIsTvtnI1mvKhAD/5tSkUxIfGpGt
         7iH/My/Mhb0Rg==
Date:   Fri, 3 Dec 2021 07:56:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the kbuild tree
Message-ID: <20211203075659.2c7fbc5e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cQT6TSE2PEfHymjiWIb.P_l";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cQT6TSE2PEfHymjiWIb.P_l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  0431acd87a6c ("streamline_config.pl: show the full Kconfig name")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/cQT6TSE2PEfHymjiWIb.P_l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGpMxsACgkQAVBC80lX
0Gws5AgAnKn2cKKUKz7vLxiIN+7axXPNvQg4qv2rm9lLzsdw3z2PZrIFcSaWtkLA
wlekD27KAI47W9Dol++Qgi1krDgLCqc3ukM1UDmhrVcwSApMyiOnQyftjCMwCbxt
P6hsNbAJiwN7eQoU+e7s6wDtCVyzqPKG6kTodE7+nEC/skXyPrDH3LVubDB1yDqS
JfSDD+6T9CQfZ1MW9rurUkCiY88Hr+Q6XR5QL3ANuD1gUwVqoRu9AVSR00qMTbXD
evwSIW1/831ZPthOem3MOrs2sfvoltDNhHZlyHEA6u9Xy1bWPJerfjdkFbC56q04
v1kxF1AYsrgypix4rKO1/vdm0GSxEg==
=37v7
-----END PGP SIGNATURE-----

--Sig_/cQT6TSE2PEfHymjiWIb.P_l--
