Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E3B5548C4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357917AbiFVLip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357452AbiFVLhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:37:54 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C913CA4A;
        Wed, 22 Jun 2022 04:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=bFaoYKE+rc6SnVof0cEgO4N8K0rH2w7eaPwkAQ3ydaQ=; b=axJQtSdD2xYCiPAH2DdgxqIGWZ
        tfUqO6JSYGcf5IFigxTlRSYvEbYGGEwc5Ki7MVCAmOjqef6S13tAPGJT4fymk0oergkMcbUNY1J4P
        1iGl7RvGcoFHf55+n9LZc7wbeIP95IsPiD0sb8oEOfFzly8EKOqRVXv6W1JxAbReVAkRbJ4yoepf0
        9kYLICcMqkpM8eEoUo2dpyS6Qcaf6HHNSwTCClX03XSRcBtcYOr8oepYsEcPBTX5zXZXKdLsAnabd
        cCMsoEbe9R6K9PczBw7yICpVDhwJhzgDL+IYa4/O/4qZasZEKsaXExEsSFRRh97fmpkMZNMW/ddst
        U8LvWE0w==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1o3yg3-0001Xl-Dt; Wed, 22 Jun 2022 14:37:42 +0300
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, digetx@gmail.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v2 02/13] dt-bindings: Add headers for Host1x and VIC on Tegra234
Date:   Wed, 22 Jun 2022 14:37:22 +0300
Message-Id: <20220622113733.1710471-3-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622113733.1710471-1-cyndis@kapsi.fi>
References: <20220622113733.1710471-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

Add clock, memory controller, powergate and reset dt-binding headers
for Host1x and VIC on Tegra234.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 include/dt-bindings/clock/tegra234-clock.h     | 4 ++++
 include/dt-bindings/memory/tegra234-mc.h       | 5 +++++
 include/dt-bindings/power/tegra234-powergate.h | 1 +
 include/dt-bindings/reset/tegra234-reset.h     | 1 +
 4 files changed, 11 insertions(+)

diff --git a/include/dt-bindings/clock/tegra234-clock.h b/include/dt-bindings/clock/tegra234-clock.h
index bd4c3086a2da..6e4e5cc75631 100644
--- a/include/dt-bindings/clock/tegra234-clock.h
+++ b/include/dt-bindings/clock/tegra234-clock.h
@@ -38,6 +38,8 @@
  * throughput and memory controller power.
  */
 #define TEGRA234_CLK_EMC			31U
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_HOST1X */
+#define TEGRA234_CLK_HOST1X                     46U
 /** @brief output of gate CLK_ENB_FUSE */
 #define TEGRA234_CLK_FUSE			40U
 /** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C1 */
@@ -132,6 +134,8 @@
 #define TEGRA234_CLK_UARTA			155U
 /** @brief output of gate CLK_ENB_PEX1_CORE_6 */
 #define TEGRA234_CLK_PEX1_C6_CORE		161U
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_VIC */
+#define TEGRA234_CLK_VIC                        167U
 /** @brief output of gate CLK_ENB_PEX2_CORE_7 */
 #define TEGRA234_CLK_PEX2_C7_CORE		171U
 /** @brief output of gate CLK_ENB_PEX2_CORE_8 */
diff --git a/include/dt-bindings/memory/tegra234-mc.h b/include/dt-bindings/memory/tegra234-mc.h
index e3b0e9da295d..73fdd18523a9 100644
--- a/include/dt-bindings/memory/tegra234-mc.h
+++ b/include/dt-bindings/memory/tegra234-mc.h
@@ -26,6 +26,8 @@
 #define TEGRA234_SID_PCIE8	0x09
 #define TEGRA234_SID_PCIE10	0x0b
 #define TEGRA234_SID_BPMP	0x10
+#define TEGRA234_SID_HOST1X	0x27
+#define TEGRA234_SID_VIC	0x34
 
 /*
  * memory client IDs
@@ -33,6 +35,7 @@
 
 /* High-definition audio (HDA) read clients */
 #define TEGRA234_MEMORY_CLIENT_HDAR 0x15
+#define TEGRA234_MEMORY_CLIENT_HOST1XDMAR 0x16
 /* PCIE6 read clients */
 #define TEGRA234_MEMORY_CLIENT_PCIE6AR 0x28
 /* PCIE6 write clients */
@@ -65,6 +68,8 @@
 #define TEGRA234_MEMORY_CLIENT_SDMMCRAB 0x63
 /* sdmmcd memory write client */
 #define TEGRA234_MEMORY_CLIENT_SDMMCWAB 0x67
+#define TEGRA234_MEMORY_CLIENT_VICSRD 0x6c
+#define TEGRA234_MEMORY_CLIENT_VICSWR 0x6d
 /* BPMP read client */
 #define TEGRA234_MEMORY_CLIENT_BPMPR 0x93
 /* BPMP write client */
diff --git a/include/dt-bindings/power/tegra234-powergate.h b/include/dt-bindings/power/tegra234-powergate.h
index f610eee9bce8..c3f7e380d2c6 100644
--- a/include/dt-bindings/power/tegra234-powergate.h
+++ b/include/dt-bindings/power/tegra234-powergate.h
@@ -18,5 +18,6 @@
 #define TEGRA234_POWER_DOMAIN_MGBEA	17U
 #define TEGRA234_POWER_DOMAIN_MGBEB	18U
 #define TEGRA234_POWER_DOMAIN_MGBEC	19U
+#define TEGRA234_POWER_DOMAIN_VIC       29U
 
 #endif
diff --git a/include/dt-bindings/reset/tegra234-reset.h b/include/dt-bindings/reset/tegra234-reset.h
index 547ca3b60caa..1971400bf360 100644
--- a/include/dt-bindings/reset/tegra234-reset.h
+++ b/include/dt-bindings/reset/tegra234-reset.h
@@ -44,6 +44,7 @@
 #define TEGRA234_RESET_QSPI1			77U
 #define TEGRA234_RESET_SDMMC4			85U
 #define TEGRA234_RESET_UARTA			100U
+#define TEGRA234_RESET_VIC                      113U
 #define TEGRA234_RESET_PEX0_CORE_0		116U
 #define TEGRA234_RESET_PEX0_CORE_1		117U
 #define TEGRA234_RESET_PEX0_CORE_2		118U
-- 
2.36.1

