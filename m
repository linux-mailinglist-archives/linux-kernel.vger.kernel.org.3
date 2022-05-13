Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7E5525C08
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377541AbiEMG4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377531AbiEMG4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:56:10 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2343BFAD;
        Thu, 12 May 2022 23:56:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KzzvB22Jzz4xXS;
        Fri, 13 May 2022 16:56:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652424966;
        bh=Zzs8W9olAm7/BVysWerN2adjTxULXwiT/Ujq0I2vKHY=;
        h=Date:From:To:Cc:Subject:From;
        b=pb/ee9F6qL3nAgAzHCAbXXzWHXQf5DKrVXJjLDtIWWhCJcwGSPhSrQBkuMYwfFz+C
         aM6pVot0ugvcfN5zLCYglBeXHRCcTT1Y/5klrUEA4rdjzdm0Hf+VT54YXEibeTd9uK
         S/75OphLvLZi9DENZsDcQuj2lnsKOMWV0TQKjjbP6Q2z20hcFhMQp7jHo6UvX85g0Y
         nYG2C/ed3BbhHOXVBBs2T2e9oRq+8ivtg0/TyKgJPKicvPrperHSNFeASMuJoY+GUe
         kODwaFe9o8mhzd2pDlj2FnXsr9d2aH1VmLvINveW3mkpehoHzir0zTwr8+1x5XGOMv
         1d1y3S+rVXWuQ==
Date:   Fri, 13 May 2022 16:56:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mm tree
Message-ID: <20220513165605.306223da@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3goykHgHmWyQpmzb=We/rfU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3goykHgHmWyQpmzb=We/rfU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  58fd0cc2b3ba ("mm, compaction: fast_find_migrateblock() should return pfn=
 in the target zone")

Fixes tag

  Fixes: 70b4459 ("mm, compaction: use free lists to quickly locate a migra=
tion source")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/3goykHgHmWyQpmzb=We/rfU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ+AQUACgkQAVBC80lX
0GwdYwgAlhhR31xf/01juU4uVmlmPcx7erQklc19Si0Gke75AOY6r+Y9pZiAIiEy
8YccE7HPwZBwP4T3UTXb7qOJdTxgQ6hBHxOORUze+na7jR64rV0k/9INZO5MugFt
GwdaQnqAu5iGvQW5WxAC4YiT3Prq7k5qerJwB360LlAD5BOxlUVW5vwyvBgpxyvj
T7NOJFMwfd6OkPUBJGAgf8uqU4KpJN7nSaO8ro6FMj4sQ7FNL9GYV7y7xnqwFChj
No1F0OGntTqhjBFXFIYuatXESYB5mTaBCUekpP+nB09Z8UTEv/mr+qZZf0I36qvr
l6xWBSxMdQiNKDqnQenkZLr/JV12GA==
=1FPP
-----END PGP SIGNATURE-----

--Sig_/3goykHgHmWyQpmzb=We/rfU--
