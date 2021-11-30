Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAE3462D19
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238821AbhK3Gym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhK3Gyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:54:41 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B747CC061574;
        Mon, 29 Nov 2021 22:51:22 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J3CYN4rSLz4xQv;
        Tue, 30 Nov 2021 17:51:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638255080;
        bh=lhL5PUUFXrK2X40tGvNjCzFWRNBeX05n6jOvo1zH29w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OGG3qNcBauFKetv9NJNhW2Qwq4BBVSxRNLrZTl/ITwMGen9z0t4RMPLqlam1TpfDx
         AFrogANUKHNrFKfTbumDaHiAyblIWHjHpwxgaboSnEYrln6OUp8uOnCf6eijhl7Nty
         hnK2+Xk50eGUjdYX/zddE/iw8yStYh53ooeRJhH3AdIk+8W1snQNC3PPEVHP+LzPpV
         63wAi5ZsDeWR/OFqLLwVeq0giA22m8ul6KpgjrcpiGwRMDElxTSpJNQ4pVo7V+0gwd
         K/zk/lg1QtjXXFQ6CL7X8oAE4TAKdgRDunGyBgnnQ1ee6Hf68vRn3jw36zUECHfrKE
         nodrM02PHXzfA==
Date:   Tue, 30 Nov 2021 17:51:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the fscache tree
Message-ID: <20211130175119.63d0e7aa@canb.auug.org.au>
In-Reply-To: <20211130162311.105fcfa5@canb.auug.org.au>
References: <20211130162311.105fcfa5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4dQe+d0r.Z4JHi+93mEG4nb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4dQe+d0r.Z4JHi+93mEG4nb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 30 Nov 2021 16:23:11 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> After merging the fscache tree, today's linux-next build (htmldocs)
> produced this warning:
>=20
> Documentation/filesystems/caching/backend-api.rst:417: WARNING: undefined=
 label: documentation/filesystems/netfs_library.rst
>=20
> Introduced by commit
>=20
>   b3c088faf78b ("fscache: Rewrite documentation")

Also

Documentation/filesystems/netfs_library.rst:518: WARNING: Inline emphasis s=
tart-string without end-string.
Documentation/filesystems/netfs_library.rst:518: WARNING: Inline emphasis s=
tart-string without end-string.

--=20
Cheers,
Stephen Rothwell

--Sig_/4dQe+d0r.Z4JHi+93mEG4nb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGlyecACgkQAVBC80lX
0GzJdQgAnGS4QXC0fuUor8W+9y+6SwoqIagBratLuQpFCxPUgJBBB3rEzwtvd8K1
btIePlBCUPucF3cPeJ6v3grxe2cm9JNlLpjaqxr43MEV0CO2BzYTsRncsE7RfDc/
LLiPz11cn/eh/UwI7/uTIPsvJl7T5ET4KNfYjAqzBCeH+F39seA5/s21N6lNcVD+
6rRFuyE5jrp4Da9y2+FyRMIF8MjsiT4TU9A2CANn2LGfPuyBLdk6t2WU5WbkpU7j
PRNsgsm5uWNm4c+szLtTRzYdoO09rYuevb2GYp/knCazABpl62+MlgDaIFN3m/XO
jBdIs30ZuIO/t7bU2n3jkVaVWg4EDA==
=FdLT
-----END PGP SIGNATURE-----

--Sig_/4dQe+d0r.Z4JHi+93mEG4nb--
