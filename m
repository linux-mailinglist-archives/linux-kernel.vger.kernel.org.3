Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F2247E8E3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 22:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350292AbhLWVAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 16:00:31 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:38195 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350277AbhLWVAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 16:00:30 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JKjJX2jnGz4xgr;
        Fri, 24 Dec 2021 08:00:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1640293229;
        bh=0T3Y6ODw4JpA28k5Oz5NHiGKaZ/Hmffs6J5OZF3x0u0=;
        h=Date:From:To:Cc:Subject:From;
        b=gP+Z+X/xaHQ6uWP2eFQSiSif0Bg95N3VkQ8YyxcbpsEpHm7qdXc3QDVxN37PUrkRU
         xo5MUR4ZsRNsVCJW0LDel8g3guG6l7XnBfR6H70gQ3jFvHHFSA5SP34Vr7IaothOEe
         Bmy34oSiloqBaFs06UHCulZ/LGL2sCWx3tf6EJH2NHvAfuQb9p7kRDnoXrlYsar0XB
         pdfem4nathdQQCRBeBxbHmLXOvH/MQ4AKNpXlGp8v4290OdCD0ng4PkwIEejCXuBtM
         pmIOnb+RARSfBjDg97MatntNx6alyF1ZqZUbh5i2Uc7BMc+cnJc7K28rOUv3EEVXJL
         hVj9G3Jrw490Q==
Date:   Fri, 24 Dec 2021 08:00:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the livepatching
 tree
Message-ID: <20211224080027.63028aa9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kBUC_zQ5fqkxvuvC=m3nYqO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kBUC_zQ5fqkxvuvC=m3nYqO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  bf01c2975925 ("livepatch: Fix kobject refcount bug on klp_init_patch_earl=
y failure path")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/kBUC_zQ5fqkxvuvC=m3nYqO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHE42sACgkQAVBC80lX
0GxYvgf/XidCRkldwmz1vVAiARbpOBvyYXsE/rTgxuz2b4moVVEWDRHpYYbH8Byg
3AKO0IMkENAop2cdXAQ74WyxKqcNR7UnYFOxAkdDTGXWiMJ2aAKr1duKVu5/6+t8
IWVx/fCZ/4krVKn79B1VEAabbKygmTELuYozu6FzrPaJ6+z1UYff4lxRGeM8B7B0
Bsx67961QKKQ6Fdw0IPF+Kgbx6Bss41jppJ48jwYz4JxEQsgR2HykF08YOhnwh/p
ZYAYNkoO7RlF75iE46U80PI4qM8dq/gNtAuQmi4haEkRAKp91f3t6HRw/D7st7tR
csvxkT06q2c99TJRCqpm1sUcrea8wQ==
=X1bn
-----END PGP SIGNATURE-----

--Sig_/kBUC_zQ5fqkxvuvC=m3nYqO--
