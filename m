Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D0B56C57A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238731AbiGHX1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 19:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237520AbiGHX1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 19:27:14 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB65419BB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 16:27:12 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 268NQtSp059322;
        Fri, 8 Jul 2022 18:26:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657322815;
        bh=+bm3Wh1/TDP6a3e59S4Ynn5UhkVTq89RAIYkfdv0mkY=;
        h=Date:From:To:CC:Subject;
        b=Qo0rFyjzMv1E+wWw90kEN8hPGJjXhoKgszuD2E0cZxMvCyBEQGM3C+A3pOHCxL3k3
         7u2OIT3oiCVXSn83deHx0FPpXQaIAnmRD/cZXNkQ7p6cGOHEU068L0rt7tdm4wjqL5
         eKmGU9hB3/rAx2Ohn5eqfGIkYGfZGPLSsRZuHbDk=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 268NQtvo122764
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jul 2022 18:26:55 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 8
 Jul 2022 18:26:55 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 8 Jul 2022 18:26:55 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 268NQtku112567;
        Fri, 8 Jul 2022 18:26:55 -0500
Date:   Fri, 8 Jul 2022 18:26:55 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Arnd <arnd@arndb.de>, Olof <olof@lixom.net>, SoC <soc@kernel.org>
CC:     <arm@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/3] TI SoC driver updates for v5.20
Message-ID: <20220708232655.reqjdbib52ejdja4@unadvised>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ay7qkbfwj2qln4rf"
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

--ay7qkbfwj2qln4rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi ARM SoC maintainers,

Please pull

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-driver=
-soc-for-v5.20

for you to fetch changes up to f16afe238a7ff3c71a943cf74392538974c29b22:

  soc: ti: pruss: Enable support for PRUSS-M subsystem on K3 AM62x SoCs (20=
22-07-06 19:34:45 -0500)

----------------------------------------------------------------
TI Driver updates for v5.20

* pruss: Enable support for AM62, bindings cleanups
* wkup_m3_ipc: cosmetic cleanup

----------------------------------------------------------------
Kishon Vijay Abraham I (3):
      dt-bindings: soc: ti: pruss: Re-arrange "compatible" in alphabetic or=
der
      dt-bindings: soc: ti: pruss: Update bindings for K3 AM62x SoCs
      soc: ti: pruss: Enable support for PRUSS-M subsystem on K3 AM62x SoCs

Yang Li (1):
      soc: ti: wkup_m3_ipc: Remove unneeded semicolon

 Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 5 +++--
 drivers/soc/ti/pruss.c                                 | 1 +
 drivers/soc/ti/wkup_m3_ipc.c                           | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--ay7qkbfwj2qln4rf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmLIvTgACgkQ3bWEnRc2
JJ1dSg//WDPjB2UiAEo8F7eh3WTgsW1vngaKgHX4++rhyE1QjpSsFRrvGH0bWUXp
niRg0fiZ1UEkCkXZ7ZvGKIrol+UfQtjXSLo4jv3/y+wETlqAjDAiEV6Rk1B6J9WT
ipdcU3fe+dBMncFFbLkA0gYC3NhtLLdwysi7E2aOf5Hf1HmQxAmRnlLDTNfPKXWA
L6jCoHy13RBUW1YU9xxeYEaWBJdCDWqPCkqXuZ8CxoWwQjmsQAgi0zm5Pew7rJ8c
qDpaA9fWwv9ck/eRtrgvHT5CqH4WIPiXFLdg3qiPhqKLypvSnl5aoSbbVFDmoapA
y7Q91MLdo1Wbm5J5Rp14mmuk1ls7z5hqI02z8K8/lSHKSEqAp25U61qnUojgz9MM
3CjoPkzFIbdBvZE4rALPH+PH4WUTHNeGY2jQ5aIucjVxRMpYa65MHcKm2Oaf9oNo
Dil2f0bFKa0vVXV4qwI3iXDbtoNYpvvKuOrJgo1KLmbXU4nwGkY/G6H4nfV5Py9g
eKcQ1G+uR2Qjjc/LEdPGLUVvs9ZgjPBAaiHH2zItCA6Sj0DsI2gfsXEUq1pDvCOR
NbjL0UgUz9qfqB+sdW94bemGvBTvQTP/EPPGDHlInwz2HS2rtMuX3T+hxkKkrx4N
4S1GuViC+GfOeJdzQQV9PaTnoyVCb2b7p/EonQFVdLbJBOeMQ4E=
=twhQ
-----END PGP SIGNATURE-----

--ay7qkbfwj2qln4rf--
