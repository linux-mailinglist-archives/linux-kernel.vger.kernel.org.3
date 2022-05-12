Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6D35246C7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350904AbiELHT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245010AbiELHTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:19:47 -0400
Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A56FC5E63;
        Thu, 12 May 2022 00:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=bymoT
        b01r1T+Wm4ZEMiXz/r4v+miJ0K1oL+JDw06UN8=; b=A7yasGqeDwqhbnUkMFSTN
        oUyGCGpo5JYjwrzVchHgw0DzxfrNDlR1BwvnJnPjp1hYOaUJNwxOf2IXzNxzfL3L
        GJgb6m6uPHXIXpL8xKOHE+aj80F0cQUvY3u6m4sj4Nq4EVamzQz3R8xm51XDQk47
        /U3gpivIStKNboCNNkTOek=
Received: from DESKTOP-B1R4FVG.localdomain (unknown [218.201.129.19])
        by smtp13 (Coremail) with SMTP id EcCowACHoI3ptHxiu+ySCA--.8205S3;
        Thu, 12 May 2022 15:19:07 +0800 (CST)
From:   qianfanguijin@163.com
To:     linux-sunxi@lists.linux.dev
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        qianfan Zhao <qianfanguijin@163.com>
Subject: [PATCH v3 2/2] ARM: dts: sun8i-r40: Add "cpu-supply" node for sun8i-r40 based board
Date:   Thu, 12 May 2022 15:18:58 +0800
Message-Id: <20220512071858.10805-2-qianfanguijin@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220512071858.10805-1-qianfanguijin@163.com>
References: <20220512071858.10805-1-qianfanguijin@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowACHoI3ptHxiu+ySCA--.8205S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWUCryfGw4xZr43JryxZrb_yoW8uryrpw
        17CrZ7Gwn3WF1rt347WrWDGr1UCFykWw4YvF15C34fJrsrXaykXryftwnakrZ8Xr13J3y0
        93s5Xr97Xw4DX3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zihIDxUUUUU=
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiGhP+7VaEBigVVQACsk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: qianfan Zhao <qianfanguijin@163.com>

sun8i-r40 actived cpufreq feature now, let's add "cpu-supply" node on
board.

Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
---
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 4 ++++
 arch/arm/boot/dts/sun8i-r40-feta40i.dtsi          | 4 ++++
 arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts          | 4 ++++
 arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts | 4 ++++
 4 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index a6a1087a0c9b..4f30018ec4a2 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -113,6 +113,10 @@ &ahci {
 	status = "okay";
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &de {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun8i-r40-feta40i.dtsi b/arch/arm/boot/dts/sun8i-r40-feta40i.dtsi
index 265e0fa57a32..b872b51a346d 100644
--- a/arch/arm/boot/dts/sun8i-r40-feta40i.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40-feta40i.dtsi
@@ -6,6 +6,10 @@
 
 #include "sun8i-r40.dtsi"
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &i2c0 {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts b/arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts
index 6931aaab2382..0eb1990742ff 100644
--- a/arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts
+++ b/arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts
@@ -88,6 +88,10 @@ &ahci {
 	status = "okay";
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &de {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
index 47954551f573..fdf8bd12faaa 100644
--- a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
+++ b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
@@ -107,6 +107,10 @@ &ahci {
 	status = "okay";
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &de {
 	status = "okay";
 };
-- 
2.25.1

