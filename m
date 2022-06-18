Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3794B550259
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 05:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbiFRDQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 23:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiFRDQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 23:16:38 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B666A6D181
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 20:16:37 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25I3GSln015032;
        Fri, 17 Jun 2022 22:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655522188;
        bh=zTdIw9iN79bljgaLtUEHHav7RH26oRtCIOTmQsJUuTU=;
        h=Date:From:To:CC:Subject;
        b=jDZYPLbwU/ohWcg/TGJ3wVR84PFtMNoNmsrLpqx1oAyUFL/civaieV0vC3B3bChgL
         9NSZXc6fAevsIaylSnYmdyPoXbV2eXv0TLkjakl2zoUIfL+KwjtEvyWL99zPT+Bc+7
         CUn0ZpaZzvzaHN6G+XK+DfzJbWQbXR8+wceuCxnk=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25I3GSS2045807
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jun 2022 22:16:28 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 17
 Jun 2022 22:16:27 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 17 Jun 2022 22:16:28 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25I3GRUa046331;
        Fri, 17 Jun 2022 22:16:28 -0500
Date:   Fri, 17 Jun 2022 22:16:27 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Tero Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [GIT PULL] arm64: dts: TI K3 fixes for v5.19
Message-ID: <20220618031627.xxvscc22c6doaa3t@kahuna>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bu67thgfnt2zdkmk"
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

--bu67thgfnt2zdkmk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi ARM SoC maintainers,

Please pull the following for 5.19 cycle as these fixup critical boot
failures noticed on 5.19-rc1 testing.

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3-dt-=
fixes-for-v5.19

for you to fetch changes up to 0c0af88f3f318e73237f7fadd02d0bf2b6c996bb:

  arm64: dts: ti: k3-am64-main: Remove support for HS400 speed mode (2022-0=
6-17 20:24:01 -0500)

----------------------------------------------------------------
Devicetree fixes for TI K3 platforms for v5.19

Critical fixes for the following:
* Boot failure on J721s2 (overlap GIC memory map)
* AM64 boot fails on highspeed cards (SoC characterization updates)

----------------------------------------------------------------
Aswath Govindraju (1):
      arm64: dts: ti: k3-am64-main: Remove support for HS400 speed mode

Matt Ranostay (1):
      arm64: dts: ti: k3-j721s2: Fix overlapping GICD memory region

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi   | 2 --
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--bu67thgfnt2zdkmk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmKtQ4UACgkQ3bWEnRc2
JJ3t0hAAgiIZ8GCHi/gXXVmoAV2H68nNmPsG7xfXqCfZLTf90P9IobHgMBA/fFix
PQEVOe4+YFLSM9IuEtq0Bz1RgF31ckW98ZvsWWH+Oo5sACyr1TrIpbXo3lwGLUIH
7VkJDr/xHwMRdOxuAqru/7WgJxtoS72xUwySImkldUM8IfPbRP2w/g5ZbGiNzLR/
CV0Dsb4TNHhvyJ7ARQ/Q/xCaH6OmopgMJ4LuTdQl77FEXSwBg4+dntq5nxFKCz3d
/RjitmUOalOZWSajWyMEnBSNCAv1Jx2HRxIb89TOVrhU+j4xSiV/LJFA5zamRU55
DZIAwVtYrtJ1NN2p8aN1YJx/sqaVsCMZXIuKvRflOOL2koMmWa1LxrNB7e6/1BUb
s3gLnUmwEaWR2e0L0C4WG4mAgMvP9EBgw9Smn0hsZyPA1wHh8JogtR264xMYIAnd
GJaBqAaXrMCMghjek8LVQUkDyMgYCli20n+898vKHr9F3ru/YY9wGmJSLPr1hksU
m4zD4FPOGtOfOURu6CMZpYvRoaYPMui7zUKXgQd9GFgaxoyXiHz2WZF6dke5XPEB
0FkJmMCnvi3+8MGjgbjPK44A0hE/dYb/EI+enm+2GwuTu+/Iyu0cnJXCuMEqJPyQ
9p44Im2N+fXN5h8K4l7r8htBvBUGqL5/X++oy0PlgnPjojpCSeU=
=vabo
-----END PGP SIGNATURE-----

--bu67thgfnt2zdkmk--
