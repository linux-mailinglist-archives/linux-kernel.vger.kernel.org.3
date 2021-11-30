Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C820464006
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344128AbhK3V1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:27:36 -0500
Received: from m-r2.th.seeweb.it ([5.144.164.171]:33593 "EHLO
        m-r2.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344027AbhK3V1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 16:27:12 -0500
Received: from localhost.localdomain (adsl-d210.84-47-0.t-com.sk [84.47.0.210])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 6D2F33F4E8;
        Tue, 30 Nov 2021 22:23:47 +0100 (CET)
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
Subject: [PATCH 3/4] arm64: dt: sm6125: Add RPMPD node
Date:   Tue, 30 Nov 2021 22:23:31 +0100
Message-Id: <20211130212332.25401-3-martin.botka@somainline.org>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211130212332.25401-1-martin.botka@somainline.org>
References: <20211130212332.25401-1-martin.botka@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RPM Power Distribution node for sm6125 SoC.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
---
 arch/arm64/boot/dts/qcom/sm6125.dtsi | 50 ++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index 78f4705e4117..1e280c4d402d 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -303,6 +303,56 @@ rpmcc: clock-controller {
 				compatible = "qcom,rpmcc-sm6125", "qcom,rpmcc";
 				#clock-cells = <1>;
 			};
+
+			rpmpd: power-controller {
+				compatible = "qcom,sm6125-rpmpd";
+				#power-domain-cells = <1>;
+				operating-points-v2 = <&rpmpd_opp_table>;
+
+				rpmpd_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					rpmpd_opp_ret: opp1 {
+						opp-level = <RPM_SMD_LEVEL_RETENTION>;
+					};
+
+					rpmpd_opp_ret_plus: opp2 {
+						opp-level = <RPM_SMD_LEVEL_RETENTION_PLUS>;
+					};
+
+					rpmpd_opp_min_svs: opp3 {
+						opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
+					};
+
+					rpmpd_opp_low_svs: opp4 {
+						opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
+					};
+
+					rpmpd_opp_svs: opp5 {
+						opp-level = <RPM_SMD_LEVEL_SVS>;
+					};
+
+					rpmpd_opp_svs_plus: opp6 {
+						opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
+					};
+
+					rpmpd_opp_nom: opp7 {
+						opp-level = <RPM_SMD_LEVEL_NOM>;
+					};
+
+					rpmpd_opp_nom_plus: opp8 {
+						opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
+					};
+
+					rpmpd_opp_turbo: opp9 {
+						opp-level = <RPM_SMD_LEVEL_TURBO>;
+					};
+
+					rpmpd_opp_turbo_no_cpr: opp10 {
+						opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
+					};
+				};
+			};
 		};
 	};
 
-- 
2.34.0

