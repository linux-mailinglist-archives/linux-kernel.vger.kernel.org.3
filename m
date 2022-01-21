Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41F5495C98
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379690AbiAUJPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 04:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbiAUJPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:15:36 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6B1C061574;
        Fri, 21 Jan 2022 01:15:35 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id u14so749824lfo.11;
        Fri, 21 Jan 2022 01:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fusO5f+lHxDaOb0VSmz+4+tHP16TPs0f0afJOTsfjE4=;
        b=DViKZjc0KCTHv8wOQQlnN6CuLmc8/xCiTlBVbrBCFEvqKQzBDQYosVt2+/Ecl7Q817
         RoC4J/Q5lv0vWa6QvOH48BRboPuiGcGLZumd2rIG5tv2m0EniL9p6YQUhHlAzSD7NYLD
         fE/Yg7IYVLXyrobpPbguB2YBZTUI3MgbfS2fnE+6MstwCkC8kDwxxRmzg9JjKoMfpbTl
         Rd9+pTuaFPueeJJYDuxQNVIKmGiGo2Jop7LGxmMhvo58MviMwiZx9vbtMAkNazSOd2gY
         Mb7kkGpBzGgN12B06GuH9c0lxQFpqBO4ZkuxDkLt1PPj5ZY/b2cdlwR8NrosG8tMmmQv
         CUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fusO5f+lHxDaOb0VSmz+4+tHP16TPs0f0afJOTsfjE4=;
        b=huu4G7b7H5ovrNO65r0HDhjMzmy2MhLBWtqF4mduGbBpvEo7JiImDQP02VVeksJ4N0
         Pl1uBZr5mPBLHGL0q6rGKGk6OgPrfK9CuCPbNuwGCaWBCr8ApLKJcoeOcX3YywtHB0v2
         gxe1E/ruZSv8tYZIgay5LpfGbCPNRC8ANQRafZ5ap3H+ZVGn+LZqYdhIpvB7WpRh3oZo
         lC0zsRWX3jcUV1Ynuxb+bFB1vgo3jRRggigPmBQ8zXnogSF7JNb71RRPK3uLghc1DpRO
         YyGoRaRkL0lnc0KxXAcO2d1jsmE37pKL7u7bAMhwTF4e7n03Vey8anSLIDlflucZmMd/
         MIvw==
X-Gm-Message-State: AOAM5316rtf6vHj7q9FxVmglC5entNU/PYD0bm+cgV1fsc1X145kpaX1
        gPuTm+gGmFMx8l7yt2qA+eU=
X-Google-Smtp-Source: ABdhPJyq/AiVI/98A8fQ3Rfe6G7qDquOCgOGLHmgUGcerpGxZXW4bSGIamkROJRIV2WfGF5ar6fwkg==
X-Received: by 2002:a19:7914:: with SMTP id u20mr3088831lfc.325.1642756534107;
        Fri, 21 Jan 2022 01:15:34 -0800 (PST)
Received: from localhost.localdomain ([185.6.236.169])
        by smtp.googlemail.com with ESMTPSA id m2sm191429lfh.163.2022.01.21.01.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 01:15:33 -0800 (PST)
From:   Maxim Kiselev <bigunclemax@gmail.com>
To:     mpe@ellerman.id.au
Cc:     andrew@lunn.ch, benh@kernel.crashing.org, bigunclemax@gmail.com,
        davem@davemloft.net, devicetree@vger.kernel.org, fido_max@inbox.ru,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        paulus@samba.org, robh+dt@kernel.org, vladimir.oltean@nxp.com
Subject: [PATCH v3] powerpc: dts: t1040rdb: fix ports names for Seville Ethernet switch
Date:   Fri, 21 Jan 2022 12:14:47 +0300
Message-Id: <20220121091447.3412907-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <87czkmudh0.fsf@mpe.ellerman.id.au>
References: <87czkmudh0.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On board rev A, the network interface labels for the switch ports
written on the front panel are different than on rev B and later.

This patch fixes network interface names for the switch ports according
to labels that are written on the front panel of the board rev B.
They start from ETH3 and end at ETH10.

This patch also introduces a separate device tree for rev A.
The main device tree is supposed to cover rev B and later.

Fixes: e69eb0824d8c ("powerpc: dts: t1040rdb: add ports for Seville Ethernet switch")
Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
Reviewed-by: Maxim Kochetkov <fido_max@inbox.ru>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Here is the fix for the error in t1040rdb-rev-a.dts caused by containing '#include' directive inside '/include/'
---
 arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dts | 30 ++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/t1040rdb.dts       |  8 +++---
 2 files changed, 34 insertions(+), 4 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dts

diff --git a/arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dts b/arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dts
new file mode 100644
index 0000000000000..73f8c998c64df
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * T1040RDB-REV-A Device Tree Source
+ *
+ * Copyright 2014 - 2015 Freescale Semiconductor Inc.
+ *
+ */
+
+#include "t1040rdb.dts"
+
+/ {
+	model = "fsl,T1040RDB-REV-A";
+	compatible = "fsl,T1040RDB-REV-A";
+};
+
+&seville_port0 {
+	label = "ETH5";
+};
+
+&seville_port2 {
+	label = "ETH7";
+};
+
+&seville_port4 {
+	label = "ETH9";
+};
+
+&seville_port6 {
+	label = "ETH11";
+};
diff --git a/arch/powerpc/boot/dts/fsl/t1040rdb.dts b/arch/powerpc/boot/dts/fsl/t1040rdb.dts
index af0c8a6f56138..b6733e7e65805 100644
--- a/arch/powerpc/boot/dts/fsl/t1040rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1040rdb.dts
@@ -119,7 +119,7 @@ &seville_port0 {
 	managed = "in-band-status";
 	phy-handle = <&phy_qsgmii_0>;
 	phy-mode = "qsgmii";
-	label = "ETH5";
+	label = "ETH3";
 	status = "okay";
 };
 
@@ -135,7 +135,7 @@ &seville_port2 {
 	managed = "in-band-status";
 	phy-handle = <&phy_qsgmii_2>;
 	phy-mode = "qsgmii";
-	label = "ETH7";
+	label = "ETH5";
 	status = "okay";
 };
 
@@ -151,7 +151,7 @@ &seville_port4 {
 	managed = "in-band-status";
 	phy-handle = <&phy_qsgmii_4>;
 	phy-mode = "qsgmii";
-	label = "ETH9";
+	label = "ETH7";
 	status = "okay";
 };
 
@@ -167,7 +167,7 @@ &seville_port6 {
 	managed = "in-band-status";
 	phy-handle = <&phy_qsgmii_6>;
 	phy-mode = "qsgmii";
-	label = "ETH11";
+	label = "ETH9";
 	status = "okay";
 };
 
-- 
2.32.0

