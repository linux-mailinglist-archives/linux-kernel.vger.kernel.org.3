Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE881485F89
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 05:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiAFEKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 23:10:15 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:48387 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiAFEKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 23:10:14 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JTtDN3fjjz4xd4;
        Thu,  6 Jan 2022 15:10:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641442212;
        bh=Ved6JHdmzhtZe5QjKz9X6ODAkx9dqx1to5coknU5gdk=;
        h=Date:From:To:Cc:Subject:From;
        b=Uwj77FXqfXLH3HbsO3/ufvHvTCHnOJXk1MddT+beRtdhO3WNZt1NtZe2EP01aF6iZ
         w8P9/tvLX/PiKy9EW9+SqGWjv1CDZd5go8gAlDGKlL+4nCG7IQIjBy1rKSqSAsCVto
         JEImhtXaI5Bjo4JnHYZ/N/lkP6XfdhareHo290gXzddNp0NJydsr+5FgT8uMX9yevY
         SbzgNgAHBYaTmJi9vCjfwhoaflLLszrBTpH5UfaLvW4UM0q5hkFFPYjWyDhQYI8q6x
         fg6z3H9Fx98/mnLIJV1FpR5GHgFB9dsRwth7PDheBLabUe/1piKPWO7QPnHECKMOa6
         ck4DAIdaKNYGw==
Date:   Thu, 6 Jan 2022 15:10:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: please clean up the keys tree
Message-ID: <20220106151010.500e4f83@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8MBV+HpNehm5g+O9jpIX3OM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8MBV+HpNehm5g+O9jpIX3OM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

All the commits in the keys tree
(git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git#keys-n=
ext)
are also in Linus' tree as different commits.  Please clean that up as
it is causing merge conflicts against later work.

--=20
Cheers,
Stephen Rothwell

--Sig_/8MBV+HpNehm5g+O9jpIX3OM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHWa6IACgkQAVBC80lX
0Gy9kAgAi8L+l7i56isbP6GaPUpJpoYNea+b/MlrO1Uf3c8CwbNWws2ypFvv1A7y
YZ1qmc+bCWo4yqa5ca0ia+9k5hWq7oJ5ZQxvVun74MZn+XGx5trq3t2LdIWd9vz4
FGQ/Js/hOyx8+O1L2zlWaHYrOjT9g0TxBYdVsMRcI+oTqp+U/OoZRPzZA7hBQbah
VdVRlyKp0iRpTjZPzg5Os/rt0gGIAUWXB2K9hcq+a2r2LGgisqH+NkUlwd4mZma4
oI9ALV3oz+Fmxo08o0R/oQ34R3vtzT55HvrEr3PAcHanlM406VPrHwi7ggkrVvBH
zpfZKgadHTphi9kJCCrC7b/cCKABgA==
=zHbj
-----END PGP SIGNATURE-----

--Sig_/8MBV+HpNehm5g+O9jpIX3OM--
