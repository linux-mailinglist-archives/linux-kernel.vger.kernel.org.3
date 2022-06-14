Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EFA54A3B5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 03:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243254AbiFNBg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 21:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236615AbiFNBgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 21:36:23 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007FD3388B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 18:36:22 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id s37so4599591pfg.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 18:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vr3fX45ywehvFPMvVsgjiEhDYk6zSPz1Xs7VmBa3RB0=;
        b=LGa6nEeSyttuoLknR2c4ecMPP3TPyj6tCthui57qYgw/9fGxHzpcnjdS273kViIUw/
         JMXLrGiNmzTblwp1WrKeNUlFe89PfzQVWDK1QGw1SlbAnRNMAoxdAepoKzXKGYxX7QOh
         MphoTdoxRuC+0D+5YiEJ2JUgELuChbgGPcMw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vr3fX45ywehvFPMvVsgjiEhDYk6zSPz1Xs7VmBa3RB0=;
        b=jJFlYYHqv3EcMVsizgDhHFUDSLQdfRk8a93skONiyve18H9aJouPUm2A9veWsuZeRD
         OIYxc66XB3F2lvqT1TYLZV9cYt8R/N/ifZF1adk89rCc73NXY4Ab+7kpZ9JmCR+aPVTA
         l1YLMADe7o7VN+OH7xJQYJCmdog32geisRS1+h/hFxJRbuEOlCDCr+7DECrkq9fK3Rcd
         zihzzk7hqnX7p6ge8b8tJbCAp/j2QLBXKczOCCdDn1+BBHGUwgR17qv7MllRSj7zhwoq
         L7+xGdLEK3Tm883+8tcomOQkQRcti80nvHKSvr9xPoP9/mw5u1GiAZ0dLQuJeWhSbWqt
         7Zjg==
X-Gm-Message-State: AOAM531N04KyWfoiluyx0TR4YYl1ihJzKt9YIdXpiqo02ZqOrOC9xcBD
        AdscDBR23ZKGZqwNZNAgHN68Rg==
X-Google-Smtp-Source: ABdhPJzfoL5dT43VZDaBfP2Fy3VDED2naoP7v9bNzu2D2llcrm9KDkbvSNS3WSdcYmyGG8N1LyIebQ==
X-Received: by 2002:a63:1c2:0:b0:3fd:3458:5dd4 with SMTP id 185-20020a6301c2000000b003fd34585dd4mr2236115pgb.87.1655170582435;
        Mon, 13 Jun 2022 18:36:22 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:ceef:e68b:2670:64f3])
        by smtp.gmail.com with UTF8SMTPSA id o12-20020a63a80c000000b00407e25d4527sm3487782pgf.22.2022.06.13.18.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 18:36:21 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Caesar Wang <wxt@rock-chips.com>, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [RFC PATCH] Revert "arm64: dts: rockchip: add SdioAudio pd control for rk3399"
Date:   Mon, 13 Jun 2022 18:36:17 -0700
Message-Id: <20220613183556.RFC.1.I9ca71105e505f024d53b7e0ba4462230813ebb8d@changeid>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit b0f2110af8475bc6812287b6598161a2c1a34c61.

(With some minor changes for context that have changed since then.)

I've found that speaker and headphone audio have issues on RK3399 Gru
Scarlet devices after commit: b0f2110af847 ("arm64: dts: rockchip: add
SdioAudio pd control for rk3399"). It's likely somehow related to the
fact that we completely reset VD_LOGIC in S3 suspend, which includes the
SDIOAUDIO domain.

Problematic test case:

1. play audio (e.g., youtube) through speakers
2. plug in headphones to 3.5mm jack (youtube remains playing)
3. suspend/resume the system (S3)
4. resume audio
5. unplug headphones (and resume audio)
6. plug headphones (youtube remains playing)

At step 4, the audio sounds like garbage through the headphones (like
every other sample is missing or stretched out, so it sounds like a
screechy version on the original track?). At step 5, the speakers are
silent. At step 6, the audio is garbage again.

These problems go away if we stop managing this power domain and instead
leave it on all the time.

Power impact should be minimal.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
I don't really expect this patch to be merged as-is, but I want to put
it up as a form of bug report and place to point people if they somehow
have the same issue.

I've poked around at the rockchip-i2s and codec drivers in use and have
come up dry, to explain why audio breaks like this for me on kernels
with commit b0f2110af847 involved. I don't plan on spending a lot more
time on debugging this but instead am simply going to run with this
patch in my kernels. If anyone has hot tips, I may be willing to spend a
few cycles looking at alternatives though...

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index fbd0346624e6..1563e8d503f5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -296,7 +296,6 @@ sdio0: mmc@fe310000 {
 			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
-		power-domains = <&power RK3399_PD_SDIOAUDIO>;
 		resets = <&cru SRST_SDIO0>;
 		reset-names = "reset";
 		status = "disabled";
@@ -794,7 +793,6 @@ spi5: spi@ff200000 {
 		dma-names = "tx", "rx";
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi5_clk &spi5_tx &spi5_rx &spi5_cs0>;
-		power-domains = <&power RK3399_PD_SDIOAUDIO>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1102,12 +1100,6 @@ power-domain@RK3399_PD_SD {
 				pm_qos = <&qos_sd>;
 				#power-domain-cells = <0>;
 			};
-			power-domain@RK3399_PD_SDIOAUDIO {
-				reg = <RK3399_PD_SDIOAUDIO>;
-				clocks = <&cru HCLK_SDIO>;
-				pm_qos = <&qos_sdioaudio>;
-				#power-domain-cells = <0>;
-			};
 			power-domain@RK3399_PD_TCPD0 {
 				reg = <RK3399_PD_TCPD0>;
 				clocks = <&cru SCLK_UPHY0_TCPDCORE>,
@@ -1648,7 +1640,6 @@ spdif: spdif@ff870000 {
 		clocks = <&cru SCLK_SPDIF_8CH>, <&cru HCLK_SPDIF>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&spdif_bus>;
-		power-domains = <&power RK3399_PD_SDIOAUDIO>;
 		#sound-dai-cells = <0>;
 		status = "disabled";
 	};
@@ -1664,7 +1655,6 @@ i2s0: i2s@ff880000 {
 		clocks = <&cru SCLK_I2S0_8CH>, <&cru HCLK_I2S0_8CH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s0_8ch_bus>;
-		power-domains = <&power RK3399_PD_SDIOAUDIO>;
 		#sound-dai-cells = <0>;
 		status = "disabled";
 	};
@@ -1679,7 +1669,6 @@ i2s1: i2s@ff890000 {
 		clocks = <&cru SCLK_I2S1_8CH>, <&cru HCLK_I2S1_8CH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2s1_2ch_bus>;
-		power-domains = <&power RK3399_PD_SDIOAUDIO>;
 		#sound-dai-cells = <0>;
 		status = "disabled";
 	};
@@ -1692,7 +1681,6 @@ i2s2: i2s@ff8a0000 {
 		dma-names = "tx", "rx";
 		clock-names = "i2s_clk", "i2s_hclk";
 		clocks = <&cru SCLK_I2S2_8CH>, <&cru HCLK_I2S2_8CH>;
-		power-domains = <&power RK3399_PD_SDIOAUDIO>;
 		#sound-dai-cells = <0>;
 		status = "disabled";
 	};
-- 
2.36.1.476.g0c4daa206d-goog

