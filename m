Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B139E56C542
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239264AbiGHX1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 19:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239113AbiGHX1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 19:27:20 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED333C142
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 16:27:19 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 268NRAUa048679;
        Fri, 8 Jul 2022 18:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657322830;
        bh=qIbjL05PQMumEnQYc+oAO4pidbgefASidT5Db2Pp2zM=;
        h=Date:From:To:CC:Subject;
        b=e0xOF+UmbP7r9YJlr2KnLgTG5EihiborfSakLH0wuuyZSaF/ctE2PF1nbwh95LnFs
         rdooHSY2KqnQhrIDNv9qBlARXbMQx0Dj7cVrrTIdmzqrjWaHV7/AKKZVHngLPOa4eP
         Bb2Bk5Ez8bwnPdz5jMeh6MRJ0BcwhhFUzo59b2WU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 268NRAJW050899
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jul 2022 18:27:10 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 8
 Jul 2022 18:27:09 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 8 Jul 2022 18:27:09 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 268NR9RM112793;
        Fri, 8 Jul 2022 18:27:09 -0500
Date:   Fri, 8 Jul 2022 18:27:09 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Arnd <arnd@arndb.de>, Olof <olof@lixom.net>, SoC <soc@kernel.org>
CC:     <arm@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/3] ARM: dts: TI K2 updates for v5.20
Message-ID: <20220708232709.rrpzbrpv7jbipyym@eldest>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ea6yopqo7hq57gmy"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ea6yopqo7hq57gmy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi ARM SoC maintainers,

Please pull

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-keysto=
ne-dt-for-v5.20

for you to fetch changes up to 3ea73bf02225ad433e7cfbf8427b08aa8c593775:

  ARM: dts: keystone: Adjust whitespace around '=3D' (2022-06-17 20:24:35 -=
0500)

----------------------------------------------------------------
Keystone2 device tree updates for v5.20

* Whitespace cleanups.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      ARM: dts: keystone: Adjust whitespace around '=3D'

 arch/arm/boot/dts/keystone-k2e-netcp.dtsi  | 26 +++++++++++++-------------
 arch/arm/boot/dts/keystone-k2e.dtsi        |  6 +++---
 arch/arm/boot/dts/keystone-k2g-netcp.dtsi  |  2 +-
 arch/arm/boot/dts/keystone-k2g.dtsi        | 18 +++++++++---------
 arch/arm/boot/dts/keystone-k2hk-netcp.dtsi | 12 ++++++------
 arch/arm/boot/dts/keystone-k2hk.dtsi       |  4 ++--
 arch/arm/boot/dts/keystone-k2l-netcp.dtsi  | 18 +++++++++---------
 arch/arm/boot/dts/keystone-k2l.dtsi        |  8 ++++----
 arch/arm/boot/dts/keystone.dtsi            | 18 +++++++++---------
 9 files changed, 56 insertions(+), 56 deletions(-)

--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--ea6yopqo7hq57gmy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmLIvUUACgkQ3bWEnRc2
JJ0Zwg//SLRdliH3Iqad1C2OSP/SdfXLNvZtr+E9wCNGkYxWTYyx8WOuHXmztCNb
CKh95k5xucLAdOnvaG8fyQnYHqSYKO1YBi0N2WQudEEmt1Gp4x9JfkqNWpfkOzym
5WRysmyHWBWbqf2Nf2+L5DXiepS8L0lnaQEqrquEP9oEcCe8fcwW3nOsTI2CQ29r
gJ7/d/hWgNhvokSSC94XyVCvyWH0Kn33FgMfjKY5zJxvYFxIw47JHuqKEh9gGlsW
ufrHyuQD1kCmhnG9chJ1KUciRU/n91MxXdZKls+KSAUHydkNsDX+skLcA6POwGH7
TuKYqFYpRX0G3OKxtoo7qTj/tfWAetOa+zp+YmzFY/57c4mb/CKZms/LBPFN4FIz
iNaabJGLHZ4ynTZQ9GLgbOrP9gLfgwPkts6NUQstOZkpZkgKM7z7N5xw3vmvGH/5
VoOjPLQ3amHb9F09kE4tm1o8T8sbvJIqphkQTqu+cGcHgCqEyCY0mgQGjw0iRppS
VC4Kf5OLE2gkk5QcQkmb6o2lu5kspLicza4Q+5QGbVZziWqvv8EuTojZF/+qecWQ
x5d02xrcKZu3yrpbElxRozRZhfXO/988SYw4GAcr1+i/xmwLauQ0BdDUjj5wAAdx
SSSMpwn32BQNlTH9A9p25EJjvz7nS6QBwsjXHS6cjK3nRlKNZbo=
=iuhX
-----END PGP SIGNATURE-----

--ea6yopqo7hq57gmy--
