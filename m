Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A024551255B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 00:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbiD0Wjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 18:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238234AbiD0Wj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:39:26 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575ABA7;
        Wed, 27 Apr 2022 15:36:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KpYW926KGz4xNl;
        Thu, 28 Apr 2022 08:36:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651098966;
        bh=CVc1pHXe+LoYxpb4zAZj3he9Z6Nbc6APPLnq8Jgno6o=;
        h=Date:From:To:Cc:Subject:From;
        b=AnBbwbA0PagS7YZTrZBE75UovDEebnSt+SVxlAb9qwWDmfmvSxYylLXXfnR9+7oUX
         kTQVKngLkJX0br0fZDPLDmUC983haO0JwwHunFRqvRcy8ru//nC/qQnILa9O8t0ZD0
         Lcs8IdUiyFknc+DG3sINbBodNdHsTAJwLw0Dyd60c9c8YgbcqNwKwjsCwHu+Q+gStG
         rFckYiXE5WAfBzC8pn8386coTVsBiM3K/ZFOH/5USE4kQnfKylUXN7Ei40GjxVYN5R
         27CIoIFCps5eYZYWdMnk3rXyi3fvyz1DgKJG0AaEzS0cI/IPPiKHrYv4sofFUlC9Ty
         Raon1ALEBW3xA==
Date:   Thu, 28 Apr 2022 08:36:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Xu Yu <xuyu@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mm-hotfixes tree
Message-ID: <20220428083604.0872e25a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tEeY0os.jP=m3xOo1jZg+2u";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tEeY0os.jP=m3xOo1jZg+2u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  9d4dacd9cc3f ("Revert "mm/memory-failure.c: skip huge_zero_page in memory=
_failure()"")

Fixes tag

  Fixes: d173d5417fb ("mm/memory-failure.c: skip huge_zero_page in memory_f=
ailure()")

has these problem(s):

  - SHA1 should be at least 12 digits long

In commit

  7b5cc291112f ("mm/huge_memory: do not overkill when splitting huge_zero_p=
age")

Fixes tag

  Fixes: d173d5417fb ("mm/memory-failure.c: skip huge_zero_page in memory_f=
ailure()")

has these problem(s):

  - SHA1 should be at least 12 digits long

These are probably not worth rebasing for but this can be fixed for the
future by setting core.abbrev to 12 (or more) or (for git v2.11 or later)
just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/tEeY0os.jP=m3xOo1jZg+2u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJpxVQACgkQAVBC80lX
0Gy6IAgAplqiDG6SrYozWsfSrqR383BGVsmzctGlEQtOElxcIzx1ibqymLYTnB5+
fHoRwVzbyvN56y0SwV2C2jO7Oo326d4l6jvo88XanDlMX6nmOqREbzAor8h+UOqK
O33t2aNeg8562E3dIls12ciNSYCF4BIaD/jT5GbqcVqmGEk4BD/bCp+z6cH0dbvA
ZLze02RVVzxCuoyiLPs54/3kXoBm+ARiyZRZiijBp08xlycZdNnHpk+HL4rRSVBM
m3Oq485eC2ZroTwWxJWDgXeNImzI9jnTYoxzyeDZgF27T6Yp/Q8ZVJH1ONL2Z7D0
gEYrHwHl16k32icQN9A/8owc2ZAIuQ==
=o7L/
-----END PGP SIGNATURE-----

--Sig_/tEeY0os.jP=m3xOo1jZg+2u--
