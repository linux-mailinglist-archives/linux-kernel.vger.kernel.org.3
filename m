Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A8D4BED2F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 23:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbiBUW0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 17:26:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbiBUW0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 17:26:00 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CFD023BE4;
        Mon, 21 Feb 2022 14:25:35 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.88,386,1635174000"; 
   d="scan'208";a="111174654"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 22 Feb 2022 07:25:35 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id AA60C400A8A2;
        Tue, 22 Feb 2022 07:25:33 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH] soc: renesas: Kconfig: Explicitly select PM and PM_GENERIC_DOMAINS configs
Date:   Mon, 21 Feb 2022 22:24:50 +0000
Message-Id: <20220221222450.5393-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly select PM and PM_GENERIC_DOMAINS configs for ARCH_R9A07G044
and ARCH_R9A07G045 configs. PM and PM_GENERIC_DOMAINS configs are
required for RZ/{G2L,V2L} SoC without these configs the SMARC EVK's
won't boot.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/soc/renesas/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 90f4f98be29c..57b6292b46a3 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -293,11 +293,15 @@ config ARCH_R8A774B1
 
 config ARCH_R9A07G044
 	bool "ARM64 Platform support for RZ/G2L"
+	select PM
+	select PM_GENERIC_DOMAINS
 	help
 	  This enables support for the Renesas RZ/G2L SoC variants.
 
 config ARCH_R9A07G054
 	bool "ARM64 Platform support for RZ/V2L"
+	select PM
+	select PM_GENERIC_DOMAINS
 	help
 	  This enables support for the Renesas RZ/V2L SoC variants.
 
-- 
2.17.1

