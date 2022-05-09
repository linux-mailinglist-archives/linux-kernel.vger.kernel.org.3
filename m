Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D41051FED7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236456AbiEINva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbiEINvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:51:04 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F6B19CB79;
        Mon,  9 May 2022 06:47:10 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 249CkU1q011337;
        Mon, 9 May 2022 15:46:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=YCUzkBMpATH4oafdkH+ZZgiEl4z5yPbRDWExDNymfS0=;
 b=KU41ueLp4zx7fAW+P0ojjYgNwFdPzVZtCJ9dsjkKsRvTs4tUTPOiW0BwEiNOPIoA6uRb
 TGQnTDv5soQDuXNoLoAffj65sk8hUiAFKWdGqprK2vtJYuWQ1dm+msWDFcnjwlV3Ba6K
 TDiTdoQ6Ld0FCEqfA6OXvk7W5AmrNeVnemlTVUmVphyfXZegmjJd/nJ6c1iofD4m0DDp
 XKVTiWSNJvzF9vXxwv3VhzAXbPm2ISwYyZxm8S85zbX6ZaC7sMDmmwWQBatRYEgxB+Ql
 pixTqTG4thhLgKfOsCEZzux4A93g6OCG9y7N0JQbB5Cyj+mGaNejBGUb71QQsmN+2709 Rw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3fwe6kjfgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 May 2022 15:46:59 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0970510002A;
        Mon,  9 May 2022 15:46:59 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 02E402248D3;
        Mon,  9 May 2022 15:46:59 +0200 (CEST)
Received: from localhost (10.75.127.46) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 9 May
 2022 15:46:58 +0200
From:   Alexandre Torgue <alexandre.torgue@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] dt-bindings: clock: stm32mp1: adapt example for "st,stm32mp1-rcc-secure"
Date:   Mon, 9 May 2022 15:46:58 +0200
Message-ID: <20220509134658.16267-1-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-09_03,2022-05-09_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For "st,stm32mp1-rcc-secure" schema, clocks and clock-names entries are now
required properties.

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
index bb0e0b92e907..45b94124366c 100644
--- a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
+++ b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
@@ -106,10 +106,17 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/clock/stm32mp1-clks.h>
     rcc: rcc@50000000 {
         compatible = "st,stm32mp1-rcc-secure", "syscon";
         reg = <0x50000000 0x1000>;
         #clock-cells = <1>;
         #reset-cells = <1>;
+        clock-names = "hse", "hsi", "csi", "lse", "lsi";
+        clocks = <&scmi_clk CK_SCMI_HSE>,
+                 <&scmi_clk CK_SCMI_HSI>,
+                 <&scmi_clk CK_SCMI_CSI>,
+                 <&scmi_clk CK_SCMI_LSE>,
+                 <&scmi_clk CK_SCMI_LSI>;
     };
 ...
-- 
2.17.1

