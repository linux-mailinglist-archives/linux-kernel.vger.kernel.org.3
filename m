Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6895A48A386
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 00:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242515AbiAJXQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 18:16:47 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:58891 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbiAJXQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 18:16:46 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JXqTT3tqcz4xbT;
        Tue, 11 Jan 2022 10:16:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641856605;
        bh=2ZTmK2zhdydCwGSAqsW7rrdJoUXI9mPmclZ2vEJQ+lg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C2BEQ1yvvHJHrb9eolIFN2+i+i5O1TP+4fSjGEptBpkgW2+cTo3BzL6LtPcpbFO8R
         DLaz/nBRwQNTgwb3xL64XHGj7Yly56dwc74+hkgjgoGxC6exnvlLhpKWOcioaqv/Zi
         YbPVi98r2UB7Eyts8vslURgZduQ7sgfkp9W3akYt5636aDzDd6KJMMh3sq2L0enUH7
         Jko39QcrNvFd330R1TM4B1rC3CLQ1bZ5OVSuMcUOAs0krISOvCeoZd5gi8gX078Gv5
         oFgs9XvMLrfpxDc+9YNc2LK9fZmBDbwgIk9JaA2g/A7NayYJe3bfyfHzThoo6yDZhS
         i//vkd3lwi4nw==
Date:   Tue, 11 Jan 2022 10:16:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Harinder Singh <sharinder@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the kunit-next tree with the
 jc_docs tree
Message-ID: <20220111101644.2f90ba50@canb.auug.org.au>
In-Reply-To: <20211224163256.2a0f01af@canb.auug.org.au>
References: <20211224163256.2a0f01af@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sozoy_UNK_/l3qO6BdJKTvL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sozoy_UNK_/l3qO6BdJKTvL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 24 Dec 2021 16:32:56 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the kunit-next tree got a conflict in:
>=20
>   Documentation/dev-tools/kunit/index.rst
>=20
> between commit:
>=20
>   6c6213f4a29b ("Documentation: KUnit: Rewrite main page")
>=20
> from the jc_docs tree and commit:
>=20
>   58b391d74630 ("Documentation: kunit: remove claims that kunit is a mock=
ing framework")
>=20
> from the kunit-next tree.
>=20
> I fixed it up (I just used the former version) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

This is now a conflict between the jc_docs tree and Linus' tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/sozoy_UNK_/l3qO6BdJKTvL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHcvlwACgkQAVBC80lX
0Gyekgf/aY+juahxsNiAnAIlFMKvij5chGP88Jq9GUMmz8b2Av1CLMtuA4MhwTVJ
x8fXd02Rjs+en/CoIt16/qoFGMlevJ0O7J5FpLmOt4xjPLB3ID3W0+SwPGNiZEyp
H1fF/719SkmowvTNq6u5p9055/N0r6TPQ6IZw6Mi2SuNF5HA+YrILhjzBYAcXZre
t07PMw1MMtlXv5s+IM3qwtztnfjGLtKFuDT/BDnk/ujEchmtjuZNCWkU+2+4aieL
/Tc/Kx54Zqvg52DLO74+v8Y2FJaymUyfy9gkOSGSA2kePMSHKZDAmMJUlZ24jag8
p6IS0mA4kV+wPBGJzAlZ+FjvDEicCQ==
=D9k8
-----END PGP SIGNATURE-----

--Sig_/sozoy_UNK_/l3qO6BdJKTvL--
