Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A86467174
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 06:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350516AbhLCFY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 00:24:26 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:50501 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358112AbhLCFYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 00:24:10 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J51PK4Vltz4xYy;
        Fri,  3 Dec 2021 16:20:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638508842;
        bh=NDy0lZu/+Zbrc5v2q52N+63FnkGowi1wu2UPtBaQ7O4=;
        h=Date:From:To:Cc:Subject:From;
        b=at+YicyEhwTT9zvgevQ2T0eiI2aLkeJ2kF712g+mHC/iR8IaQUfKXDVEfv09zcw1S
         TfHIjQ5ttR3rQJ9uG+wXiT5m89+j4aYoaf3AiOROOvMYCCPHpm0ESFvpHScOKZ/YuK
         uqTqqF42DiqmdMj9TpHkCEkA9Ua1HdT42GYyAprrtvP1w+3xzRCFMpaezY5mfACfZ4
         aU+OUX5daPnoQOu5gSi8CrBS63AlCME1a1l3h6a/an2OTjLQlJAXpoJD0YVSl9+ZR2
         vBLi65onfNByLpeG7Wx/IPWDkxw1TxdtTnfJqED92vd4As1koW0CCtdvT4XHAVLdJ2
         Pxg8TQAlcgDXQ==
Date:   Fri, 3 Dec 2021 16:20:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Finn Behrens <me@kloenk.de>, Gary Guo <gary@garyguo.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Wei Liu <wei.liu@kernel.org>, Wu XiangCheng <bobwxc@email.cn>,
        Yuki Okushi <jtitor@2k36.org>
Subject: linux-next: manual merge of the rust tree with the kbuild tree
Message-ID: <20211203162035.406a055a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Mg5lyGTE0AHQoRmC7R./cdG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Mg5lyGTE0AHQoRmC7R./cdG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rust tree got a conflict in:

  Documentation/process/changes.rst

between commit:

  df05c0e9496c ("Documentation: Raise the minimum supported version of LLVM=
 to 11.0.0")

from the kbuild tree and commit:

  d029d8003e02 ("docs: add Rust documentation")

from the rust tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/process/changes.rst
index a337e8eabfe1,c51644fbb801..000000000000
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@@ -30,7 -35,9 +35,9 @@@ know what you are doing, use the exact=20
          Program        Minimal version       Command to check the version
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
  GNU C                  5.1              gcc --version
 -Clang/LLVM (optional)  10.0.1           clang --version
 +Clang/LLVM (optional)  11.0.0           clang --version
+ rustc (optional)       1.56.0           rustc --version
+ bindgen (optional)     0.56.0           bindgen --version
  GNU make               3.81             make --version
  binutils               2.23             ld -v
  flex                   2.5.35           flex --version

--Sig_/Mg5lyGTE0AHQoRmC7R./cdG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGpqSQACgkQAVBC80lX
0Gy40wgAgiqP6nvfp0LUd1PFnZlunEsNX6qZ5/fVxHSOytAArAKlHrdtB763m9xm
XSrzjc44HM9NNPwC+h5XHEcnwdl3UQ7KWZeJ6wPkNemvw0jD1S48NzvGd85w1jKS
vs5OcKHqtBIPqWiA430he9a6UDDgVc4m1jsWioudlA2DndyKjSs1boPHjLGLbmDe
ebwoNY2rApXhrI19trUSbK17D+V2iD5M/cnmjdZmG27jindYVNQqWP8mvNDgqjtD
CinhwNi2fJzBSLVXK8rNUX5rQvuJKP+FHrRfWSJs7MBC50qi0tsX5ZPs27Q6my6V
su8eHugwWLJ8eQxchfpPC0wTAP16xA==
=J6vQ
-----END PGP SIGNATURE-----

--Sig_/Mg5lyGTE0AHQoRmC7R./cdG--
