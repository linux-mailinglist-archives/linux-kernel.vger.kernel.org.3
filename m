Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4585233D3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbiEKNRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbiEKNRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:17:24 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95A8737A5;
        Wed, 11 May 2022 06:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652275042; x=1683811042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=2v9dAOsjL4Pp7TIhSagJHphXDNxT9Hyez9gvQcYZ4QI=;
  b=Qb4e/lXUsWhuH1kerHJ66kn/1UFrJN71lcf9bKtsl2Shp1KbzMNSe/my
   ujaR69vsYueJm6uzJfHlUAuXeGGLId5DfrChf94y4n+Qwchyv+HLl/JQ7
   mcV320UyDoKmZsk490Ociw9hDT/Q46ayKuWDP16ARGIsh0SSJpvSCr5AW
   Y=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 11 May 2022 06:17:22 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 06:17:21 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 06:17:21 -0700
Received: from mkshah-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 06:17:17 -0700
From:   Maulik Shah <quic_mkshah@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <ulf.hansson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <quic_lsrao@quicinc.com>,
        <quic_rjendra@quicinc.com>, Maulik Shah <quic_mkshah@quicinc.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 1/6] dt-bindings: soc: qcom: Update devicetree binding document for rpmh-rsc
Date:   Wed, 11 May 2022 18:46:51 +0530
Message-ID: <1652275016-13423-2-git-send-email-quic_mkshah@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652275016-13423-1-git-send-email-quic_mkshah@quicinc.com>
References: <1652275016-13423-1-git-send-email-quic_mkshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change documents power-domains property for RSC device.
This optional property points to corresponding PM domain node.

Cc: devicetree@vger.kernel.org
Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
index f5ecf4a..7683cc9 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
@@ -110,6 +110,9 @@ properties:
       - const: drv-2
       - const: drv-3
 
+  power-domains:
+    maxItems: 1
+
   bcm-voter:
     $ref: /schemas/interconnect/qcom,bcm-voter.yaml#
 
@@ -162,6 +165,7 @@ examples:
                           <SLEEP_TCS   3>,
                           <WAKE_TCS    3>,
                           <CONTROL_TCS 1>;
+        power-domains = <&CLUSTER_PD>;
       };
 
   - |
@@ -208,6 +212,7 @@ examples:
                           <SLEEP_TCS   3>,
                           <WAKE_TCS    3>,
                           <CONTROL_TCS 0>;
+        power-domains = <&CLUSTER_PD>;
 
         clock-controller {
             compatible = "qcom,sm8350-rpmh-clk";
-- 
2.7.4

