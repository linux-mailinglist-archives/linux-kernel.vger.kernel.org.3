Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EEB463FFE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbhK3V13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:27:29 -0500
Received: from relay06.th.seeweb.it ([5.144.164.167]:60367 "EHLO
        relay06.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344029AbhK3V1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 16:27:11 -0500
Received: from localhost.localdomain (adsl-d210.84-47-0.t-com.sk [84.47.0.210])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 1A5123F585;
        Tue, 30 Nov 2021 22:23:48 +0100 (CET)
From:   Martin Botka <martin.botka@somainline.org>
To:     martin.botka1@gmail.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        paul.bouchara@somainline.org,
        Martin Botka <martin.botka@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dt: sm6125: Add power domains to sdhc
Date:   Tue, 30 Nov 2021 22:23:32 +0100
Message-Id: <20211130212332.25401-4-martin.botka@somainline.org>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211130212332.25401-1-martin.botka@somainline.org>
References: <20211130212332.25401-1-martin.botka@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RPM Power Domains to internal eMMC and SDCard.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
---
 arch/arm64/boot/dts/qcom/sm6125.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index 1e280c4d402d..b5471bf9fbc4 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -460,6 +460,9 @@ sdhc_1: sdhci@4744000 {
 				 <&gcc GCC_SDCC1_APPS_CLK>,
 				 <&xo_board>;
 			clock-names = "iface", "core", "xo";
+
+			power-domains = <&rpmpd SM6125_VDDCX>;
+
 			bus-width = <8>;
 			non-removable;
 			status = "disabled";
@@ -483,6 +486,8 @@ sdhc_2: sdhci@4784000 {
 			pinctrl-1 = <&sdc2_state_off>;
 			pinctrl-names = "default", "sleep";
 
+			power-domains = <&rpmpd SM6125_VDDCX>;
+
 			bus-width = <4>;
 			status = "disabled";
 		};
-- 
2.34.0

