Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7954DE9C7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 18:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243806AbiCSRss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 13:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243745AbiCSRsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 13:48:35 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693972467EA;
        Sat, 19 Mar 2022 10:47:13 -0700 (PDT)
Received: from localhost.localdomain (abxi119.neoplus.adsl.tpnet.pl [83.9.2.119])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 9DF813F3EF;
        Sat, 19 Mar 2022 18:47:10 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/15] arm64: dts: qcom: msm8994: Fix the cont_splash_mem address
Date:   Sat, 19 Mar 2022 18:46:38 +0100
Message-Id: <20220319174645.340379-9-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220319174645.340379-1-konrad.dybcio@somainline.org>
References: <20220319174645.340379-1-konrad.dybcio@somainline.org>
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

The default memory map places cont_splash_mem at 3401000, which was
overlooked.. Fix it!

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/msm8994.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index 195d8de4cd5a..a2210cf9d0b4 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -185,8 +185,8 @@ dfps_data_mem: dfps_data_mem@3400000 {
 			no-map;
 		};
 
-		cont_splash_mem: memory@3800000 {
-			reg = <0 0x03800000 0 0x2400000>;
+		cont_splash_mem: memory@3401000 {
+			reg = <0 0x03401000 0 0x2200000>;
 			no-map;
 		};
 
-- 
2.35.1

