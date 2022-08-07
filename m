Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C398358BDAC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 00:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242325AbiHGWOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 18:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243368AbiHGWNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 18:13:33 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4C912AD5;
        Sun,  7 Aug 2022 15:05:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M1Czy4Xjxz4xGS;
        Mon,  8 Aug 2022 08:04:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1659909886;
        bh=JXky3o1+FjUra+eLP3JqUfPG/Fy+qTINfM0OKoNf1Ug=;
        h=Date:From:To:Cc:Subject:From;
        b=srOrBgszybYA/Qn9NsHKMl08BISpMwii4uU2uDOPvHamEkeyARSIf4VYizCZhaFvW
         QMKX7ZdXspNQjGriacR7VWRrsnxJqouzIuOV22IIlxdkO1TZsAxshUtjdTI7BRDvdM
         cvKMeYYJsgMY6cRL4twVoOjaI+ojQvKsjR5vq2HLHcqfcKHP78Q1BlPMfidrFkH4xR
         CPRj7FkcnXf/lr6UwVzmN1RhHCXKyj/+fPe2kj+p+OIAID8XJKxLf3sxMBODf2xDbk
         3ElhsA+2hFQnUxQgaNGxrsHyxh2TfNaxYMv6dErVmcnnxWhYZfPkg8w1U2xd8mr38Y
         KO8mhuflSBxwQ==
Date:   Mon, 8 Aug 2022 07:19:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mm-hotfixes tree
Message-ID: <20220808071941.4e18e748@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KCuy/W_yhQf8pfFX3A8OAez";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KCuy/W_yhQf8pfFX3A8OAez
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  b2f4c6e29531 ("mm/smaps: don't access young/dirty bit if pte unpresent")

Fixes tag

  Fixes: b1d4d9e0cbd0 ("proc/smaps: carefully handle migration entries", 20=
12-05-31)

has these problem(s):

  - Subject has leading but no trailing quotes
  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

Please do not include the date part - it adds nothing.

--=20
Cheers,
Stephen Rothwell

--Sig_/KCuy/W_yhQf8pfFX3A8OAez
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLwLG0ACgkQAVBC80lX
0Gy4igf9EcW3ux9Z6rZRSibgzAQW06g4hC2oHPL2kuSoC72/rDKKtXKSmbJ3WOWA
G80drdXKSvZYkaBKE8bI5fvGl52zM+/8Z7EMVlxBhCNcnt26inagyNkGqLfZ8fw9
dXkIpSd8XI32mrZTaWt0snMqt93pOiJMHbdHPQe4GwFihFXlG5fJTIjZDMxz/HoT
6TeMxZQsjGwMjugqbpa6VID441D/Za8yIXI2aukfZB84Dc8XWdNgQrF29NeVCHBE
xUiWVQETEItOg+DlfqyVBbv+D0cnLWYNeh8/wBHYFu7t2S+EaRu1GR+AJPfI59Np
oTGzboPpC0y6/v4tqqv2lj31ZS2GrA==
=cmHN
-----END PGP SIGNATURE-----

--Sig_/KCuy/W_yhQf8pfFX3A8OAez--
