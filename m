Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE21491279
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 00:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243846AbiAQXvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 18:51:16 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:58073 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243839AbiAQXvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 18:51:13 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jd7vs0t1pz4y3l;
        Tue, 18 Jan 2022 10:51:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642463472;
        bh=U5ePYBcLSSsiGs20yGfXoqllL031A9bEv13F94J46kU=;
        h=Date:From:To:Cc:Subject:From;
        b=cQ33iLtEdNOSXLLV+l3QVA8gD3hqJ9T5BYaz/7m9SIQM8vJeyKQ4afrEjMq6bsV85
         E6ap4nroIKuArCr37XTQ3H3g/SSPyFRJQA9NaM0cdtlWv5wK5x02NgVQuZcAhN5N7A
         hxYcrwI38hzKT9kAAsv2Jz6N51tMrB7VfGsQolk40naceLxJ28IoLwBX6Lxfs1TOIx
         F6hcJA6zozFHgNa4feLxJPw0CCcznXdEaqno0IL8Np18pQMYrqUktkeqoTCq3a4yYg
         OVdK+B8QqiCPU1Zq9qFBeo99JctPmJm/+J+XaeeMnywjARharwoRZCsSgINHwfJBso
         DnUkxIxVZPSPA==
Date:   Tue, 18 Jan 2022 10:51:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Daniel Xu <dxu@dxuuu.xyz>, Finn Behrens <me@kloenk.de>,
        Gary Guo <gary@garyguo.net>,
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
Message-ID: <20220118105104.67c5def1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EZ.EqF6OsVE5ebnOnZlSAWl";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EZ.EqF6OsVE5ebnOnZlSAWl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rust tree got a conflict in:

  Documentation/process/changes.rst

between commit:

  df05c0e9496c ("Documentation: Raise the minimum supported version of LLVM=
 to 11.0.0")

from the kbuild tree and commit:

  78b471443e27 ("docs: add Rust documentation")

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
index a337e8eabfe1,0f5d64d3993f..000000000000
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@@ -30,7 -30,9 +30,9 @@@ you probably needn't concern yourself w
          Program        Minimal version       Command to check the version
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
  GNU C                  5.1              gcc --version
 -Clang/LLVM (optional)  10.0.1           clang --version
 +Clang/LLVM (optional)  11.0.0           clang --version
+ Rust (optional)        1.58.0           rustc --version
+ bindgen (optional)     0.56.0           bindgen --version
  GNU make               3.81             make --version
  binutils               2.23             ld -v
  flex                   2.5.35           flex --version

--Sig_/EZ.EqF6OsVE5ebnOnZlSAWl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHmAOgACgkQAVBC80lX
0Gy0BAf+ManR3uMGCPSIDV55J79YEgtziApLhwVHeXT+9wxtoakkmMpz9lCpC9uq
+WulxA0UhC599lk1hP084G+t/M0vdvwd8swBPUXSzCWz/1HkwGxxZggYq1ZbYpoz
4CnHCRAJmzRQge27lXNAvGxDcy5tLmbB69QvoRvFNVXja89qNqOM9XP4uVup2OEc
1GiP1poV/XanVAx5uz7zpevhVpSgiTxANvUYuc2aKZQJBP4R/spqU9ukE7b9hPd5
ME/MSmnKLPqzoaI3u6B8DLsBuhl2NHOOrcXbUjuMMWqc67fnuNSe/gdIvKnxQD8n
iJt/YOmPhBKB98IeRRjdmaXisvme4w==
=0vKt
-----END PGP SIGNATURE-----

--Sig_/EZ.EqF6OsVE5ebnOnZlSAWl--
