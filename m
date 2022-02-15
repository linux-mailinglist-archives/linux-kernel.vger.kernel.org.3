Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842084B79AC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240567AbiBOVaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:30:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244411AbiBOVaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:30:10 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4012E6874;
        Tue, 15 Feb 2022 13:29:56 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JyvPX4hlHz4xcY;
        Wed, 16 Feb 2022 08:29:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644960592;
        bh=pwmoRh+xNWdVdREPS54AAjyj75LCvfppmcESRwDk39E=;
        h=Date:From:To:Cc:Subject:From;
        b=IxLwGx2wKcydh1WVwuHZ9pEybwScibPOFe0X/0755CWfkxB93U5TbRjFjj9+SwtOo
         YSW8f4t1k5JgvrFmz0VGsnD5/qshdmhPNTw8PVmChZ2Bz6RhCu2D/jCJsqIpzlnVPS
         LfxhtFt7y6dPASJscxjmC1YsP7Mw4vQlTbkxYV14GvqUQ35cj5PnPKBf9CMWzurG/A
         K7Htn1RLNcMdHrWljyO1FN5ZaEiI5djC1DZWLiDh3v88UV5PYv3GAZ74V7bOJWhTJm
         wYhzyMQXIVA13VWgdI/0/sqnFEO5ItqXfrc8tIKUJ6AsgH7pa8B5XmxSFwZVBfKFR2
         8/cIU3ygxvhqA==
Date:   Wed, 16 Feb 2022 08:29:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the folio tree
Message-ID: <20220216082951.4bffb750@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Avm4GGYns9gcbhJ5.=vHY+g";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Avm4GGYns9gcbhJ5.=vHY+g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  9864078ecbb0 ("mm/thp: shrink_page_list() avoid splitting VM_LOCKED THP")
  6a04fcd09a18 ("mm/thp: collapse_file() do try_to_unmap(TTU_BATCH_FLUSH)")
  52322c19db3b ("mm/munlock: page migration needs mlock pagevec drained")
  fc43a522c2b6 ("mm/munlock: mlock_page() munlock_page() batch by pagevec")
  b60d40429fe9 ("mm/munlock: delete smp_mb() from __pagevec_lru_add_fn()")
  d1dfa0133d1d ("mm/migrate: __unmap_and_move() push good newpage to LRU")
  27649a0ad4f2 ("mm/munlock: mlock_pte_range() when mlocking or munlocking")
  a098b3660d99 ("mm/munlock: maintain page->mlock_count while unevictable")
  4aefb923cead ("mm/munlock: replace clear_page_mlock() by final clearance")
  8a2bfd6e9bc1 ("mm/munlock: rmap call mlock_vma_page() munlock_vma_page()")
  0942176186ca ("mm/munlock: delete munlock_vma_pages_all(), allow oomreap")
  190136f4d2e7 ("mm/munlock: delete FOLL_MLOCK and FOLL_POPULATE")
  9833b8ff6c78 ("mm/munlock: delete page_mlock() and all its works")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/Avm4GGYns9gcbhJ5.=vHY+g
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIMG08ACgkQAVBC80lX
0Gw2RAf+IAAq5trzuU7i3KTv17vvzslo4FWE4+QEbhig0En2mXI4VcBAwf6dqqp7
1ZyOEJZHU9mXRuguxyDqMPnZzYjJSKOpPritrzxksQLNBQ/P8z+u2DHsYTJjyjgs
ycPSmRsNY2CpogPxQcRWWuDvCyVFLhwwKwIG5lvVNbSio3xPjbxNZR+WIdCFJDKl
mRz6G5YgsMy5ggIAGIYzCcY/TQp8AApda+2P42tsUkzAie0ATS/qckLPRc/l4y2m
GpD+kSZpNbYnerJjokSrATmUm26irZivfAmJBuOCRzwkUTlKoQr9DO4X5T0wulgC
kyecBmXIVepxA2BNmeSFE6ZyMlEnXQ==
=sg1L
-----END PGP SIGNATURE-----

--Sig_/Avm4GGYns9gcbhJ5.=vHY+g--
