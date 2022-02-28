Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193D74C6BD2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbiB1MIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbiB1MIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:08:13 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DB16393
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:07:21 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21SC7CgO063928;
        Mon, 28 Feb 2022 06:07:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1646050032;
        bh=6Tao1zcdP9BNLg7KbFrt9/eMRui2cABSBVkwtBMq2zY=;
        h=Date:From:To:CC:Subject;
        b=vYmO0EmQh1MwfBgKCIYDkld9jsEFbho1T0MIqkoqV7LaEEnZ7RlKg9uBCCkF7Unu/
         9qQ+bmQvNLjCqdmFlKUMhY7ZyT8A1HfCiVCexOSEHenQpmbVHNT/jnCj/JEa41UHnj
         FqnctjKExlgX7fPhXoatylILVV7TK85v8YVSz69Q=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21SC7CIV082070
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Feb 2022 06:07:12 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 28
 Feb 2022 06:07:11 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 28 Feb 2022 06:07:11 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21SC7B2L035473;
        Mon, 28 Feb 2022 06:07:11 -0600
Date:   Mon, 28 Feb 2022 06:07:11 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Tero Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [GIT PULL 3/3] TI K3 device tree updates for v5.18
Message-ID: <20220228120711.xdburehxs5gnwxko@capacity>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sqodd6rh2ja7ngpy"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--sqodd6rh2ja7ngpy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi ARM SoC maintainers,

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3-dt-=
for-v5.18

for you to fetch changes up to a033588ec66bffd6cb51f946b2e998a9f9bf598d:

  arm64: dts: ti: Add support for AM62-SK (2022-02-28 05:34:43 -0600)

----------------------------------------------------------------
TI K3 device tree updates for v5.18

Since (ti-k3-dt-fixes-for-v5.17):
Fixes:
* Cleanups for flash nodes across K3.
* gic-v3 backward compatible registers
* j721s2 interrupt parent fixup for wakeup GPIO

New:
* AM62 SoC and AM62-SK board
* wdt support for am64

----------------------------------------------------------------
Aswath Govindraju (2):
      arm64: dts: ti: k3-j721s2: Move aliases to board dts
      arm64: dts: ti: k3-j721s2-common-proc-board: Alias console uart to se=
rial2

Christian Gmeiner (1):
      arm64: dts: ti: k3-am64-main: Add RTI watchdog nodes

Hari Nagalla (1):
      arm64: dts: ti: k3-am64: Add ESM0 to device memory map

Keerthy (1):
      arm64: dts: ti: k3-j721s2-mcu-wakeup: Fix the interrupt-parent for wk=
up_gpioX instances

Matthias Schiffer (1):
      arm64: dts: ti: k3-am65*: Remove #address-cells/#size-cells from flas=
h nodes

Nishanth Menon (7):
      arm64: dts: ti: k3-am65: Fix gic-v3 compatible regs
      arm64: dts: ti: k3-j721e: Fix gic-v3 compatible regs
      arm64: dts: ti: k3-j7200: Fix gic-v3 compatible regs
      arm64: dts: ti: k3-am64: Fix gic-v3 compatible regs
      arm64: dts: ti: k3-j721s2: Fix gic-v3 compatible regs
      dt-bindings: arm: ti: Add bindings for AM625 SoC
      arm64: dts: ti: Add support for AM62-SK

Pratyush Yadav (2):
      arm64: dts: ti: k3-*: Fix whitespace around flash@0 nodes
      arm64: dts: ti: k3-*: Drop address and size cells from flash nodes

Suman Anna (1):
      dt-bindings: pinctrl: k3: Introduce pinmux definitions for AM62

Vignesh Raghavendra (1):
      arm64: dts: ti: Introduce base support for AM62x SoC

 Documentation/devicetree/bindings/arm/ti/k3.yaml   |   6 +
 arch/arm64/boot/dts/ti/Makefile                    |   2 +
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi           | 267 +++++++++++++++++=
++++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi            |  36 +++
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi         |  41 ++++
 arch/arm64/boot/dts/ti/k3-am62.dtsi                | 105 ++++++++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts             | 206 ++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am625.dtsi               | 103 ++++++++
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi           |  23 +-
 arch/arm64/boot/dts/ti/k3-am64.dtsi                |   4 +
 arch/arm64/boot/dts/ti/k3-am642-evm.dts            |   4 +-
 arch/arm64/boot/dts/ti/k3-am642-sk.dts             |   4 +-
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi |   2 -
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi           |   5 +-
 arch/arm64/boot/dts/ti/k3-am65.dtsi                |   1 +
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts     |   8 +-
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi          |   5 +-
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi        |   4 +-
 arch/arm64/boot/dts/ti/k3-j7200.dtsi               |   1 +
 .../boot/dts/ti/k3-j721e-common-proc-board.dts     |   4 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          |   5 +-
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts             |   2 -
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi        |   4 +-
 arch/arm64/boot/dts/ti/k3-j721e.dtsi               |   1 +
 .../boot/dts/ti/k3-j721s2-common-proc-board.dts    |  14 +-
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi         |   5 +-
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi   |   4 +-
 arch/arm64/boot/dts/ti/k3-j721s2.dtsi              |  23 +-
 include/dt-bindings/pinctrl/k3.h                   |   3 +
 29 files changed, 836 insertions(+), 56 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-sk.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625.dtsi

--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 8=
49D 1736 249D

--sqodd6rh2ja7ngpy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmIcuukACgkQ3bWEnRc2
JJ1PRw//bpjBL12JTn1cJIwm0LeTavnY6/M2uev/hZv4mNCw1pumX2ZQhkig/+cC
BQDjBXfOpqXDsDTEvXUbmH4S6l1KtSXVz/tcbGP9vGls94CU59ypjjuWvmIrjZvL
31hVZ9rrzKOkq28w+uMpKQVae1hLi4oLg954clmCR6UaGfcJLGawzHmPiya3kwd1
7h7It4QiRY/n868mv44TqHLjsWbgYjphfdy1Cn31psIpfLam5hQds++eSfxorS0b
CdAhBQ5IqsumZ/DyzKMypKBVx+oqK43Novx2qKctCLYq+wezStcdS6BVIhPisAVp
taFj12vItroEd7H/Jv+y+9SPE7aTTRkBh/Rm4gHGdYUs5SFzgU31UpUHpT5LpHzg
asJXOgI5A+RUSwrWIYqWVHD35JQCBYtOGPq7a8HXpcXKy0pCYghy+WAWCv7Xxbcn
ESJingNNYyrbvpLf5Qw8AOAwydvW6vqDGYr/rb5k7aiU6Uzm681DtaxFiciyiMDf
YUR7OyGqt/05nSiO1ScLSY9Z3aElUx1KOpynAKW0x2g4J44UTgWSVzHjtONRtprv
xuX/xSgRqLld0ZIliuLJaWFdGn/XebefyIhzPPnjUm2nHT0Cd+nC0uWOHkomyn0k
1kTYhKi1LdiJ2Mb9L2lc+58rWWTnPlY6LSdPB5jv4NcuwrjVbxc=
=VuNv
-----END PGP SIGNATURE-----

--sqodd6rh2ja7ngpy--
