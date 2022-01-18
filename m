Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A52F4913B7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244351AbiARBjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244272AbiARBiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:38:25 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4771C06173E;
        Mon, 17 Jan 2022 17:38:24 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id u21so72857248edd.5;
        Mon, 17 Jan 2022 17:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FK6u2FLB6MoMO+1EQ+GjM1uvRkKVrC3suh/EkaZcZyo=;
        b=DTSaOzdwCqLa3dYnPwoPmAfnGkes37NcsdLA0D846Pug4ADJ1nXOKxV66vUvhzykNv
         rj+0SgrPE80eKKb5ZbZfKuc0z6nDiZLsRUGAa3FCY4YrBfKw9Y1jyEvUHVGfq/vgQKsI
         da+fmxH/2N3qoJRr/kg49VPzdEud2FAGaxBg8aOO+of0zGqQpksoJ+V9/KwyMYnSOH3k
         mJkgZucJXDiEbt9VFSkMH717zksedwM3n+gjBeZ6VeBjzZPO3BvpnGZ/evH93rA9Jzwx
         isfCNkwECx5/CDhdLxfINFT3YRQnW+rI6AHhs5E2oFwEr1W3d+JMU2R12K1Z/ZCotlGw
         8Yeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FK6u2FLB6MoMO+1EQ+GjM1uvRkKVrC3suh/EkaZcZyo=;
        b=fmLmBkO01rnsx1d2k9P8LTYeADPhimnvGP+crxcKw6fHp+QEBEyJKzL5tHPbIbH+tm
         stWNgbR2cXvc+NImmi92585F5SfZfK9Vwe3lhkomi2i7cHYyICik5d4O66oWJDkE0Zfd
         t3KkJGJplNaxcL+LMSXtD0cuZHBTyLc3u2nvdAn4Z06D1L2lNn9c3t3pdfC8czhT/DyV
         3wxAYEtEEx1FO446WO6IAU4iQrd84zyO2LG6gT9Qk8gsLIgY0tfMumZDEgM1sh7PvNaq
         hIRQaoLtim54T3hsyN0NJSHrxg8sbLEY+QTN0obVFBiGaf3jrIilImglgjyflRiMCwkn
         /qFA==
X-Gm-Message-State: AOAM530tsJRUZ+RCK22v8nQXmFu9vHHhhY5oPWDn9sICsOCfYrkjY0vB
        YheSD6KmVtp1rv+qIoj5JA4=
X-Google-Smtp-Source: ABdhPJzWmAGRoDNfTvQ65SOZ9KtqLEzamMPTTYfCq4O5jBw7ZFp7VAkgQRSDOlk1XOaTfu5tV1IEuA==
X-Received: by 2002:a50:a452:: with SMTP id v18mr23846797edb.55.1642469903332;
        Mon, 17 Jan 2022 17:38:23 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id kj18sm3990675ejc.139.2022.01.17.17.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:38:22 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 14/17] ARM: dts: qcom: add multiple missing binding for cpu and l2 for ipq8064
Date:   Tue, 18 Jan 2022 02:20:45 +0100
Message-Id: <20220118012051.21691-16-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118012051.21691-1-ansuelsmth@gmail.com>
References: <20220118012051.21691-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add multiple binding for cpu node, l2 node and add idle-states
definition for ipq8064 dtsi.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 36 +++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index a1a809134d9e..e4a2b95699c7 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -30,6 +30,16 @@ cpu0: cpu@0 {
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc0>;
 			qcom,saw = <&saw0>;
+			clocks = <&kraitcc 0>, <&kraitcc 4>;
+			clock-names = "cpu", "l2";
+			clock-latency = <100000>;
+			cpu-supply = <&smb208_s2a>;
+			operating-points-v2 = <&opp_table0>;
+			voltage-tolerance = <5>;
+			cooling-min-state = <0>;
+			cooling-max-state = <10>;
+			#cooling-cells = <2>;
+			cpu-idle-states = <&CPU_SPC>;
 		};
 
 		cpu1: cpu@1 {
@@ -40,11 +50,37 @@ cpu1: cpu@1 {
 			next-level-cache = <&L2>;
 			qcom,acc = <&acc1>;
 			qcom,saw = <&saw1>;
+			clocks = <&kraitcc 1>, <&kraitcc 4>;
+			clock-names = "cpu", "l2";
+			clock-latency = <100000>;
+			cpu-supply = <&smb208_s2b>;
+			operating-points-v2 = <&opp_table0>;
+			voltage-tolerance = <5>;
+			cooling-min-state = <0>;
+			cooling-max-state = <10>;
+			#cooling-cells = <2>;
+			cpu-idle-states = <&CPU_SPC>;
+		};
+
+		idle-states {
+			CPU_SPC: spc {
+				compatible = "qcom,idle-state-spc";
+				status = "disabled";
+				entry-latency-us = <400>;
+				exit-latency-us = <900>;
+				min-residency-us = <3000>;
+			};
 		};
 
 		L2: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
+			qcom,saw = <&saw_l2>;
+
+			clocks = <&kraitcc 4>;
+			clock-names = "l2";
+			l2-supply = <&smb208_s1a>;
+			operating-points-v2 = <&opp_table_l2>;
 		};
 	};
 
-- 
2.33.1

