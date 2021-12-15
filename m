Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45C3475E30
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245153AbhLORHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 12:07:37 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:39692 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbhLORHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:07:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1639588056; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=klyI/FnBhc37XmbYzTlJCHIPfhTWx4QvxgD/m6XT+ZA=; b=mHnZdU4A8vj7p8QPfz6Bl/bALoTUNm5lEjar4yrNNDwr59BV/DyRjzHy9Yq4oJzoalPp7grl
 /70yub+oh3p0JqwgqAms00m39BmXdqhlsGVu/DdnF45TO5ijMQI5KWWRvoOCcMgfcXxpVrzi
 nGt9PIKvCOmNJAZBInK+SWgnWjo=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 61ba2092df12ba53c47dc137 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 15 Dec 2021 17:06:26
 GMT
Sender: bgodavar=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 645CDC4338F; Wed, 15 Dec 2021 17:06:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from bgodavar-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 48447C43616;
        Wed, 15 Dec 2021 17:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 48447C43616
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        bjorn.andersson@linaro.org
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        rjliao@codeaurora.org, hbandi@codeaurora.org,
        abhishekpandit@chromium.org, mcchou@chromium.org,
        saluvala@codeaurora.org
Subject: [PATCH v4] arm64: dts: qcom: sc7280: Add bluetooth node on SC7280 IDP boards
Date:   Wed, 15 Dec 2021 22:36:03 +0530
Message-Id: <1639587963-22503-1-git-send-email-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bluetooth SoC WCN6750 node for SC7280 IDP boards.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
v4:
  * updated commit subject
  * Removed drive strength for bt_en
  * updated swctrl_gpio name to sw_ctrl

v3:
  * Addressed reviewers comments
  * Added pin config for sw_ctrl line.
v2:
  * merged two patches into one
  * Removed unused comments
  * Removed pinmux & pin conf.
  * Addressed reviewers comments

v1: initial patch
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dts  |  4 ++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 36 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp2.dts |  4 ++++
 3 files changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
index 9b991ba..19bd228 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
@@ -56,6 +56,10 @@
 	};
 };
 
+&bluetooth {
+	vddio-supply = <&vreg_l19b_1p8>;
+};
+
 &ipa {
 	status = "okay";
 	modem-init;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index d623d71..a146d0d 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -14,6 +14,11 @@
 #include "pmk8350.dtsi"
 
 / {
+	aliases {
+		bluetooth0 = &bluetooth;
+		serial1 = &uart7;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		label = "gpio-keys";
@@ -422,6 +427,23 @@
 				<&tlmm 31 IRQ_TYPE_EDGE_FALLING>;
 	pinctrl-names = "default", "sleep";
 	pinctrl-1 = <&qup_uart7_sleep_cts>, <&qup_uart7_sleep_rts>, <&qup_uart7_sleep_tx>, <&qup_uart7_sleep_rx>;
+
+	bluetooth: bluetooth {
+		compatible = "qcom,wcn6750-bt";
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_en>, <&sw_ctrl>;
+		enable-gpios = <&tlmm 85 GPIO_ACTIVE_HIGH>;
+		swctrl-gpios = <&tlmm 86 GPIO_ACTIVE_HIGH>;
+		vddaon-supply = <&vreg_s7b_0p9>;
+		vddbtcxmx-supply = <&vreg_s7b_0p9>;
+		vddrfacmn-supply = <&vreg_s7b_0p9>;
+		vddrfa0p8-supply = <&vreg_s7b_0p9>;
+		vddrfa1p7-supply = <&vreg_s1b_1p8>;
+		vddrfa1p2-supply = <&vreg_s8b_1p2>;
+		vddrfa2p2-supply = <&vreg_s1c_2p2>;
+		vddasd-supply = <&vreg_l11c_2p8>;
+		max-speed = <3200000>;
+	};
 };
 
 /* PINCTRL - additions to nodes defined in sc7280.dtsi */
@@ -491,6 +513,13 @@
 };
 
 &tlmm {
+	bt_en: bt-en {
+		pins = "gpio85";
+		function = "gpio";
+		output-low;
+		bias-disable;
+	};
+
 	nvme_pwren: nvme-pwren {
 		function = "gpio";
 	};
@@ -554,6 +583,13 @@
 		 */
 		bias-pull-up;
 	};
+
+	sw_ctrl: sw-ctrl {
+		pins = "gpio86";
+		function = "gpio";
+		input-enable;
+		bias-pull-down;
+	};
 };
 
 &sdc1_on {
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp2.dts b/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
index 0382c77..73b9911 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
@@ -23,6 +23,10 @@
 	};
 };
 
+&bluetooth {
+	vddio-supply = <&vreg_l18b_1p8>;
+};
+
 &nvme_pwren {
 	pins = "gpio51";
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

