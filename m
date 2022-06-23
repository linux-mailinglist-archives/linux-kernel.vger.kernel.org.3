Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFED5577E5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiFWKai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiFWKae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:30:34 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0B674A3D5;
        Thu, 23 Jun 2022 03:30:32 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,215,1650898800"; 
   d="scan'208";a="123880673"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 Jun 2022 19:30:31 +0900
Received: from renesas-ubuntu18.ree.adwin.renesas.com (unknown [10.226.92.226])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 547E84008550;
        Thu, 23 Jun 2022 19:30:28 +0900 (JST)
From:   Chris Paterson <chris.paterson2@renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Paterson <chris.paterson2@renesas.com>
Subject: [PATCH] arm64: dts: renesas: r9a07g054l2-smarc: Correct SoC name in comment
Date:   Thu, 23 Jun 2022 11:30:24 +0100
Message-Id: <20220623103024.24222-1-chris.paterson2@renesas.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This dts is for the RZ/V2L SMARC EVK, not RZ/G2L.

Fixes: f91c4c74796a ("arm64: dts: renesas: Add initial device tree for RZ/V2L SMARC EVK")
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts
index 4e07e1a0fb66..3d01a4cf0fbe 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 /*
- * Device Tree Source for the RZ/G2L SMARC EVK board
+ * Device Tree Source for the RZ/V2L SMARC EVK board
  *
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
-- 
2.36.1

