Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F745977EA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241878AbiHQUZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241882AbiHQUZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:25:54 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D767A925D;
        Wed, 17 Aug 2022 13:25:52 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3055B1A0237;
        Wed, 17 Aug 2022 22:25:51 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C2A901A0233;
        Wed, 17 Aug 2022 22:25:50 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 834EE4060D;
        Wed, 17 Aug 2022 13:25:49 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v4 0/2] lx216x DTS updates
Date:   Wed, 17 Aug 2022 15:25:36 -0500
Message-Id: <20220817202538.21493-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

v4 updates:
- Dropped patches from v3 that have been merged

Li Yang (1):
  arm64: dts: lx2160a: update PCIe nodes to match rev2 silicon

Xiaowei Bao (1):
  arm64: dts: lx2160a: add pcie EP mode nodes

 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 156 ++++++++++++------
 1 file changed, 108 insertions(+), 48 deletions(-)

-- 
2.37.1

