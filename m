Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB7850C390
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbiDVWd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbiDVWcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:32:45 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293752512F0;
        Fri, 22 Apr 2022 14:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650662761; x=1682198761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bz2rLXg33ZlwCJFTP5vcqCWU/OHhXNlZLcLHoGg/qx4=;
  b=eAxS+LQI0o6/mcUs8oWPfe8NFAPVeyzv3TCr5EkAiWtgpwZe/ur00433
   1wLeHu6iGKvWO6sed4cDg/VDqhRDEPvejZ3Sdjugq4f6knljS7m1VT3QO
   fToulQMqqaaP7rTnoJGuS2gJFU397N3+ZJbD7iKEKkBP18rrhDOZm7h30
   k=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Apr 2022 12:14:25 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 12:14:25 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Apr 2022 12:14:24 -0700
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Apr 2022 12:14:24 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <dmitry.torokhov@gmail.com>, <corbet@lwn.net>, <sre@kernel.org>,
        <robh+dt@kernel.org>
CC:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <bjorn.andersson@linaro.org>,
        <swboyd@chromium.org>, <linux-doc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        David Collins <collinsd@quicinc.com>,
        David Collins <quic_collinsd@quicinc.com>,
        "Anjelique Melendez" <quic_amelende@quicinc.com>
Subject: [PATCH v6] dt-bindings: power: reset: qcom-pon: update "reg" property details
Date:   Fri, 22 Apr 2022 12:12:38 -0700
Message-ID: <20220422191239.6271-2-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422191239.6271-1-quic_amelende@quicinc.com>
References: <20220422191239.6271-1-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Collins <collinsd@quicinc.com>

Update the description of "reg" property to add the PON_PBS base
address along with PON_HLOS base address.  Also add "reg-names"
property description.

Signed-off-by: David Collins <quic_collinsd@quicinc.com>
Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 .../bindings/power/reset/qcom,pon.yaml | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
index 353f155d..65ec8197 100644
--- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
+++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
@@ -26,7 +26,24 @@ properties:
       - qcom,pm8998-pon
 
   reg:
-    maxItems: 1
+    description: |
+      Specifies the SPMI base address for the PON (power-on) peripheral.  For
+      PMICs that have the PON peripheral (GEN3) split into PON_HLOS and PON_PBS
+      (e.g. PMK8350), this can hold addresses of both PON_HLOS and PON_PBS
+      peripherals.  In that case, the PON_PBS address needs to be specified to
+      facilitate software debouncing on some PMICs.
+    minItems: 1
+    maxItems: 2
+
+  reg-names:
+    description: |
+      For PON GEN1 and GEN2, it should be "pon".  For PON GEN3 it should include
+      "pon_hlos" and optionally "pon_pbs".
+    minItems: 1
+    items:
+      - const: pon_hlos
+      - const: pon_pbs
+      - const: pon
 
   pwrkey:
     type: object
-- 
2.35.1

