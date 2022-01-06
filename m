Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32849486BC9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244183AbiAFVUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbiAFVT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:19:59 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D9DC061245;
        Thu,  6 Jan 2022 13:19:59 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JVK4X6S8Fz4xnF;
        Fri,  7 Jan 2022 08:19:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641503997;
        bh=VDBZJEo81/pglaTKBkfMIXSstc11WSE6wtBZjTJ1LcM=;
        h=Date:From:To:Cc:Subject:From;
        b=fgkoT75Ymos3uklv6ou51D0n0NBiEvtY0wm9ygJLn+LrAvAYoU/59Vp7dDavTqOsw
         k0eQzlXoDmDe/9bklV4s73PDmfW0u7Ama+0sEDvQLbq6GENQTDl6TVHyKAIudMNTN8
         +8Dh1jitmZgcEeaAbVYEUwqwQdoH20UlsmA2Tssf1EHUoIvPFoY1UBPlKoKFeorknH
         gQCm1+4UODIrtUpQ0TRipHjcah0Jg9Jncu/8Ft/3FqG5Nx1eMmknvYjtwNIDxARj+F
         ZCbUgqqij6y8hrYjwnTcrhj68Olt1pGsQNFTZYuHtedYqeWtFkXdmgoP6xlarmlWMb
         O7+h3vMxQzQIQ==
Date:   Fri, 7 Jan 2022 08:19:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Miaoqian Lin <linmq006@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the bluetooth tree
Message-ID: <20220107081955.3b003103@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Mb.0v=3sKEf7d+oE2NBZn/T";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Mb.0v=3sKEf7d+oE2NBZn/T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  6845667146a2 ("Bluetooth: hci_qca: Fix NULL vs IS_ERR_OR_NULL check in qc=
a_serdev_probe")

Fixes tag

  Fixes: 77131dfe ("Bluetooth: hci_qca: Replace devm_gpiod_get() with devm_=
gpiod_get_optional()")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/Mb.0v=3sKEf7d+oE2NBZn/T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHXXPsACgkQAVBC80lX
0Gx4CQf/SRHArc+5FFAa4CRO5RytpmGGEfQ+p3iXtK9dOF644SMlDabqjl3Sa5um
PF/sP6wU2mKe33v1zWOQZZ0uxYphDpHIU56rSsUVQMYeCBCaBWcmkhXuM783amoN
q7UpgtJ4VH8XktQFCyWga988BST7ka9seLb4bCox2UrhiO8lahFc/bJXnyv1vCGs
3BP1VWyA2Pq0/9sFc9gPpqF7JRkogulH8wDdAOBeENyrfOud2RRCGcJhsweREWZc
de2CE91K8WPLP31is/kzA63jbEfhZwDdovF4S1h6qHkzZi791nwAkg50uhp3rCPo
rcFmn10RMlXPTlJwb2Q/Dfx17DjcIA==
=npeN
-----END PGP SIGNATURE-----

--Sig_/Mb.0v=3sKEf7d+oE2NBZn/T--
