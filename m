Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03B353D77E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 17:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237765AbiFDPaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 11:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbiFDPaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 11:30:10 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F4650473;
        Sat,  4 Jun 2022 08:30:07 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n10so21160004ejk.5;
        Sat, 04 Jun 2022 08:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3bk7baS2SNynPNN4B6G8lp7hpcyD8ZFLbXx8vqds4tM=;
        b=QVHu+WBPZB67UwBQxVrKxY+BylBP8feaLPaDi0O5fCJuLupUHPjv41RD9TA/ljh/UI
         3OJHeY6K5MdvviD1q1q+HqWrMDh8WL9k5gy1h5AQth72cWe+2kPQRvA6+XgMilKWTHuQ
         bI+wRFGvmAaBJKCLFRyeMl3Qoac/Gx1TNDxdn5Dkd9cToXVAXsGlb4dmsNk2MPyMR8lX
         6JUITLd5W6pQHscw3dxfwKqWNB9WCaDa9dhNjf74vKQv9oRQCxULGSlxJU5OViRiU/UB
         aJbWHVHQgyLAPC/Oi5zyO3A5R2+bnNeLZD7fIlR2Rt3Uw1GNyq8UJVzhjzfKVWf7YabA
         klPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3bk7baS2SNynPNN4B6G8lp7hpcyD8ZFLbXx8vqds4tM=;
        b=jggchCeZCt4sL61X/XIAtR4NHofE2kgoW4PEqN1rJ6Wf/4M6ccaftMMHXb/uK+rxVM
         +Bf2MjILtOakpTxddn+NBN6pI8g4/52ZIDNzLYuzb8KbzgXDkqZ4iO3ArsBJVEayY57U
         LiwX+tnhBhKGk1Rz72zW3rlgFNptLOOIrSQcAeyL5oTw/Ey5ywByCqinSyVH03a3W7iX
         80ZrpxA0UQITRA+AY0Usb9vJ9PaRrpuaF70UNA+uUTzMTq5jl6oKAFMlZZEJoetaPGj0
         m5mklltpdHLbiwWfwRz5xQzpynFFmXowQ83iatFpmjSR9yHcM480B6qj2IxeUw7h/XZa
         iEPg==
X-Gm-Message-State: AOAM533bhJE2j/k4qFDQDO8MhAZ1ZvuT8vXOTOfpBMsb1wiUohOdgejN
        ErcmlEp62On86/niV9B4Og4=
X-Google-Smtp-Source: ABdhPJzCyjjZCIsbjsxVOA5l13Qm04uEQWHvW8LtSgGavAFKukbQEvvnWXzh3QUYeNqsht4LsLtF6Q==
X-Received: by 2002:a17:906:ae57:b0:70b:e847:271b with SMTP id lf23-20020a170906ae5700b0070be847271bmr11034710ejb.700.1654356606421;
        Sat, 04 Jun 2022 08:30:06 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-43.zg.cable.xnet.hr. [94.253.165.43])
        by smtp.googlemail.com with ESMTPSA id hz10-20020a1709072cea00b0070e01426360sm2069250ejc.91.2022.06.04.08.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 08:30:05 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH] arm64: dts: qcom: ipq6018: correct QUP peripheral labels
Date:   Sat,  4 Jun 2022 17:30:03 +0200
Message-Id: <20220604153003.55172-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current QUP peripheral labels like spi_0 and i2c_0 dont really tell what is
the exact QUP HW being used as there are actually 6 identical QUP HW blocks
for UART, SPI and I2C.
For example current i2c_0 label actually points to the QUP2 I2C HW.

This style of labeling does not follow what the rest of Qualcomm SoC-s use,
for example IPQ8074 which has the identical QUP blocks.
It also makes it really hard to add the missing QUP DT nodes as there are
multiple missing.

So utilize the same style as other Qualcomm SoC-s are using and update the
CP01 DTS as its the current sole user of them.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts | 4 ++--
 arch/arm64/boot/dts/qcom/ipq6018.dtsi        | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
index 5aec18308712..b603961c5831 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
+++ b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
@@ -29,13 +29,13 @@ &blsp1_uart3 {
 	status = "okay";
 };
 
-&i2c_1 {
+&blsp1_i2c3 {
 	pinctrl-0 = <&i2c_1_pins>;
 	pinctrl-names = "default";
 	status = "okay";
 };
 
-&spi_0 {
+&blsp1_spi1 {
 	cs-select = <0>;
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index aac56575e30d..1c3f3d521715 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -282,7 +282,7 @@ blsp1_uart3: serial@78b1000 {
 			status = "disabled";
 		};
 
-		spi_0: spi@78b5000 {
+		blsp1_spi1: spi@78b5000 {
 			compatible = "qcom,spi-qup-v2.2.1";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -297,7 +297,7 @@ spi_0: spi@78b5000 {
 			status = "disabled";
 		};
 
-		spi_1: spi@78b6000 {
+		blsp1_spi2: spi@78b6000 {
 			compatible = "qcom,spi-qup-v2.2.1";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -312,7 +312,7 @@ spi_1: spi@78b6000 {
 			status = "disabled";
 		};
 
-		i2c_0: i2c@78b6000 {
+		blsp1_i2c2: i2c@78b6000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -327,7 +327,7 @@ i2c_0: i2c@78b6000 {
 			status = "disabled";
 		};
 
-		i2c_1: i2c@78b7000 { /* BLSP1 QUP2 */
+		blsp1_i2c3: i2c@78b7000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.36.1

