Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD9946E6CB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbhLIKjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:39:39 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54434 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbhLIKj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:39:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D4492CE2576;
        Thu,  9 Dec 2021 10:35:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301B4C341C3;
        Thu,  9 Dec 2021 10:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639046153;
        bh=emf2Yi1eiIxyrS0RiasyqhBYmlqekS8lTjt0MK+WlVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kyeISIHMzIkognjgqBabZSmwMiuLJs1DHt+hZmMVlBDxrO6VLEtQRuDkrbCEXLFOe
         1C5ce6G8ryXlc30rRsqbm18jW0mwDEhFuaw1B7shlHCIHlWCQggWL8PQ47jfkziq+A
         /1nS0mbrLNGRnHllLmxR0ViXl+bv4zrwd4UFlttahhArp4p2yMSIKr0ZGomx4qiJY5
         jsj13tiJ+fnJswJFiD9aqPM20T/YJhKx87nMhl/c9isUweLQDAkZ2dwTH0jZnxJIPt
         HKFxqLmH+gnlHkh6t6tRa4jjXD7owy1qC+Zfz3TnUFCw3iFxo9Kk6RbT+Xfu8B2StH
         4V77+s8fEDeAg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 12/13] arm64: dts: qcom: sm8450: add cpufreq support
Date:   Thu,  9 Dec 2021 16:05:04 +0530
Message-Id: <20211209103505.197453-13-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211209103505.197453-1-vkoul@kernel.org>
References: <20211209103505.197453-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

The change adds a description of a SM8450 cpufreq-epss controller and
references to it from CPU nodes.

Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index f303e12dbfb7..94bc8b352547 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -45,6 +45,7 @@ CPU0: cpu@0 {
 			next-level-cache = <&L2_0>;
 			power-domains = <&CPU_PD0>;
 			power-domain-names = "psci";
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_0: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -62,6 +63,7 @@ CPU1: cpu@100 {
 			next-level-cache = <&L2_100>;
 			power-domains = <&CPU_PD1>;
 			power-domain-names = "psci";
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_100: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -76,6 +78,7 @@ CPU2: cpu@200 {
 			next-level-cache = <&L2_200>;
 			power-domains = <&CPU_PD2>;
 			power-domain-names = "psci";
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_200: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -90,6 +93,7 @@ CPU3: cpu@300 {
 			next-level-cache = <&L2_300>;
 			power-domains = <&CPU_PD3>;
 			power-domain-names = "psci";
+			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_300: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -104,6 +108,7 @@ CPU4: cpu@400 {
 			next-level-cache = <&L2_400>;
 			power-domains = <&CPU_PD4>;
 			power-domain-names = "psci";
+			qcom,freq-domain = <&cpufreq_hw 1>;
 			L2_400: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -118,6 +123,7 @@ CPU5: cpu@500 {
 			next-level-cache = <&L2_500>;
 			power-domains = <&CPU_PD5>;
 			power-domain-names = "psci";
+			qcom,freq-domain = <&cpufreq_hw 1>;
 			L2_500: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -133,6 +139,7 @@ CPU6: cpu@600 {
 			next-level-cache = <&L2_600>;
 			power-domains = <&CPU_PD6>;
 			power-domain-names = "psci";
+			qcom,freq-domain = <&cpufreq_hw 1>;
 			L2_600: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -147,6 +154,7 @@ CPU7: cpu@700 {
 			next-level-cache = <&L2_700>;
 			power-domains = <&CPU_PD7>;
 			power-domain-names = "psci";
+			qcom,freq-domain = <&cpufreq_hw 2>;
 			L2_700: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -942,6 +950,21 @@ rpmhpd_opp_turbo_l1: opp10 {
 
 		};
 
+		cpufreq_hw: cpufreq@17d91000 {
+			compatible = "qcom,sm8450-cpufreq-epss", "qcom,cpufreq-epss";
+			reg = <0 0x17d91000 0 0x1000>,
+			      <0 0x17d92000 0 0x1000>,
+			      <0 0x17d93000 0 0x1000>;
+			reg-names = "freq-domain0", "freq-domain1", "freq-domain2";
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
+			clock-names = "xo", "alternate";
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dcvsh-irq-0", "dcvsh-irq-1", "dcvsh-irq-2";
+			#freq-domain-cells = <1>;
+		};
+
 		gem_noc: interconnect@19100000 {
 			compatible = "qcom,sm8450-gem-noc";
 			reg = <0 0x19100000 0 0xbb800>;
-- 
2.31.1

