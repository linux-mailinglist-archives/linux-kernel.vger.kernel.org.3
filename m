Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009C45461EF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244218AbiFJJZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349689AbiFJJYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:24:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767CB144BDA;
        Fri, 10 Jun 2022 02:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654852954; x=1686388954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pEPCyor0HPhRyWJrWn5UaIdWPgtJJseLNoyP9PCSfuA=;
  b=WTFex8YeTvbyTwVBd4gdXIpIvyfY3zlg7H8emGrvEKALbKGhj3vdGF1c
   VNIbSKQkojbA8GChBVQU2jTyf/XhCDpNXLpaOKd0c34tMNJjs6s7ImDuG
   AuN8UOzBBjbva3zEPGMX7T5EkMgN78dtnBG6C4vap+fIP1fqrgubGuySd
   adeZOcEx1cBm1qdRhH3RZnKC6A3SePj7iOhuldnE+wZgb5typwhXQm2Ty
   TVvZ5Qp5qqnd9zjr9TL7npKJEHY1Wyjn2nLCiWxNkWJD7NwLxxP2yyWI+
   Cn1U+wvn/TW8sw75EekNVAviNqUGipNkkzSWZDC8e/QuvanBwS2A0OeYe
   w==;
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="167889027"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jun 2022 02:22:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 10 Jun 2022 02:22:33 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 10 Jun 2022 02:22:29 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <p.zabel@pengutronix.de>, <sre@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 4/9] dt-bindings: reset: add sama7g5 definitions
Date:   Fri, 10 Jun 2022 12:24:09 +0300
Message-ID: <20220610092414.1816571-5-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220610092414.1816571-1-claudiu.beznea@microchip.com>
References: <20220610092414.1816571-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset bindings for SAMA7G5. At the moment only USB PHYs are
included.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Rob Herring <robh@kernel.org>
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
2.34.1

