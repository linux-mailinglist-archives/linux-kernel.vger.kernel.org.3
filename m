Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973B34FF731
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbiDMM4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbiDMM41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:56:27 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9371453B4C;
        Wed, 13 Apr 2022 05:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649854446; x=1681390446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=75XqXF4iWGyzuP5KRCXXWWVEeCNk9pacfderG6P+d7Y=;
  b=XVMqLe0/Jhj+xxK/BIzE/i+mqlrLoC7QCj4KlzpeUA+6edVGpelMrTBw
   ctX6tBS+NvWviuWFCVrTw1qQSMFeRfvfV15s9Eq5nW/dNWl6/LDj7XYbf
   FEFm5fTH3E5Prd4/diPCj7FcHxZUI6wh3IDIePHYw8+UY48fWwUPKz6l4
   s=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 13 Apr 2022 05:54:06 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 13 Apr 2022 05:54:05 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg02-blr.qualcomm.com with ESMTP; 13 Apr 2022 18:23:49 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 1BF3A3AC7; Wed, 13 Apr 2022 18:23:48 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2 1/2] dt-bindings: interconnect: Add Qualcomm SDX65 DT bindings
Date:   Wed, 13 Apr 2022 18:23:34 +0530
Message-Id: <1649854415-11174-2-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649854415-11174-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1649854415-11174-1-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interconnect IDs for Qualcomm SDX65 platform.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 .../bindings/interconnect/qcom,rpmh.yaml           |  3 +
 include/dt-bindings/interconnect/qcom,sdx65.h      | 67 ++++++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 include/dt-bindings/interconnect/qcom,sdx65.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index 5a911be..9ee2a51 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -72,6 +72,9 @@ properties:
       - qcom,sdx55-mc-virt
       - qcom,sdx55-mem-noc
       - qcom,sdx55-system-noc
+      - qcom,sdx65-mc-virt
+      - qcom,sdx65-mem-noc
+      - qcom,sdx65-system-noc
       - qcom,sm8150-aggre1-noc
       - qcom,sm8150-aggre2-noc
       - qcom,sm8150-camnoc-noc
diff --git a/include/dt-bindings/interconnect/qcom,sdx65.h b/include/dt-bindings/interconnect/qcom,sdx65.h
new file mode 100644
index 0000000..b25288a
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sdx65.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SDX65_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SDX65_H
+
+#define MASTER_LLCC	0
+#define SLAVE_EBI1	1
+
+#define MASTER_TCU_0		0
+#define MASTER_SNOC_GC_MEM_NOC	1
+#define MASTER_APPSS_PROC	2
+#define SLAVE_LLCC		3
+#define SLAVE_MEM_NOC_SNOC	4
+#define SLAVE_MEM_NOC_PCIE_SNOC	5
+
+#define MASTER_AUDIO		0
+#define MASTER_BLSP_1		1
+#define MASTER_QDSS_BAM		2
+#define MASTER_QPIC		3
+#define MASTER_SNOC_CFG		4
+#define MASTER_SPMI_FETCHER	5
+#define MASTER_ANOC_SNOC	6
+#define MASTER_IPA		7
+#define MASTER_MEM_NOC_SNOC	8
+#define MASTER_MEM_NOC_PCIE_SNOC	9
+#define MASTER_CRYPTO		10
+#define MASTER_IPA_PCIE		11
+#define MASTER_PCIE_0		12
+#define MASTER_QDSS_ETR		13
+#define MASTER_SDCC_1		14
+#define MASTER_USB3		15
+#define SLAVE_AOSS		16
+#define SLAVE_APPSS		17
+#define SLAVE_AUDIO		18
+#define SLAVE_BLSP_1		19
+#define SLAVE_CLK_CTL		20
+#define SLAVE_CRYPTO_0_CFG	21
+#define SLAVE_CNOC_DDRSS	22
+#define SLAVE_ECC_CFG		23
+#define SLAVE_IMEM_CFG		24
+#define SLAVE_IPA_CFG		25
+#define SLAVE_CNOC_MSS		26
+#define SLAVE_PCIE_PARF		27
+#define SLAVE_PDM		28
+#define SLAVE_PRNG		29
+#define SLAVE_QDSS_CFG		30
+#define SLAVE_QPIC		31
+#define SLAVE_SDCC_1		32
+#define SLAVE_SNOC_CFG		33
+#define SLAVE_SPMI_FETCHER	34
+#define SLAVE_SPMI_VGI_COEX	35
+#define SLAVE_TCSR		36
+#define SLAVE_TLMM		37
+#define SLAVE_USB3		38
+#define SLAVE_USB3_PHY_CFG	39
+#define SLAVE_ANOC_SNOC		40
+#define SLAVE_SNOC_MEM_NOC_GC	41
+#define SLAVE_IMEM		42
+#define SLAVE_SERVICE_SNOC	43
+#define SLAVE_PCIE_0		44
+#define SLAVE_QDSS_STM		45
+#define SLAVE_TCU		46
+
+#endif
-- 
2.7.4

