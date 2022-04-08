Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5594F8EC8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbiDHFKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 01:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbiDHFKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 01:10:11 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0D6ECC52;
        Thu,  7 Apr 2022 22:08:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KZR8d4J1xz4xXS;
        Fri,  8 Apr 2022 15:08:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649394482;
        bh=KdL5sLjE/ADdptpatVzJVoHaOJls6PEdu/KJhpd+hWw=;
        h=Date:From:To:Cc:Subject:From;
        b=YENdiEu1N4xLR+o0DLcxJTKtn7B8HUlSH6K5r2AIKZDAa2ObestvGSKaucXS8alJ5
         LLlgftT7HnT2uE+Z73+w4kekkAXaXnxSsq62B2B6ahzQb+NwlGWUB5cqBKcUlX3Gxc
         UgL6JBmuT9W4T8YWt+SfFnDKwyESfBJ/VAe+IauUtnZEyICk0qVu4mDllTseGCg28u
         S9aHRa7xtNspnte15gYrHJUhWQDKeGdyPKbebRdNHd2YL++ZZUgomZd6doyOXViPjn
         qpzxI3w1EqW08uuL2wqklK1oUkyol42BFWmkMICHi1IzWHzCIHnOmlZnFWO0SQaK8d
         NmDxZA3MXuwuw==
Date:   Fri, 8 Apr 2022 15:08:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Zi Yan <ziy@nvidia.com>
Subject: linux-next: manual merge of the akpm-current tree with the folio
 tree
Message-ID: <20220408150800.06ebf216@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/O7VEjXQOk.u4KMX4mmuKo/Y";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/O7VEjXQOk.u4KMX4mmuKo/Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  mm/mempolicy.c

between commit:

  ec4858e07ed6 ("mm/mempolicy: Use vma_alloc_folio() in new_page()")

from the folio tree and commit:

  c5b406e86042 ("mm: migrate: use thp_order instead of HPAGE_PMD_ORDER for =
new page allocation.")

from the akpm-current tree.

I fixed it up (I just ued the former change) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/O7VEjXQOk.u4KMX4mmuKo/Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJPwzAACgkQAVBC80lX
0GwGgAf/U9HODQCSCrqmt3lenqsR8ALmqzNcDAYJxXk0DcNXS0Bom+gC6pPH6ktV
tgZgC14+0ZgmDlQY4C5b6GLjsbAiKmHTjY2X8BgGwzxzdzmf28R98XvxrGsUNfbM
dahWMCQ+BwBFY+QjX0hEkVFfX6omPJkwU9jE53Jvrjr0HXwWmUzvo8rFt/RTiXzU
mbNAHMjxbmmO/DKQnaHaLwXyxJORdj9y85d2zbxRF1RYn4BhLK14zuvVX4k7d/t2
29TMQSy9qJp+IvZdDH0jN/G8qtZPYy5+Mkhr7Kic36AOsIVg3nEeNMw7x3dQMrWm
ORbAmu7OTbRwPlsSYw76FXe6AFjOew==
=Qhe3
-----END PGP SIGNATURE-----

--Sig_/O7VEjXQOk.u4KMX4mmuKo/Y--
