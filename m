Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9C848CC68
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350288AbiALTwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:52:03 -0500
Received: from mail.z3ntu.xyz ([128.199.32.197]:33202 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346449AbiALTvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:51:21 -0500
Received: from localhost.localdomain (ip-213-127-106-2.ip.prioritytelecom.net [213.127.106.2])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 4DDE1CDFC9;
        Wed, 12 Jan 2022 19:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1642016546; bh=ohieyEzXNmPDcc0FGZkXrfv8PmkK+p86gnZQ/VhgRlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=eukxzcKOhqFstQXxtp7goRrxhZv0KKcM5tDZ/mO9pAEpgdlRAZTE6keTbq2vG98wW
         qmZJTo2xLZkq4SjOjZbVcCaD62PHkJlWEIr6AFOScqM746pdK/GNcBFuGEj2/rELVJ
         lSxcN8VIpzJCfUZHD1mVjJKB1PZcV6qBgq1yLEC8=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/15] dt-bindings: mfd: qcom,tcsr: Document msm8953 compatible
Date:   Wed, 12 Jan 2022 20:40:52 +0100
Message-Id: <20220112194118.178026-4-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112194118.178026-1-luca@z3ntu.xyz>
References: <20220112194118.178026-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for tcsr found in msm8953.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
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
2.34.1

