Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9DC4BD168
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244918AbiBTUU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:20:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244834AbiBTUUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:20:12 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1470E4C780;
        Sun, 20 Feb 2022 12:19:50 -0800 (PST)
Received: from localhost.localdomain (ip-213-127-118-180.ip.prioritytelecom.net [213.127.118.180])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 8B239C83E9;
        Sun, 20 Feb 2022 20:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1645388388; bh=VXX5F/h0hjht7uz/YF5YGs/QOjunaAi3MmCFODKAvGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=TtzoKS+drxicpXWJbFgJuH4+tGnuaF5nx4AEs94a3P3PTZU2BZ+cHiJzCR13ryP0U
         2v05SP6+jnc1kEjawXqA0mSKQJHNern4MnMaZTZ1ZjamcGITOxFw6T52tN4Y2ZMqtO
         99kKFxcyb/J0eJIw2CMwu7J5KWE6yrALQ3OBuT+4=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Rob Herring <robh@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/10] dt-bindings: arm: qcom: Document sdm632 and fairphone,fp3 board
Date:   Sun, 20 Feb 2022 21:19:02 +0100
Message-Id: <20220220201909.445468-10-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220220201909.445468-1-luca@z3ntu.xyz>
References: <20220220201909.445468-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for Fairphone 3 smartphone which is based on
Snapdragon 632 (sm632).

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v2:
- no changes

 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index e8b1606bc849..129cdd246223 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -42,6 +42,7 @@ description: |
         sc7180
         sc7280
         sdm630
+        sdm632
         sdm660
         sdm845
         sdx55
@@ -224,6 +225,11 @@ properties:
               - google,senor
           - const: qcom,sc7280
 
+      - items:
+          - enum:
+              - fairphone,fp3
+          - const: qcom,sdm632
+
       - items:
           - enum:
               - xiaomi,lavender
-- 
2.35.1

