Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BD948C871
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355275AbiALQdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:33:00 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44726 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1349879AbiALQct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:32:49 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20CBHwDO019096;
        Wed, 12 Jan 2022 17:32:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=ahUofAV0amC2ef1QfiggLlyt//R3c+cCHFHBmCWx2D0=;
 b=PjEAB7Gh5/3vifspwgErRLH0/twz8FafaAN/xT0HPm9DFg8EBb2H+fTlzdn2W236fyu/
 LAEpUOQhNZ5aKeqD2TVv+3JUpQw8Ipm1aVpwy5mcT0m/bBvlXTLEi3xj7m1BGzKE2rm0
 m+goMd9mp/UY8Lrq1r8FTvE+UcMCx+EGgYB5yN8ttS7wjnsT+H8IO7N5hNtdkIG0I5Fk
 VKEPMmk/0bO3ki7Ycg1nujqZprcFW/2X2NJffMcGKIu9LkcR3bEWg0HYYLmCQ4LgriE/
 jri4b8ZntSI+xumiGIdejF33KpHVKiKDszrmWmIcYjg9/ks8E1p9SlrATLipCTBu862Y zw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dhtg9u814-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 17:32:35 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2BC11100034;
        Wed, 12 Jan 2022 17:32:35 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2386524B8B1;
        Wed, 12 Jan 2022 17:32:35 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 12 Jan 2022 17:32:34
 +0100
From:   Yann Gautier <yann.gautier@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Yann Gautier <yann.gautier@foss.st.com>
Subject: [PATCH 03/10] ARM: dts: stm32: increase SDMMC max-frequency for STM32MP13
Date:   Wed, 12 Jan 2022 17:32:19 +0100
Message-ID: <20220112163226.25384-4-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220112163226.25384-1-yann.gautier@foss.st.com>
References: <20220112163226.25384-1-yann.gautier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-12_04,2022-01-11_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max-frequency limitation is due to IOs.
On STM32MP13, it is 130MHz. Update the corresponding property.

Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
---
 arch/arm/boot/dts/stm32mp131.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
index 9b318fcd6ef0..672ac9360619 100644
--- a/arch/arm/boot/dts/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/stm32mp131.dtsi
@@ -131,7 +131,7 @@
 			clock-names = "apb_pclk";
 			cap-sd-highspeed;
 			cap-mmc-highspeed;
-			max-frequency = <120000000>;
+			max-frequency = <130000000>;
 			status = "disabled";
 		};
 
-- 
2.17.1

