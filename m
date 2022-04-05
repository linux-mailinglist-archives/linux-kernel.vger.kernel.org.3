Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E140A4F5074
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1841929AbiDFB0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382415AbiDEMPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:15:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EFBAFAFA;
        Tue,  5 Apr 2022 04:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649157934; x=1680693934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B3e5nwQfZpposlIlxa12xtU2rD09+R4h9VUHhMbRZHs=;
  b=S4g8iLAs0kMb193fq9FPnwUL7YXH8BLFyYETy/LB4PUdDRP+oN8Dn+Y0
   57sW9x2/gwkAuzq0ufKWOisdEZ+ljg39ux5yC6g0kO9FooukiSYYYDVy/
   S3nNQD5hv7hr3t37FmjLzIMZE/B86GtRfX0cPnN7bxhRIOXUCK1Sn7Gr0
   gMQjFWj1Z/wvST6Ig+OF/D4SrKxKTQLwVqTXV7k5ICHsVdSG3qTYvERop
   NWIY5L8NHrY+7qfUz0BQpOVfe6GpkLOu2gYDaa6d67JNsBa1zcier3U5g
   6gSwwumkI/eOmpCmE2SPZJiJg3yUdyox+4HMdra7a88NG8VhgNbeuwBw3
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,236,1643698800"; 
   d="scan'208";a="158916331"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Apr 2022 04:25:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 5 Apr 2022 04:25:32 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 5 Apr 2022 04:25:30 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <p.zabel@pengutronix.de>,
        <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 4/8] dt-bindings: reset: add sama7g5 definitions
Date:   Tue, 5 Apr 2022 14:27:20 +0300
Message-ID: <20220405112724.2760905-5-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220405112724.2760905-1-claudiu.beznea@microchip.com>
References: <20220405112724.2760905-1-claudiu.beznea@microchip.com>
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

Add reset bindings for SAMA7G5. At the moment only USB PHYs are
included.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 include/dt-bindings/reset/sama7g5-reset.h | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 include/dt-bindings/reset/sama7g5-reset.h

diff --git a/include/dt-bindings/reset/sama7g5-reset.h b/include/dt-bindings/reset/sama7g5-reset.h
new file mode 100644
index 000000000000..670d8075f463
--- /dev/null
+++ b/include/dt-bindings/reset/sama7g5-reset.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __DT_BINDINGS_RESET_SAMA7G5_H
+#define __DT_BINDINGS_RESET_SAMA7G5_H
+
+#define RESET_USB_PHY1		4
+#define RESET_USB_PHY2		5
+#define RESET_USB_PHY3		6
+
+#endif /* __DT_BINDINGS_RESET_SAMA7G5_H */
-- 
2.32.0

