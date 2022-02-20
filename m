Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62F24BD151
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244850AbiBTUUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:20:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244046AbiBTUUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:20:04 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8767C4C43F;
        Sun, 20 Feb 2022 12:19:42 -0800 (PST)
Received: from localhost.localdomain (ip-213-127-118-180.ip.prioritytelecom.net [213.127.118.180])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id D9D70C83D5;
        Sun, 20 Feb 2022 20:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1645388381; bh=zXQ10jAoie1vLqkGOjbcP21izWcDeodFwUqgXrQpMF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=r/mGJNVgBeKVCoCbRMBMVR4St9ZyQtmkSTyYftn1UaMP+4LT9iKuMXKymRRKCXuEH
         THiXg+8fLT676IfixGLqysqws2QqJO3/ocDXzWDkCLYxMcuphi0nJlwPxekfrWbTqa
         q9ro/x2YWXkvvadwiFkTMEfsbKwioHpXBLLXY8gM=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/10] dt-bindings: mfd: qcom,tcsr: Document msm8953 compatible
Date:   Sun, 20 Feb 2022 21:18:54 +0100
Message-Id: <20220220201909.445468-2-luca@z3ntu.xyz>
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

Document the compatible for tcsr found in msm8953.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v2:
- no changes

 Documentation/devicetree/bindings/mfd/qcom,tcsr.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.txt b/Documentation/devicetree/bindings/mfd/qcom,tcsr.txt
index c5f4f0ddfcc3..add61bcc3c74 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.txt
+++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.txt
@@ -10,6 +10,7 @@ Required properties:
 		"qcom,tcsr-ipq8064", "syscon" for IPQ8064
 		"qcom,tcsr-apq8064", "syscon" for APQ8064
 		"qcom,tcsr-msm8660", "syscon" for MSM8660
+		"qcom,tcsr-msm8953", "syscon" for MSM8953
 		"qcom,tcsr-msm8960", "syscon" for MSM8960
 		"qcom,tcsr-msm8974", "syscon" for MSM8974
 		"qcom,tcsr-apq8084", "syscon" for APQ8084
-- 
2.35.1

