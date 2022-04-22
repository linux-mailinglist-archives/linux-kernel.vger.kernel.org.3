Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BE650BB65
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiDVPNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449274AbiDVPNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:13:14 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A625C375;
        Fri, 22 Apr 2022 08:10:20 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23M9XkOE025876;
        Fri, 22 Apr 2022 17:09:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=l9SvZJdyy9uik1+mGIZMe5PR4/rWu4TCEUCl9ef8drk=;
 b=jbKArl5ep7u/A1rbHlG5Z7uo3gZEl+6ZGde+j+xe+gGmxapzyLgljOhoQAzUZhw59Blw
 1t0bSa8oYoMukfyrXlETsxI18PAcnM901AKdxAQPuG2+FDV2rxPi+AUYOMFrfbLO+bOh
 1Gzl9zzTdYiMt91Jtmhq+B6fC9uUOuMWX+qIcvmUtWM4RUKyjXFSPrb8eQ0sjEXdyCe6
 z1K+/jJOwsCIJCHHhiC/UbDwATIbtq81nkNSZXnoNTqcRimNSBUYIzuycGgKygY/6pdE
 91da/OCfrlVoDUbGT58Wjhng7BiPMBFuoCp/yYKNqyu+RKubNEjx6ODwS+xEUG4uel34 ow== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ffpqe9v5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 17:09:56 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 653EB100034;
        Fri, 22 Apr 2022 17:09:56 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5D7F1233C64;
        Fri, 22 Apr 2022 17:09:56 +0200 (CEST)
Received: from localhost (10.75.127.50) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 22 Apr
 2022 17:09:56 +0200
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
Subject: [PATCH 3/8] dt-bindings: clock: stm32mp15: rename CK_SCMI define
Date:   Fri, 22 Apr 2022 17:09:47 +0200
Message-ID: <20220422150952.20587-4-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220422150952.20587-1-alexandre.torgue@foss.st.com>
References: <20220422150952.20587-1-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
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

As we only have one SCMI instance, it's not necessary to add an index to
the name.

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

diff --git a/include/dt-bindings/clock/stm32mp1-clks.h b/include/dt-bindings/clock/stm32mp1-clks.h
index e02770b98e6c..25e8cfd43459 100644
--- a/include/dt-bindings/clock/stm32mp1-clks.h
+++ b/include/dt-bindings/clock/stm32mp1-clks.h
@@ -249,30 +249,26 @@
 #define STM32MP1_LAST_CLK 232
 
 /* SCMI clock identifiers */
-#define CK_SCMI0_HSE		0
-#define CK_SCMI0_HSI		1
-#define CK_SCMI0_CSI		2
-#define CK_SCMI0_LSE		3
-#define CK_SCMI0_LSI		4
-#define CK_SCMI0_PLL2_Q		5
-#define CK_SCMI0_PLL2_R		6
-#define CK_SCMI0_MPU		7
-#define CK_SCMI0_AXI		8
-#define CK_SCMI0_BSEC		9
-#define CK_SCMI0_CRYP1		10
-#define CK_SCMI0_GPIOZ		11
-#define CK_SCMI0_HASH1		12
-#define CK_SCMI0_I2C4		13
-#define CK_SCMI0_I2C6		14
-#define CK_SCMI0_IWDG1		15
-#define CK_SCMI0_RNG1		16
-#define CK_SCMI0_RTC		17
-#define CK_SCMI0_RTCAPB		18
-#define CK_SCMI0_SPI6		19
-#define CK_SCMI0_USART1		20
-
-#define CK_SCMI1_PLL3_Q		0
-#define CK_SCMI1_PLL3_R		1
-#define CK_SCMI1_MCU		2
+#define CK_SCMI_HSE		0
+#define CK_SCMI_HSI		1
+#define CK_SCMI_CSI		2
+#define CK_SCMI_LSE		3
+#define CK_SCMI_LSI		4
+#define CK_SCMI_PLL2_Q		5
+#define CK_SCMI_PLL2_R		6
+#define CK_SCMI_MPU		7
+#define CK_SCMI_AXI		8
+#define CK_SCMI_BSEC		9
+#define CK_SCMI_CRYP1		10
+#define CK_SCMI_GPIOZ		11
+#define CK_SCMI_HASH1		12
+#define CK_SCMI_I2C4		13
+#define CK_SCMI_I2C6		14
+#define CK_SCMI_IWDG1		15
+#define CK_SCMI_RNG1		16
+#define CK_SCMI_RTC		17
+#define CK_SCMI_RTCAPB		18
+#define CK_SCMI_SPI6		19
+#define CK_SCMI_USART1		20
 
 #endif /* _DT_BINDINGS_STM32MP1_CLKS_H_ */
-- 
2.17.1

