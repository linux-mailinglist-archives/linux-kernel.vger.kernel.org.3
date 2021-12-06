Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340B1468FCB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 04:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbhLFDwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 22:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbhLFDwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 22:52:41 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03048C0613F8;
        Sun,  5 Dec 2021 19:49:12 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J6qDL1Lcmz4xgq;
        Mon,  6 Dec 2021 14:49:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638762547;
        bh=vvRwc0WVIBZDcqyJ1LPhcq6pqZkLP75P5NbC6E/R+t8=;
        h=Date:From:To:Cc:Subject:From;
        b=jgW4/EvjYAcx9wIIpPPz+CzU59NwWSm8gHCK/GcWN3a4sg1hGBs1abRMam/MCSrjA
         6tBl8JbhXwJYXF4aD5LTxXKX9PK2AEDsXT1hefCMVKiXv88O3fNMfK6C7Fdck6hvqn
         Wt51mE/o/SKjPGpOUZL6n1QHUVanXWNaH2SNQ4YICtyZSoZvwPCXyYKLTQPQUBMP7M
         ttTlj/xLIvsJHZ/AYcFaLD+PSGdFIptzAuukW2OOAsfUeG2MsCzEgG+KRihc7zOeh3
         cSjwayOrc5xHgqX3/DRIUCzAWxz8jbYfcAhF+Yv6uL8qFzc/QPrcaBza9CL264XWpq
         ZB5n86zlBtToA==
Date:   Mon, 6 Dec 2021 14:49:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ralph Siemsen <ralph.siemsen@linaro.org>
Subject: linux-next: manual merge of the char-misc tree with the
 char-misc.current tree
Message-ID: <20211206144901.63529ac9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZNXWm.6bRtKGc62SSn__+9z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZNXWm.6bRtKGc62SSn__+9z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the char-misc tree got a conflict in:

  drivers/misc/eeprom/at25.c

between commit:

  9a626577398c ("nvmem: eeprom: at25: fix FRAM byte_len")

from the char-misc.current tree and commits:

  5b557298d7d0 ("misc: at25: Make driver OF independent again")
  a692fc39bf90 ("misc: at25: Don't copy garbage to the at25->chip in FRAM c=
ase")
  58589a75bba9 ("misc: at25: Check proper value of chip length in FRAM case=
")
  51902c1212fe ("misc: at25: Use at25->chip instead of local chip everywher=
e in ->probe()")
(and probably more)

from the char-misc tree.

I fixed it up (I just used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/ZNXWm.6bRtKGc62SSn__+9z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGtiC0ACgkQAVBC80lX
0GygPwf/YlXFDh1wqEqmJD6dhCNJhyc1dJFD+EeVRQcV/wCsFKG2DQuGpw8pv2er
YT9P0OR+X3YjzA49K0yGYZSJPIdQy+uUtFweGFz6gpCZ++591n56GF7qtXZi7jYS
uKyN9qOu+6aOBOMaZB/fCIeDZ9W2MC2beA+iof+4JFniHjBsugo4pqtwO2dB0Upa
Kw62CyEeqZsu91S3PKwzmxMrVKhlY5pU9FuGp6bKZSXpe8gcoVHdzwO6g3TijDkh
AVtH9vgzuASoRSJbF5azzcI19l9SQ9XON4VSDgBszp2jH6aDx1SFrseJvlsRcY3q
uy/pbdSaBx5ryVBLl9QIl2nDspkd5g==
=C/b8
-----END PGP SIGNATURE-----

--Sig_/ZNXWm.6bRtKGc62SSn__+9z--
