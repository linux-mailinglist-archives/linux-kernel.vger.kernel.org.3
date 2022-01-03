Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C4D483949
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 00:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiACXuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 18:50:32 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:38033 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiACXub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 18:50:31 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JSXYf1Pfjz4xgr;
        Tue,  4 Jan 2022 10:50:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641253830;
        bh=KQs3YxUQZmemphXfY2NFLrFnQbOVwIoYU0KDTRQ+ez0=;
        h=Date:From:To:Cc:Subject:From;
        b=AoWcJj67bE5KxEmcuKkYN4r7Z3nnU+0fdx7WvPTzOjkao/gHQmhNlyStOLfNACmKU
         FAhE7vbbga+noxS18BaDJvKxt3NqiCjD6zO6FfnmyVpe184V3S+IZm6vH9KRYolOOS
         i0UxUgv0EqVFFT4e7/a7CelMuqbWsC1FMT6V+a2078ZshJM0voCXjYeLY7nosYQVOj
         9kq7JQjvnj9WmM2f++a55IPEm/RtybL0HAYizx59O4bf99/S4vqfQAPInYcVet+TBb
         a7rHZYBV3oogvh6i9eQZ7bta/44D6sJlV8vON9d7SZGYe10bOpZMbC5otxPBBQqCHx
         T4DPz9KtXT+6A==
Date:   Tue, 4 Jan 2022 10:50:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the amdgpu tree
Message-ID: <20220104105028.023863e2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8C6JJDB+VXrKg8Xl5emQBqI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8C6JJDB+VXrKg8Xl5emQBqI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  3be2709660dc ("drm/amdgpu: Call amdgpu_device_unmap_mmio() if device is u=
nplugged to prevent crash in GPU initialization failure")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/8C6JJDB+VXrKg8Xl5emQBqI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHTi8QACgkQAVBC80lX
0Gw7Swf8D8EOxTo89/qCabAVs95FqUZKmz2c5P7RoIzTlEK5wEwAOAAqyjhx4jGp
d6aJI7BcAyt9qHEM56DOSZ0cYr/SBuN97JdwHq6Ji6HL3+rO1dleNN2pl2C8SVz2
qwRfV94QOiZEqsrsM4asL5uHnEWL7ibaQhboGMXWBdx5DjkycfkPQgPF0Z75FIHN
5IXAMsdjL2Kg+Mxip3c2WQUAmt1kBIWZGLUVUBknL+8wk27oWgmRVLrmK0q4C8Xb
wvIziiYLcUz+R5X19OzI/2uHbneFKcx5Nw8EyyJhkBdCp6Pims7TjOHrJMyENIBN
BG/tyxefNbMCPXL1/mv6qUvbcmdsxg==
=ie3U
-----END PGP SIGNATURE-----

--Sig_/8C6JJDB+VXrKg8Xl5emQBqI--
