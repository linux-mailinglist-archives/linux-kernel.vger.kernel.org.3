Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA2356053D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbiF2QBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiF2QA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:00:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471DD1E3C1;
        Wed, 29 Jun 2022 09:00:28 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E55406601A52;
        Wed, 29 Jun 2022 17:00:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656518427;
        bh=vZ9XvC5lN6ld9CuAEKGg4eWU+inCLtaAJj3gykR2qRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kroCAwD9EotEFf6ntWKGoMCnuT6MkbcPEdP2kmpMrqrG8CXL3qErgDCUhnc2ud6RQ
         E544H3FLOb3gThZbIrN6H3KBnrVc2kB7cTWu5eKjxCE9fo6Ad2SQ/NbbUvS5Sh9LER
         ywFTqBoG8ofREu/tdXUSQeXa2XPLirgxMo9LJY4yTEobT7dlwRSrscU2TZ5q5LOPyY
         0wep5r8udr+0OLq09pHjk6wImA/R9UQdG6ZjJ41I22ipxR/jvVrmLXimNFgem6Dm6o
         X9o8hDdh4d4OHJaAYCpvFnZW/FLf46TJxaAnrugiUhfUrGrquTUU9ofACRZBd8TWxf
         hi4B5Rvf0J74w==
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
Subject: [PATCH v4 16/19] arm64: dts: mediatek: asurada: Add SPMI regulators
Date:   Wed, 29 Jun 2022 11:59:53 -0400
Message-Id: <20220629155956.1138955-17-nfraprado@collabora.com>
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

The Asurada platform uses regulators from MT6315 PMICs acessible through
SPMI. Add support for them.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

---

Changes in v4:
- Updated Vgpu minimum voltage to appropriate value

Changes in v2:
- Added this patch

 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index 31c9d1f8c80a..d56c73e37633 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -7,6 +7,7 @@
 #include "mt8192.dtsi"
 #include "mt6359.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/spmi/spmi.h>
 
 / {
 	aliases {
@@ -679,6 +680,54 @@ cr50@0 {
 	};
 };
 
+&spmi {
+	#address-cells = <2>;
+	#size-cells = <0>;
+
+	mt6315_6: pmic@6 {
+		compatible = "mediatek,mt6315-regulator";
+		reg = <0x6 SPMI_USID>;
+
+		regulators {
+			mt6315_6_vbuck1: vbuck1 {
+				regulator-compatible = "vbuck1";
+				regulator-name = "Vbcpu";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1193750>;
+				regulator-enable-ramp-delay = <256>;
+				regulator-allowed-modes = <0 1 2>;
+				regulator-always-on;
+			};
+
+			mt6315_6_vbuck3: vbuck3 {
+				regulator-compatible = "vbuck3";
+				regulator-name = "Vlcpu";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1193750>;
+				regulator-enable-ramp-delay = <256>;
+				regulator-allowed-modes = <0 1 2>;
+				regulator-always-on;
+			};
+		};
+	};
+
+	mt6315_7: pmic@7 {
+		compatible = "mediatek,mt6315-regulator";
+		reg = <0x7 SPMI_USID>;
+
+		regulators {
+			mt6315_7_vbuck1: vbuck1 {
+				regulator-compatible = "vbuck1";
+				regulator-name = "Vgpu";
+				regulator-min-microvolt = <606250>;
+				regulator-max-microvolt = <1193750>;
+				regulator-enable-ramp-delay = <256>;
+				regulator-allowed-modes = <0 1 2>;
+			};
+		};
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.36.1

