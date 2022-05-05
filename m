Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3DD51C99E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbiEETvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385457AbiEETul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:50:41 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B6E5E74C;
        Thu,  5 May 2022 12:46:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 6824E1F45CD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651780018;
        bh=66Gcdl/BCzrTY3JeghuLR7TheiL9yVTorpEjlpfyV/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=clx1QUAk8PRxDtNJSmG0WHj2SvvJhV+eWQHT6V/uHzLDOmjgrAULRqO22jnVi4B7R
         KrVPYpgopgTt1EP8r9ITnc8O+J0zWoALXltUIlU1cL330dOvZXLUCCC5WvpS1GByNC
         ewX4Aw73EaPT9GEZizyuUoeVJNqZiHgp9asN6Ba70yDdGS2wfn0rFL+dZbBve2HE+u
         Q03Q774WnoLME1E14XLDNaz5PbAhH+9Pu2D9IYS1kJWeONUh3TkMdgiwdAsqNOcs+a
         llLphy1KdOCJ3XBNSMTNM9ajhJXzP+a/TX3NMush3nP/lmA/gxDydY6tACIvzxBENx
         vz2hB6Q0KBEeg==
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
Subject: [PATCH v2 15/16] arm64: dts: mediatek: asurada: Add MT6359 PMIC
Date:   Thu,  5 May 2022 15:45:49 -0400
Message-Id: <20220505194550.3094656-16-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220505194550.3094656-1-nfraprado@collabora.com>
References: <20220505194550.3094656-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT6359 is the primary PMIC present on the Asurada platform. Include its
dtsi and configure properties specific for the platform.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

---

Changes in v2:
- Added this patch

 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index 87a9a6b1eabc..a9ffa74b2764 100644
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
@@ -559,6 +585,10 @@ pins-report-sw {
 	};
 };
 
+&pmic {
+	interrupts-extended = <&pio 214 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &spi1 {
 	status = "okay";
 
-- 
2.36.0

