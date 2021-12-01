Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A563446554E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352400AbhLAS0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352322AbhLASZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:25:11 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BC9C061574;
        Wed,  1 Dec 2021 10:21:50 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 133so21200418wme.0;
        Wed, 01 Dec 2021 10:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gfaLjrdMaBtEBA6gW3vzSiLmG5RGlxbWPlwFCA3b58U=;
        b=hjXRECTmt3QwxBwLLnhgBiEI0L5akGhC0tr7krj/gFDT22AYR2ULra1IoJgQMtMz7X
         YI331nOul8a+jDq0lt3YzzjizQQJ0IiB1XBfoewkHiqFbgtM8WIHhl1PNo7OnWhqvGrr
         yYbLWhx9KF8uESHrks2xTAQuq/r0oV+5OzcKGyuNpWorxB4QEqQaXIOmyPg7zB7euhBC
         6ZUSa0VyjBunzlnTxnnjetsAqOU1mF8KJAG4ZMPssfbO8xlKCBNPSXYUc2KaL4tQiCtM
         kt2TdIEE7Yu9oRbNWncLFwbksICPqb8R/K1AETHggO/Kgm+SDDy0vhfSZff2T5pBpBWG
         Ne1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gfaLjrdMaBtEBA6gW3vzSiLmG5RGlxbWPlwFCA3b58U=;
        b=4dLqTQ0AKP+MPSbbaIu0prBwcvDrDvj8TGAekhkKmyoSRwL3EF8CSo2Op8zfnNTKaG
         FhNf/e18Ehp2kEnH0RbLH2UMI7qPe3d6/sbDipOzysDk4Hqnxu7giOA5VQho4gURJk7Y
         7IJqt9BaHJE0kLvtO+FkMJe7tVaUxS3W/UKjuH3lJEohou60bRJI+YMUBLn5JViQdUE/
         t+/rkQG4BODCyDFcTu75Uxjm9tQaSotJDx3h3hdxbTZXOscaG/TFsh7Yr2/gf5p5W4jq
         IUlXb3XmOVrHasZ9imvPIJjJ+P0bZK0pTru/ZzzG2jew7y3EBJ+l9tIL4ClZHOqpRTiP
         AR5Q==
X-Gm-Message-State: AOAM530pzkzN1WQa1imqdP0bJNZzQfnNQf08y7o1qyDGIOohitUAhY/a
        6O8yhMBrUqTveVh0/opL+LI=
X-Google-Smtp-Source: ABdhPJwHMXO+np1LQE1gqerHfoqcLb/cmi07fe92xjTe0mj3fR0IGiphnTzvbOkCTqi1e0kQCZqATw==
X-Received: by 2002:a7b:c097:: with SMTP id r23mr8796600wmh.193.1638382908605;
        Wed, 01 Dec 2021 10:21:48 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id f7sm604705wri.74.2021.12.01.10.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:21:48 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 4/5] arm64: dts: allwinner: h6: tanix: Add MMC1 node
Date:   Wed,  1 Dec 2021 19:21:17 +0100
Message-Id: <20211201182118.1213806-5-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211201182118.1213806-1-jernej.skrabec@gmail.com>
References: <20211201182118.1213806-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both, Tanix TX6 and Tanix TX6 mini, have SDIO wifi module, albeit
different. However, driver can be autoprobed via SDIO ID.

Add MMC1 node, so kernel can discover wifi module and load driver for
it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../boot/dts/allwinner/sun50i-h6-tanix.dtsi      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi
index 166b6a7a586c..edb71e4a0304 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi
@@ -75,6 +75,13 @@ spdif_out: spdif-out {
 		#sound-dai-cells = <0>;
 		compatible = "linux,spdif-dit";
 	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&rtc 1>;
+		clock-names = "ext_clock";
+		reset-gpios = <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* PM3 */
+	};
 };
 
 &cpu0 {
@@ -121,6 +128,15 @@ &mmc0 {
 	status = "okay";
 };
 
+&mmc1 {
+	vmmc-supply = <&reg_vcc3v3>;
+	vqmmc-supply = <&reg_vcc1v8>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+};
+
 &mmc2 {
 	vmmc-supply = <&reg_vcc3v3>;
 	vqmmc-supply = <&reg_vcc1v8>;
-- 
2.34.1

