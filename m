Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD2A4913B2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238992AbiARBj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244285AbiARBi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:38:26 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A32DC06173F;
        Mon, 17 Jan 2022 17:38:26 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id a18so72931838edj.7;
        Mon, 17 Jan 2022 17:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VSVdYqZu+t7n9C8goCLOO4CRPlINCB2udmlWCoWNckw=;
        b=kUrB0NiJF2okvxJXJE/HMZ0OdonK9/RRyfs2mOtTvzO2KepiT/xNy7BilPxKWIqlPJ
         E27OmHbhC1Dtn08/OUYE8TfagzuShyG+c7qNBgVLpg7wHuGM28YAArZRIrE6WTLeVPpf
         +oP8xG8adc9/77MmkjCuUyEENcuC07/32JNNTJRw7le+vF9PD9nWl2VmBaakI7I7Tu8j
         h+/EJtxDeKPhIN9JXrTp25oxkANUlmT9JVP13R8LuiJvAOJau0DXI6Fk0cyNobFkUqEl
         OgsE2OrXsSzbAS8PykXmgqEyKo6vBMQNfSHahGkd1iIUkQOXEklzw9e2hwD4LWcBq9cC
         DpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VSVdYqZu+t7n9C8goCLOO4CRPlINCB2udmlWCoWNckw=;
        b=t65F6OmrdxvSqQybWv831mu5qp0JEtcGW5FFZULvMcoKdZQVd9x5p05dckjMqbnvqe
         9TL8ZGFlCQxVZwoUQA/eVQadBmoZ+6qx/M27FZU2MR6lgWmQuTLBjz7aXZf2/AIvPVqR
         kkzAhmP9NNfx+t4pYuoMaMOJxi37waNt3TfXeQjQ9Tb/aW3aYKvziJbY+UNHNvuavgjR
         qlxQSaZbA6VQd/H2NSo0dZRCBaiwmEjzUA2bT1rDEOWR1iNyF+KV7MI9vkOv6ioOeupL
         7lu2oRJYCNEv1gij4i5jYc31DlAHKgPr2+YW2CIXBDL8DOifc90EdtRWSB3y9cKNmf0o
         4YOg==
X-Gm-Message-State: AOAM532kFgUNjZImaPPvlSHx+y20uG0naKplGUDgLmfvw76YbMAmZKc6
        y0gmdbY92QlMjpsNijiJnY1KohbwoFU=
X-Google-Smtp-Source: ABdhPJxaRYSx3oyiI+34N3/G8KsIL7E8AqUJarYhcoHiRDX/kQY/ElW6tcpNBFOtE1alpuyGPXEN9w==
X-Received: by 2002:a05:6402:1003:: with SMTP id c3mr23624978edu.405.1642469904921;
        Mon, 17 Jan 2022 17:38:24 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id kj18sm3990675ejc.139.2022.01.17.17.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:38:24 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 15/16] ARM: dts: qcom: add ipq8064-v2.0 dtsi
Date:   Tue, 18 Jan 2022 02:20:47 +0100
Message-Id: <20220118012051.21691-18-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118012051.21691-1-ansuelsmth@gmail.com>
References: <20220118012051.21691-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many devices are based on the v2.0 of the ipq8064 SoC. Main difference
is a change in the pci compatible and different way to configre the usb
phy.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi | 70 ++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi

diff --git a/arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi b/arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi
new file mode 100644
index 000000000000..c082c3cd1a19
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "qcom-ipq8064.dtsi"
+
+/ {
+	aliases {
+		serial0 = &gsbi4_serial;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		rsvd@41200000 {
+			reg = <0x41200000 0x300000>;
+			no-map;
+		};
+	};
+};
+
+&gsbi4 {
+	qcom,mode = <GSBI_PROT_I2C_UART>;
+	status = "okay";
+
+	serial@16340000 {
+		status = "okay";
+	};
+	/*
+	 * The i2c device on gsbi4 should not be enabled.
+	 * On ipq806x designs gsbi4 i2c is meant for exclusive
+	 * RPM usage. Turning this on in kernel manifests as
+	 * i2c failure for the RPM.
+	 */
+};
+
+&CPU_SPC {
+	status = "okay";
+};
+
+&pcie0 {
+	compatible = "qcom,pcie-ipq8064-v2";
+};
+
+&pcie1 {
+	compatible = "qcom,pcie-ipq8064-v2";
+};
+
+&pcie2 {
+	compatible = "qcom,pcie-ipq8064-v2";
+};
+
+&sata {
+	ports-implemented = <0x1>;
+};
+
+&ss_phy_0 {
+	qcom,rx-eq = <2>;
+	qcom,tx-deamp_3_5db = <32>;
+	qcom,mpll = <5>;
+};
+
+&ss_phy_1 {
+	qcom,rx-eq = <2>;
+	qcom,tx-deamp_3_5db = <32>;
+	qcom,mpll = <5>;
+};
-- 
2.33.1

