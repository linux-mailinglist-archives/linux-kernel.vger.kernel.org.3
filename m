Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0524792D3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239911AbhLQR2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:28:47 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53932 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239897AbhLQR2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:28:46 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BHHSbXr074651;
        Fri, 17 Dec 2021 11:28:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639762117;
        bh=RbHCEK8mCjW5Pm8yz76jfET1YGxxHey+QfmYZXEPjsk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ycpBociEFayGx9hj1tFLjYpYy1yyKvQsa1xYqjWzMvd3D4nl5UtKNPv5vuMCjz17w
         1OpyRlGK3YLIKJglLsfIw044TiCyReMn7ytIuuPpqmlNgz5YGadHFpTOj7jRndglZm
         zB5R/MJUQKJSRNuxz8QmqVo6sSO7y8OG38Hah2fA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BHHSb9l075653
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Dec 2021 11:28:37 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 17
 Dec 2021 11:28:36 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 17 Dec 2021 11:28:37 -0600
Received: from uda0132425.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BHHSVcF076735;
        Fri, 17 Dec 2021 11:28:34 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, SoC <soc@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, <arm@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [GIT PULL 2/2] arm64: dts: TI K3 updates for v5.17
Date:   Fri, 17 Dec 2021 22:58:06 +0530
Message-ID: <20211217172806.10023-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217172806.10023-1-vigneshr@ti.com>
References: <20211217172806.10023-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please pull the device tree changes for TI K3 platforms for v5.17.

Please note:
This adds a dtbs_check warning due to missing YAML binding for pinctrl-single compatible.
There also a checkpatch error for complex macro usage in dt-bindings
header defining pinmux marco which is harmless.


The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3-dt-for-v5.17

for you to fetch changes up to effb32e931dd4feb8aa3cee7b5b4ddda43c8b701:

  arch: arm64: ti: Add support J721S2 Common Processor Board (2021-12-13 23:21:22 +0530)

----------------------------------------------------------------
Devicetree changes for TI K3 platforms for v5.17 merge window:

* New Platforms:
  - J721s2 SoC, SoM and Common Processor Board support
* New features:
  - CAN support on AM64 EVM and SK
  - TimeSync Router on AM64
* Fixes:
  - Correct d-cache-sets info on J7200
  - Fix L2 cache-sets value for J721e/J7200/AM64
  - Fixes for dtbs_check warnings wrt serdes_ln_ctrl node on J721e/J7200
  - Disable McASP on IoT2050 board to fix dtbs_check warnings

----------------------------------------------------------------
Aswath Govindraju (8):
      arm64: dts: ti: am654-base-board/am65-iot2050-common: Disable mcan nodes
      arm64: dts: ti: k3-am64-main: Add support for MCAN
      arm64: dts: ti: k3-am642-evm/sk: Add support for main domain mcan nodes in EVM and disable them on SK
      dt-bindings: arm: ti: Add bindings for J721s2 SoC
      dt-bindings: pinctrl: k3: Introduce pinmux definitions for J721S2
      arm64: dts: ti: Add initial support for J721S2 SoC
      arm64: dts: ti: Add initial support for J721S2 System on Module
      arch: arm64: ti: Add support J721S2 Common Processor Board

Christian Gmeiner (1):
      arm64: dts: ti: k3-am64-main: add timesync router node

Faiz Abbas (3):
      arm64: dts: ti: k3-am65-mcu: Add Support for MCAN
      arm64: dts: ti: k3-j721e: Add support for MCAN nodes
      arm64: dts: ti: k3-j721e-common-proc-board: Add support for mcu and main mcan nodes

Jayesh Choudhary (1):
      arm64: dts: ti: iot2050: Disable mcasp nodes at dtsi level

Kishon Vijay Abraham I (2):
      arm64: dts: ti: j7200-main: Fix 'dtbs_check' serdes_ln_ctrl node
      arm64: dts: ti: j721e-main: Fix 'dtbs_check' in serdes_ln_ctrl node

Nishanth Menon (4):
      arm64: dts: ti: k3-am642: Fix the L2 cache sets
      arm64: dts: ti: k3-j7200: Fix the L2 cache sets
      arm64: dts: ti: k3-j721e: Fix the L2 cache sets
      arm64: dts: ti: k3-j7200: Correct the d-cache-sets info

Peng Fan (1):
      arm64: dts: ti: k3-j721e: correct cache-sets info

 Documentation/devicetree/bindings/arm/ti/k3.yaml       |   6 +
 arch/arm64/boot/dts/ti/Makefile                        |   2 +
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi               |  36 +
 arch/arm64/boot/dts/ti/k3-am642-evm.dts                |  40 +
 arch/arm64/boot/dts/ti/k3-am642-sk.dts                 |   8 +
 arch/arm64/boot/dts/ti/k3-am642.dtsi                   |   2 +-
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi     |  20 +
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi                |  30 +
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts         |   8 +
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi              |   2 +-
 arch/arm64/boot/dts/ti/k3-j7200.dtsi                   |   6 +-
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts  | 155 ++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi              | 198 +-
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi        |  28 +
 arch/arm64/boot/dts/ti/k3-j721e.dtsi                   |   6 +-
 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts | 421 +++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi             | 937 ++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi       | 302 +++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi           | 175 ++
 arch/arm64/boot/dts/ti/k3-j721s2.dtsi                  | 189 ++
 include/dt-bindings/pinctrl/k3.h                       |   3 +
 21 files changed, 2565 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2.dtsi
