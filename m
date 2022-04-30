Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A9D515F0F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 18:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383081AbiD3Q1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 12:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382977AbiD3Q1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 12:27:25 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF645F8D3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 09:24:03 -0700 (PDT)
Received: from localhost.localdomain (abxh26.neoplus.adsl.tpnet.pl [83.9.1.26])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 25EB43F731;
        Sat, 30 Apr 2022 18:24:01 +0200 (CEST)
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
Subject: [PATCH 04/14] arm64: dts: qcom: msm8998-yoshino-lilac: Disable LVS1
Date:   Sat, 30 Apr 2022 18:23:42 +0200
Message-Id: <20220430162353.607709-4-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220430162353.607709-1-konrad.dybcio@somainline.org>
References: <20220430162353.607709-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's disabled on downstream, follow it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-lilac.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-lilac.dts b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-lilac.dts
index caacb7c28402..fcaefc1b1e2f 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-lilac.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-lilac.dts
@@ -29,3 +29,7 @@ &vreg_l22a_2p85 {
 	regulator-min-microvolt = <2800000>;
 	regulator-max-microvolt = <2800000>;
 };
+
+&vreg_lvs1a_1p8 {
+	status = "disabled";
+};
-- 
2.35.2

