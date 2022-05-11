Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD931523D16
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346615AbiEKTHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346587AbiEKTHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:07:34 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867006C0D5;
        Wed, 11 May 2022 12:07:33 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 3344D3F866;
        Wed, 11 May 2022 21:07:31 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: [PATCH v3 3/4] arm64: dts: qcom: pm660l: Add LPG node
Date:   Wed, 11 May 2022 21:07:17 +0200
Message-Id: <20220511190718.764445-3-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220511190718.764445-1-marijn.suijten@somainline.org>
References: <20220511190718.764445-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Light Pulse Generator describes a hardware block responsible for
displaying colors and patterns on an RGB LED (usually used for [battery]
status and notifications), and drive PWM signals for general-purpose
(ie. backlight) LEDs.  The availability and usage of the individual
channels differ per board and is hence left for individual platform DTs
to configure.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 arch/arm64/boot/dts/qcom/pm660l.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm660l.dtsi b/arch/arm64/boot/dts/qcom/pm660l.dtsi
index cfef42353611..636b8d398d96 100644
--- a/arch/arm64/boot/dts/qcom/pm660l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660l.dtsi
@@ -65,6 +65,15 @@ pmic@3 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pm660l_lpg: lpg@b100 {
+			compatible = "qcom,pm660l-lpg";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+		};
+
 		pm660l_wled: leds@d800 {
 			compatible = "qcom,pm660l-wled";
 			reg = <0xd800 0xd900>;
-- 
2.36.1

