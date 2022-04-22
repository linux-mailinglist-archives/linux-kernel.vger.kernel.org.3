Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7063B50BB66
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449257AbiDVPNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449277AbiDVPNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:13:14 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37495C376;
        Fri, 22 Apr 2022 08:10:20 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23MEYpBg004664;
        Fri, 22 Apr 2022 17:09:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=9QxTQMUq/Xo8vdY6aSgRWMlI+mjf+2qkd9WP7GUpTsg=;
 b=Ln1OT3cHY7fMCotXOcF1xtV1w1/MCnpw+WVkG4tNhhJ1LT3BXhPKxK62Lc59rcjqhFor
 ZP6AD9hOkedjAD+CsJ0UCmgNPK+ux54d0ho39Qz/y1Z2AGMv5ERelxM2O8tZotp85UxJ
 Q+hwbXhapEObuiuEDJFEkDh3Qp2p9/nEAQl53QF8wQS0NeE4rdom9pvte7qZejNMrcxD
 S/U7OgyukjJmEyPQBsRQCQzXGT0K5prJxp02FUInkyHoPRAI6wEmvexZe1lvJAQ9dFAJ
 XYnSaovAiuu3Xnn9H20npmcC1S1GU+8T74C6vPkrA7y/xErV0MITVOP5dXU5/fP5Ks+i iA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ffpqe9v5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Apr 2022 17:09:57 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EB02E10002A;
        Fri, 22 Apr 2022 17:09:56 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E21A8233C65;
        Fri, 22 Apr 2022 17:09:56 +0200 (CEST)
Received: from localhost (10.75.127.51) by SHFDAG1NODE1.st.com (10.75.129.69)
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
Subject: [PATCH 4/8] dt-bindings: reset: stm32mp15: rename RST_SCMI define
Date:   Fri, 22 Apr 2022 17:09:48 +0200
Message-ID: <20220422150952.20587-5-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220422150952.20587-1-alexandre.torgue@foss.st.com>
References: <20220422150952.20587-1-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SHFDAG1NODE1.st.com
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

diff --git a/include/dt-bindings/reset/stm32mp1-resets.h b/include/dt-bindings/reset/stm32mp1-resets.h
index f3a0ed317835..4ffa7c3612e6 100644
--- a/include/dt-bindings/reset/stm32mp1-resets.h
+++ b/include/dt-bindings/reset/stm32mp1-resets.h
@@ -107,17 +107,17 @@
 #define GPIOK_R		19786
 
 /* SCMI reset domain identifiers */
-#define RST_SCMI0_SPI6		0
-#define RST_SCMI0_I2C4		1
-#define RST_SCMI0_I2C6		2
-#define RST_SCMI0_USART1	3
-#define RST_SCMI0_STGEN		4
-#define RST_SCMI0_GPIOZ		5
-#define RST_SCMI0_CRYP1		6
-#define RST_SCMI0_HASH1		7
-#define RST_SCMI0_RNG1		8
-#define RST_SCMI0_MDMA		9
-#define RST_SCMI0_MCU		10
-#define RST_SCMI0_MCU_HOLD_BOOT	11
+#define RST_SCMI_SPI6		0
+#define RST_SCMI_I2C4		1
+#define RST_SCMI_I2C6		2
+#define RST_SCMI_USART1	3
+#define RST_SCMI_STGEN		4
+#define RST_SCMI_GPIOZ		5
+#define RST_SCMI_CRYP1		6
+#define RST_SCMI_HASH1		7
+#define RST_SCMI_RNG1		8
+#define RST_SCMI_MDMA		9
+#define RST_SCMI_MCU		10
+#define RST_SCMI_MCU_HOLD_BOOT	11
 
 #endif /* _DT_BINDINGS_STM32MP1_RESET_H_ */
-- 
2.17.1

