Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C485B48C872
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355271AbiALQdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:33:05 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:45892 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355216AbiALQct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:32:49 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20CG1vkT031920;
        Wed, 12 Jan 2022 17:32:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=muhLgS3eQo5JHf14ynN7ycK1cLH33qsCvcDuI/2QMIc=;
 b=XzgUD1sGqEMNd9EWiKYi0eZ7xtcrFYdz9MyScEJ8y4AXlTGNA6xCvpRZserM7ribvXTc
 U0B4KIfIKZjYs7YIdyarB4x6v8mC80RdKZhnTxtsPOsj54lF5aMEr8u3D+fEW3JUEg9g
 MMBrdj8SareY1Oxek9Y6INTyRWLnZ2UvOdD3vLIoHHhTAa/MrapaR3WGvtML+dRq+mWf
 0dmw2oziCWhF3FyR8Oq6mI+OSdFj7ndrObW8HYru3b/n5KUzHd7NKkdZLaibd4a1KcFr
 OPqaBULRTzm6TRu6eGL8/uWEsJ3cg0EyWZyLTFmdCtbRaguq8ix0y6iRncOBvbIgx/Xm JA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dj25b04bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 17:32:34 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8168110002A;
        Wed, 12 Jan 2022 17:32:34 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7A2BA24B8B1;
        Wed, 12 Jan 2022 17:32:34 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
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
Subject: [PATCH 02/10] ARM: dts: stm32: add st,stm32-sdmmc2 compatible on stm32mp131
Date:   Wed, 12 Jan 2022 17:32:18 +0100
Message-ID: <20220112163226.25384-3-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220112163226.25384-1-yann.gautier@foss.st.com>
References: <20220112163226.25384-1-yann.gautier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-12_04,2022-01-11_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To align with bootloaders device tree files, and thanks to what was
added in yaml file [1], the compatible property for sdmmc1 node is
updated with "st,stm32-sdmmc2" string.

[1] commit 552bc46484b3 ("dt-bindings: mmc: mmci: Add st,stm32-sdmmc2
    compatible")

Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
---
 arch/arm/boot/dts/stm32mp131.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
index 86126dc0d898..9b318fcd6ef0 100644
--- a/arch/arm/boot/dts/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/stm32mp131.dtsi
@@ -122,7 +122,7 @@
 		};
 
 		sdmmc1: mmc@58005000 {
-			compatible = "arm,pl18x", "arm,primecell";
+			compatible = "st,stm32-sdmmc2", "arm,pl18x", "arm,primecell";
 			arm,primecell-periphid = <0x00253180>;
 			reg = <0x58005000 0x1000>, <0x58006000 0x1000>;
 			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.17.1

