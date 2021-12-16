Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B95476F34
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbhLPKxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbhLPKw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:52:59 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D08C061401
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 02:52:59 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id w24so6451967ply.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 02:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xJNVCG0knDeDsaJRBAsMdg1APPcQKKogOd6G1MVemXg=;
        b=Q2gICRMzjrR/Us93SmT0ldWcKbKZAQli6cfoem2qOu1zbCNWmZ1znMaFW5AWlhCca4
         5Ju3ROmEGuaXfTwBCYPzRsSPBOSLzsOd7XEv27KF4yXYiHLCTu2PuZ+D7efKLDh5xC+/
         +eIgsItC8hPANGjd7moiz3HHsUrAU5ciW4t94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xJNVCG0knDeDsaJRBAsMdg1APPcQKKogOd6G1MVemXg=;
        b=DWUiSCydtxTy+PYnevpWlc0b+wAbo3LhHZAsVaHoxKcU6KTmB9MTEpwa9Ywf9XTbLl
         gKIUHhl539uwv7omWpS3hCFwtoBMRXWp2Lk7c9/hOpfdytvRC6ZHW9sI6qlZ1PbvUQDY
         +s0Z0tWJ/sjCw8s/dFjOKNZRgvpOAeH/AMoqHxSra5vVcV9earBCi8cOb0iN7tCD9zHF
         jx8Mlxb/OlDdUaIGY0DVLQ3Un11FbJxh3GTPII5OOy9g+McLH9VwNsXBPGwXX37PEvav
         UBCTcj32jO/jJUFrZHvqHKGgCuQpcA0i+H1GWYGOVRvVUk1SCFOYf5fiHCl1j1nqWOBP
         7QYg==
X-Gm-Message-State: AOAM531uw/3cZqsREreNjBfxI4+4YWxM3u71UQw+75PHql/W0eAbCwzV
        OuOlfT7X/u4DAJqY3gYBACwU2A==
X-Google-Smtp-Source: ABdhPJz47U/nyiwJjen0eI2Oqt/pHJMHdUfmpdoUgShXoEM5bEEGwmMbZRe4lxtrKJqaHYrjKPCv0A==
X-Received: by 2002:a17:90a:7b8b:: with SMTP id z11mr1340920pjc.210.1639651978948;
        Thu, 16 Dec 2021 02:52:58 -0800 (PST)
Received: from shiro.work (p864106-ipngn200510sizuokaden.shizuoka.ocn.ne.jp. [180.9.58.106])
        by smtp.googlemail.com with ESMTPSA id w19sm4986142pjh.10.2021.12.16.02.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 02:52:58 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, romain.perier@gmail.com,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 3/3] ARM: dts: mstar: Add a dts for Miyoo Mini
Date:   Thu, 16 Dec 2021 19:52:46 +0900
Message-Id: <20211216105246.3548133-4-daniel@0x0f.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216105246.3548133-1-daniel@0x0f.com>
References: <20211216105246.3548133-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miyoo has released a portable retro games machine based
on the SigmaStar SSD202D. Add the initial device tree
for this machine. Just enough to get to an initramfs
shell.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Link: http://linux-chenxing.org/infinity2/miyoomini/
---
 arch/arm/boot/dts/Makefile                    |  1 +
 .../mstar-infinity2m-ssd202d-miyoo-mini.dts   | 25 +++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 arch/arm/boot/dts/mstar-infinity2m-ssd202d-miyoo-mini.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0de64f237cd8..b270a4d8e0d6 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1468,6 +1468,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 dtb-$(CONFIG_ARCH_MILBEAUT) += milbeaut-m10v-evb.dtb
 dtb-$(CONFIG_ARCH_MSTARV7) += \
 	mstar-infinity-msc313-breadbee_crust.dtb \
+	mstar-infinity2m-ssd202d-miyoo-mini.dtb \
 	mstar-infinity2m-ssd202d-ssd201htv2.dtb \
 	mstar-infinity2m-ssd202d-unitv2.dtb \
 	mstar-infinity3-msc313e-breadbee.dtb \
diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd202d-miyoo-mini.dts b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-miyoo-mini.dts
new file mode 100644
index 000000000000..1bbbf47132dc
--- /dev/null
+++ b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-miyoo-mini.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+/dts-v1/;
+#include "mstar-infinity2m-ssd202d.dtsi"
+
+/ {
+	model = "Miyoo Mini";
+	compatible = "miyoo,miyoo-mini", "mstar,infinity2m";
+
+	aliases {
+		serial0 = &pm_uart;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&pm_uart {
+	status = "okay";
+};
-- 
2.34.1

