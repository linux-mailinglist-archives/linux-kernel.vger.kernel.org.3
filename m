Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1282597834
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241701AbiHQUoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241638AbiHQUoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:44:11 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFD9AA3C3;
        Wed, 17 Aug 2022 13:44:09 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C14AB1A0211;
        Wed, 17 Aug 2022 22:44:07 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BBC031A0256;
        Wed, 17 Aug 2022 22:44:06 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 77DBB4060D;
        Wed, 17 Aug 2022 13:44:04 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 0/6] ls208xa dts updates
Date:   Wed, 17 Aug 2022 15:43:51 -0500
Message-Id: <20220817204357.21753-1-leoyang.li@nxp.com>
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

Some accumulated dts updates for NXP ls208xa SoC family.

v2 Updates:
- Cleaned up patch descriptions
- Updated node names to use - instead of _

Biwen Li (1):
  arm64: dts: ls208xa-rdb: fix errata E-00013

Li Yang (3):
  arm64: dts: ls2080a-qds: add mdio mux nodes from on-board FPGA
  arm64: dts: ls2088a-qds: add mdio mux nodes from on-board FPGA
  arm64: dts: ls2080a-rdb: add phy nodes

Pankaj Bansal (1):
  arm64: dts: ls208x: remove NXP Erratum A008585 from LS2088A.

Priyanka Jain (1):
  arm64: dts: ls2081a-rdb: Add DTS for NXP LS2081ARDB

 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/fsl-ls2080a-qds.dts    |  69 +++++++++
 .../boot/dts/freescale/fsl-ls2080a-rdb.dts    |  68 +++++++++
 .../arm64/boot/dts/freescale/fsl-ls2080a.dtsi |   4 +
 .../boot/dts/freescale/fsl-ls2081a-rdb.dts    | 131 ++++++++++++++++++
 .../boot/dts/freescale/fsl-ls2088a-qds.dts    |  68 +++++++++
 .../boot/dts/freescale/fsl-ls208xa-rdb.dtsi   |   2 +
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi |   3 +-
 8 files changed, 344 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls2081a-rdb.dts

-- 
2.37.1

