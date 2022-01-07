Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449224877C9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 13:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347382AbiAGMvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 07:51:40 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:40632 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347443AbiAGMui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641559838; x=1673095838;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Mdi0FfApzXXlanizF2QXF55IPByMuk3+tGAbBFptguA=;
  b=aknlj4K7VEi9I8lZ0d1aaL9ZEaNDNR55uqZeQFwZNyd+AVW26okYr7Qc
   hdbcw303LslwydbRUyllQGEG44YRxEL7wjTUarDL/a4s/8+hM/GWovZdl
   X/1wb0tnIfCNpftrj3dPqL2I5Vvaa7Y4hColZDq/JOdQ5Pd7b2Omz5PDT
   Y=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Jan 2022 04:50:35 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 04:50:35 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 7 Jan 2022 04:50:34 -0800
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 7 Jan 2022 04:50:31 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH] arm64: dts: ipq8074: add the reserved-memory region
Date:   Fri, 7 Jan 2022 18:20:22 +0530
Message-ID: <1641559822-31825-1-git-send-email-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On IPQ8074, 4MB of memory is needed for TZ. So mark that region
as reserved.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 6c6a0f853669..b4d813c27230 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -82,6 +82,17 @@
 		};
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		memory@4ac00000 {
+			no-map;
+			reg = <0x0 0x4ac00000 0x0 0x00400000>;
+		};
+	};
+
 	soc: soc {
 		#address-cells = <0x1>;
 		#size-cells = <0x1>;
-- 
2.7.4

