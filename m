Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B83358C44C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 09:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237399AbiHHHli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 03:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241654AbiHHHl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 03:41:27 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA8712AF9;
        Mon,  8 Aug 2022 00:41:23 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2787XHsQ018462;
        Mon, 8 Aug 2022 09:41:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=f/9YJc7lHxTxvRxehhYNQeqTxdKH0Po556YIBtfjFVI=;
 b=PynfWpXh4BK8uD5mI+3Ml5QaJGYo91w4fBV/zDqzvFX9i9HIirOb/7ETxNvAd+0jPfHn
 HbejdU16WDmJHAi+JsCJe3dh5gf6Y0KpVBgW4vem2i9RgSTohtROVVnQL7fNGnwGwaOu
 CH4fF2CWg6hIL69F5SE6V8jEQ8XzJcAJt37zvgxRWE9Wr7PEtxk+tWuhepNHGTfLBgMk
 4Ou21qthE63kgPPLmMokxpj/kA4ClRNaXdyUGuhVDVgU/UswzxW/AyDhdGNUVFn4JPyu
 flwtHB9CFEMly/VwyuDVxUQMmRk7zag7LNtXA+c+DoXnNIBx19XcJliWCdfK0tTYtEqR 4g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3hsfn07w9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 09:41:02 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 103AA10002A;
        Mon,  8 Aug 2022 09:41:00 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7CD042171DE;
        Mon,  8 Aug 2022 09:41:00 +0200 (CEST)
Received: from localhost (10.75.127.46) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 8 Aug
 2022 09:40:59 +0200
From:   <patrice.chotard@foss.st.com>
To:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        <patrice.chotard@foss.st.com>, <devicetree@vger.kernel.org>
Subject: [PATCH 1/3] dt-bindings: spi: stm32: Add st,dual-flash property in st,stm32-qspi.yaml
Date:   Mon, 8 Aug 2022 09:40:49 +0200
Message-ID: <20220808074051.44736-2-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220808074051.44736-1-patrice.chotard@foss.st.com>
References: <20220808074051.44736-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_05,2022-08-05_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Add new property st,dual-flash which allows to use the QSPI interface as a
communication channel using up to 8 qspi line.
This mode can only be used if cs-gpios property is defined.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
index 6ec6f556182f..5e4f9109799e 100644
--- a/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
@@ -46,6 +46,14 @@ properties:
       - const: tx
       - const: rx
 
+  st,dual-flash:
+    type: boolean
+    description:
+      Allows to use 8 data lines in case cs-gpios property is defined.
+
+dependencies:
+  st,dual-flash: [ cs-gpios ]
+
 required:
   - compatible
   - reg
-- 
2.25.1

