Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481D14680F3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 00:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383572AbhLCX6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 18:58:21 -0500
Received: from inva021.nxp.com ([92.121.34.21]:58008 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354388AbhLCX6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 18:58:20 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 52ED02001BB;
        Sat,  4 Dec 2021 00:54:54 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1AEAB20017F;
        Sat,  4 Dec 2021 00:54:54 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 5DB5C40007;
        Fri,  3 Dec 2021 16:54:53 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 00/10] lx216x DTS updates
Date:   Fri,  3 Dec 2021 17:54:36 -0600
Message-Id: <20211203235446.8266-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some accumulated updates for lx2160/lx2162 SoC and boards with two
missing binding updates being used already.

v2 updates:
- Dropped duplicated "arm64: dts: lx2160a-qds: enable sata nodes"
- Removed binding patches which are applied in fsl-soc tree
- Enables optee-tz in the missing lx2162a-qds board
- added new patches "arm64: dts: lx2162a-qds: add interrupt line for RTC node"
- added new patches "arm64: dts: lx2162a-qds: enable CAN nodes"
	

Biwen Li (1):
  arm64: dts: lx2162a-qds: add interrupt line for RTC node

Ioana Radulescu (1):
  arm64: dts: lx2160a-rdb: Add Inphi PHY node

Kuldeep Singh (1):
  arm64: dts: lx2162a-qds: enable CAN nodes

Li Yang (1):
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

 .../boot/dts/freescale/fsl-lx2160a-qds.dts    | 149 +++++++++++++++
 .../boot/dts/freescale/fsl-lx2160a-rdb.dts    |  21 +++
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 170 ++++++++++++------
 .../boot/dts/freescale/fsl-lx2162a-qds.dts    |  21 +++
 4 files changed, 311 insertions(+), 50 deletions(-)

-- 
2.25.1

