Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC73455968A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbiFXJ1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbiFXJ1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:27:38 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC7D77FD3;
        Fri, 24 Jun 2022 02:27:37 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25O80Faf003188;
        Fri, 24 Jun 2022 11:27:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=kjc3aiJB+Hj9ReWa1anGkTzwdmkmMYpxyo1+DmPMteQ=;
 b=C54N92ZyrSjoW1L6zWL9u2n+GM/2GThgaz6PJnZskIFMR+bvSkDj+C9hgPvjuIEgZ/0/
 qAmIBXl7if86xi6QW3UNT6pps2ZPCQRKrnmwLELwNCMqdOgIecRVdgIXmIJ85O3O6pDe
 R4h1oGmfKj5RnhuLubYNTb4VzIvEUTfuLbl9m7uLppw1ePJnjoS8NrmEeGeZiDUMzC3S
 WxUrYk29SMmAOWBGuwnXbnM9/kgLbelm7OQESahcP9ZVt6FKaXhzU4wvKKZHcCfF9FmS
 fTG+K0IyVPKzHxHCty7nPyfASEbKTfgNlNZvqqXNK45bHsPN5h9Ra0Pfx3KznXuyr44o gQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gvn8s7r4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 11:27:21 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E6D7D10002A;
        Fri, 24 Jun 2022 11:27:20 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E1B242138D8;
        Fri, 24 Jun 2022 11:27:20 +0200 (CEST)
Received: from localhost (10.75.127.51) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 24 Jun
 2022 11:27:20 +0200
From:   <gabriel.fernandez@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>
Subject: [PATCH 3/3] ARM: dts: stm32: delete fixed clock node on STM32MP15-SCMI
Date:   Fri, 24 Jun 2022 11:27:15 +0200
Message-ID: <20220624092715.1397827-4-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624092715.1397827-1-gabriel.fernandez@foss.st.com>
References: <20220624092715.1397827-1-gabriel.fernandez@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-24_05,2022-06-23_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Delete the node fixed clock managed by secure world with SCMI.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
---
 arch/arm/boot/dts/stm32mp15-scmi.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp15-scmi.dtsi b/arch/arm/boot/dts/stm32mp15-scmi.dtsi
index e90cf3acd0b3..44a8aa6094b2 100644
--- a/arch/arm/boot/dts/stm32mp15-scmi.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-scmi.dtsi
@@ -45,3 +45,9 @@ scmi_shm: scmi-sram@0 {
 		};
 	};
 };
+
+/delete-node/ &clk_hse;
+/delete-node/ &clk_hsi;
+/delete-node/ &clk_lse;
+/delete-node/ &clk_lsi;
+/delete-node/ &clk_csi;
-- 
2.25.1

