Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0412473D8E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 08:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhLNHXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 02:23:53 -0500
Received: from inva021.nxp.com ([92.121.34.21]:41188 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230000AbhLNHXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 02:23:49 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 33C0820001E;
        Tue, 14 Dec 2021 08:23:48 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ED9D7200CF8;
        Tue, 14 Dec 2021 08:23:47 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id B16D44057A;
        Tue, 14 Dec 2021 00:23:46 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v3 00/10] lx216x DTS updates
Date:   Tue, 14 Dec 2021 01:23:32 -0600
Message-Id: <20211214072342.22692-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some accumulated updates for lx2160/lx2162 SoC and boards.

v2 updates:
- Dropped duplicated "arm64: dts: lx2160a-qds: enable sata nodes"
- Removed binding patches which are applied in fsl-soc tree
- Enables optee-tz in the missing lx2162a-qds board
- added new patches "arm64: dts: lx2162a-qds: add interrupt line for RTC node"
- added new patches "arm64: dts: lx2162a-qds: enable CAN nodes"

v3 updates:
- Dropped "arm64: dts: lx2162a-qds: enable CAN nodes" merged
- Added new "fsl,lx2160ar2-pcie" compatible and use it dts update
- Changed pcie_ep node name to pcie-ep
- Added Fixes tag for "arm64: dts: lx2160a: fix scl-gpios property name"

Biwen Li (1):
  arm64: dts: lx2162a-qds: add interrupt line for RTC node

Ioana Radulescu (1):
  arm64: dts: lx2160a-rdb: Add Inphi PHY node

Li Yang (2):
  dt-bindings: PCI: layerscape: Add LX2160A rev2 PCIe RC compatible
    string
  arm64: dts: lx2160a: update PCIe nodes to match rev2 silicon

Pankaj Bansal (1):
  arm64: dts: lx2160a-qds: Add mdio mux nodes

Pankaj Gupta (1):
  arm64: dts: lx2160a: add optee-tz node

Ran Wang (1):
  arm64: dts: lx2160a: enable usb3-lpm-capable for usb3 nodes

Xiaowei Bao (1):
  arm64: dts: lx2160a: add pcie EP mode nodes

Yangbo Lu (1):
  arm64: dts: lx2162a-qds: support SD UHS-I and eMMC HS400 modes

Zhang Ying-22455 (1):
  arm64: dts: lx2160a: fix scl-gpios property name

 .../bindings/pci/layerscape-pci.txt           |   1 +
 .../boot/dts/freescale/fsl-lx2160a-qds.dts    | 149 +++++++++++++++
 .../boot/dts/freescale/fsl-lx2160a-rdb.dts    |  21 +++
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 170 ++++++++++++------
 .../boot/dts/freescale/fsl-lx2162a-qds.dts    |  13 ++
 5 files changed, 304 insertions(+), 50 deletions(-)

-- 
2.25.1

