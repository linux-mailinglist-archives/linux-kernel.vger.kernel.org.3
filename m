Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FCE50BB4C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449199AbiDVPNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449278AbiDVPNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:13:14 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AC35C644;
        Fri, 22 Apr 2022 08:10:20 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23MEYpBf004664;
        Fri, 22 Apr 2022 17:09:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=woZ58dxJuQ0iY6HX7qWewtoszaIe7hcsPEtRaLww4Ew=;
 b=Jw/nj+nNe128iHIBmznWCB+qMFrcWGndUZdv+4CESixDbY9YcVxahyCYJ0OYeUclq4ut
 xVW43lrH0T8kiUlbCD+xLGkeO8bEg7H0PFlmyxJVeHwf9KzxZ8keabdPWFQ72FxG4WXT
 pfCTSXlw21tBKFVcJSsJdQX32uvrrLbe9v1g1a0ix1BGxtiyj5o29FcAd31HLv3Onz37
 tjtGTjtril1ljEc+2VfUJguNgxwelJof0XGpdDMWoFcN1xeyb4oG5OSKTYHJNiosBSZm
 KZpNlVuFG0mw7PXS5ROku3dtvlUXDeTPZfn1YHwyJo9f4P9eLc4YYC8wbQABle1T8Tsb LQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ffpqe9v5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 17:09:56 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C61B110002A;
        Fri, 22 Apr 2022 17:09:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BEDE3233C62;
        Fri, 22 Apr 2022 17:09:55 +0200 (CEST)
Received: from localhost (10.75.127.51) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 22 Apr
 2022 17:09:55 +0200
From:   Alexandre Torgue <alexandre.torgue@foss.st.com>
To:     <arnd@arndb.de>, <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>, <soc@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        <etienne.carriere@st.com>
Subject: [PATCH 2/8] dt-bindings: clock: stm32mp1: describes clocks if "st,stm32mp1-rcc-secure"
Date:   Fri, 22 Apr 2022 17:09:46 +0200
Message-ID: <20220422150952.20587-3-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220422150952.20587-1-alexandre.torgue@foss.st.com>
References: <20220422150952.20587-1-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_04,2022-04-22_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of "st,stm32mp1-rcc-secure" (stm32mp1 clock driver with RCC
security support hardened), "clocks" and "clock-names" describe oscillators
and are required.

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
index 7a251264582d..bb0e0b92e907 100644
--- a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
+++ b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
@@ -58,14 +58,8 @@ properties:
           - st,stm32mp1-rcc-secure
           - st,stm32mp1-rcc
       - const: syscon
-
-  clocks:
-    description:
-      Specifies the external RX clock for ethernet MAC.
-    maxItems: 1
-
-  clock-names:
-    const: ETH_RX_CLK/ETH_REF_CLK
+  clocks: true
+  clock-names: true
 
   reg:
     maxItems: 1
@@ -76,6 +70,38 @@ required:
   - compatible
   - reg
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - st,stm32mp1-rcc-secure
+then:
+  properties:
+    clocks:
+      description: Specifies oscillators.
+      maxItems: 5
+
+    clock-names:
+      items:
+        - const: hse
+        - const: hsi
+        - const: csi
+        - const: lse
+        - const: lsi
+  required:
+    - clocks
+    - clock-names
+else:
+  properties:
+    clocks:
+      description:
+        Specifies the external RX clock for ethernet MAC.
+      maxItems: 1
+
+    clock-names:
+      const: ETH_RX_CLK/ETH_REF_CLK
+
 additionalProperties: false
 
 examples:
-- 
2.17.1

