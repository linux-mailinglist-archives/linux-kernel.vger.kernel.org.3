Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2F74D2331
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350405AbiCHVUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbiCHVUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:20:54 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378FA4C791;
        Tue,  8 Mar 2022 13:19:57 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KCpBL2DH4z4xYy;
        Wed,  9 Mar 2022 08:19:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646774395;
        bh=BJhkJe4LYs9pxm71zcYYsUcXFCJRkTAxHcVlmOvy4FQ=;
        h=Date:From:To:Cc:Subject:From;
        b=GE8CDYOek//QOHsPTu53CNjkXO8coI+IHAKymEz2BLm44qxjpIVR6KFIXaX4rWuNT
         3P2ck31TpIXSb+o2W5OqKuLvv+3ngVXDsxFMgOArkFSVfg2+B4gN/ArGlxxwMjEl+f
         uZHO0Fl8V2V/oEmDohkFwMfgj7cLHwy1Ty+XnvWTrIsIcxYFA6bjAggN7i9kUP8Ouz
         0jHQhUi9q+TGx+dj4jKLQTGVXPKm/YaLlYuGNQCg1+1pEUeoDZV6BF2kPx8l8PMJE7
         lFc0PrtFyqUJOt0cBU7x3/dJ8xns+QPPRU3YeITHyzvuB0verf7MRAtDwygg7hpSM4
         O0QhcEWPK1JLA==
Date:   Wed, 9 Mar 2022 08:19:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the arm-soc tree
Message-ID: <20220309081953.49930b56@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_hnHC+ddFvuB7KUZqACfo/2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_hnHC+ddFvuB7KUZqACfo/2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  c953c764e505 ("arm64: dts: ns2: Fix spi-cpol and spi-cpha property")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/_hnHC+ddFvuB7KUZqACfo/2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmInyHkACgkQAVBC80lX
0GxjvAf/ds4FnsqgKybXCwpNBWsS2B8xf3FLWbxj3foQHi5NnuR1Tkl2aU54fwJp
4W4vEKZwihSXbnP+gsYZD2ZX2e13cp2mqTioUy4w7uAiowtvx9BlLZNVozfCmkav
ISKhh3IWMOoyA5dwDy06HlRwVGvrIs8UTx5ehXhPYnIT21mdZA4DlGlnGLGk6ccx
8oiKx+Xo8e4S1z5jJZs4EfKex6EOReLqNcEgOkr/GJKDdeZpcYJ3ovilCRexQ7pv
9iRKr91tZVMAjxyvqklUEKmOAb6unpGn/0gNp76OCqOjq+bFW2hZ1PNq1THDWoKQ
6u0PkVNCHtFkUV01PLc7uwpWZTsGWA==
=Kp3y
-----END PGP SIGNATURE-----

--Sig_/_hnHC+ddFvuB7KUZqACfo/2--
