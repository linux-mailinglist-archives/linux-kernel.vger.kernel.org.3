Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077B74B66AD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbiBOIye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:54:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235004AbiBOIyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:54:31 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613CE114FD3;
        Tue, 15 Feb 2022 00:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644915261; x=1676451261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=mMSYBKsFrCeLssIDuR+nWYQYyce2npHgB9PBnij0FWc=;
  b=QG5lipD6AcJmFLopvwBI4esEkeJCIMQcv6VwlDgfhSPJ89ONzBXuqJ6s
   aOLD5uAAFX4WJIqSxyg/JasXVz+esOPFjHj+Ai+mVjgnRf7Q7UnGMULDh
   7hJzoFKlKzh5ew4CBE+XZt4i4fs9ku6XRRvrqqaEVf/hd4zKW/0zpjFAw
   Q=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Feb 2022 00:54:20 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 00:54:20 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Feb 2022 00:54:19 -0800
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 15 Feb 2022 00:54:15 -0800
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: [PATCH V6 1/6] dt-bindings: regulator: Add pm8008 regulator bindings
Date:   Tue, 15 Feb 2022 14:23:46 +0530
Message-ID: <1644915231-7308-2-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644915231-7308-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1644915231-7308-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

Add bindings for pm8008 pmic regulators.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in V2:
 - Moved this patch before "mfd: pm8008: Add pm8008 regulator node" to
   resolve dtschema errors. Removed regulator-min-microvolt and 
   regulator-max-microvolt properties.

Changes in V3:
 - As per Rob's comments added standard unit suffix for mindropout property,
   added blank lines where required and added description for reg property.

Changes in V4:
 - Changed compatible string to "com,pm8008-regulators"
 - Moved "regulator-min-dropout-voltage-microvolt" to regulator.yaml as
   separate patch.

Changes in V5:
 - Removed the separate compatible for pm8008 regulator driver.
 - Moved the supply nodes to chip level.
 - Removed min-dropout property.

Changes in V6:
 - Changed regulator node names to small letters.
 - Changed regulator-name property to optional.

 .../bindings/regulator/qcom,pm8008-regulator.yaml  | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,pm8008-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/qcom,pm8008-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,pm8008-regulator.yaml
new file mode 100644
index 0000000..4ad3189
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/qcom,pm8008-regulator.yaml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/qcom,pm8008-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. PM8008 Regulator bindings
+
+maintainers:
+  - Satya Priya <skakit@codeaurora.org>
+
+description:
+  Qualcomm Technologies, Inc. PM8008 is an I2C controlled PMIC
+  containing 7 LDO regulators.
+
+patternProperties:
+  "^ldo[1-7]$":
+    type: object
+    $ref: "regulator.yaml#"
+    description: PM8008 regulator peripherals of PM8008 regulator device
+
+    properties:
+      regulator-name: true
+
+    unevaluatedProperties: false
+
+additionalProperties: false
+...
-- 
2.7.4

