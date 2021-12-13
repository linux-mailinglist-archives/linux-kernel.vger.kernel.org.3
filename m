Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F42384731D2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240847AbhLMQ3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240823AbhLMQ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:29:03 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5D3C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 08:29:02 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id g18so15383163pfk.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 08:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2tU0hw9Fvr13Zay+fstlz/pyiNLZeA6ZP9w6V5x5DuU=;
        b=KxiYz8+JA80WTPI5E6V52Uo45TgQhCf/f+OnQeeCML6RkM7Tr2IXBAZf74WCTohzFS
         uI+FhNy2HM6SiHGEVHVkJbSnt+LFGwKuOgKLRrkM0v65KQHQTFd5H7ThVcl0V7qdpm22
         UR548+Wtog7B9zP8NvtXv43tsg5VWT4XdNUBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2tU0hw9Fvr13Zay+fstlz/pyiNLZeA6ZP9w6V5x5DuU=;
        b=u3p+JzVKFE+SGHAitfAs1HVyfE7cwnRM6Upa6KY9m4ZoldoMYQALGO7Kao3LCuqM6g
         Ng/Ew7n+V4CWxsXoEBYQGF/0zu0CqX0KCq725XQDhlDHGIqN1eiaG1mVVuUt+EQczITL
         5R2MBvAMrs4xRzrU0fiUoLZpu12qAwY8Sn23/zhpGhPSFy5Daw8en1ei3o3Fgk/mxfWJ
         sZAR2EhaoEPv4xa7FxHtxQ2ASzMuWBmFdLurYVlQ6XCKeDpaa7PFXoel0rrhsQa3tDMz
         BkKzB8D9ay+blM+ZM8BiqUyktYY/6HE6M4LGTigqm/0rr1GZDV0s8uV43FZIroajyc3v
         atQA==
X-Gm-Message-State: AOAM531U9Ut9ifGUSeSntyouINzB7tyx/8sDgNKnj9GWizjS73xgtLMa
        qpb5ZlZYGd2njP8jnAfk8TYIpQ==
X-Google-Smtp-Source: ABdhPJyVKUIG4JiDJfTwgnVjQB80rFaeAfGNBryQjZXYrn4n3GcGW1Z/DoTYoEhFP6KxTqeOjADVEw==
X-Received: by 2002:a62:1708:0:b0:4a7:e068:b121 with SMTP id 8-20020a621708000000b004a7e068b121mr34003359pfx.61.1639412942231;
        Mon, 13 Dec 2021 08:29:02 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:9447:edff:ad23:1bfc])
        by smtp.gmail.com with ESMTPSA id mh1sm7803802pjb.6.2021.12.13.08.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:29:01 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] arm64: dts: mt8183: Add kukui-jacuzzi-makomo board
Date:   Tue, 14 Dec 2021 00:28:54 +0800
Message-Id: <20211213162856.235130-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
In-Reply-To: <20211213162856.235130-1-hsinyi@chromium.org>
References: <20211213162856.235130-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makomo is known as Lenovo 100e Gen 2.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/Makefile         |  2 ++
 .../mt8183-kukui-jacuzzi-makomo-sku0.dts      | 24 +++++++++++++++++++
 .../mt8183-kukui-jacuzzi-makomo-sku1.dts      | 24 +++++++++++++++++++
 3 files changed, 50 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index c130518c3293d5..fe60607084f19d 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -24,6 +24,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-fennel14-sku2.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-juniper-sku16.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-kappa.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-kenzo.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-makomo-sku0.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-makomo-sku1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-willow-sku0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-jacuzzi-willow-sku1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kakadu.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts
new file mode 100644
index 00000000000000..51bf2893ec03b1
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku0.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2021 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-jacuzzi-fennel.dtsi"
+#include "mt8183-kukui-audio-da7219-rt1015p.dtsi"
+
+/ {
+	model = "Google makomo sku0 board";
+	compatible = "google,makomo-rev4-sku0", "google,makomo-rev5-sku0",
+		"google,makomo", "mediatek,mt8183";
+};
+
+&qca_wifi {
+	qcom,ath10k-calibration-variant = "GO_FENNEL14";
+};
+
+&mmc1_pins_uhs {
+	pins_clk {
+		drive-strength = <MTK_DRIVE_6mA>;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts
new file mode 100644
index 00000000000000..c3b7e9bb0c8960
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-makomo-sku1.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2021 Google LLC
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-jacuzzi-fennel.dtsi"
+#include "mt8183-kukui-audio-ts3a227e-rt1015p.dtsi"
+
+/ {
+	model = "Google makomo sku1 board";
+	compatible = "google,makomo-rev4-sku1", "google,makomo-rev5-sku1",
+		"google,makomo", "mediatek,mt8183";
+};
+
+&qca_wifi {
+	qcom,ath10k-calibration-variant = "GO_FENNEL14";
+};
+
+&mmc1_pins_uhs {
+	pins_clk {
+		drive-strength = <MTK_DRIVE_6mA>;
+	};
+};
-- 
2.34.1.173.g76aa8bc2d0-goog

