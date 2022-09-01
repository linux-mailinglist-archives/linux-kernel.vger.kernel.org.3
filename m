Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC0D5A99CE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiIAOOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbiIAOON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:14:13 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C088667CB2;
        Thu,  1 Sep 2022 07:14:03 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 281EDp4b014651;
        Thu, 1 Sep 2022 09:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662041631;
        bh=mDQFiaiggsWsyW43OzLAuvT5ox1nuXHBTohRWo/HmAc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qu15OMKfwwlJTwQ0XChOhn9mya0Aa4hwBgDXT7qehDpXn6kC36jhJNnusHxIB4yKK
         FbIdpt2r3HI3SI8tGZ3LVxmwFZEKnRN1N/APn4BE8N/G0wIf8TR2FUULrshwPOQnSg
         U4L+edMQGer7wFryR5aTOtGl9g6zIij+WZYZ6OBY=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 281EDp4S016142
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Sep 2022 09:13:51 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 1 Sep
 2022 09:13:50 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 1 Sep 2022 09:13:51 -0500
Received: from uda0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 281EDhdS015476;
        Thu, 1 Sep 2022 09:13:47 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 1/5] dt-bindings: arm: ti: Rearrange IOPAD macros alphabetically
Date:   Thu, 1 Sep 2022 19:43:24 +0530
Message-ID: <20220901141328.899100-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901141328.899100-1-vigneshr@ti.com>
References: <20220901141328.899100-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rearrange SOC specific IOPAD macros alphabetically, so that its easier
to read. No functional change intended.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 include/dt-bindings/pinctrl/k3.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/dt-bindings/pinctrl/k3.h b/include/dt-bindings/pinctrl/k3.h
index a5204ab91d3e..6c3d02f63bfb 100644
--- a/include/dt-bindings/pinctrl/k3.h
+++ b/include/dt-bindings/pinctrl/k3.h
@@ -29,19 +29,19 @@
 #define PIN_INPUT_PULLUP	(INPUT_EN | PULL_UP)
 #define PIN_INPUT_PULLDOWN	(INPUT_EN | PULL_DOWN)
 
+#define AM62X_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
+#define AM62X_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
+
+#define AM64X_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
+#define AM64X_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
+
 #define AM65X_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
 #define AM65X_WKUP_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
 
 #define J721E_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
 #define J721E_WKUP_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
 
-#define AM64X_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
-#define AM64X_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
-
 #define J721S2_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
 #define J721S2_WKUP_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
 
-#define AM62X_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
-#define AM62X_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
-
 #endif
-- 
2.37.2

