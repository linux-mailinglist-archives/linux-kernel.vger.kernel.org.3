Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D93B46D3FF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbhLHNJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:09:24 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46100 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234018AbhLHNJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:09:23 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B8ATQE3015743;
        Wed, 8 Dec 2021 14:05:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=QO75VVUtLxytzTAB78gKyxinIEuCKxE3/gSrZc3vF48=;
 b=0FPPcpCG+hjSHvsJPgBxFvxC1fp1XSpKs1SwRE2qA5yzSYR3RvrlgtlyJjkz6SQVpLEd
 SMyNKUpmDVWMkXDVnuLti9jYlkWuoyWyM3MQQuS5e0PCGYjWPrYy/sY1KJ7fFtLdX3Bv
 BYjNxs5AnroIr9iGX/VZVtmMGDgm5gPL6oRapEDjTeNKjN12y2kiZRK9dmCin6CMSnBA
 R+Vbp/x5U9eMZwSkEfBt+jAK3N5KV3/C1j79qOT9V9FbUI9/OmIQWmBpmqJtJJwcGh7i
 sUGGDG91WbwFlqPf3fC/gOpogGxCx8JyoDgh0zpaKmCKHbqpOmRwSMKH+gSqCvDljLuX sA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ctmsrjsc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 14:05:32 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2C89B100034;
        Wed,  8 Dec 2021 14:05:32 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2489024DE9D;
        Wed,  8 Dec 2021 14:05:32 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 8 Dec 2021 14:05:31
 +0100
From:   Alexandre Torgue <alexandre.torgue@foss.st.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <alexandre.torgue@foss.st.com>
Subject: [PATCH 1/3] dt-bindings: interrupt-controller: stm32-exti: document st,stm32mp13-exti
Date:   Wed, 8 Dec 2021 14:04:54 +0100
Message-ID: <20211208130456.4002-2-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211208130456.4002-1-alexandre.torgue@foss.st.com>
References: <20211208130456.4002-1-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_04,2021-12-08_01,2021-12-02_01
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

