Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA485500CC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383608AbiFQXcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbiFQXcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:32:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CDA66F9C;
        Fri, 17 Jun 2022 16:31:59 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DC947660179F;
        Sat, 18 Jun 2022 00:31:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655508718;
        bh=n9sLhXNjmusuOMKUZekzYGCFTzx5wo77t60SpQPcB2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XFMD22ifwYgUxcvg2bKgPykOy7shu9KUsdax9wZ3PJ6YXV62bc4b6NEzNoKsXPz7s
         fbjMS499RlRKUM1uTufD5/C+OXIvO6D1o5ZkB1NGtc2YaPzQ6O6wTPwKQqjSMA2wVm
         lXycfrw0SR/m0pYa51g88/guIbJjgZKHYJixJHY4tYSEaiLHn9cOEUE6vj/CcC6FI+
         0JWJUCsQrcC9wKajzDp3tbehurfxrfR9nk++QVRIhikTnbSLBqMJqgQ2BQ/uNPrzAp
         +rIqI/e7DMNhWj44WAzA+afrPCrV/zH+FT6lhXA6wXk3PX2xeHQ+r7DQ1cNXMX67mj
         0L/YyN4iQH4Rw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, James Liao <jamesjj.liao@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/2] arm64: dts: mt8192: Fix idle-states nodes naming scheme
Date:   Fri, 17 Jun 2022 19:31:49 -0400
Message-Id: <20220617233150.2466344-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220617233150.2466344-1-nfraprado@collabora.com>
References: <20220617233150.2466344-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tweak the name of the idle-states subnodes so that they follow the
binding pattern, getting rid of dtbs_check warnings.

Only the usage of "-" in the name was necessary, but "off" was also
exchanged for "sleep" since that seems to be a more common wording in
other dts files.

Fixes: 9260918d3a4f ("arm64: dts: mt8192: Add cpu-idle-states")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 733aec2e7f77..c739e910883a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -43,7 +43,7 @@ cpu0: cpu@0 {
 			reg = <0x000>;
 			enable-method = "psci";
 			clock-frequency = <1701000000>;
-			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
+			cpu-idle-states = <&cpu_sleep_l &cluster_sleep_l>;
 			next-level-cache = <&l2_0>;
 			capacity-dmips-mhz = <530>;
 		};
@@ -54,7 +54,7 @@ cpu1: cpu@100 {
 			reg = <0x100>;
 			enable-method = "psci";
 			clock-frequency = <1701000000>;
-			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
+			cpu-idle-states = <&cpu_sleep_l &cluster_sleep_l>;
 			next-level-cache = <&l2_0>;
 			capacity-dmips-mhz = <530>;
 		};
@@ -65,7 +65,7 @@ cpu2: cpu@200 {
 			reg = <0x200>;
 			enable-method = "psci";
 			clock-frequency = <1701000000>;
-			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
+			cpu-idle-states = <&cpu_sleep_l &cluster_sleep_l>;
 			next-level-cache = <&l2_0>;
 			capacity-dmips-mhz = <530>;
 		};
@@ -76,7 +76,7 @@ cpu3: cpu@300 {
 			reg = <0x300>;
 			enable-method = "psci";
 			clock-frequency = <1701000000>;
-			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
+			cpu-idle-states = <&cpu_sleep_l &cluster_sleep_l>;
 			next-level-cache = <&l2_0>;
 			capacity-dmips-mhz = <530>;
 		};
@@ -87,7 +87,7 @@ cpu4: cpu@400 {
 			reg = <0x400>;
 			enable-method = "psci";
 			clock-frequency = <2171000000>;
-			cpu-idle-states = <&cpuoff_b &clusteroff_b>;
+			cpu-idle-states = <&cpu_sleep_b &cluster_sleep_b>;
 			next-level-cache = <&l2_1>;
 			capacity-dmips-mhz = <1024>;
 		};
@@ -98,7 +98,7 @@ cpu5: cpu@500 {
 			reg = <0x500>;
 			enable-method = "psci";
 			clock-frequency = <2171000000>;
-			cpu-idle-states = <&cpuoff_b &clusteroff_b>;
+			cpu-idle-states = <&cpu_sleep_b &cluster_sleep_b>;
 			next-level-cache = <&l2_1>;
 			capacity-dmips-mhz = <1024>;
 		};
@@ -109,7 +109,7 @@ cpu6: cpu@600 {
 			reg = <0x600>;
 			enable-method = "psci";
 			clock-frequency = <2171000000>;
-			cpu-idle-states = <&cpuoff_b &clusteroff_b>;
+			cpu-idle-states = <&cpu_sleep_b &cluster_sleep_b>;
 			next-level-cache = <&l2_1>;
 			capacity-dmips-mhz = <1024>;
 		};
@@ -120,7 +120,7 @@ cpu7: cpu@700 {
 			reg = <0x700>;
 			enable-method = "psci";
 			clock-frequency = <2171000000>;
-			cpu-idle-states = <&cpuoff_b &clusteroff_b>;
+			cpu-idle-states = <&cpu_sleep_b &cluster_sleep_b>;
 			next-level-cache = <&l2_1>;
 			capacity-dmips-mhz = <1024>;
 		};
@@ -173,7 +173,7 @@ l3_0: l3-cache {
 
 		idle-states {
 			entry-method = "arm,psci";
-			cpuoff_l: cpuoff_l {
+			cpu_sleep_l: cpu-sleep-l {
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x00010001>;
 				local-timer-stop;
@@ -181,7 +181,7 @@ cpuoff_l: cpuoff_l {
 				exit-latency-us = <140>;
 				min-residency-us = <780>;
 			};
-			cpuoff_b: cpuoff_b {
+			cpu_sleep_b: cpu-sleep-b {
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x00010001>;
 				local-timer-stop;
@@ -189,7 +189,7 @@ cpuoff_b: cpuoff_b {
 				exit-latency-us = <145>;
 				min-residency-us = <720>;
 			};
-			clusteroff_l: clusteroff_l {
+			cluster_sleep_l: cluster-sleep-l {
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x01010002>;
 				local-timer-stop;
@@ -197,7 +197,7 @@ clusteroff_l: clusteroff_l {
 				exit-latency-us = <155>;
 				min-residency-us = <860>;
 			};
-			clusteroff_b: clusteroff_b {
+			cluster_sleep_b: cluster-sleep-b {
 				compatible = "arm,idle-state";
 				arm,psci-suspend-param = <0x01010002>;
 				local-timer-stop;
-- 
2.36.1

