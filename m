Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575504848B1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 20:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiADThf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 14:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiADThd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 14:37:33 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B52AC061761;
        Tue,  4 Jan 2022 11:37:32 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id x6so31172024lfa.5;
        Tue, 04 Jan 2022 11:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MqDFLlq3VWxFS0cMOIJ3RThrgRba36XLCT0Etg8h8PA=;
        b=d22zZX5UQQFvYJz1V0IqyvYKI17zkeJqguw4hTlCsfuc/BeMsTo+0EWw510A+Vl/zh
         susy9OVa1Il1XZjt2DiB7jcpziadV5Xdb/el0dH+DZbLEsZwyJ9itP1EA2hoawe5d9eU
         d4zvPjoKhUO8vdj1y80LTYJIh6Er47g/qaaQLewKp/XJlhn8xDGT9F/cPeUWLDAgAFb6
         62X+j03BrlNm+5GWJtpuMwnjVzKP0DHqLsXor5OORoWBx/2Avo8UiVJy4MJKRRLRRsnM
         cxkUrbURJ5l6NkWc8smAbaDwbmR0ip0nIUrMeaWzcXuBLVfhvEoXXQ/ZAS4UEp0Xc1ln
         KAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MqDFLlq3VWxFS0cMOIJ3RThrgRba36XLCT0Etg8h8PA=;
        b=M8Nfyd63BCf+izTNemQcL5t9iuYWpXsIdEVdUFn62FEB84O79fp5gwZZ80oe/IhtKX
         y6U9ARflmGdI76YuLNk29DCGUdBZHkws1kou+R4DcnszBe452xxkWb+TD3TdVOR4OfzS
         Iu7xBUzcqQwK8hQ0oPBRCOGRiapbmoOcp3+ZmdaO2WgJSvhgKlAzpeGkSEoOhPIjupxd
         //cUqTvgK1w3EuqyjKz8OBQMdLQwnkTXKu3NyK/b9Rl+uYVl+8SswrLsLKKuC/QBq0ej
         GxMEXmKq4DbovA/wPpGOlB6q+bns1W8Ah35KxwcpqzaHQg2VFDIYNfgJ/omczrHw8Ddx
         9oOQ==
X-Gm-Message-State: AOAM530PSBvYu4Q/YJhS+Zo3CmBxOeVEpzW+VG3K1PlICnbeo8DutBsA
        yYpNhRVbG6olMuyo1vmwtUVdPAIM1vgmqQ==
X-Google-Smtp-Source: ABdhPJxE1b7joWTMcKyxqd2QwxBmI6VZjwN8/Q3c0BSzizxrMwMPSblooXHp47Nc+gRbdl4accQtQA==
X-Received: by 2002:a05:6512:3485:: with SMTP id v5mr28180175lfr.495.1641325050872;
        Tue, 04 Jan 2022 11:37:30 -0800 (PST)
Received: from localhost (93-80-64-103.broadband.corbina.ru. [93.80.64.103])
        by smtp.gmail.com with ESMTPSA id bp22sm3643453lfb.150.2022.01.04.11.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 11:37:30 -0800 (PST)
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: nanopi-neo-air: Add eMMC and bluetooth
Date:   Tue,  4 Jan 2022 22:37:18 +0300
Message-Id: <20220104193719.87091-1-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the bluetooth part of AP6212 chip (connected to UART3) and the
onboard eMMC (connected to MMC2) for the NanoPi NEO Air board.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
index be49eabbff94..cd3df12b6573 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
@@ -103,12 +103,40 @@ brcmf: bcrmf@1 {
 	};
 };
 
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_8bit_pins>;
+	vmmc-supply = <&reg_vcc3v3>;
+	vqmmc-supply = <&reg_vcc3v3>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pa_pins>;
 	status = "okay";
 };
 
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>, <&uart3_rts_cts_pins>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		clocks = <&rtc 1>;
+		clock-names = "lpo";
+		vbat-supply = <&reg_vcc3v3>;
+		vddio-supply = <&reg_vcc3v3>;
+		device-wakeup-gpios = <&pio 0 8 GPIO_ACTIVE_HIGH>; /* PA8 */
+		host-wakeup-gpios = <&pio 0 7 GPIO_ACTIVE_HIGH>; /* PA7 */
+		shutdown-gpios = <&pio 6 13 GPIO_ACTIVE_HIGH>; /* PG13 */
+	};
+};
+
 &usbphy {
 	/* USB VBUS is always on */
 	status = "okay";
-- 
2.34.1

