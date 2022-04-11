Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAB04FB26D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 05:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244567AbiDKDiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 23:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244654AbiDKDiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 23:38:01 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C90D2AEC;
        Sun, 10 Apr 2022 20:35:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KcDyl4Xrvz4xNl;
        Mon, 11 Apr 2022 13:35:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649648143;
        bh=FITXLJ2XB3AefAccJrSzrvZrDIBGXAT3i4LUXuXtc2U=;
        h=Date:From:To:Cc:Subject:From;
        b=Wcnn5jLP+iJfSEDKqI2FBz/hzrxBAZfAzKzuvTWwjCruilaw26XT7BbxwxSCDZCkl
         rF31DDPd/cQmw6gmbOOLZf5n8kkGbat/G2MZEHzZGmqjoTMZqcNGZjGJAeaVZOrKRG
         914v8GSh7O8r5daK3hEusfZ9jLvh8OnYhU1x336QiXSmWPa1HJwI15c3ulrhM/QrLK
         0qUknbYm4DNRXmVelPMiiGeJhcKO9auBdurLW/Inb45Oat+KrLKGNS99T6mHx65GtA
         c/oP3cCp7OHZ6De0phZ6CfkCh4T5+Ip2+2sT/nbO+ZlDFOsVMCnPgejnYosdoIClE0
         DwKsd8iWIpycQ==
Date:   Mon, 11 Apr 2022 13:35:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: linux-next: manual merge of the akpm-current tree with Linus' tree
Message-ID: <20220411133542.29debc54@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7hB/jbvO41o8D+qU4HGQHSm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7hB/jbvO41o8D+qU4HGQHSm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  mm/migrate.c

between commits:

  ffe06786b540 ("mm/migrate: Use a folio in alloc_migration_target()")
  c185e494ae0c ("mm/migrate: Use a folio in migrate_misplaced_transhuge_pag=
e()")

from Linus' tree and commits:

  4ea144548e29 ("mm/migration: remove unneeded out label")
  fc5f5507f33b ("mm/migration: fix the confusing PageTransHuge check")

from the akpm-current tree.

I fixed it up (I used the former version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/7hB/jbvO41o8D+qU4HGQHSm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJTog4ACgkQAVBC80lX
0Gzhbgf/XKWwYDPZwS4FsGGhvPMMsgIHFc8+nx56MVg2deRfWvnClKKJZYII+oif
BedumazkSdOL4t1Zo72hWjtwXdKaYKRqX8GvzChBpcRsmfIWsfkYOexEq3lkVAhI
/vNe352BuJcH1n0V0zb7qHrCgqbTVg8Q8DZxnO2EPV91FHJYLlbYagdBhnPNJ760
S5XwNgthHAB9If+g8ivhwBspR7kkrE57qNV2qWrXSmfGMqf4WsLJNoV3tL9W4wro
1l524hBzjEcpKrBkZRtXok8kEYT3hVyabc2AiK4w30MAR4LFUcDnGnF+7RY/EASv
NCF2Vp2HVFF5UQb0poKsOlyimEzYUQ==
=o9TM
-----END PGP SIGNATURE-----

--Sig_/7hB/jbvO41o8D+qU4HGQHSm--
