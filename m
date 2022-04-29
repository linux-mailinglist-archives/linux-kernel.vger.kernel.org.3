Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6267F51482E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358458AbiD2LeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358435AbiD2Lds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:33:48 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F5449247;
        Fri, 29 Apr 2022 04:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651231830; x=1682767830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ozc1nAJKzhIpDHlfaNRXWXWHk5wj+THsga8WcVzOCHw=;
  b=pzUiyXKeVZhOccUdMs4lxB+MIWIeGZXV6Q9ATQBjkbOikEI4Pu/Aruga
   4I1RIUvEZFoWSkowXtcDJ21sYuml3jd5At2nw+bSIffuB72IQuFgY61L0
   d5qv2aPFQNF9kMJar4iOulYBsTJ5gGYRuleS3putx3+LYJ83j81sMrdim
   E=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Apr 2022 04:30:30 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 04:30:28 -0700
Received: from bgodavar-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Apr 2022 04:30:23 -0700
From:   Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
To:     <agross@kernel.org>, <robh+dt@kernel.org>,
        <bjorn.andersson@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <mka@chromium.org>, <linux-bluetooth@vger.kernel.org>,
        <quic_hemantg@quicinc.com>, <quic_saluvala@quicinc.com>,
        <quic_rjliao@quicinc.com>, <mcchou@chromium.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
Subject: [PATCH v1 1/3] dt-bindings: net: bluetooth: Add wlan-gpio entry for wcn6750
Date:   Fri, 29 Apr 2022 15:57:51 +0530
Message-ID: <1651228073-1999-2-git-send-email-quic_bgodavar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651228073-1999-1-git-send-email-quic_bgodavar@quicinc.com>
References: <1651228073-1999-1-git-send-email-quic_bgodavar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a wlan-gpio entry and its reference usage for
BT SoC wcn6750.

Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
Signed-off-by: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
---
 Documentation/devicetree/bindings/net/qualcomm-bluetooth.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.yaml
index f93c6e7..624f957 100644
--- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.yaml
@@ -24,6 +24,10 @@ properties:
       - qcom,qca6390-bt
       - qcom,wcn6750-bt
 
+  wlan-gpios:
+    maxItems: 1
+    description: gpio specifier used to wlan chip
+
   enable-gpios:
     maxItems: 1
     description: gpio specifier used to enable chip
@@ -123,6 +127,7 @@ allOf:
               - qcom,wcn6750-bt
     then:
       required:
+        - wlan-gpios
         - enable-gpios
         - swctrl-gpios
         - vddio-supply
@@ -166,6 +171,7 @@ examples:
             compatible = "qcom,wcn6750-bt";
             pinctrl-names = "default";
             pinctrl-0 = <&bt_en_default>;
+            wlan-gpios = <&tlmm 84 GPIO_ACTIVE_HIGH>;
             enable-gpios = <&tlmm 85 GPIO_ACTIVE_HIGH>;
             swctrl-gpios = <&tlmm 86 GPIO_ACTIVE_HIGH>;
             vddio-supply = <&vreg_l19b_1p8>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

