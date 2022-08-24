Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64625A041B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 00:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiHXWhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 18:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiHXWhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 18:37:08 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094B95725F;
        Wed, 24 Aug 2022 15:37:07 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 71CEB1A13D8;
        Thu, 25 Aug 2022 00:37:06 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 33C731A13D3;
        Thu, 25 Aug 2022 00:37:06 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id D8FA84060A;
        Wed, 24 Aug 2022 15:37:04 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 00/11] accumulated dts updates for ls1043a
Date:   Wed, 24 Aug 2022 17:36:51 -0500
Message-Id: <20220824223700.32442-1-leoyang.li@nxp.com>
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

Hou Zhiqiang (2):
  arm64: dts: ls1043a: Add SCFG phandle for PCIe nodes
  arm64: dts: ls1043a: Add big-endian property for PCIe nodes

Laurentiu Tudor (2):
  arm64: dts: ls1043a: add missing dma ranges property
  arm64: dts: ls1043a: use a pseudo-bus to constrain usb and sata dma
    size

Li Yang (7):
  arm64: dts: ls1043a: fix the wrong size of dcfg space
  arm64: dts: ls1043a: Enable usb3-lpm-capable for usb3 node
  arm64: dts: ls1043a: use pcie aer/pme interrupts
  arm64: dts: ls1043a: make dma-coherent global to the SoC
  arm64: dts: ls1043a: add gpio based i2c recovery information
  arm64: dts: ls1043a-qds: add mmio based mdio-mux support
  arm64: dts: ls1043a-rdb: add pcf85263 rtc node

 .../boot/dts/freescale/fsl-ls1043a-qds.dts    | 173 +++++++++++++++++-
 .../boot/dts/freescale/fsl-ls1043a-rdb.dts    |  10 +
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 131 +++++++------
 3 files changed, 256 insertions(+), 58 deletions(-)

-- 
2.37.1

