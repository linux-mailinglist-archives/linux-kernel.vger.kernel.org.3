Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D33560545
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbiF2QB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbiF2QAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:00:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CE42C644;
        Wed, 29 Jun 2022 09:00:33 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 61E6E66019AC;
        Wed, 29 Jun 2022 17:00:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656518431;
        bh=fWpLVNkaRd2J8/GN0NiVTcm+/j+WzfBVE0/fxSI1x5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DY92GFjN3oeuKinw8Ew49bJgJxgOWoEzUt8A8bZVJPRHE59LO3545axbqRbXd5QI6
         NOvolx1mgJgf+roEOHSN7NuOJQ0r6maVhCTo9p/20oueU1YT8lQYaE3TusW4e13aqr
         Wgu7phTuv8d70Zc6IPA7puSWOvI4bWE4Ja98bu7eOeSwM4CGQ9n6g4oCbh/YlShGuW
         KJ69HN2yvBHPBnC+GdC/nehh+L3J4vxiQ25nRQYnVCiERoBvR/UOVrNpAmN9USsz9c
         G6OHQ6n+q17lHnOZDCbgPHHs/6yvDDjHN52lMDHILXCKmiCK5/ReyFXGzmOYbOelxW
         TGpBJe7lQUP0g==
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
Subject: [PATCH v4 19/19] arm64: dts: mediatek: asurada: Add SPI NOR flash memory
Date:   Wed, 29 Jun 2022 11:59:56 -0400
Message-Id: <20220629155956.1138955-20-nfraprado@collabora.com>
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

Add support for the SPI NOR flash memory present on the Asurada
platform.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

---

Changes in v4:
- Added this patch

 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index a5625b3cb317..4b314435f8fd 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -241,6 +241,23 @@ &mt6359codec {
 	mediatek,mic-type-2 = <2>; /* DMIC */
 };
 
+&nor_flash {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&nor_flash_pins>;
+	assigned-clocks = <&topckgen CLK_TOP_SFLASH_SEL>;
+	assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D6_D8>;
+
+	flash@0 {
+		compatible = "winbond,w25q64jwm", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <52000000>;
+		spi-rx-bus-width = <2>;
+		spi-tx-bus-width = <2>;
+	};
+};
+
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_pins>;
@@ -658,6 +675,29 @@ pins-clk {
 		};
 	};
 
+	nor_flash_pins: nor-flash-default-pins {
+		pins-cs-io1 {
+			pinmux = <PINMUX_GPIO24__FUNC_SPINOR_CS>,
+				 <PINMUX_GPIO28__FUNC_SPINOR_IO1>;
+			input-enable;
+			bias-pull-up;
+			drive-strength = <10>;
+		};
+
+		pins-io0 {
+			pinmux = <PINMUX_GPIO27__FUNC_SPINOR_IO0>;
+			bias-pull-up;
+			drive-strength = <10>;
+		};
+
+		pins-clk {
+			pinmux = <PINMUX_GPIO25__FUNC_SPINOR_CK>;
+			input-enable;
+			bias-pull-up;
+			drive-strength = <10>;
+		};
+	};
+
 	pcie_pins: pcie-default-pins {
 		pins-pcie-wake {
 			pinmux = <PINMUX_GPIO63__FUNC_PCIE_WAKE_N>;
-- 
2.36.1

