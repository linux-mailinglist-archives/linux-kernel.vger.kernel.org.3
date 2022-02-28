Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542BF4C6BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbiB1MIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236275AbiB1MH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:07:58 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B030366AEC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:07:18 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21SC6uwu088786;
        Mon, 28 Feb 2022 06:06:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1646050016;
        bh=xsy/5NJoGwHmtrLksi7cIa7ZqU2/SzM/kUJsmFAq4nQ=;
        h=Date:From:To:CC:Subject;
        b=PYX5Jp4f0FypET08TuLZH0RAstflL5djO9gW1FrvBaJN5k9zt+Qe+7zm5HLUBrm5s
         tpjITpYJ8/s48QXXKbNfsI2lGqFVTPRGwG92U2+r8ydOEPIC2VOIjwa6OGm1qE/Izb
         6+WvArZqpQnnYEzQXVbTAcWdPsuaBaws0l3l2IRA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21SC6u1C053355
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Feb 2022 06:06:56 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 28
 Feb 2022 06:06:55 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 28 Feb 2022 06:06:55 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21SC6txV081800;
        Mon, 28 Feb 2022 06:06:55 -0600
Date:   Mon, 28 Feb 2022 06:06:55 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Arnd <arnd@arndb.de>, Olof <olof@lixom.net>, SoC <soc@kernel.org>
CC:     <arm@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>, <nm@ti.com>
Subject: [GIT PULL 1/3] TI SoC driver updates for v5.18
Message-ID: <20220228120655.wobd72acngl2bz6k@ecard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4udoj2hk2odz47n5"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--4udoj2hk2odz47n5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi ARM SoC maintainers,

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-driver=
-soc-for-v5.18

for you to fetch changes up to c65d68e7e95a39da31d64d67d5bea6550b91fb43:

  soc: ti: k3-socinfo: Add AM62x JTAG ID (2022-02-28 05:35:19 -0600)

----------------------------------------------------------------
TI Driver updates for v5.18

* Fixups for k3-ringacc, smartreflex, tisci, wkup_m3_ipc
* Device detection for am62x.

----------------------------------------------------------------
Christophe JAILLET (2):
      soc: ti: k3-ringacc: Use devm_bitmap_zalloc() when applicable
      firmware: ti_sci: Fix compilation failure when CONFIG_TI_SCI_PROTOCOL=
 is not defined

Lad Prabhakar (1):
      soc: ti: smartreflex: Use platform_get_irq_optional() to get the inte=
rrupt

Miaoqian Lin (1):
      soc: ti: wkup_m3_ipc: Fix IRQ check in wkup_m3_ipc_probe

Peiwei Hu (1):
      firmware: ti_sci: inproper error handling of ti_sci_probe

Vignesh Raghavendra (1):
      soc: ti: k3-socinfo: Add AM62x JTAG ID

 drivers/firmware/ti_sci.c              |  2 +-
 drivers/soc/ti/k3-ringacc.c            | 15 ++++++---------
 drivers/soc/ti/k3-socinfo.c            |  1 +
 drivers/soc/ti/smartreflex.c           | 13 +++++++------
 drivers/soc/ti/wkup_m3_ipc.c           |  4 ++--
 include/linux/soc/ti/ti_sci_protocol.h |  2 +-
 6 files changed, 18 insertions(+), 19 deletions(-)

--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 8=
49D 1736 249D

--4udoj2hk2odz47n5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmIcutkACgkQ3bWEnRc2
JJ0Afg//efvyrkRqasngIXD0GUkUHNulYkidTLUr2VZldoqLVIgGXV2rJVjrjreU
gFbuiwGbXKv5/6EFhvxOtXzYJ7Ze4pbNzLSklZFSBJ21lERp3Hh2sJJGP+ebIYEH
68KnfzYlwbakk4H428m/zUwViTSSwc9d8UhyY7TidAP5RH/TM+bOGDjZst1P1OSB
qMdvsKAxPLKozaF+MKYr7spbf4NkWjk2MM5sDa2geKqjWzXHL2v5S5o115ebgXwC
J4GVL2RAxn3eJlYxBmYMYjmyTjvrkTXnbMhNVnqrtyAltDPODgjfeqdG7IxeegOZ
L8DhQTVbAKeKO+Q7Zk8TDEew7CIUs25lwh/9uHB5Y00WNXTHYZWrvTF70bNjvP4l
1i2BeyZ6wngvN71Fm0YnrZLIM4ZsR/ZS4UalblX2Vp3FThianf+QheJIfJPZ+rWL
NaAKxkyhIl3GTrygxqCZrORVlYrkv860fTRsbmh+kTBwfX7WF4QCKmmCula1PpIg
CbooeW5PF5Dva43ovi5mJLl5ju+T5zDX9nalzOOAF+KJEq3Jcir2Lcn8/LubyEoh
Rqu93gHH3jWXEichqdjt7EsvGGe12tXmxngm5GgsimPSBIE3PnT8nuWxCDOM2j8e
BnhUbtMUMFV5nvkTJH1raeUPdFxb2fmaXi2pxVbf2SGDL1bJfoo=
=WYZx
-----END PGP SIGNATURE-----

--4udoj2hk2odz47n5--
