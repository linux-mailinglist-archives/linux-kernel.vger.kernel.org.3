Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CA84F8DA9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbiDHFUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 01:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiDHFUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 01:20:19 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AD11B29CC;
        Thu,  7 Apr 2022 22:18:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KZRNM564yz4xXK;
        Fri,  8 Apr 2022 15:18:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649395092;
        bh=9whyj+xudA1FANciUo1IJHNe6aqJEFsecJmDUXliMR0=;
        h=Date:From:To:Cc:Subject:From;
        b=bNM14mG5RbZKhXnC5PsU0SVjBd6ySnwl8lvQYOyGdx50aRSXia35WQNe4bhs9t0OM
         jjtn2tvSuaQ+RusTc1WFPN8OPIiL3jMx8yvcZJrfm1PW/5CTemXJDgIUN4sHDIPY2Q
         znXDCM+PuGCKlwc/PErqqxG5MgpndZeTveJnc9YUNMDjS08ygIip15fRsM2LoX0eI4
         zSQ4Kbe3HENs39z17nLu1YSNLdyE4cDPJau+/NEwboEzJSTaHoejxZk5sUQZhfLPFx
         OdF6HyxLesQYOetk+Void5itKy3tUqb3VWuJhHDAl+n2oH9J6uhKL4bNu0EsoeDFnn
         xcQvGEr2Q+uNA==
Date:   Fri, 8 Apr 2022 15:18:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>, Zi Yan <ziy@nvidia.com>
Subject: linux-next: manual merge of the akpm-current tree with the folio
 tree
Message-ID: <20220408151810.2123a3ee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3E4/hkTT7rhLG2XKpcWQ4uC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3E4/hkTT7rhLG2XKpcWQ4uC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  mm/migrate.c

between commits:

  ffe06786b540 ("mm/migrate: Use a folio in alloc_migration_target()")
  c185e494ae0c ("mm/migrate: Use a folio in migrate_misplaced_transhuge_pag=
e()")

from the folio tree and commits:

  c5b406e86042 ("mm: migrate: use thp_order instead of HPAGE_PMD_ORDER for =
new page allocation.")
  649b74d8bc1a ("mm/migration: fix the confusing PageTransHuge check")
  6c9c6f6b597d ("mm/migration: remove unneeded out label")

from the akpm-current tree.

I fixed it up (I used the former changes) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/3E4/hkTT7rhLG2XKpcWQ4uC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJPxZIACgkQAVBC80lX
0GyC2Af/VuiElXdFxuuSIfrMUw2cV9hyCvCRShglnQCXrP3ik4PBiYYFeVaJqV1m
DcvHYEgLspDd9TrJYuycbw3lxHoGQFLIqv/pVafTjW2QYbyWBnrBziAfH6ujGo2w
8T7nqVgUVLtaghDssB5v+vbTcP07xvakKL80AOsvHJqcAhyrQGZwF5qP9YNvCtzU
TlUYFBxrchysfkRBhCxary24zXmEQkwj943DPgVG5NZSlB0eWYlHUhubjyDcW/zB
Iq0TKyeRAI03j2PpKL8L8AlR77uCYFLYmZggTHbat5hsAFY18hZ2k82oCe6PtTUj
Nbn8y71Ere61tB0/DlHWVj/4yFF5Wg==
=x7ro
-----END PGP SIGNATURE-----

--Sig_/3E4/hkTT7rhLG2XKpcWQ4uC--
