Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465CE4F9013
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiDHIA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiDHIAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:00:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC1A133162;
        Fri,  8 Apr 2022 00:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649404711; x=1680940711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YOmvHW09br4wqaZ9CNGSAXTcoCFrHeEMZh+iZBddp2Y=;
  b=gEGmsNHoRFzi25fdjW84QDOVfkdiXzNCpyT0ZBo7zpvZ57jZEWcTVR2t
   3RcdKZOJ58xD3uwbdIymntxyDAMIfTdBXirQH5LXPVQ1Ng5eg52ME7V8p
   pIbI+Sz5VW5UC2OHWRLva5viUG2D7vZPUlZxdGlcqK1durgOqrUaopM/6
   Btxu/R5/Ul+qLqlgZBu4fLqwSQSYrvamMKgMSpd3w+x0aTM7zxJPa/NmO
   DGs3cdEfGsgdYbYD6IiXf46HXNaNlW43Cvr6Ej4gAjX8LK7M5eJAV8CXp
   VXsRA2kaPrZc8R6+gHEN5oUMWrrramwe1gvE1chsgYIHxvblUP0CY1/wb
   w==;
X-IronPort-AV: E=Sophos;i="5.90,244,1643698800"; 
   d="scan'208";a="168919696"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Apr 2022 00:58:31 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 8 Apr 2022 00:58:31 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 8 Apr 2022 00:58:28 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <p.zabel@pengutronix.de>,
        <linux@armlinux.org.uk>, <sre@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <cristian.birsan@microchip.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 04/10] dt-bindings: reset: add sama7g5 definitions
Date:   Fri, 8 Apr 2022 11:00:25 +0300
Message-ID: <20220408080031.2527232-5-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220408080031.2527232-1-claudiu.beznea@microchip.com>
References: <20220408080031.2527232-1-claudiu.beznea@microchip.com>
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
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
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

