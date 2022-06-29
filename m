Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CF4560547
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbiF2QAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbiF2QAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:00:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14AE1CB28;
        Wed, 29 Jun 2022 09:00:11 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AEAF8660194A;
        Wed, 29 Jun 2022 17:00:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656518410;
        bh=JyFvHzF1h6JWiQjjXk8U9t+6ggzEINjp5AvOftmDRZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UAzu/A85hycjxEbqCXIAVNoOgHNbXQE0ToLnVqVwvptkHeqExUIFHw4d1S/y1RsU5
         z0WfM0faQBYKnnDUAoTfGDYOxk8RVdC+JUEjObFuYnPEVHOWnBBpTvhWzBDPW/ZcZR
         iaTUDa2IothvqV7AaQyVwLH2i1qEdkOqeCggP4KP8Fs5rbZfU6DTgmVt4bwHinmW3I
         24I4HSGWrxYz9GFx8slPdSkeGvAsvMT2YWkFoaAut1DRmEevkKA9FgJWNaROhlc1IX
         zBUOXYAkX1T0ivkZ1wp4ZJa1VBKvjuS3qmoZ9VYPjyq5l8no+nwNXXKeK+HC6k75L/
         mw7GhrKa1J3MQ==
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
Subject: [PATCH v4 05/19] arm64: dts: mediatek: asurada: Add system-wide power supplies
Date:   Wed, 29 Jun 2022 11:59:42 -0400
Message-Id: <20220629155956.1138955-6-nfraprado@collabora.com>
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

Add system-wide power supplies present on all of the boards in the
Asurada family.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

(no changes since v3)

Changes in v3:
- Renamed nodes to be generic

 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index e10636298639..ca55dd095e80 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -19,6 +19,70 @@ memory@40000000 {
 		device_type = "memory";
 		reg = <0 0x40000000 0 0x80000000>;
 	};
+
+	/* system wide LDO 1.8V power rail */
+	pp1800_ldo_g: regulator-1v8-g {
+		compatible = "regulator-fixed";
+		regulator-name = "pp1800_ldo_g";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&pp3300_g>;
+	};
+
+	/* system wide switching 3.3V power rail */
+	pp3300_g: regulator-3v3-g {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_g";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&ppvar_sys>;
+	};
+
+	/* system wide LDO 3.3V power rail */
+	pp3300_ldo_z: regulator-3v3-z {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_ldo_z";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&ppvar_sys>;
+	};
+
+	/* separately switched 3.3V power rail */
+	pp3300_u: regulator-3v3-u {
+		compatible = "regulator-fixed";
+		regulator-name = "pp3300_u";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		/* enable pin wired to GPIO controlled by EC */
+		vin-supply = <&pp3300_g>;
+	};
+
+	/* system wide switching 5.0V power rail */
+	pp5000_a: regulator-5v0-a {
+		compatible = "regulator-fixed";
+		regulator-name = "pp5000_a";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&ppvar_sys>;
+	};
+
+	/* system wide semi-regulated power rail from battery or USB */
+	ppvar_sys: regulator-var-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "ppvar_sys";
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &pio {
-- 
2.36.1

