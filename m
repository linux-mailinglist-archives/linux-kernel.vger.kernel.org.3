Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0ED448A6B1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 05:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347440AbiAKEIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 23:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiAKEIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 23:08:50 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F62BC06173F;
        Mon, 10 Jan 2022 20:08:50 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JXxyR3L1Pz4y4c;
        Tue, 11 Jan 2022 15:08:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641874128;
        bh=AUuXzaLZAhyKaIShQ1tVhL+TJ7Ty1V/fGkqASMoF3GY=;
        h=Date:From:To:Cc:Subject:From;
        b=EGcjZr61k1SCAcptEzunnd2ky7oq39+ptpIEh0OvTjBVIHEP0Le3AidcyENPue5IC
         maUZ23JZAAKl4AkqjTatzdLRKHb+wrApTANoZ4aL33I866wYXlCLOGTleTlykp25do
         iS8jctowqf4Glx4OW6Oijown2qdhcm4Mo0ksIux79CfAJC4hQCLPM93NcS+/blwjkq
         u6SOejj3jfXOnOloRgY80Sd2rePLQRJVyk5QWfAT+6AOIFiKkrlLY2k9ps6GvY7VW4
         Y8/mPozRUv5DwZRQmeLFB3LgmroqTq1M2zTqviYA1skoHoQllBfQrfOu3h70gPTT4h
         QhfWjfxsf0Jug==
Date:   Tue, 11 Jan 2022 15:08:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jiri Kosina <jikos@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Jiri Kosina <jkosina@suse.cz>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Subject: linux-next: manual merge of the trivial tree with the jc_docs tree
Message-ID: <20220111150846.563d051f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=0JOdCy1tHQ+jqPMkcyuvsQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=0JOdCy1tHQ+jqPMkcyuvsQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the trivial tree got a conflict in:

  Documentation/process/submitting-patches.rst

between commit:

  6c5ccd24ff17 ("Remove mentions of the Trivial Patch Monkey")

from the jc_docs tree and commit:

  081c8919b02b ("Documentation: remove trivial tree")

from the trivial tree.

I fixed it up (it was just an empty line difference, I used the latter)
and can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/=0JOdCy1tHQ+jqPMkcyuvsQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHdAs4ACgkQAVBC80lX
0Gzc7ggAphwnAjkzJ55fag9g5mOUbUI8JERKoIO4Ttm8kLjBBl3451v4xFyakr4v
r3AI/XOijuFbCKQzHh91aJN7HJK4cKLjigyDPoe27n/80W4JPbHNXZlEKKDqiYrH
miOMycni91DZVtc89CX8t6RVJBHMgZQ94FsGJbn3PxoyOOFINyZZovGvkmJecGo6
SRQIbuIuZPAfV8gSI38VkXlRy/b/hDUTaC0Iwgg6K6LybQwOg4wOj8+Rqd/LhA2k
L2gv5z1V+Guzp8OR90Gv4gucbSkh+wbtNsPdEVDrjghjWKOzKHrynKA17d43YTHF
Vliw/7OZ+2k0CZWRWP4OD6ghZY5f3w==
=DGOX
-----END PGP SIGNATURE-----

--Sig_/=0JOdCy1tHQ+jqPMkcyuvsQ--
