Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEB8475717
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241860AbhLOK7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:59:15 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:50972 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229912AbhLOK7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:59:13 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BF8xc5o015267;
        Wed, 15 Dec 2021 11:58:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=fxCRXpeKeVQqkPAsiZl8T2m7WvryL9rb7qxj3EPPyV4=;
 b=zj4c2gfFtID+sjJ5K/ae8CCmly9VzfDFoTiOcO/6ysFtfI2Yauxkn7yQKVGTTI+m1R5i
 vN/l1B/rX2SPv3An8z3rWd2mBBCi0vPuSkiHMJSCa/nyZwRkzi0GzgexBi5bYRJd5tHg
 Qw7BgumxZZgbt4UkTyzVZQUvEdw4vUvcaAGr8EfIKuKZDEbhk1DgvJ9uDpf7+RPjOyuQ
 QEzBtC6lowtv4IisLrCIMa6n3nCRBoIZDr2vBynBtIHClVBRBZRUjJFM/8Sfi6LotNtE
 DLlHRVOLRPLsOPMUY47/bGr6sraFiVj9Kx+UGt01IYM+YMc1PJJc/pDruvT0eRp8c4UB 2A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cxrthy01a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Dec 2021 11:58:54 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 17A8910002A;
        Wed, 15 Dec 2021 11:58:54 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0EF1B235F6C;
        Wed, 15 Dec 2021 11:58:54 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 15 Dec 2021 11:58:53
 +0100
From:   Alexandre Torgue <alexandre.torgue@foss.st.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <alexandre.torgue@foss.st.com>
Subject: [PATCH v2 3/5] dt-bindings: interrupt-controller: stm32-exti: document st,stm32mp13-exti
Date:   Wed, 15 Dec 2021 11:58:45 +0100
Message-ID: <20211215105847.2328-4-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211215105847.2328-1-alexandre.torgue@foss.st.com>
References: <20211215105847.2328-1-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-15_08,2021-12-14_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support of STM32MP13 SoC implies a new EXTI-GIC mapping.

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
index e08bb51e97a8..532425b1e5bb 100644
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

