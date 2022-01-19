Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B72494336
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 23:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357601AbiASWng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 17:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344033AbiASWnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 17:43:31 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F177C061574;
        Wed, 19 Jan 2022 14:43:31 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JfLJw5xvFz4y3q;
        Thu, 20 Jan 2022 09:43:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642632209;
        bh=w4RJa7LhdlEwidZ+0nB3oeRlJt8ZXOwyiD8Czy99fzU=;
        h=Date:From:To:Cc:Subject:From;
        b=TA9kdtZ8Cax6NiKl4d2zCMZr/te6y4kixuSSJMFG7wFNCUjzHRsE6QATh2aSMV75t
         ypR7Ndm073YXOfkqH0AfXLZ7z8tiIC6ZY1ZkZ8/7GuBkVGzMjKfLtCsldU5qokgb2L
         n+w4bXCBu7slmY5/4BwBOLNfpV61YrrKug3/tqePZjj8338iXiUPwFmXoqUsa2qQqC
         q/EMSMoV4pG57vcTVljnwzrPrqUbr7IGiR2yLNwdijtFErn2B6b7cz6M8+VHfwZegq
         UJand6kq6LJULCgZLe6xQcsLXuHlQIJN9y6HZinSOzBmkHqILViUHdMZijTys90cOZ
         WfCGRaxjY0BVA==
Date:   Thu, 20 Jan 2022 09:43:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: linux-next: manual merge of the cifs tree with the fscache tree
Message-ID: <20220120094328.1e7015cb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bOe_3LTxZ/S.vWHPjj+71Yj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bOe_3LTxZ/S.vWHPjj+71Yj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the cifs tree got conflicts in:

  fs/cifs/file.c
  fs/cifs/fscache.h

between commit:

  a91e6e1c8074 ("cifs: Support fscache indexing rewrite")

from the fscache tree and commit:

  70431bfd825d ("cifs: Support fscache indexing rewrite")

from the cifs tree.

I fixed it up (I just used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/bOe_3LTxZ/S.vWHPjj+71Yj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHolBAACgkQAVBC80lX
0GwSuAf/dlThWpO7LU9wRWkFgFqPTONn2TeyQPiPn1nrP97g/M+82fxLpZRw2ez7
oLh1iIqRV5xDdVlL9EIVZ5XWA1qc1WCZ3KYeBXHGv9tX8JYG6GlvhfrOHJoc3zbj
7leI+pF1nIEg4gh+TXotCD8y09Vs0j8k/hVCXYAQrB8J4xhUFKd1NDKIY3ajdhax
EGXjoGq/aj6OmD28LDkZ1HPPUIskkTL7tVa0gMExeX5PxhF+A5sU8/rrTtZBIce+
PugOhy65ywGia7/FRErmu+rd4VPhNhxFTrdkNQLDzRuvapCUQNWGxUl2obJJsetU
eXYJSKs2/AUKf/V8wIFmeAu02M4TgQ==
=i3M4
-----END PGP SIGNATURE-----

--Sig_/bOe_3LTxZ/S.vWHPjj+71Yj--
