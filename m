Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9424A7293
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344770AbiBBOCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:02:41 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:60426 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236875AbiBBOCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:02:37 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 212BHSnv008883;
        Wed, 2 Feb 2022 15:00:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=QO75VVUtLxytzTAB78gKyxinIEuCKxE3/gSrZc3vF48=;
 b=3EXTZHzWH8i/yNWoN5JmS6nmGSKab60UkUiqpgBwP0KlUJzEPnHQ4TmQ6E4RoKBPUNFH
 /6OoLMzz8GT9dA2laFxA5PnmjKa1/K7AX6Nf6c8XCXEyr/yVUcybKO/hVbjjcmFkdLSJ
 OE2QxCinekBuAaNmA/qny+KWvhWA1K41eAIBtFg7edzJZQMn+6eaqCpLP4+WNKZ7pcuZ
 p40C3iNHz8wBW3PPtKPGQjPJHXK97CYDHYvbKpzWUk3On/GSI3PvWmdIMZMseioJSCLg
 71MecnPAew64O3nYNhcJMzpQ2DxFGduhEpnRTv3bImJpZML05ZPbS70L67orzbUhsYbS gg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dyhe9junp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 15:00:11 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B7297100034;
        Wed,  2 Feb 2022 15:00:10 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AFB0321F0D0;
        Wed,  2 Feb 2022 15:00:10 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 2 Feb 2022 15:00:09
 +0100
From:   Alexandre Torgue <alexandre.torgue@foss.st.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <alexandre.torgue@foss.st.com>
Subject: [PATCH v3 1/3] dt-bindings: interrupt-controller: stm32-exti: document st,stm32mp13-exti
Date:   Wed, 2 Feb 2022 15:00:03 +0100
Message-ID: <20220202140005.860-2-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220202140005.860-1-alexandre.torgue@foss.st.com>
References: <20220202140005.860-1-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_06,2022-02-01_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support of STM32MP13 SoC implies to create a new compatible in order to
manage EXTI/GIC mapping changes.

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
index d19c881b4abc..e44daa09b137 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
@@ -20,6 +20,7 @@ properties:
       - items:
           - enum:
               - st,stm32mp1-exti
+              - st,stm32mp13-exti
           - const: syscon
 
   "#interrupt-cells":
-- 
2.17.1

