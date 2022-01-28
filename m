Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6850F49EFE6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 01:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344672AbiA1Ai0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 19:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241685AbiA1AiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 19:38:19 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33203C061749;
        Thu, 27 Jan 2022 16:38:19 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id k9so4397369qvv.9;
        Thu, 27 Jan 2022 16:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j2PLycvcW6dLTZ8kcMY5iFXYAkkFP3UnZiWjf1YUPQ4=;
        b=qei5y1xK5AiiFqzeJefi3veSDhVeTBnZu8kMBlXneKUPa8tac/pYCkuigqyB6dU8po
         jo6xLloKFqPXGZTlJEzi+nNm9P4AFCGOnAKG2pG3GUjrRjJ2J61K4UEiUj4QJz739dZg
         UnpeXicZpoOkOSftq78cDX4rMTR38Tnoog8YEVHVTEhDrdwvPllI8QZM+kKjGt4O4FLO
         tdh9wcNQLAB4Au3XCe3+8ZtLAM0fwd5ibfwz7VGdd1mWF5rMDW8A/c6QJfFue0GcXUs2
         Ji7/dRmJ1PpHOuYqxm/yiEuRA2vB67e8c02i+YQN30MIacjrkFnKjCmFubKYmo+q6ggl
         /YXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j2PLycvcW6dLTZ8kcMY5iFXYAkkFP3UnZiWjf1YUPQ4=;
        b=PRMbAhI8tBrHu29i8HWnvMxIbGLb3j6TlnJGBB1uUm1iELAXhHleSq0U1GQCUBb9KU
         j4wviePu/vwdYI4PW16vfjXf/L3uNltEBXXOlEMvAIuVlN4wBof578qF+GmvMdEPLqKq
         sKTjZp4Azb4UPOVY39ONedWdQ0fiSCwwc/fVrFsQWs6BrTooQcFdKJSgOh6DFmBR8Ktx
         qh4xoxz/b6TLzGbAS1rfkti4/ZHZJ4R/auFKGUP/HlFLu3qRO2j3+lG4lmlTonbzpBOs
         WIH1mmE8GARvQeYk69xRMhIJEA/WjHvsWaUWpD7D4AcyzGe9N1wE09Z5cCfiA1Jz7mXv
         1bLA==
X-Gm-Message-State: AOAM532VH+FdPu5xA9nbbkQ9L7zw7st4SED5+LVvFSA+tRHVdtFt8IH8
        +tsOlXMIys/nae3uxZE+xqjRwUVpqsVpDw==
X-Google-Smtp-Source: ABdhPJyR73xdepexciUgvlSA/jSq2GFvHyyuqvrAYyMxkwDfo1QZ7VBQCxZ2wWUgM/C9GfryivNEPA==
X-Received: by 2002:a05:6214:1d2e:: with SMTP id f14mr5730571qvd.2.1643330298334;
        Thu, 27 Jan 2022 16:38:18 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.dc.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id t1sm2142883qtc.48.2022.01.27.16.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 16:38:18 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] arm64: dts: rockchip: add Quartz64-A con40 hardware
Date:   Thu, 27 Jan 2022 19:38:08 -0500
Message-Id: <20220128003809.3291407-5-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128003809.3291407-1-pgwipeout@gmail.com>
References: <20220128003809.3291407-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Quartz64-A has a 40 pin connector that exposes various functions.
Annotate the functions exposed in the device tree.
Enable i2c3, which is pulled up to vcc_3v3 on board.

The following functions are currently exposed:
i2c3
spi1
uart2
uart0
spdif

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index c5a79046a9d0..d3dc60ff60dd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -449,6 +449,14 @@ regulator-state-mem {
 	};
 };
 
+/* i2c3 is exposed on con40
+ * pin 3 - i2c3_sda_m0, pullup to vcc_3v3
+ * pin 5 - i2c3_scl_m0, pullup to vcc_3v3
+ */
+&i2c3 {
+	status = "okay";
+};
+
 &i2s1_8ch {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2s1m0_sclktx
@@ -559,10 +567,17 @@ &sdmmc1 {
 	status = "okay";
 };
 
+/* spdif is exposed on con40 pin 18 */
 &spdif {
 	status = "okay";
 };
 
+/* spi1 is exposed on con40
+ * pin 11 - spi1_mosi_m1
+ * pin 13 - spi1_miso_m1
+ * pin 15 - spi1_clk_m1
+ * pin 17 - spi1_cs0_m1
+ */
 &spi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi1m1_cs0 &spi1m1_pins>;
@@ -576,6 +591,10 @@ &tsadc {
 	status = "okay";
 };
 
+/* uart0 is exposed on con40
+ * pin 12 - uart0_tx
+ * pin 14 - uart0_rx
+ */
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_xfer>;
@@ -602,6 +621,10 @@ bluetooth {
 	};
 };
 
+/* uart2 is exposed on con40
+ * pin 8 - uart2_tx_m0_debug
+ * pin 10 - uart2_rx_m0_debug
+ */
 &uart2 {
 	status = "okay";
 };
-- 
2.25.1

