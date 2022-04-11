Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E407B4FBAB9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345873AbiDKLU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343916AbiDKLUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:20:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9024A427DB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649675913; x=1681211913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hxmhVU25D3rkudonJ1U48jVC1YzKh8bTlt+6h0NWC6c=;
  b=gXkA0k7SewI5wla5AeFGFx6w38GOq4cHdhbxDPEh06uj71AGch0dmsv9
   74pFT07tGa8MjSn/mO+ejYQOpwl8loufvPnulB2imr77AdLDa3fdW7sDf
   MXx10j8+/HcSbeaheRICx+lUl16jVH9PAOviFtQWyPKb4APou8xM4gIuj
   7RkNbMVQvYxsJiVF250GBlfyMC29evHFU2iBfMj8bV7rNBjVLrg/Rk9di
   iRtb8OXrcGqyEhPN2jU5imesv0y+vvQjD+k2Lwe7WSG6Q2t1FohS9RvK6
   5KYOFYSoXZgM+YwDW+6ee86b8Y+Qhc6jfS5dg2YGQMAzGjhnkPxswSiNC
   w==;
X-IronPort-AV: E=Sophos;i="5.90,251,1643698800"; 
   d="scan'208";a="160061925"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Apr 2022 04:18:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Apr 2022 04:18:32 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 11 Apr 2022 04:18:31 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/4] ARM: at91: pm: keep documentation inline with structure members
Date:   Mon, 11 Apr 2022 14:20:54 +0300
Message-ID: <20220411112057.35369-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220411112057.35369-1-claudiu.beznea@microchip.com>
References: <20220411112057.35369-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move documentation of bu to keep the same order as in the structure
itself.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 0fd609e26615..7ea4c7f13d28 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -65,9 +65,9 @@ struct at91_pm_sfrbu_regs {
  * @config_shdwc_ws: wakeup sources configuration function for SHDWC
  * @config_pmc_ws: wakeup srouces configuration function for PMC
  * @ws_ids: wakup sources of_device_id array
+ * @bu: backup unit mapped data (for backup mode)
  * @data: PM data to be used on last phase of suspend
  * @sfrbu_regs: SFRBU registers mapping
- * @bu: backup unit mapped data (for backup mode)
  * @memcs: memory chip select
  */
 struct at91_soc_pm {
-- 
2.32.0

