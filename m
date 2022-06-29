Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9827856052E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbiF2QBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbiF2QA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:00:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD0B1C935;
        Wed, 29 Jun 2022 09:00:26 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 79AB36601956;
        Wed, 29 Jun 2022 17:00:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656518425;
        bh=SNen9swPBsEHXS8P51GX0gG1JD4BO4FIhFQGHBNVKtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=laJDhYt22pwi+Vo2pepUI0VbSlrpfKVE9+99pydYxucpyavxNZnYi1Nl2ACq9+HB+
         LRthalCQTGrpqz4vz1LhnohwytS9H65MFhfJWynYGPl8JitDy6N6nMeqK/GgQci/d7
         9+NHy6TnS3j9al0+kJPxKIYDf7+hTqttqLdBln177AoCoN9wFeyOOW4qL9SIkHd9l+
         pa4IARvJxESVRcwEezNEZU+E6cx+IVHfxdxidjiNXV4cTOcIvwnaKreQbN/i4QJ15q
         NQqp/zGUiTGU4qhvr5Ls80JcQ95czf+deolJwGbmYQnRyxU37zRp+lZ7ZpZgAWs7jy
         cJ4cJHL66Yxcg==
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
Subject: [PATCH v4 15/19] arm64: dts: mediatek: asurada: Add MT6359 PMIC
Date:   Wed, 29 Jun 2022 11:59:52 -0400
Message-Id: <20220629155956.1138955-16-nfraprado@collabora.com>
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

MT6359 is the primary PMIC present on the Asurada platform. Include its
dtsi and configure properties specific for the platform.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

---

(no changes since v2)

Changes in v2:
- Added this patch

 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index e59c178d3d26..31c9d1f8c80a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -5,6 +5,7 @@
  */
 /dts-v1/;
 #include "mt8192.dtsi"
+#include "mt6359.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 
 / {
@@ -168,6 +169,31 @@ &i2c7 {
 	pinctrl-0 = <&i2c7_pins>;
 };
 
+/* for CORE */
+&mt6359_vgpu11_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vgpu11_sshub_buck_reg {
+	regulator-always-on;
+	regulator-min-microvolt = <575000>;
+	regulator-max-microvolt = <575000>;
+};
+
+&mt6359_vrf12_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359_vufs_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359codec {
+	mediatek,dmic-mode = <1>; /* one-wire */
+	mediatek,mic-type-0 = <2>; /* DMIC */
+	mediatek,mic-type-2 = <2>; /* DMIC */
+};
+
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_pins>;
@@ -555,6 +581,10 @@ pins-report-sw {
 	};
 };
 
+&pmic {
+	interrupts-extended = <&pio 214 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &spi1 {
 	status = "okay";
 
-- 
2.36.1

