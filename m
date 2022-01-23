Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E498E49757A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 21:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240062AbiAWUYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 15:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239824AbiAWUYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 15:24:34 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7271FC06173B;
        Sun, 23 Jan 2022 12:24:29 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jhl2d2RvLz4xNp;
        Mon, 24 Jan 2022 07:24:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642969465;
        bh=7wjl80U+njEwMXV1/vX38G0FRHWH79agiKblFR7hqQg=;
        h=Date:From:To:Cc:Subject:From;
        b=hUyaysxZ88jg2szAgcYnD65m/zV3eE5FR0UDRSvN85k9Kq/S5o4mApcx4HjRZlbyo
         /bDFsZ1QtqxjNMoreZ9UZQYqURkWXTwxy/r3UW6oelXaOFBsvxvqtqbjvV9WJ7tLLs
         tKK3Kx0zMWbm5HnM+TCth/2D3FBK60VR51NCophWyup8V/bquteBZCZxZU48zGS2uV
         Zh6oD9HNWXlWi+oQnQ0bkyr2GJXj8FnAHB1ukBJfZ0dX3zp3zchs50YBQl5P5lpGr2
         kV8sSiT6Ogq95jTwf5iROtBvrBkxgDgwqwtkMWxJqPNF9CMJ3DLIfNUq/LIzfYYwVq
         YVkQn9WMvgx5w==
Date:   Mon, 24 Jan 2022 07:24:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the phy tree
Message-ID: <20220124072422.3cf483a1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Vxe92CtCaC60/oFCKTMHL=p";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Vxe92CtCaC60/oFCKTMHL=p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  760e61025158 ("phy: ti: Fix "BUG: KASAN: global-out-of-bounds in _get_max=
div" issue")

Fixes tag

  Fixes: 091876cc35 ("phy: ti: j721e-wiz: Add support for WIZ module presen=
t in TI J721E SoC")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed in the future by setting core.abbrev to 12 (or more) or
    (for git v2.11 or later) just making sure it is not set (or set to
    "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/Vxe92CtCaC60/oFCKTMHL=p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHtuXYACgkQAVBC80lX
0Gxc6Af6AnsUiPCEyKIQljdINcAq4R2b93Idc3uG8KMEGb9kJOj5Bqd+wwhYX5ZK
gy1yRObFETBrplhgPBKZamL7sti5G3r8CC/OXPW32HoRxCdQyNqQH4UlDChP0zgA
WtF4w5g/d66x9FW/SSHyXzRrtp2CEob7juUvMFj4HPTPZJ1T+p57fgprIpolWpBL
ZRBEkSjimoKPfx8gGXyFFF9BThKBetFrD4jjyRiViNQUFY8Cae+4x1Iliovp4PLf
CWUdjU6mOulGeEiSnVCL3+5/tXU1ZUOqWRzKRyEZBzae4CpYoa9zLsYR8dRMkOal
XzdNWEKjAByTl6bRAfJ5Hyntm873Pg==
=4WcS
-----END PGP SIGNATURE-----

--Sig_/Vxe92CtCaC60/oFCKTMHL=p--
