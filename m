Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B11477B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240637AbhLPSfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:35:14 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:41599 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbhLPSfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:35:13 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JFLQ80cwdz4xbd;
        Fri, 17 Dec 2021 05:35:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639679712;
        bh=eeDb7MVD5BBDokKe3UUl3Pb5UOkmbP8LeT7a4juWWs8=;
        h=Date:From:To:Cc:Subject:From;
        b=U48YSo0lmn2AgRqmyKUoobWB6P2VT6wKnp2ImYwrsYW2ViAsI7ydBk2oobyIU/9k9
         e0yYnRvBol6ddX3ivjSXjlg4KEjXuCwTkqYhvCOkHof6QL/wc3ynx0EWsoI0QKDSmT
         x3Rvbu3YNgrm8zOFZ3C3D0yNQBoK8MziHp2pqePJHXHZdMVD3Is2b9yG1pXsIO/xt7
         /MQR9Faa75uF6B0j5xeYfSh1AcHhtlh/ZfSjbanmf4+cMrk1M9syv0EbY5UFd3wP4Y
         PYV9T+Knyyl4QFe5Q3vMnwsENQ8GvBwzlDOj1i9dkjPFwu8OUbNCXKLi8QX/wivful
         F7rkE2W9R6LNg==
Date:   Fri, 17 Dec 2021 05:35:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the ksmbd tree
Message-ID: <20211217053511.45b50bc9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SINDbU3jXbiYT.DmfInM_tQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SINDbU3jXbiYT.DmfInM_tQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  4ff2d94444b2 ("ksmbd: fix uninitialized symbol 'pntsd_size'")
  2ac388a188ae ("ksmbd: fix error code in ndr_read_int32()")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/SINDbU3jXbiYT.DmfInM_tQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG7ht8ACgkQAVBC80lX
0Gz6WQgAmlP6ka8jgTA+hCgGUoSlh0T9uYkO5TWcQQ9uV+p3mBeTuwt2nndZF+wF
ONKjzuKUSNR+Jdf58EbsRWU1LVGI2l8LU2I08KHrh+mNyYvNgKphoV6xVF5I18B6
Abl0988FylUK3B2kz8ntraiQQavK8kW/3Sy3f+RGoQGNoOCPBU9qNTA4IkDR0QZC
6/zTOpm8q6HTPmWrHexc88nnhSa2dsZ+m/4zP1jAykWrczW29iZBcxq7LccbjRiv
M7sV9s6wGjZMmXa3X9+JgkUilgdV8JhP6ZYSEmh0xWkRC6EsuLjDbkEHXM+d00kP
q3JvSq3Q/bOU0hVmysEq/RlGKQQGmw==
=wwGP
-----END PGP SIGNATURE-----

--Sig_/SINDbU3jXbiYT.DmfInM_tQ--
