Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5458F51D342
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390107AbiEFIZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390096AbiEFIZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:25:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12DD13D13
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 01:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651825278; x=1683361278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f3Co6OGCYeWWxJEwjya8qaocxIctKpd8QmKpvKixx+c=;
  b=f+N6AJ+0CI0TZP1EVFVu/o/YB6A7AUxBO+We+t48UvMItkPGFq5SdMqT
   ph/IG3BIPRsH49TAIYbOxYfhKOmoixp8qWrdeONnLdG9e991wJuMAsuYo
   SdkHG2vWGVTpm+R4/6Bp3sY29+YYLZChVKZ68byAbNO4rXrrUVvHZSsa9
   ZXWXZb/aBkVCVTw+3F/ne1UsXgZ5L1qDTszbHsz6VfgUGPUrlTxRtE3bz
   gq8ueH81HacqMcTiR+RYeCVF0deLQMzb8RV23e+Tyr0/Pw9W4r0E1YEG1
   oAFHKqGY2SlY7l0jO4ZiKxca142ycX19TxKW5DweGzr3BykuGDWT2japD
   w==;
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="158023604"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 May 2022 01:21:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 6 May 2022 01:21:17 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 6 May 2022 01:21:14 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 1/4] ARM: at91: pm: keep documentation inline with structure members
Date:   Fri, 6 May 2022 11:23:32 +0300
Message-ID: <20220506082335.3817259-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220506082335.3817259-1-claudiu.beznea@microchip.com>
References: <20220506082335.3817259-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
2.34.1

