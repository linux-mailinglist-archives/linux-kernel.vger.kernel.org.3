Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345A1464865
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347518AbhLAHc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:32:58 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:55196 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347483AbhLAHcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:32:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 17319CE1D75;
        Wed,  1 Dec 2021 07:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE44BC53FAD;
        Wed,  1 Dec 2021 07:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343769;
        bh=qUBCqTkVk67waMd2M9a6Vqzm6ZXAqVe1PfEqjwIDh4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CkYFN9R/d1jtPIkncUI0kUQv0o6XdO7QEo0FaWdkk3lbTcjTUH+TB2ZAmMpq1twQK
         EXfYLv8RYj3HKljky8DtxwWH6GHBmh1KjNpebZy9LaQoyeVD0I9b3KFFd/etl4Vuec
         K6CE8u/r94ywTNCLLP1X8pBRd3wWNoodL0Ok9OBsavixctqQnRmtey3h3/Cp0w16e8
         6EGfNHgh6HUym+IJnvC65kJbJWvOXt9ZcgdFw2RK8YbYsxghD5QVx6lNREKhjKsqBD
         jIbTGXjOsY5llRg0FuwoOvcCc9KRzeQxWzJCFwTm7XDlIHtTLcHyyGDY/MEVf2ttXf
         I0u4gnXr42AMA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/15] arm64: dts: qcom: Add base SM8450 QRD DTS
Date:   Wed,  1 Dec 2021 12:59:02 +0530
Message-Id: <20211201072915.3969178-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201072915.3969178-1-vkoul@kernel.org>
References: <20211201072915.3969178-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DTS for Qualcomm QRD platform which uses SM8450 SoC

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/Makefile       |  1 +
 arch/arm64/boot/dts/qcom/sm8450-qrd.dts | 29 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8450-qrd.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 6b816eb33309..9b37261484cf 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -107,3 +107,4 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx203.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx206.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-mtp.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-qrd.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
new file mode 100644
index 000000000000..127d32502555
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2021, Linaro Limited
+ */
+
+/dts-v1/;
+
+#include "sm8450.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. SM8450 QRD";
+	compatible = "qcom,sm8450-qrd", "qcom,sm8450";
+
+	aliases {
+		serial0 = &uart7;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&uart7 {
+	status = "okay";
+};
-- 
2.31.1

