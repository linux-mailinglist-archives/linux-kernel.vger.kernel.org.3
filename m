Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D63E4804F2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 22:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbhL0Vwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 16:52:55 -0500
Received: from ixit.cz ([94.230.151.217]:48642 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229728AbhL0Vwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 16:52:55 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 7B26C2243C;
        Mon, 27 Dec 2021 22:52:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1640641972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=u3VD4X345O68uaZNqZvUhlwb1CDjiiPvV1FJOjvoHN8=;
        b=s5YLM8OaA+PnWvdiQhIjk3f46wIu6x0meY0Dk5cWK0SqChTFOtCKHFkGk/JRKmxO1N0e3U
        H2UM68QkD1aylkaGlcNirCIRprtBvtMGcZk91NUZDhirTz8RBGf5L77jugvk11LDF+yng4
        FqPBVcPh+/CAmUy9hiqaf+VCRpXHKg4=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: pms405: assign device specific compatible
Date:   Mon, 27 Dec 2021 22:52:37 +0100
Message-Id: <20211227215238.113956-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow common pattern for this device, first specific
and then generic compatible.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/pms405.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
index 172be177fc8f..98d173a377d5 100644
--- a/arch/arm64/boot/dts/qcom/pms405.dtsi
+++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
@@ -32,7 +32,7 @@ pms405_crit: pms405-crit {
 
 &spmi_bus {
 	pms405_0: pms405@0 {
-		compatible = "qcom,spmi-pmic";
+		compatible = "qcom,pms405", "qcom,spmi-pmic";
 		reg = <0x0 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -139,7 +139,7 @@ rtc@6000 {
 	};
 
 	pms405_1: pms405@1 {
-		compatible = "qcom,spmi-pmic";
+		compatible = "qcom,pms405", "qcom,spmi-pmic";
 		reg = <0x1 SPMI_USID>;
 
 		pms405_spmi_regulators: regulators {
-- 
2.34.1

