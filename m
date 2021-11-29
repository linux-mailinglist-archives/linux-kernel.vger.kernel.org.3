Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD93A462261
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbhK2UpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:45:05 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:46939 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbhK2UnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:43:00 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J2xzd2PHCz4xPv;
        Tue, 30 Nov 2021 07:39:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638218381;
        bh=IygQIoNfMp3ydDZF4+fj0uBoLquTJOKsZ0E71DZW0+4=;
        h=Date:From:To:Cc:Subject:From;
        b=uqlN4JTp7cEY/gSirCSk95zbtH4evAQB5UiSTrsO6aviQPQX3gG4NzjyNsTPOw6HH
         PJXspu+PtWochyYGV72T1ACXoJQD4LsPpG2Th/+vEagg4nN5yMd0ZNlrFKK5Gcmqfp
         sf8E5EeNig03oyBZCAnga+PvAlCoUO/NUi4hL1yPA95wn53E+3vYt465/vw5e1u7He
         tt1/KotrnTFRRP+khPGdj3H8Q2M7KWCp61OwkVGuvXINlpjYGIQ9Gexh8ZJ/4RtQyu
         D1Db+xgURnRhH2Dv9ZnCjIQgn2oSgcWxyVpyohBw5j5aLXQnEoGy7AkLwQFsdurPpZ
         z8dkvqGlmNU6g==
Date:   Tue, 30 Nov 2021 07:39:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the tee tree
Message-ID: <20211130073940.7eb0f2c1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ba_JD2K+bcOwsc=rGHbT6wi";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ba_JD2K+bcOwsc=rGHbT6wi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  9fcd8dc5d651 ("optee: Fix NULL but dereferenced coccicheck error")

Fixes tag

  Fixes: 'commit 6749e69c4dad ("optee: add asynchronous notifications")'

has these problem(s):

  - No SHA1 recognised


Please just use

	git log -1 --format=3D'Fixes: %h ("%s")' <commit>

--=20
Cheers,
Stephen Rothwell

--Sig_/Ba_JD2K+bcOwsc=rGHbT6wi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGlOowACgkQAVBC80lX
0GzNKQf/cBPHIr6EllaeTVHFQVKCXtLwm3qjJfiPAYRDMb/oFBYC3sQ8AMy5LG0b
5sD5e13IoREKebk3InhFrzAdS5SsslBEyqtBonCfR6cSf/Fi0QThqJk3fEYU7JCG
9bzS6oaFf82KMIzRGPSDu+iGvIbGaTvwIF69zjpsblqvnavRp5TEr8PYGE8p+peT
QRYD2cazZjrny4skkKyhVd5X6vhjga/O6rYXwPd5j4GZp/mDVOMOkHjoUAUYF3Eu
Hl7lMIbWMfU6CIbsHljPxuZapKW4QcIfgLZz3k8nVdo2Js3LtXAPBjUkPtM/BuY8
TmMTj7zF24wPEGglNx+twg8FA5OyYw==
=q15r
-----END PGP SIGNATURE-----

--Sig_/Ba_JD2K+bcOwsc=rGHbT6wi--
