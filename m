Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BD759317A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243091AbiHOPQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242139AbiHOPQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:16:17 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B029A11812;
        Mon, 15 Aug 2022 08:16:14 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,238,1654527600"; 
   d="scan'208";a="129579718"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 16 Aug 2022 00:16:14 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 459F540108F7;
        Tue, 16 Aug 2022 00:16:10 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Conor Dooley <Conor.Dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 4/8] RISC-V: Kconfig.socs: Add Renesas RZ/Five SoC kconfig option
Date:   Mon, 15 Aug 2022 16:14:47 +0100
Message-Id: <20220815151451.23293-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce SOC_RENESAS_RZFIVE config option to enable Renesas RZ/Five
(R9A07G043) SoC, along side also add ARCH_RENESAS config option as most
of the Renesas drivers depend on this config option.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* No Change
---
 arch/riscv/Kconfig.socs | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 69774bb362d6..91b7f38b77a8 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -80,4 +80,18 @@ config SOC_CANAAN_K210_DTB_SOURCE
 
 endif # SOC_CANAAN
 
+config ARCH_RENESAS
+	bool
+	select GPIOLIB
+	select PINCTRL
+	select SOC_BUS
+
+config SOC_RENESAS_RZFIVE
+	bool "Renesas RZ/Five SoC"
+	select ARCH_R9A07G043
+	select ARCH_RENESAS
+	select RESET_CONTROLLER
+	help
+	  This enables support for Renesas RZ/Five SoC.
+
 endmenu # "SoC selection"
-- 
2.25.1

