Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0A44C547B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 08:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiBZHqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 02:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiBZHqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 02:46:42 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D64A1DEA9A;
        Fri, 25 Feb 2022 23:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645861568; x=1677397568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=RSfdJwuCbYLQ64ELpUKd+PcIHa7v60+qAk66UHs9+Vk=;
  b=aIJAPRmXFwd1epD6mHI1Ey3nSTYv7/RYKez6CqLIzLK+qmVyjt3ukfBU
   KizyjmR1JDhKnBUTJ3q517ygasysV3DSWyh9/FRMUF7XPbhUm2dTTSGoT
   THL13TW98cSt4hkkOfQuIr9K1CO3oJ+BW4QCRSZxc7/uSBA6sgrJD6C09
   s=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 25 Feb 2022 23:46:08 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 23:46:07 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 25 Feb 2022 23:46:07 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 25 Feb 2022 23:46:01 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@codeaurora.org>,
        <perex@perex.cz>, <tiwai@suse.com>,
        <srinivas.kandagatla@linaro.org>, <rohitkr@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [RESEND v4 2/2] ASoC: qcom: dt-bindings: Add bindings for power domains in lpass digital codecs
Date:   Sat, 26 Feb 2022 13:15:31 +0530
Message-ID: <1645861531-13829-3-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645861531-13829-1-git-send-email-quic_srivasam@quicinc.com>
References: <1645861531-13829-1-git-send-email-quic_srivasam@quicinc.com>
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

Include power domain dt-bindings for lpass digital codecs RX, TX and
VA macros, which are required for ADSP bypass architecture.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml | 8 ++++++++
 Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml | 8 ++++++++
 Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml | 8 ++++++++
 3 files changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
index bc762b3..6127df5 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
@@ -39,6 +39,14 @@ properties:
     items:
       - const: mclk
 
+  power-domains:
+    maxItems: 2
+
+  power-domain-names:
+    items:
+      - const: macro
+      - const: dcodec
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
index 74f5386..3f0f99c 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
@@ -39,6 +39,14 @@ properties:
     items:
       - const: mclk
 
+  power-domains:
+    maxItems: 2
+
+  power-domain-names:
+    items:
+      - const: macro
+      - const: dcodec
+
   qcom,dmic-sample-rate:
     description: dmic sample rate
     $ref: /schemas/types.yaml#/definitions/uint32
diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
index 99f2c36..9868a5e 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
@@ -37,6 +37,14 @@ properties:
     items:
       - const: fsgen
 
+  power-domains:
+    maxItems: 2
+
+  power-domain-names:
+    items:
+      - const: macro
+      - const: dcodec
+
   qcom,dmic-sample-rate:
     description: dmic sample rate
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.7.4

