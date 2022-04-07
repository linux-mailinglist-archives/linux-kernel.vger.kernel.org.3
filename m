Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7DA4F7718
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241752AbiDGHRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241569AbiDGHRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:17:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66667145993;
        Thu,  7 Apr 2022 00:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649315714; x=1680851714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oAgSbpsEs00wd9ecBkOKHM9TSKuXXBzsPclEgGe7uZs=;
  b=QGfUFTIzpvb6OQTC+cdPV5FfkfIOqCHRxlvvI/VZGTn9aZ9IQwp0j80b
   lUuRczSTHXdJiUn22jmbpMQWG8DAIeC1v8Oegsll1qrghDmnDRmYYzVC8
   edTUErxeF0t8KX6GTd/oe0XDUkRWMhYlt37IGEFxvv3lWQ+NJcCIGyen+
   elf90VUVWiev7qI7GAiSjlbgyI8DZIsyheW7wqHNWQagu8opaZtOYPj01
   FrAwmVwn5T3xQPphZVkYpZOa4kd++JfY0pC3C3rOcsIUX8Ldnb6alNNnC
   8v448+jgyjWq4UrB7lY+7J/wcHbBnBczQZzhX+/44SK0Aglkz0eBQ/R1j
   w==;
X-IronPort-AV: E=Sophos;i="5.90,241,1643698800"; 
   d="scan'208";a="151841380"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2022 00:15:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Apr 2022 00:15:12 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 7 Apr 2022 00:15:09 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <p.zabel@pengutronix.de>,
        <linux@armlinux.org.uk>, <sre@kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 04/10] dt-bindings: reset: add sama7g5 definitions
Date:   Thu, 7 Apr 2022 10:17:02 +0300
Message-ID: <20220407071708.3848812-5-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220407071708.3848812-1-claudiu.beznea@microchip.com>
References: <20220407071708.3848812-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index 000000000000..2116f41d04e0
--- /dev/null
+++ b/include/dt-bindings/reset/sama7g5-reset.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef __DT_BINDINGS_RESET_SAMA7G5_H
+#define __DT_BINDINGS_RESET_SAMA7G5_H
+
+#define SAMA7G5_RESET_USB_PHY1		4
+#define SAMA7G5_RESET_USB_PHY2		5
+#define SAMA7G5_RESET_USB_PHY3		6
+
+#endif /* __DT_BINDINGS_RESET_SAMA7G5_H */
-- 
2.32.0

