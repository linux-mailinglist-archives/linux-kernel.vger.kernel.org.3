Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF9A507D3F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 01:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354561AbiDSXpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 19:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243010AbiDSXps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 19:45:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86B4205EF;
        Tue, 19 Apr 2022 16:43:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KjgMy38VVz4xNm;
        Wed, 20 Apr 2022 09:42:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650411775;
        bh=J7MkUMhWQdU5+xYSe/nobBFT2dwUOTLlJX16ZJ5gCZ8=;
        h=Date:From:To:Cc:Subject:From;
        b=DGSZuOWZM8pCiYTIENJ0+s6W1KftyaOAof61s/j2aB0TyVlAm0by7Pud090LGTSrE
         sNmC6HGYoXcAG0Vv7yccphUoiWSvKu2KYHR0iyVodEdy6NklxJpwJh1hhO5q2O+d4Z
         qynJMnBl3mQ+BPSbmgfa18YodD//89wO/jAmE+D8K27EsfvPZA7rVAqoPuf8qr85UM
         Ne1GIZ3q6o+IpR+wVjL4Ih43JO0/R4qbZwM6uXarQ3RfB/AzE1lzNxddLJXvg1INV9
         2sfVUEjtVTwa1WyCAt7wFKW4yxDGMciB6qtxEdYa/ggcLpnbmbspDrQXbQxm4Zbf+z
         quVc/yQoGro0A==
Date:   Wed, 20 Apr 2022 09:42:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the arm-soc tree with the
 samsung-krzk-fixes tree
Message-ID: <20220420094253.2300b293@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DKp=N4C.Lgr+UUxrN6C=uKa";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DKp=N4C.Lgr+UUxrN6C=uKa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in:

  arch/arm/Kconfig

between commit:

  436ce66003d5 ("ARM: s3c: mark as deprecated and schedule removal")

from the samsung-krzk-fixes tree and commit:

  8c1fb11b8a77 ("ARM: s3c: enable s3c24xx multiplatform support")

from the arm-soc tree.

I fixed it up (I used the latter version of this file and added the
following merge fix patch) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 20 Apr 2022 09:38:18 +1000
Subject: [PATCH] fixup for "ARM: s3c: mark as deprecated and schedule remov=
al"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/arm/mach-s3c/Kconfig.s3c24xx | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c/Kconfig.s3c24xx b/arch/arm/mach-s3c/Kconfig.=
s3c24xx
index d7dc031abc7a..f151a6f6d89e 100644
--- a/arch/arm/mach-s3c/Kconfig.s3c24xx
+++ b/arch/arm/mach-s3c/Kconfig.s3c24xx
@@ -6,7 +6,7 @@
 # Copyright 2007 Simtec Electronics
=20
 menuconfig ARCH_S3C24XX
-	bool "Samsung S3C24XX SoCs"
+	bool "Samsung S3C24XX SoCs (deprecated, see help)"
 	depends on ARCH_MULTI_V4T || ARCH_MULTI_V5
 	depends on CPU_LITTLE_ENDIAN
 	select ATAGS
@@ -22,6 +22,11 @@ menuconfig ARCH_S3C24XX
 	  (<http://www.simtec.co.uk/products/EB110ITX/>), the IPAQ 1940 or the
 	  Samsung SMDK2410 development board (and derivatives).
=20
+	  The platform is deprecated and scheduled for removal. Please reach to
+	  the maintainers of the platform and linux-samsung-soc@vger.kernel.org if
+	  you still use it.
+	  Without such feedback, the platform will be removed after 2022.
+
 if ARCH_S3C24XX
=20
 config PLAT_S3C24XX
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/DKp=N4C.Lgr+UUxrN6C=uKa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJfSP0ACgkQAVBC80lX
0GyrfQgAmh9MwcpRZSHBxgz5bDaAiL1XEFj1XQWe4T82DJXjOhdKQbuc4TiI7O36
VXbLplS5ORqO9zhujJY/q5GJFYvcSa8nqm0JpETG0WroIfji2gvnqyH5s43gKDu4
8JKCRKBnIElh1VFh9ubr6OEmlOCDLMkKby87P/UitNKfhpCbvxSuhxTC/ETFUh+6
cxDMgv7EN4GT7AQLfqGdDw0/hmSOgDkGfdmUGJwjhI3kibNeGBzn8QeyKKYQ8tDT
gGHAgUtA5GcgbIhdNsjd2oaJOSgFBWrqkaNg7f4IOyP4kwcXzeYc/Brt8ahy6t+v
kgmNREgR2nn4GEipEBCUvtTwhJ5r1w==
=DlxJ
-----END PGP SIGNATURE-----

--Sig_/DKp=N4C.Lgr+UUxrN6C=uKa--
