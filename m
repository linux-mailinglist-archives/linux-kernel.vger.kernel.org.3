Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0EB464051
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344201AbhK3Vju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:39:50 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:51711 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbhK3Vjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 16:39:48 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J3bBg2N3Cz4xR9;
        Wed,  1 Dec 2021 08:36:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638308187;
        bh=KVcjZKAh2Vz9OxmAtKoRcpH+t6oxbtKVS+0AmdcvdBs=;
        h=Date:From:To:Cc:Subject:From;
        b=MwpLysB7J1IqOJT0gpXjaEQHFJw+LzO0UCm+RetqCoPRWeAVsw2Bt4HrATdC7Ltun
         laqy2VdT2Af/Jto/ukZOpIp10PIcc3QPLyIctz+rGmuRbYKn0LQeyoACmn1IX95m2R
         SNAXbIyaKsJKoh6hjToKwm46N7ECaU9PyNKjaGDSvDRYlrHfQNJaQGEri5wmE+i45d
         rteTBIh3C8iGwYMlO/2kpjHnsBckJ7ZZRXkS/sGlaz09/fLrxAHCgUUBxiU7/ZKmfi
         nepklqCzC03F1zgKjRSGRUjE8TrxzFleeqXupe5tzkNd9SJzmrtKzuJTOdNuoHKfsR
         7MyYKlzrYpR5g==
Date:   Wed, 1 Dec 2021 08:36:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the fscache tree with Linus' tree
Message-ID: <20211201083625.74dec92b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hExX9xm0F19YMLGWdVrtPyj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hExX9xm0F19YMLGWdVrtPyj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the fscache tree got a conflict in:

  Documentation/filesystems/netfs_library.rst

between commit:

  ddca5b0eba4e ("netfs: Adjust docs after foliation")

from Linus' tree and commit:

  b3c088faf78b ("fscache: Rewrite documentation")

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

--Sig_/hExX9xm0F19YMLGWdVrtPyj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGmmVkACgkQAVBC80lX
0GzVSgf/Z/hhV/MmnG7MV48wX+LDpIVyW43KqO40KAdgmVpIIh+klwRtIJrpZE/m
vrikspfzBTYV/3BOwKusYCTGDCMnsuDaIvB4VsaKpdpx5H/F2aQyzliWvqiw2GLk
tOyFTjG0QvzxlhVuhTtnIHFFwdiT46t/QrXQY9rApDlJJn36+4d4WnVsBndY+I2+
o5UVGTcveGq+0peOYZJ+f0hSaoDgztucbpE0cihRw0peJPD4Mb2T6RFjBeADRe4G
bs3QkuBbtARHTokGrEvaaibVpjo5HKAMunGNmqnpFIMuNiGtCBAoFLKtZp8qoWH6
+YMmaEfZC3mc67CHAE35PZKJ+thS2g==
=Hxih
-----END PGP SIGNATURE-----

--Sig_/hExX9xm0F19YMLGWdVrtPyj--
