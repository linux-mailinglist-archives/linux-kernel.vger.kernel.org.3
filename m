Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CE148CC79
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357437AbiALTwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:52:24 -0500
Received: from mail.z3ntu.xyz ([128.199.32.197]:33204 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350092AbiALTvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:51:25 -0500
Received: from localhost.localdomain (ip-213-127-106-2.ip.prioritytelecom.net [213.127.106.2])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id CD62CCDFED;
        Wed, 12 Jan 2022 19:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1642016563; bh=6F81iIhw6L3fR9xstLRfDEkQg3uu6FeMQbZUHrqGro0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=D42ky5nDMCA7/HQq7c01+S7T+TPsZiVXAvbs+965NqsrkbA+N2MPUcx8G/SdC2zDX
         Br8H26e6pFB0/epmgScNs+CfovalPN7UkURJGi0RzQiYc9Lqx5fm/mqJlZTzAV6KHN
         uQ9RQM9ZzSEyBd2VGkjXVpFTA5ZgvGRuP/+BJlEA=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/15] dt-bindings: arm: qcom: Document sdm632 and fairphone,fp3 board
Date:   Wed, 12 Jan 2022 20:41:03 +0100
Message-Id: <20220112194118.178026-15-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112194118.178026-1-luca@z3ntu.xyz>
References: <20220112194118.178026-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for Fairphone 3 smartphone which is based on
Snapdragon 632 (sm632).

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index c8808e0f9e64..d3755bc8c28f 100644
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
@@ -207,6 +208,11 @@ properties:
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
2.34.1

