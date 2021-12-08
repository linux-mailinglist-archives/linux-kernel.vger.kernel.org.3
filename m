Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB0446CD2F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 06:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbhLHFfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 00:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbhLHFfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 00:35:04 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5341AC061574;
        Tue,  7 Dec 2021 21:31:33 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J85PZ50l2z4xhB;
        Wed,  8 Dec 2021 16:31:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638941491;
        bh=PJ/YZgVeyIPhCQ3XWUVX0z8KoEnbGSuDKzZg81Kr76M=;
        h=Date:From:To:Cc:Subject:From;
        b=rUc7eSozW1Hf3xKBfzqvWDrIeR40nj2OTABZMU8YukOIdekLZ5fOjCAMg3qBvYi4b
         HLyTv+2a8sbthuF/WBUjtf7wqQLsmP3VI+mMMAU6J9V995zfsik4tHnBrnZmy8CDyp
         JdytkYapTlkwMiknnS4ROomEHi83en+YImCgf/HsnmutFdMymwZ5H1eLGoMWXQopT0
         FpbmR/bBK4G4pZUnsjmheIsoGc7w3mQfAmBCFhbrP5gWVunkEU3STCb3/hw7+UZvxd
         LUbJeL6JwIXVwP2AI+kEB5132wsK9ybVJLaaA4WawEoym9hmEglNnBL0oS4B21UQ8f
         2LOZAEncTpTrg==
Date:   Wed, 8 Dec 2021 16:31:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: linux-next: manual merge of the bitmap tree with the powerpc tree
Message-ID: <20211208163130.4ec2ac9f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BXtPfqECSnuDAGE7fsCimNj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BXtPfqECSnuDAGE7fsCimNj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bitmap tree got a conflict in:

  arch/powerpc/include/asm/cputhreads.h

between commit:

  b350111bf7b3 ("powerpc: remove cpu_online_cores_map function")

from the powerpc tree and commit:

  4e258d05437b ("cpumask: replace cpumask_next_* with cpumask_first_* where=
 appropriate")

from the bitmap tree.

I fixed it up (the former removed the code updated by the latter, so I
just used that) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/BXtPfqECSnuDAGE7fsCimNj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGwQzIACgkQAVBC80lX
0Gzavwf/Q3TdzyGglcsa4N2TUYqNnP/NTlBB0muZTlToVh8xb1VziBMsKHUbiwaU
SRwfakgvRiqkbpFwY8RAXHHeqM0gybJlv6ahGfWfCaalibcAFHzFQ40Kp8Nh+d9f
Q6wZIzCIte1O4MBTrPl/sIKKe3N5UK9w9swN/XlWthssvzuKKXKvE2kNodbn2kuq
hXNpPuaN/fQ75c8uzOWqBpRRzQRF6z/REIoAy6FyP+xuSBIkLlW/bY4PWuCLYpSN
OyJL99Tv1Px33vUAcwwQ+Ah+/BrQemcoJwuwTC1DgpeO4sqriXhgKRGVSPfJyCHw
O0Guq71daRFJhOL91xHGDv7qBBXPHQ==
=+G71
-----END PGP SIGNATURE-----

--Sig_/BXtPfqECSnuDAGE7fsCimNj--
