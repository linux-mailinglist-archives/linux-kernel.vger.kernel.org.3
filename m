Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552D7478123
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhLQAL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:11:59 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:57373 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhLQAL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:11:56 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JFTtf3kMZz4xcF;
        Fri, 17 Dec 2021 11:11:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639699914;
        bh=cAY2D9wTg90GtlfCAf4NvCnI4BXbdjnsmGEg2/S92WY=;
        h=Date:From:To:Cc:Subject:From;
        b=czXJQVrTUh5WQT1YqQonJJDFyoWbAy9QytxOpY7N6jXlXj94naKR5esUV25EcdTTM
         nYCRrUuI5HgRgwgL/s3eIK1EgxNenjB01S87dPDN/8RICkW0gi9n+0c7sUfViVPG5O
         2lmlSU/bJkkrVZLPb1SYjllPEE4lFeK/fz5f0XFC62FpEQedqbOXmdpELssBTRUfWR
         ilUF3htIOm6JkcSiSgN8pd9PgSR5BOpkeCuhys5ajvIgw++itPF/W4CEKCLDpwQ4MJ
         o+kMaxUzbKzHM8KSn6q4lW4sibwYnuSa7KRFHKmcM9Zib28ripUyMcJ9mFqHrmhXkx
         Y52AnRd+Bb6cQ==
Date:   Fri, 17 Dec 2021 11:11:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the fscache tree with the asm-generic
 tree
Message-ID: <20211217111153.67e98357@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CSB+0hGA5_EmUMK65+GDqRU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CSB+0hGA5_EmUMK65+GDqRU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the fscache tree got a conflict in:

  fs/fscache/proc.c

between commit:

  5c61c384095a ("Documentation, arch, fs: Remove leftovers from fscache obj=
ect list")

from the asm-generic tree and commit:

  8ed89a0cad0c ("fscache: Introduce new driver")

from the fscache tree.

I fixed it up (I just used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/CSB+0hGA5_EmUMK65+GDqRU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG71ckACgkQAVBC80lX
0GyvYAf9GTRrpUg7IR0G/FXTdL390Bx9noT2RxGb99ic+rYB8h/kczo/LzI3WYKO
LusfdLqBY92Ljlax4mTxEPlPLjixPDsw1BoiSVquJvw8RBjN22yAOfRnOMvdHABA
RTV/j4iOjx8VUaBKz5kmcZ/0SAj7zz80FmaYGwLlseXCKUqBT9bM37gZAopZ6X0v
3OZXuQUjY/DaWVFQNd7Oo8b0r5FiSZCQjGJFikI+DSYCiJKs1sV7xEQLV7gDAf7P
eixt3b8vwE1AKiG+WyOQXI+CT5J5ckpThiFa7UIZPdcdpxWaYcrTcqWAjUctziJP
3YyQSI5Cq9h7gyOP7e2uQHmtSpIOug==
=7Azr
-----END PGP SIGNATURE-----

--Sig_/CSB+0hGA5_EmUMK65+GDqRU--
