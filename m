Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792D348B8C4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244068AbiAKUmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbiAKUl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:41:57 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEF6C06173F;
        Tue, 11 Jan 2022 12:41:57 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JYN0F6kl2z4xmx;
        Wed, 12 Jan 2022 07:41:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641933711;
        bh=yq+/dnA+ItMpfCTHJZDB+Ogmt6oelxd4pb0RcNcbpzE=;
        h=Date:From:To:Cc:Subject:From;
        b=M6/DtQhbD7UQYda5yzKV7evwDx1Wv8HD6m+LqaSjkb6CN3EfDgbkI/zCUDGKpzMYA
         V72VSKeMfqeRWEQYs0aTkXEBu/28pqmPx2ue3CFuPXxBUkbtilUkd2SF2Ln5HWVNFZ
         ZpY6VYgWgRUMKdiymAnlg3JZEz+cYFl9ZwXzagWxsxB0LIIOPGSESjPexsaAGE7vRp
         x98WhQ33fhcjYnqhGJK9F+LZmdDx0R/sVu43xO8KVEXY+ePSWjcohxV3+9j4z8gx3p
         ers1+J1w4ZmeySQMQHKWdATG6svXCXngXkAQG2ph+61eub3sCNzKk5aXMvuLUZTWbI
         PXA9HRHjYQPlw==
Date:   Wed, 12 Jan 2022 07:41:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: error fetching the arm-soc-fixes tree
Message-ID: <20220112074147.7d38bc43@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=30Ug5mcAkLId/DId9Mh2.Z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=30Ug5mcAkLId/DId9Mh2.Z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Fetching the arm-soc-fixes tree
(git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git#arm/fixes)
produces this error:

fatal: couldn't find remote ref refs/heads/arm/fixes

--=20
Cheers,
Stephen Rothwell

--Sig_/=30Ug5mcAkLId/DId9Mh2.Z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHd64sACgkQAVBC80lX
0Gy73gf/ZOk65scGtbeQGuyi8H2oMpBP0zo16OMygtwY3wau3pq3ifIAA/gQgpZS
6m5bN9wBsLt/2I0KlU+Cu4DbWtsFWBSosng8OgkWMRk4p4oa4Jht4hV33uJifasm
2q9N7hZ6/DYgbq8fpRkJzTyYp/4suKlQNsdr7vVZ9jp3S04YWG5UMmSvWaLXtu1s
4NC6rKQnwFvesK0v3TnV7agRXWO1hT8jrx7P3jNcp238YycUXBrOR3MRDUS2nTUO
AGI1PIAxjfbi/G7vHg6qMpFX6BRZmFvFhfAWaem9wlRCo9OljJtsE9FNn8qdZ3Ao
JUjPDn1HwKHp117OS3H0MLwoav7cPw==
=kb7I
-----END PGP SIGNATURE-----

--Sig_/=30Ug5mcAkLId/DId9Mh2.Z--
