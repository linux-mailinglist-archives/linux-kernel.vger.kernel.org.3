Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FE8497009
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 06:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbiAWFlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 00:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiAWFlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 00:41:24 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A3DC06173B;
        Sat, 22 Jan 2022 21:41:23 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JhMRc5mWGz4y4h;
        Sun, 23 Jan 2022 16:41:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642916477;
        bh=r7NPI2TNvsMacvzHSFiKu0O4MgYsJ2iddlDbMqUX9kI=;
        h=Date:From:To:Cc:Subject:From;
        b=qR6iffQSKTaTC2PEihKWf99cU5RvvnRZBZdTEbKsVDBD/hePrAB9GfbiNWbpJbiJQ
         /dxGz0iGUvRXAVgsbv0bJpAKkyBTBQSuV76YMrphK2RhucmUXVpXma+8ol6RosKgvh
         Y90nVap9zajtjPi1Bz/6Hqh8eWlZVwMyTw3s116UW9vN4PcLI62F9sP9Hg5YBxfw7t
         /fTYbsFk82cNRPDQFjdhz1cSgS0ScM8SEyJqteZKaHnwLgsndzF/loruUZD3H7b7ke
         DgZrw2LWLGipGGj8gCV3pWaRuOvyVhjuxzz/GFt8DMPNO/zx1HkdUfRtqHCnvpdB6Y
         EN731aV6sSy+Q==
Date:   Sun, 23 Jan 2022 16:41:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Luben Tuikov <luben.tuikov@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the amdgpu tree
Message-ID: <20220123164116.5fd89414@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/c/N9DKwK2gFA84ASPi1sIG0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/c/N9DKwK2gFA84ASPi1sIG0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  47b6584b9f43 ("drm/amdgpu: Fix kernel compilation; style")

Fixes tag

  Fixes: 824c2051039dfc ("drm/amdgpu: Disable FRU EEPROM access for SRIOV")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: eadabcc2bc6c ("drm/amdgpu: Disable FRU EEPROM access for SRIOV")

--=20
Cheers,
Stephen Rothwell

--Sig_/c/N9DKwK2gFA84ASPi1sIG0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHs6nwACgkQAVBC80lX
0GziIAgAkDx7MkIr4sSxSIbmENXVNrg67iAf7GKKTmTOczI11oFbMw+d2Kt2O/QL
hzUf9F/mQ2V4heynkpatihGIk/ziFmfKum7t8WEUt1IqZWKTNmA6bcBla5ofiJE1
zTqUyBbE/43BbLfMjjnc2UcyTemlpez6hvM0cFpXrELJBtqF6d3Rxen/IRVZVfNO
dFt69Gc5fVmeZDSxfQnEHFzHKtExREVFlutBK0ybZ+IzsB1vvKK5qWac39golHFo
UX1ToNBF/5g8z3Ot4+S8Fngcp5va8i2wuMj74O0ChBswaypEQ94+4iXEZ6+aZf+v
gQC1jr3OO0OSMfvdKXsMhTVdCM8nYw==
=UgJd
-----END PGP SIGNATURE-----

--Sig_/c/N9DKwK2gFA84ASPi1sIG0--
