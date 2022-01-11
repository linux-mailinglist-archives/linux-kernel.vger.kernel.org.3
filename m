Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5C548B953
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 22:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244543AbiAKVXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 16:23:18 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:44255 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiAKVXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 16:23:15 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JYNw11K1nz4y41;
        Wed, 12 Jan 2022 08:23:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641936193;
        bh=gH3vPl16f+LUWdP8Gm8iHygFw6tcFSVQIVS6kij8bv8=;
        h=Date:From:To:Cc:Subject:From;
        b=ng4iic4KtcAl0wQC+IlM6BjNQm3fM7z3BOxqE/gKNMk3Dg2djKKonP1D3lht2sOrD
         6Z45clJxE1tIu2ozauvX2V/LIX/OBMy9Te2gY610AX3bSz36ipmkiMHAiTxVJHnDgW
         OabP3tedQHaPlaVgRQoGmyWnCSCymwBoLu3bpYt1JcCJr0+gwn9bhIETGXTY7DKRb8
         ucmJr66r1n5hni1qgoEc3MwXe3Oks2jZBDGCcexlo+RhcUGACk93glPm53VRStr2eA
         GpKA4E8Dy0TrWeSGX3v/OyBxIIPZnAgF7eHqBCngZ4Q3zarCM5Nt9/rBAOGeOu2UjE
         YIZRUaaMmEADg==
Date:   Wed, 12 Jan 2022 08:23:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the amdgpu tree
Message-ID: <20220112082312.70b99afb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3oulqhfug7Mc.bGQUW_FIrF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3oulqhfug7Mc.bGQUW_FIrF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  420e543b708d ("Revert "drm/amdgpu: stop scheduler when calling hw_fini (v=
2)"")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/3oulqhfug7Mc.bGQUW_FIrF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHd9UAACgkQAVBC80lX
0GznJgf7BWs3GghUehCsRvtjggUp7s32E3awmti1IFXUVtMApOr0WkEJzZJ/1Mob
fFdO910yB1GA55fOS4qKUDFIrldPwdf/PQr+OwFCzGWQXh9GNTSlDCCJ3mKoQwy9
SexKsfmBojZ3//vb7yJN1VhiWXLlnMeLpzmfUOvAbWbXWgFtduLN/jOcocnjaHMQ
9pXrT3cBrC3cpBXlTPxJNo0K1rZLZtqnSfRBv0I2bzpc1zVPOn9wckuD1GfCXnr1
f1bKXJ+5heqn0l1RcVqg36tPC1AY+DkigBZFoQ9zsczPEtMdorGVtXa8FuUCL0N+
6WXzivfiBZ/Td5OWGJVfznIPMyZy5g==
=dCyv
-----END PGP SIGNATURE-----

--Sig_/3oulqhfug7Mc.bGQUW_FIrF--
