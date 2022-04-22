Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3561F50BB49
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449282AbiDVPOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449293AbiDVPOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:14:11 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED525D660;
        Fri, 22 Apr 2022 08:11:15 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23MEpQ1B028200;
        Fri, 22 Apr 2022 17:11:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=biv2CiCx22xakTMtFGlV8OZK5eeEjdPdtT+GUmPZKd0=;
 b=OBIuhDTXIGP9F5wbmZrPoVvQpwpR17h1o/ax0cSf+aHCJo9onD5qovyBooETKte+U7cF
 kkM+jyZ+NsBKlqGwnwBfOIHAMxuAe+QdE0KHJf7K1rHYlN9HdNgJ/S1wEXAwfuCup6Q9
 BXd5Y8pocf0jnerUv/NFMQm/+Nvvlss0zTWIDoYLqewmQro3/UXWS6GQJlE2Ko3LINpQ
 ahoySwqHzAL3+qWyPr9h8f0bG+mnSL5skfYfN5ebwW5p1J9U/YPjmuy75z4FDO5Pkmow
 2p7ydx6VHx9VZDevu5GtL80i27rzzJPC2zaUSFUdr9xXN6GlkmJgmaV07WzT25dm0oDl 1g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3fkskgt1we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 17:11:00 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 94FCF10002A;
        Fri, 22 Apr 2022 17:10:58 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8E49A233C64;
        Fri, 22 Apr 2022 17:10:58 +0200 (CEST)
Received: from localhost (10.75.127.51) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 22 Apr
 2022 17:10:58 +0200
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
Subject: [PATCH 7/8] dt-bindings: arm: stm32: Add SCMI version of STM32 boards (DK1/DK2/ED1/EV1)
Date:   Fri, 22 Apr 2022 17:09:51 +0200
Message-ID: <20220422150952.20587-8-alexandre.torgue@foss.st.com>
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

Add a "secure" version based on SCMI of STM32 boards. Only boards
provided by STMicroelectronics are concerned:

-STM32MP157A-DK1
-STM32MP157C-DK2
-STM32MP157C-ED1
-STM32MP157C-EV1

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index fa0a1b84122e..4a3d66da0f1c 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -75,6 +75,23 @@ properties:
 
           - const: st,stm32mp157
       - items:
+          - const: st,stm32mp157a-dk1-scmi
+          - const: st,stm32mp157a-dk1
+          - const: st,stm32mp157
+      - items:
+          - const: st,stm32mp157c-dk2-scmi
+          - const: st,stm32mp157c-dk2
+          - const: st,stm32mp157
+      - items:
+          - const: st,stm32mp157c-ed1-scmi
+          - const: st,stm32mp157c-ed1
+          - const: st,stm32mp157
+      - items:
+          - const: st,stm32mp157c-ev1
+          - const: st,stm32mp157c-ed1
+          - const: st,stm32mp157
+      - items:
+          - const: st,stm32mp157c-ev1-scmi
           - const: st,stm32mp157c-ev1
           - const: st,stm32mp157c-ed1
           - const: st,stm32mp157
-- 
2.17.1

