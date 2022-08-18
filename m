Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E02599083
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 00:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346259AbiHRW3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 18:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345633AbiHRW2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:28:52 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706693FA39;
        Thu, 18 Aug 2022 15:28:25 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M80035SCMz4x1P;
        Fri, 19 Aug 2022 08:28:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1660861700;
        bh=yp/xInT9L5HCcB4JLGvPHvWx0Hk0C/hTzX0s670S0CA=;
        h=Date:From:To:Cc:Subject:From;
        b=qcFaXYv89/8iLSH3J+k/DyaXru5f/RynfrrdNMzcOfbc7mVDq9h4OjGdawNuZrXRV
         v8dkeCcSjOVb9rMxEQY6UX1WtyAXmwwmxH/b2anHnRaRUbwX5u1++kXWQNuRfQt2zn
         m5BzxLSaw2oWSK2ZD3Gvwk0iBqyLCEAfa6MeivEQCgI9AJd1FqCOeNKSwVTLLYq9yn
         9MaoDkioylOtvBrfUJBpNmpFRgt14GRW9tXwKZLvaioiPlkpJTi340Sm2F0g0lQ8nC
         PQqjux6Yvp/KlO62sD3KXyGhvP8+4QFM35cgxlhCRU2Als0WpEPz1duAJkhrAMKrFV
         FtUIZTWOiZCvA==
Date:   Fri, 19 Aug 2022 08:28:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the char-misc.current tree with the
 mm-hotfixes tree
Message-ID: <20220819082714.5313827d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Stad/URey3R+O/CDjFd+sAA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Stad/URey3R+O/CDjFd+sAA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the char-misc.current tree got a conflict in:

  drivers/android/binder_alloc.c

between commit:

  b3bb668f3dc6 ("binder_alloc: add missing mmap_lock calls when using the V=
MA")

from the mm-hotfixes tree and commit:

  d6f35446d076 ("binder_alloc: Add missing mmap_lock calls when using the V=
MA")

from the char-misc.current tree.

I fixed it up (I used the latter as it was committed later even though
the author times were the same) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Stad/URey3R+O/CDjFd+sAA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmL+vQIACgkQAVBC80lX
0Gwncwf/S5i14ev+AKaKh9fOQ2h8oVIb/VVXc+cRbQcZ39jI+XDJEGhPLfuhHLt4
kwvNRAd7bGXTp2b6JCx3kDqszSHSGOWKyDkh1u2v/zzfI4pjI0NeLmJeq3+uTi2x
CCBXBVY1mqNvU9T7ldKLBaukw6JFQjIWjCywNrb9FqT4HrkFWm4uKW3qoWAGkxOP
13gobuI1DReard/lcucwFulxekVoZbwbLD2QHveQWNWk1EDPGcgrLgHzfF2IN8SH
m+RdvsAysJQsb/izxz/P/JbXAb4GcbABnNyfasIb8QOojYBWHYOqWRm86/cT3p4o
YkIOiEjDfOaafJWVXDQO/nONM6HcWw==
=Q59H
-----END PGP SIGNATURE-----

--Sig_/Stad/URey3R+O/CDjFd+sAA--
