Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D1D4A6AA8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 04:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244125AbiBBDyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 22:54:47 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:60659 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiBBDyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 22:54:45 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JpSby3XcCz4xmk;
        Wed,  2 Feb 2022 14:54:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643774079;
        bh=rOdpgfwxBrrg3yCRnMxYGoMM5bPf74GDyrgN3LV50g8=;
        h=Date:From:To:Cc:Subject:From;
        b=f3OFpiL9yefyKCxe0B7AMbMe/v6CwE+o0/qtdlA+BQTqrmgO69kjd8FBrpE01ml0W
         jvfDDr8iE+D3ti3XFAkB3amIofAEjaxZveeMlcKdR8DoDY7bIAVGjMp7BmHq95+Gxz
         rhfQH+gvmyEqm23XJj6UdTkMfOngKp3YEsv2ohXNz2GpEm+5EKpgJvcfYDWWxWjNTE
         Ju4eoIdq+9qin69+JU10nUkzJ4f1jT3hFfK6Bm1R3yb/GFGKBf5dPeEpcnFbgk9ZKI
         sHnQcEnGQRfhtX+2asYDaFWnGl3SSOCZwEqKlzE1YbR5DR/r42fsgEjJ/cowtmD/hQ
         wvMerLssdTnzQ==
Date:   Wed, 2 Feb 2022 14:54:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Huang Ying <ying.huang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20220202145437.2dd20b71@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hiV3eRe=RAgS/CCgJSNTtx=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hiV3eRe=RAgS/CCgJSNTtx=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/admin-guide/sysctl/kernel.rst:603: WARNING: Malformed table.
Text in column margin in table line 2.

=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
0x0 NUMA_BALANCING_DISABLED
0x1 NUMA_BALANCING_NORMAL
0x2 NUMA_BALANCING_MEMORY_TIERING
=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Introduced by commit

  49ec6eb41c49 ("NUMA balancing: optimize page placement for memory tiering=
 system")

--=20
Cheers,
Stephen Rothwell

--Sig_/hiV3eRe=RAgS/CCgJSNTtx=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmH6AH0ACgkQAVBC80lX
0Gxmdgf6A4TMxUS6Al/8dxIWm/8fMpJ6Gs9LhB4osVKbvq/k2moyd6kH7yjdBmcy
bllfPuVMC3aTmOhCDSN3oHG+/fj3g4JNbj7ZB1YXLyvsAOUNDiFW9KxyZFg9rKQQ
QJdjd7ezZMuykBtv2gifT847Mctn0yYB1Dteyqf6uFBYsF9X3MrmqeVUQNqoU8nD
C/MoEflhumELEwvoPB8kl8CF+6K4BTZ7U0aYSOrts4f7U/lG5aPZx9ipL4C0T1pO
SCSr2GfWbOyAb2TJL1jQ/xRq8vHMC5lWCsJ72VT1BTiXmOAZbWUwvGQMRJCIS+hT
UyX+hkwphYNZ48dBwoOLPSLuZI8igA==
=4Sd+
-----END PGP SIGNATURE-----

--Sig_/hiV3eRe=RAgS/CCgJSNTtx=--
