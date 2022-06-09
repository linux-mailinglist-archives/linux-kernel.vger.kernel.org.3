Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31175440A7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 02:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbiFIApH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 20:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiFIApD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 20:45:03 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F0D276CDA;
        Wed,  8 Jun 2022 17:45:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LJQNT26V2z4xZ0;
        Thu,  9 Jun 2022 10:44:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1654735497;
        bh=mLG8ejCGWmb/Au9RUWAqxX1RLyC6YWV0QuvItfBebWM=;
        h=Date:From:To:Cc:Subject:From;
        b=oLpxSQ8o58De1aCxMIeg96bwoRbj1ZPjwWbijMI3cwohr/Ecer6ysIod7WwevwtMA
         EFR0rRUiq7sR6ijYllSGFKVm0V+ZOeA98311IYVFdFmdsYX5yGIrmxvw8yoW8lZ1U0
         OvZdDU+sSq8i2nciEjtKHt8FMGzmKz4X6sF/GoV03PlIIcWS/tWHm1KSVY0nrm/LyF
         DcsEaCgte1NqoBDsU1JYX4GXcMfrLzBRdX1Y2X87sl1WNYG9uBnjYOldreKmLxn+0A
         lknrfufS8HRCNtLHI5B6KdfL380VPVpFZ6/qjtrHwEt9nwR9nni1GZ6RBsQxAXXED1
         ycL8Ppa8xfALw==
Date:   Thu, 9 Jun 2022 10:44:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Junxiao Bi <junxiao.bi@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the mm tree
Message-ID: <20220609104456.009c53c6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XTZ6Ex2v68UIuOz_Ny5O9+2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XTZ6Ex2v68UIuOz_Ny5O9+2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  a4bf92bd6e08 ("ocfs2: kill EBUSY from dlmfs_evict_inode")

is missing a Signed-off-by from its author.

This is just a patch that went through a mailing list that rewrote its
=46rom address ... I wonder if we can make git use the Reply-To address
for the author in these cases?

--=20
Cheers,
Stephen Rothwell

--Sig_/XTZ6Ex2v68UIuOz_Ny5O9+2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKhQogACgkQAVBC80lX
0GyEKwf7BhnXGOUMeiAqIjjiOY10geYJN5gA+eYMXlt15/sth1mo22PzL8Xg1KU6
DNAZhuVhcDnaC2d8cFKAyBTHkSN5sM9owF47/qxb0H3J2AN+vNk7GI8NA467bHZi
ycnlRjeNP9MeQtdrzaHuegBrQ6Y7oHvJmXnjOTOaIchSy9TELcxmq0HYtannR1+J
9FDNXHa6B0NXUc3yO8wAjfedzKLZRJ+xMMcnoYbv6dQjJJDPtpHwIi9FZ32UZ90k
GJ2Tlm/eERItwFs6WwobyBrOjXZGegxhfqx50nrtxD81fEGb7G8CQ5bv2B/npyg2
HiqhPzbjpwDu0RqOGgs+bkj5MaxODw==
=KpFt
-----END PGP SIGNATURE-----

--Sig_/XTZ6Ex2v68UIuOz_Ny5O9+2--
