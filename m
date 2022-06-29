Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29E5560542
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbiF2QAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbiF2QAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:00:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC4A1CFC8;
        Wed, 29 Jun 2022 09:00:17 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8E23E660195F;
        Wed, 29 Jun 2022 17:00:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656518416;
        bh=DkEh0i4AhAuZrJDIOKX1/1K+MmHQy1XtKrDDIPq0SBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mGuzmp1ExCM5zcE7UT3S1NSe2MQD7d0sS9HCaAVaseFC4I2QPRi96THo3qN+rHpN8
         i6HVkrIwSZlEIwusQ2V7tSfif7LJvsCk42xKv3fm9+rXmKDVleh1nHKPqzKYczIb6F
         H7gWCYmkJ5XnAIHOXboLgC70btl+u3z7I06+SJjEsNYB+ju7fZJ/ft2uX6mRhdl9f0
         xgRK69PYY9vM2C7GbxqRiB8z5zoEvnAgklCov1Q/MhxJ1Pzy3LybHRmdjck/7udDAk
         hSvj4dTLi01kYevztV7GrfacfroFBArZB3s7EsGzxKBlU1BHVRlJ9FsNBzmWAilzZ9
         W/jnPqWXGOnDg==
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
Subject: [PATCH v4 09/19] arm64: dts: mediatek: asurada: Add Cr50 TPM
Date:   Wed, 29 Jun 2022 11:59:46 -0400
Message-Id: <20220629155956.1138955-10-nfraprado@collabora.com>
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

The Asurada platform has a Google Security Chip connected to the SPI5
bus. It runs the cr50 firmware and provides TPM functionality. Add
support for it.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
---

(no changes since v1)

 .../arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index 07405dea4d9d..fe626535ee5d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -5,6 +5,7 @@
  */
 /dts-v1/;
 #include "mt8192.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	aliases {
@@ -353,6 +354,13 @@ &pio {
 			  "AUD_DAT_MISO0",
 			  "AUD_DAT_MISO1";
 
+	cr50_int: cr50-irq-default-pins {
+		pins-gsc-ap-int-odl {
+			pinmux = <PINMUX_GPIO171__FUNC_GPIO171>;
+			input-enable;
+		};
+	};
+
 	cros_ec_int: cros-ec-irq-default-pins {
 		pins-ec-ap-int-odl {
 			pinmux = <PINMUX_GPIO5__FUNC_GPIO5>;
@@ -513,6 +521,15 @@ &spi5 {
 	mediatek,pad-select = <0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi5_pins>;
+
+	cr50@0 {
+		compatible = "google,cr50";
+		reg = <0>;
+		interrupts-extended = <&pio 171 IRQ_TYPE_EDGE_RISING>;
+		spi-max-frequency = <1000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cr50_int>;
+	};
 };
 
 &uart0 {
-- 
2.36.1

