Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F26464884
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347607AbhLAHdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:33:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60456 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347621AbhLAHdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:33:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB83AB81DE8;
        Wed,  1 Dec 2021 07:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454DEC53FCE;
        Wed,  1 Dec 2021 07:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343797;
        bh=UecTKToUF3fuoVqhV5HcpAyYCXlW6vF0oJOewbWkneY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aMRMyYU0CLjVNQn4TcWiQzRneNvTeQOFHWgu7gLOQBrTEL/JFX1etQm0RPcwZfCjb
         Or12JRHlXHvzVIJd8W5RQoY3htsGOhPzkNB5NAL92q8Yem1lwFY+NQuZoC7k4jT0IP
         Y619K3hRz0xBJ1LF9rbPlm2j36ut1l9xGnFhiA13B6p8e2JbAyVQXfbKbXeJb28XNK
         Q4kPWVtydANGUUqX30eo1AxI6ukHE0kX8eKS3JQYmAkkgR2RdEYnZwA9FubS8eHw4p
         VIcvUOfIc7aJaX/V8CM3dlhWBK+BV3mQa/081CKkOUrVxLzEInL157EnkZ1NXZ9J/u
         lxRHF7ItfiWdg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] arm64: dts: qcom: sm8450-qrd: include pmic files
Date:   Wed,  1 Dec 2021 12:59:12 +0530
Message-Id: <20211201072915.3969178-13-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201072915.3969178-1-vkoul@kernel.org>
References: <20211201072915.3969178-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM8450 QRD platform has bunch of PMICs, include the common ones PM8350,
PM8350b and PMR735b

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450-qrd.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
index 3e65d662ab8c..48228888f500 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
@@ -8,6 +8,9 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sm8450.dtsi"
+#include "pm8350.dtsi"
+#include "pm8350b.dtsi"
+#include "pmr735b.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. SM8450 QRD";
-- 
2.31.1

