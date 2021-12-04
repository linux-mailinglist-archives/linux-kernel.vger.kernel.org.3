Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5D8468110
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 01:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383655AbhLDAUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 19:20:49 -0500
Received: from inva021.nxp.com ([92.121.34.21]:54142 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383639AbhLDAUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 19:20:48 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5DC90200B67;
        Sat,  4 Dec 2021 01:17:23 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1ED0D200B50;
        Sat,  4 Dec 2021 01:17:23 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 60F244030F;
        Fri,  3 Dec 2021 17:17:22 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 0/8] ls1028a device tree update
Date:   Fri,  3 Dec 2021 18:17:10 -0600
Message-Id: <20211204001718.8511-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some accumulated ls1028a dts changes from the SDK.  Also included two
binding updates needed for these dts changes.

v2 updates:
- Rebased to v5.16-rc1
- Spinned off binding changes
- Removed optee enabling patch 
- Dropped "arm64: dts: ls1028a-qds: enable optee node" as the board
  doesn't support optee

Alex Marginean (1):
  arm64: dts: ls1028a-qds: add overlays for various serdes protocols

Biwen Li (4):
  arm64: dts: ls1028a: add ftm_alarm1 node to be used as wakeup source
  arm64: dts: ls1028a: add flextimer based pwm nodes
  arm64: dts: ls1028a-rdb: enable pwm0
  arm64: dts: ls1028a-qds: move rtc node to the correct i2c bus

Li Yang (1):
  arm64: dts: ls1028a-rdb: reorder nodes to be alphabetic

Vabhav Sharma (1):
  arm64: dts: ls1028a-qds: enable lpuart1

Xiaowei Bao (1):
  arm64: dts: ls1028a: Add PCIe EP nodes

 arch/arm64/boot/dts/freescale/Makefile        |  16 +++
 .../dts/freescale/fsl-ls1028a-qds-13bb.dts    | 113 +++++++++++++++
 .../dts/freescale/fsl-ls1028a-qds-65bb.dts    | 108 +++++++++++++++
 .../dts/freescale/fsl-ls1028a-qds-7777.dts    |  82 +++++++++++
 .../dts/freescale/fsl-ls1028a-qds-85bb.dts    | 107 ++++++++++++++
 .../dts/freescale/fsl-ls1028a-qds-899b.dts    |  75 ++++++++++
 .../dts/freescale/fsl-ls1028a-qds-9999.dts    |  79 +++++++++++
 .../boot/dts/freescale/fsl-ls1028a-qds.dts    |  39 ++++--
 .../boot/dts/freescale/fsl-ls1028a-rdb.dts    |  98 +++++++------
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 130 +++++++++++++++++-
 10 files changed, 794 insertions(+), 53 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-65bb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-7777.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-85bb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-899b.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-9999.dts

-- 
2.25.1

