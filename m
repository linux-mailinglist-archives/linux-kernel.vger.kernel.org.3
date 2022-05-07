Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE8451E88B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 18:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386277AbiEGQil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 12:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386208AbiEGQih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 12:38:37 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0E318378
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 09:34:50 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 247GYZsr111500;
        Sat, 7 May 2022 11:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651941275;
        bh=Hur27LN4fekLufj1k16EnyuF+7Y01NJ48WB1vYzscoU=;
        h=Date:From:To:CC:Subject;
        b=tXiML59uN5LW6pw2muk8PTW7+B1plviyQQwwtu3r5HFX7DEWEB7EWuhWunXpFMsCz
         b1jYoWtoUpMmdEEXHjnuY0/Z+U2vuYpzz/UixyM3aQkk+hQo3aFbhIq19R5BlVuPDp
         a60BB+QTflfPXsfndOJH+vxM/dt53FeJRIVP1ZPE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 247GYZHE028615
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 7 May 2022 11:34:35 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sat, 7
 May 2022 11:34:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sat, 7 May 2022 11:34:35 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 247GYZvu059962;
        Sat, 7 May 2022 11:34:35 -0500
Date:   Sat, 7 May 2022 11:34:35 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/2] ARM: dts: TI K2 updates for v5.19
Message-ID: <20220507163435.tcg46cacwqhe7n64@busily>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vqftsuyxs5fplaqg"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--vqftsuyxs5fplaqg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi ARM SoC maintainers,

    Please pull:

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-keysto=
ne-dt-for-v5.19

for you to fetch changes up to 6273a1864d437553ab4220d1abc010c5bb758ad2:

  ARM: dts: keystone: Fix missing fallback and case in SPI NOR node compati=
ble (2022-04-22 13:48:38 -0500)

----------------------------------------------------------------
Keystone2 device tree updates for v5.19

* Cleanups for SPI NOR / flash

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      ARM: dts: keystone: Align SPI NOR node name with dtschema
      ARM: dts: keystone: Fix missing fallback and case in SPI NOR node com=
patible

 arch/arm/boot/dts/keystone-k2e-evm.dts  | 4 ++--
 arch/arm/boot/dts/keystone-k2g-evm.dts  | 2 +-
 arch/arm/boot/dts/keystone-k2g-ice.dts  | 2 +-
 arch/arm/boot/dts/keystone-k2hk-evm.dts | 4 ++--
 arch/arm/boot/dts/keystone-k2l-evm.dts  | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--vqftsuyxs5fplaqg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmJ2n44ACgkQ3bWEnRc2
JJ0tFhAAqPLkuqmvJv1Y4utKl8Hpa4Pst3VI9H1+bVnz5tDwWzUSx+4a1zQLxgcv
ZcJkRTgMhlG8zGIzevGNErnVkbLmuqzdP/VNWNfsLN4ed/bxpMzMwg3DhUi/fyRg
ZpotfG3Rut/F5U/AGgY0Qx/r02pRdXudoOLCsX8ZK+if05y4me6uk0CYc5oep2hD
bTE/qAE04aCPhfUxSt6qULnj5vgITB7+EP2cDqLm6vpE+0pnu+zAYoLNsbv5jN9v
pBmVNemnr62nPOOwfLfUT3130tnkA5wvKEdBGQDfBdoDuJBqBbQ0epaDFoyncUxr
pJh2C2Y+Gs97G/04YiyADyalSmVBbe+CFOY6By+cYPBbOOkYdNY1etjdpGi1QaM1
Uf1e7EGCZHOPlkouby9M1mmxx8ep1C2kkwELJXuv1YpPRcb/0hEclGViLs9J47v8
LvEB4du31SqUiN0bs7z77OEUdgI8Fc9MzxziKaOmTHNwIkAHDTFMBhEHsBjZJes4
oiKxT6Pm+V87rFfe6z5JuGitjVBv8G/tNXW13ZsHo4dKI9UdjmZuGv0sKL2yTlvg
dTuQlTMlLC36Ax4fbSFBlluPOs0QDs9WGut+uVGrnGzu0spKInX0RIQ18m7FeHrg
7nDm0peVFbzu3G/2tIXQT6K9fVsJvDIXrAjtFmla+y/lLuQciX4=
=GYEt
-----END PGP SIGNATURE-----

--vqftsuyxs5fplaqg--
