Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9535A6420
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiH3Mym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiH3MyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:54:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0E5161295;
        Tue, 30 Aug 2022 05:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661864042; x=1693400042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xhkGjXxUZ6UD4DKI2S418ztKaA/H6Y24X06etHrP3/c=;
  b=hNpOa42QSRXS9d8/ZCG0QBC5FZUJOdWqq9pmNT0k/EkIEg6XQVkgTXoF
   l1NufVqme1GVyV7u8Rwg3nayF1djuiZKz/wncBhMCA2mrpQlOxy/Lmv5+
   H1ZVHMhE6rlEQ47UdG6yIeV/Fr5lB4Uug/1iChbIn/kF1VPqoG3qW9aqH
   XZS3FTv7GIAqbmLV7hFvnRWLN9phEjEsB6Wajne1beZV3Fa9rhP9pAs67
   Q8uYtf2rde8QykaUiuNIKGwaX51US5hvKr9DoJowdocrF9GshDX+TwW5X
   OekX0zJgXuaTwhUzf9ltMEQz+tPLKM29AsUj4a2ZYawG8ga7DPwe4esgw
   g==;
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="171583410"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2022 05:54:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 30 Aug 2022 05:53:53 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 30 Aug 2022 05:53:50 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v4 13/13] clk: microchip: mpfs: update module authorship & licencing
Date:   Tue, 30 Aug 2022 13:52:50 +0100
Message-ID: <20220830125249.2373416-13-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220830125110.2372514-1-conor.dooley@microchip.com>
References: <20220830125110.2372514-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Padmarao wrote the driver in its original, pre upstream form.
Daire & myself have been responsible for getting it upstreamable and
subsequent development.
Move Daire out of the blurb & into a MODULE_AUTHOR entry & add entries
for myself and Padmarao.

While we are at it, convert the MODULE_LICENSE field to its preferred
form of "GPL".

Reviewed-by: Daire McNamara <daire.mcnamara@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/clk/microchip/clk-mpfs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/microchip/clk-mpfs.c b/drivers/clk/microchip/clk-mpfs.c
index fa46176eb9ca..253a55a04084 100644
--- a/drivers/clk/microchip/clk-mpfs.c
+++ b/drivers/clk/microchip/clk-mpfs.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Daire McNamara,<daire.mcnamara@microchip.com>
- * Copyright (C) 2020 Microchip Technology Inc.  All rights reserved.
+ * PolarFire SoC MSS/core complex clock control
+ *
+ * Copyright (C) 2020-2022 Microchip Technology Inc. All rights reserved.
  */
 #include <linux/auxiliary_bus.h>
 #include <linux/clk-provider.h>
@@ -505,4 +506,7 @@ static void __exit clk_mpfs_exit(void)
 module_exit(clk_mpfs_exit);
 
 MODULE_DESCRIPTION("Microchip PolarFire SoC Clock Driver");
-MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Padmarao Begari <padmarao.begari@microchip.com>");
+MODULE_AUTHOR("Daire McNamara <daire.mcnamara@microchip.com>");
+MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
+MODULE_LICENSE("GPL");
-- 
2.36.1

