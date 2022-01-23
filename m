Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4406249757D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 21:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240042AbiAWU2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 15:28:04 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:42241 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239722AbiAWU2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 15:28:03 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jhl6n0zK2z4xcF;
        Mon, 24 Jan 2022 07:28:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642969681;
        bh=eYNGmPU6PXILWtNM4ANHpXx96IbVfYKSd0bqdtxx2fg=;
        h=Date:From:To:Cc:Subject:From;
        b=bILo7eoQsziL4LJB3O9/y1+GPAFxwEm/jKFBOmWH0wm8LbPcayQ3gKXXkHoPTbVma
         WlLeYLrTYnAKtzQ9ulfDhw8diC5SpFcZrNtHpfTC7wqE8Utm2WiKnTZ4aWNu3xAFmu
         wzEHOs4RLO05b2O9dG9kdA/skgAcal8QjXP03lCuxArnO3jqtssuEudGF90EP7Atm0
         09WzljLHJxqQR4An5/VZKSRcV9oqtg8fs8vXxXho81DAOYred2APB3PScpqkIpTOuP
         hL+N5Yu0UAvz4xUsK4FynMqUOQLOkACskw3ug4q5Emba4loBaSeJuDnIc9ziDPgcxL
         SP7YcdKW6tj5w==
Date:   Mon, 24 Jan 2022 07:28:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tags need some work in the mtd-fixes tree
Message-ID: <20220124072800.14c492a5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/O6UNn/M2Ub3eiT.=UXs_3VD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/O6UNn/M2Ub3eiT.=UXs_3VD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  2b3d77cb5ce3 ("mtd: parsers: qcom: Fix kernel panic on skipped partition")

Fixes tag

  Fixes: 803eb12 ("mtd: parsers: Add Qcom SMEM parser")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed in the futrure by setting core.abbrev to 12 (or more)
    or (for git v2.11 or later) just making sure it is not set (or set to
    "auto").

In commit

  7815173a7ccb ("mtd: rawnand: ingenic: Fix missing put_device in ingenic_e=
cc_get")

Fixes tag

  Fixes: 15de8c6 ("mtd: rawnand: ingenic: Separate top-level and SoC specif=
ic code")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed in the futrure by setting core.abbrev to 12 (or more)
    or (for git v2.11 or later) just making sure it is not set (or set to
    "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/O6UNn/M2Ub3eiT.=UXs_3VD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHtulAACgkQAVBC80lX
0GysBwf/YZj6d57CPKZt6KLnmIvkHZmVrZINSP5UNZ3IY5xqdxFKi9QPNY/qRszF
LEpfktX0Imx3qp5Yt53xLH9o8rAYiGXyW689INbftSoLGr7lUgE31Be/gEd6OkhT
UNjxV8J4X8C+Velbu2mff2UAHTOkmTYE47jWMNpSiIwbG0J9+VIbDx9L6LxnL1QF
NA8hn95CppK8YjyfVauX8CkK/pfMOCUtVEB1mG6dbojkcC1tM+FePwt/YSPBX+E7
FtJyuTKttXmo00d5yeZtj1TapXHngZylRKhYbwWvYCV60ZsgNKBEDb0+fV3gsAVJ
/n2Q/kqueDxEEmxOtx6tS5fOEdQ6BA==
=9jYZ
-----END PGP SIGNATURE-----

--Sig_/O6UNn/M2Ub3eiT.=UXs_3VD--
