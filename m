Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A335556053B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbiF2QAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbiF2QAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:00:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CECA1C91B;
        Wed, 29 Jun 2022 09:00:19 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0B60F66019D8;
        Wed, 29 Jun 2022 17:00:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656518418;
        bh=o29vqqsWji0OFz7litVCz+HSv2vrNoGr04oOrOfn0YM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KA7L+82b3TQ37iIXoQ/ZOTFIuM2Ig0B5xZNl9IkANTbDCpSij0oVuahGvW1BjwMlO
         Vpn95jAVKnxoDGYxmCnUEGPW8WjJmeq6jRQdNArA2urpVCn9zT0GlVouBsXaQNjEag
         0ChL6N7YeAm6eVth0++RyWz4A2w1mzUbgBYpeDJUTdcJ48zZ3lsci31vnO5b69YMVu
         fwiI/K2VWHoDeMe5/SAusfv2dTYVb4nIemEt+TkLmHIze+Svob+tX3J6VJWbAMLrPP
         tNz2nhV7T2rCTZbOVqOk9j4hCvXTo4gI2k2cOYo1SLVkAA7qLgtHZTDn1y3BZkppiH
         hKSi2BIbzhHTA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 10/19] arm64: dts: mediatek: asurada: Add Elan eKTH3000 I2C trackpad
Date:   Wed, 29 Jun 2022 11:59:47 -0400
Message-Id: <20220629155956.1138955-11-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629155956.1138955-1-nfraprado@collabora.com>
References: <20220629155956.1138955-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Elan eKTH3000 i2c trackpad present on Asurada. It is
connected to the I2C2 bus and has address 0x15.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

---

Changes in v4:
- Switched mediatek,pull-up-adv for bias-pull-up

 .../boot/dts/mediatek/mt8192-asurada.dtsi      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index fe626535ee5d..4de4235cb768 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -109,6 +109,16 @@ &i2c2 {
 	clock-stretch-ns = <12600>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c2_pins>;
+
+	trackpad@15 {
+		compatible = "elan,ekth3000";
+		reg = <0x15>;
+		interrupts-extended = <&pio 15 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&trackpad_pins>;
+		vcc-supply = <&pp3300_u>;
+		wakeup-source;
+	};
 };
 
 &i2c3 {
@@ -436,6 +446,14 @@ pins-bus {
 			bias-disable;
 		};
 	};
+
+	trackpad_pins: trackpad-default-pins {
+		pins-int-n {
+			pinmux = <PINMUX_GPIO15__FUNC_GPIO15>;
+			input-enable;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_11>;
+		};
+	};
 };
 
 &spi1 {
-- 
2.36.1

