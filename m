Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4CD50291C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 13:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352856AbiDOL7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 07:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352751AbiDOL7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 07:59:16 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409D4A94CB;
        Fri, 15 Apr 2022 04:56:47 -0700 (PDT)
Received: from localhost.localdomain (abxj52.neoplus.adsl.tpnet.pl [83.9.3.52])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 5272C3F691;
        Fri, 15 Apr 2022 13:56:45 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/23] ARM: dts: qcom-msm8974*: Fix I2C labels
Date:   Fri, 15 Apr 2022 13:56:14 +0200
Message-Id: <20220415115633.575010-5-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415115633.575010-1-konrad.dybcio@somainline.org>
References: <20220415115633.575010-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up the label names and add missing ones.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index e102b72558f1..a74563c6f068 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -957,7 +957,7 @@ msmgpio: pinctrl@fd510000 {
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		i2c@f9923000 {
+		blsp1_i2c1: i2c@f9923000 {
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9923000 0x1000>;
@@ -968,7 +968,7 @@ i2c@f9923000 {
 			#size-cells = <0>;
 		};
 
-		i2c@f9924000 {
+		blsp1_i2c2: i2c@f9924000 {
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9924000 0x1000>;
@@ -979,7 +979,7 @@ i2c@f9924000 {
 			#size-cells = <0>;
 		};
 
-		blsp_i2c3: i2c@f9925000 {
+		blsp1_i2c3: i2c@f9925000 {
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9925000 0x1000>;
@@ -990,7 +990,7 @@ blsp_i2c3: i2c@f9925000 {
 			#size-cells = <0>;
 		};
 
-		blsp_i2c6: i2c@f9928000 {
+		blsp1_i2c6: i2c@f9928000 {
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9928000 0x1000>;
@@ -1001,7 +1001,7 @@ blsp_i2c6: i2c@f9928000 {
 			#size-cells = <0>;
 		};
 
-		blsp_i2c8: i2c@f9964000 {
+		blsp2_i2c2: i2c@f9964000 {
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9964000 0x1000>;
@@ -1012,7 +1012,7 @@ blsp_i2c8: i2c@f9964000 {
 			#size-cells = <0>;
 		};
 
-		blsp_i2c11: i2c@f9967000 {
+		blsp2_i2c5: i2c@f9967000 {
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9967000 0x1000>;
@@ -1025,7 +1025,7 @@ blsp_i2c11: i2c@f9967000 {
 			dma-names = "tx", "rx";
 		};
 
-		blsp_i2c12: i2c@f9968000 {
+		blsp2_i2c6: i2c@f9968000 {
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9968000 0x1000>;
-- 
2.35.2

