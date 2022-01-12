Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A2748CC60
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357389AbiALTvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:51:08 -0500
Received: from mail.z3ntu.xyz ([128.199.32.197]:33164 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345918AbiALTuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:50:44 -0500
X-Greylist: delayed 485 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Jan 2022 14:50:32 EST
Received: from localhost.localdomain (ip-213-127-106-2.ip.prioritytelecom.net [213.127.106.2])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id D645BCDFCF;
        Wed, 12 Jan 2022 19:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1642016548; bh=1vhW3d4UaDKe38F2VYc2x61F+EvihlShdrbGh4J8qco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OcBhJKlgB78UsLLnO/2lmGKBKkCUwwryUIpndu5DizUzvhd/As3Y2RLAob8gC7k25
         gsBu4E6PrPyOoP8pYUu/oWE4GAwNo6cAMFn6jLEzeR8fFYh6W5d3/ru7ITAhAGWrYn
         UgxnJDu/E1HAazGJNkFk+dqQt8JZHYoeg411gCS4=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/15] dt-bindings: mmc: sdhci-msm: Add msm8953 compatible
Date:   Wed, 12 Jan 2022 20:40:54 +0100
Message-Id: <20220112194118.178026-6-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112194118.178026-1-luca@z3ntu.xyz>
References: <20220112194118.178026-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add msm8953 SoC specific compatible strings for qcom-sdhci controller.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index 50841e2843fc..a62eaade5d97 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -14,6 +14,7 @@ Required properties:
 	full compatible strings with SoC and version:
 		"qcom,apq8084-sdhci", "qcom,sdhci-msm-v4"
 		"qcom,msm8226-sdhci", "qcom,sdhci-msm-v4"
+		"qcom,msm8953-sdhci", "qcom,sdhci-msm-v4"
 		"qcom,msm8974-sdhci", "qcom,sdhci-msm-v4"
 		"qcom,msm8916-sdhci", "qcom,sdhci-msm-v4"
 		"qcom,msm8992-sdhci", "qcom,sdhci-msm-v4"
-- 
2.34.1

