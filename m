Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2724FB05E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 23:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242629AbiDJVry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 17:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241131AbiDJVrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 17:47:52 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DDC65F0;
        Sun, 10 Apr 2022 14:45:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kc5Bl1RT9z4xQq;
        Mon, 11 Apr 2022 07:45:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649627135;
        bh=3hD96S4rSglqd8+81oM0O3Vm+2qDgPKjF42FNs0aZG0=;
        h=Date:From:To:Cc:Subject:From;
        b=PX0JLZj5J4eSlnR7v2GikrNw+CYbB1nBiLNaed0cPkGfey4X8qF1QWe0azBAADxsX
         sLi9Kqv9ffkvXeulTcP7jZCu06UtEPqdX4WWGjpnhCa72CGmVZJjPD2SXN4e/j6u8M
         sdoZhpuTT/E6sis5v577VBa1L9ye/GWpNMNF0wafpidkeI3GwMJjaU5q62LZCOci3F
         erxEIkWABSvgJak3uS/ecrGYZuK8AWb85MIAHHS44E/zs/SYOWRE5l8FtLi8Ae4nFw
         /mhCP3Mj69dLC0ugV5qln+jaRky8j3EhbMsIAZ34QLokRHoBH8x0qTrEbhOiA99z5L
         iYCl1vYwDg06Q==
Date:   Mon, 11 Apr 2022 07:45:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the rockchip tree
Message-ID: <20220411074534.719cd324@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uGsLD1l3l=miSOr_uzcCPWz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uGsLD1l3l=miSOr_uzcCPWz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  e0badfe359ef ("ARM: dts: rockchip: rename pcfg_pull_default node name on =
rk3036")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/uGsLD1l3l=miSOr_uzcCPWz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJTT/4ACgkQAVBC80lX
0Gzfggf+Km4cN2P99g2DxkEtxm/CJuV0tugqtuwKaMw6alKW2RYaoEeA0a6bilIJ
8RxPoeH813iOx/4X1CJa9f8Lcnt3UGFNpr68YzMMpbgM9PoKIATbSmiDuPJT+AG1
Qt15kRsqwavnmdBtgxnDmlZXEGaFhyi4Rowdc+PrABv7QegohdVCYtcjxjvNm251
vTKFeArn6UhSDQP1Or4PrGn4K7EjO3hDuNA5wg7nSYJrmzPEQuxDKniufMepJRSx
vo2HA6ANtVdsy3Xbt+8anmjbpF2Wt978u69foj0GVdPv/8NbFlzPKDyOfO/IG04R
+ES7aTDcAN/SSqSqUjwNXnHceAc3zA==
=vXvU
-----END PGP SIGNATURE-----

--Sig_/uGsLD1l3l=miSOr_uzcCPWz--
