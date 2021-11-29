Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74EF4613F3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242926AbhK2Lhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:37:36 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:22604 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237081AbhK2Lfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:35:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638185536; x=1669721536;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=wbNIFTmUvXdbEqi3JkHLWrmQ8GcsDU5jy7yV62yXM7c=;
  b=QHmrt7+kdepsprnUgv2eZoN1pyRGE+2CbtXDZdvui/FMgA+SsfEefjC7
   DFiY6Fee2sA+DbZoQYjqfWiusF8RbEgidILDtSEjmweo9mMyssbAlw7Kx
   w+lMLxDnI1L+/jFJ1lAles//ZYkSMVZ3sc+QAW2v1FvugBUiwVXch/j9m
   w=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Nov 2021 03:32:16 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 03:32:16 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 29 Nov 2021 03:32:16 -0800
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 29 Nov 2021 03:32:12 -0800
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dianders@chromium.org>,
        <mka@chromium.org>, <kgodara@codeaurora.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH v2 2/4] arm64: dts: qcom: sc7280-crd: Add device tree files for CRD
Date:   Mon, 29 Nov 2021 17:01:35 +0530
Message-ID: <1638185497-26477-3-git-send-email-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638185497-26477-1-git-send-email-quic_rjendra@quicinc.com>
References: <1638185497-26477-1-git-send-email-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CRD (Compute Reference Design) is a sc7280 based board, largely
derived from the existing IDP board design with some key deltas
1. has EC and H1 over SPI similar to IDP2
2. touchscreen and trackpad support
3. eDP display

We just add the barebones dts file here, subsequent patches will
add support for EC/H1 and other components.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
---
 arch/arm64/boot/dts/qcom/Makefile       |  1 +
 arch/arm64/boot/dts/qcom/sc7280-crd.dts | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-crd.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 6b816eb..b18708c 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -78,6 +78,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-ganges-kirin.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-discovery.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-pioneer.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
new file mode 100644
index 0000000..2da6603
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * sc7280 CRD board device tree source
+ *
+ * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "sc7280-idp.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. sc7280 CRD platform";
+	compatible = "qcom,sc7280-crd", "google,hoglin", "qcom,sc7280";
+
+	aliases {
+		serial0 = &uart5;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&nvme_3v3_regulator {
+	gpio = <&tlmm 51 GPIO_ACTIVE_HIGH>;
+};
+
+&nvme_pwren {
+	pins = "gpio51";
+};
-- 
2.7.4

