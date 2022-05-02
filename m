Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9710951756F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386534AbiEBRML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386499AbiEBRME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:12:04 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D285F55;
        Mon,  2 May 2022 10:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651511315; x=1683047315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=pSD3GbcUt2xtT95+6XWgExlKRKxHZVzndq557b9Kp+8=;
  b=Dgbsluk5UdZsls5BZCvtc7jJceFJIonjcy+jl6UFGb3FFB/b9pLXf7Oo
   H6X1jNmKWAu2y1mmzre7SQ9XxYZn+ZXeVUUSasGSQ7db4Z7fbxIsO7lVy
   J4uMUJrVj5R6moUWOryKqp4ak2z1d/uUfAioKhXCsn1glw+eV1NCq696g
   g=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 May 2022 10:08:35 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 10:08:35 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 2 May 2022 10:08:34 -0700
Received: from kaushalk-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 2 May 2022 10:08:31 -0700
From:   Kaushal Kumar <quic_kaushalk@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <manivannan.sadhasivam@linaro.org>,
        "Kaushal Kumar" <quic_kaushalk@quicinc.com>
Subject: [PATCH v3 4/4] ARM: dts: qcom: sdx65-mtp: Enable QPIC NAND support
Date:   Mon, 2 May 2022 10:08:06 -0700
Message-ID: <1651511286-18690-5-git-send-email-quic_kaushalk@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651511286-18690-1-git-send-email-quic_kaushalk@quicinc.com>
References: <1651511286-18690-1-git-send-email-quic_kaushalk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable QPIC NAND devicetree node for Qualcomm SDX65-MTP board.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Kaushal Kumar <quic_kaushalk@quicinc.com>
---
 arch/arm/boot/dts/qcom-sdx65-mtp.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
index e9c8df9..e747ec0 100644
--- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
+++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
@@ -249,6 +249,21 @@
 	status = "okay";
 };
 
+&qpic_nand {
+	status = "okay";
+
+	nand@0 {
+		reg = <0>;
+
+		nand-ecc-strength = <4>;
+		nand-ecc-step-size = <512>;
+		nand-bus-width = <8>;
+		/* ico and efs2 partitions are secured */
+		secure-regions = /bits/ 64 <0x500000 0x500000
+					    0xa00000 0xb00000>;
+	};
+};
+
 &usb {
 	status = "okay";
 };
-- 
2.7.4

