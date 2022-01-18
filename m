Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250BA4913A8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbiARBip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244255AbiARBiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:38:23 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB43C061401;
        Mon, 17 Jan 2022 17:38:23 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id k15so72769267edk.13;
        Mon, 17 Jan 2022 17:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/xnjALTE4GUZWLEucsN9ZO+gHwONpdsr4uSLtIO8uFM=;
        b=pKzotgzWjgdM4B1AZNXtY2VhlyZpT5r0NdFzcga0Fh5gJzhSuHo+Q//+xcMjks8g91
         MdOsF3fZ3CZW+rV+BAMbVmhLWbcerGF3phV56RpiY7KaVs2fUhEwJHRvxqCZEexun9KO
         nl1cO+8V+duS715t5XkT6XC6ykuYEgJdYwA+iP5qFsSv4IOih/K7rD5lMJ0gGgt8s1M6
         1qmFqtP+EEVr01/BbG5z3ziatgNsngweYP1rw50he7oEQbAjsuuCW5UVG8O7Emz6sv00
         pak8/YqMH7k5ybsS6LFeXMmK4UMH7Ad8H+lpl3R7Lku6spQZQww4uap9RhRc2Eloo68r
         uz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/xnjALTE4GUZWLEucsN9ZO+gHwONpdsr4uSLtIO8uFM=;
        b=rUcS3ZFyXIeAr4ZtGT+VkDqmGzZCyLeD4CGr0NP98zoLxHEcRjmtIVdE4gFW/0qmKJ
         f/2z1b5fHvZxqpvFsD/qypTUMbUznRk54g0sXjSAmKtRvdt8ybakzgAd6Oh7Z86EZl8G
         RLt/4Bb8yXBfYhJYHymQPRCeGiHrW6CCjxwJrETqzQ5cTm0LGd0sdmRFFyYkufWRj73x
         jF2PmSsXCvqiiS2NeAVuvurz8jEZpFzjELqdlyxKWA7+ZSaU1BG7ZpAfN+DnCOD/N6N9
         2mNYBdJnSM09JcUTelOvobD9DhUT2Wo/091voNrZw0CQDaXonUXCVuzyOT9NQGig3VQr
         cXJQ==
X-Gm-Message-State: AOAM533OjNf/xlTJRfxDraT91FV7FjWMpG3N402QKVW3H+EVQu9+wdNh
        saw6wx3ZgIlcj+O07HWqTuHAtD6JDS8=
X-Google-Smtp-Source: ABdhPJzvmld0ItRFawTC7FZd+NhWLif4D+qXMfC3f+AYCqMy7WLyu3W1mHnfK0YDrm9KqnRnfepV9w==
X-Received: by 2002:a05:6402:51cd:: with SMTP id r13mr10665608edd.139.1642469901576;
        Mon, 17 Jan 2022 17:38:21 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id kj18sm3990675ejc.139.2022.01.17.17.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:38:21 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 13/16] ARM: dts: qcom: add multiple missing binding for cpu and l2 for ipq8064
Date:   Tue, 18 Jan 2022 02:20:43 +0100
Message-Id: <20220118012051.21691-14-ansuelsmth@gmail.com>
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
index 1e6297d6f302..34f4fc249a52 100644
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

