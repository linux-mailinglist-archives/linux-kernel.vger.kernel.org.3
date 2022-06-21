Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3A555379E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353930AbiFUQMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353878AbiFUQMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:12:21 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E672E6A8;
        Tue, 21 Jun 2022 09:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655827940; x=1687363940;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=1vM/qYT3QTDRD1G/iyb0SJ1bJE0kssX8kqtLCkiG1pU=;
  b=Oofs/XQmu3SHD+3v1LnBfhIbzU7xOVPWPUQkKh36vkGx+h3Nt5xW7USQ
   JjWKL+Ftp1IysTEpdmf2t6rPvu8J7Uc7MbTEEyyHDdHVRlHKphOmogNyF
   j6MnlP36DC9GLy9ytFNnxgGdhXgQ/4w2ctiaBv32n1g3mIGI2Z8erBCuE
   s=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Jun 2022 09:12:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 09:12:19 -0700
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 21 Jun 2022 09:12:19 -0700
Received: from srichara-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 21 Jun 2022 09:12:14 -0700
From:   Sricharan R <quic_srichara@quicinc.com>
To:     <quic_srichara@quicinc.com>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <p.zabel@pengutronix.de>,
        <quic_varada@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V2 6/8] dt-bindings: qcom: Add ipq5018 bindings
Date:   Tue, 21 Jun 2022 21:41:24 +0530
Message-ID: <20220621161126.15883-7-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220621161126.15883-1-quic_srichara@quicinc.com>
References: <20220621161126.15883-1-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Varadarajan Narayanan <quic_varada@quicinc.com>

Document the new ipq5018 SOC/board device tree bindings.

Co-developed-by: Sricharan R <quic_srichara@quicinc.com>
Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 129cdd246223..6665db9c9b28 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -29,6 +29,7 @@ description: |
         apq8074
         apq8084
         apq8096
+        ipq5018
         ipq6018
         ipq8074
         mdm9615
@@ -64,6 +65,7 @@ description: |
         hk10-c2
         idp
         liquid
+        mp03
         mtp
         qrd
         sbc
@@ -198,6 +200,11 @@ properties:
               - qcom,ipq4019-dk04.1-c1
           - const: qcom,ipq4019
 
+      - items:
+          - enum:
+              - qcom,ipq5018-mp03
+          - const: qcom,ipq5018
+
       - items:
           - enum:
               - qcom,ipq8064-ap148
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

