Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5D451877C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbiECO74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237538AbiECO7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:59:51 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25409393DB;
        Tue,  3 May 2022 07:56:17 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2439PXHh031550;
        Tue, 3 May 2022 16:56:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=RnOyI1mW0pb5E+gAC2iVywTyj2C9lXRi03VkEPxPmr8=;
 b=zwDm6ATx6X16qwwb58yolddYIwQl9FgLrQ4Pm1ioLnEZ6Chu8+OdOADEDw0gRL2Ei4Rc
 qJD2X7zZw6OKkh87EqMAC7BLBq8vX9fHu1GWVYwN8fYpRj6zmKgSlEWhAmidq64G1eZE
 WNaL5bg5Ge0nq6tIEQPonOipo7g4IBlWUx8h+kusm6RHAfGVR5XvVkK/Kmx0+2DE+DKr
 4j21IEaS9MHNbJw0sndVroTw2Q6uabVjpenBTKsltS0Ma8P8qhJQCNsv/N3+A8Rf4OfH
 6HOkuSP0sFgdgMEy8IJgOkk83GavwkJUY9JIb681t4YR2wcG3Nlbm9J8VqAFQkmh5NQx sQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frthjq1ud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 May 2022 16:56:08 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4F66210002A;
        Tue,  3 May 2022 16:56:08 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 495FF226FA0;
        Tue,  3 May 2022 16:56:08 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 3 May 2022 16:56:07
 +0200
From:   Fabien Dessenne <fabien.dessenne@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@foss.st.com>
Subject: [PATCH 2/2] ARM: dts: stm32: remove the IPCC "wakeup" IRQ on stm32mp151
Date:   Tue, 3 May 2022 16:56:06 +0200
Message-ID: <20220503145606.525875-1-fabien.dessenne@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-03_06,2022-05-02_03,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stm32 ipcc mailbox driver supports only two interrupts (rx and tx), so
remove the unsupported "wakeup" one.
Note that the EXTI interrupt 61 has two roles : it is hierarchically linked
to the GIC IPCC "rx" interrupt, and it acts as a wakeup source.

Signed-off-by: Fabien Dessenne <fabien.dessenne@foss.st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 7fdc324b3cf9..edc0a1641c7b 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1117,10 +1117,9 @@ ipcc: mailbox@4c001000 {
 			reg = <0x4c001000 0x400>;
 			st,proc-id = <0>;
 			interrupts-extended =
-				<&intc GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
-				<&intc GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
-				<&exti 61 1>;
-			interrupt-names = "rx", "tx", "wakeup";
+				<&exti 61 1>,
+				<&intc GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "rx", "tx";
 			clocks = <&rcc IPCC>;
 			wakeup-source;
 			status = "disabled";
-- 
2.25.1

