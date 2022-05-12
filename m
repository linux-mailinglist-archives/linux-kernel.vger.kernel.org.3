Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408105256BE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 22:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358614AbiELU5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 16:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358571AbiELU5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 16:57:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9055A68FA3;
        Thu, 12 May 2022 13:56:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id C44701F45948
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652388996;
        bh=j9EKFrnbOZbyTcEQCEWfG2IS74kguTTzKhClb3b7Sbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HJ8wu6AYCA+FpIEs9q8u7ovvjzcuuduExswm/0ZNchZ7YXJhw1nHCIZxRFBTtOveS
         w/DZz7DRShWZ3LLaz17T1ZF8srgWgCZIrAa4J6y6OSgItZ8CRewkgRcwiml6Qb/ojd
         UFw3SZ9bt3tsf2Tg89pbOZ5zhsjExbmuRzukLJKBSijxb1p/JDQ3zUfZ69+jOaRaIJ
         gTOulhx+Rpkr/vtFoz3gSEggfsbBJBw1dJM+m6TTSoY7oVZ+gkAkiW53Cps09kMH4n
         WNOZtYFsETBGGHwOBzDHpG3yUwHXdHRjfLSaMb2nVY4pDnj6GGG6Rg6mB28mlx89hW
         cycLiWuUtha9w==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 10/16] arm64: dts: mediatek: asurada: Add Elan eKTH3000 I2C trackpad
Date:   Thu, 12 May 2022 16:55:56 -0400
Message-Id: <20220512205602.158273-11-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220512205602.158273-1-nfraprado@collabora.com>
References: <20220512205602.158273-1-nfraprado@collabora.com>
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

Add support for the Elan eKTH3000 i2c trackpad present on Asurada. It is
connected to the I2C2 bus and has address 0x15.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
---

(no changes since v1)

 .../boot/dts/mediatek/mt8192-asurada.dtsi      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index ddf18861edad..a63b3c86d650 100644
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
@@ -440,6 +450,14 @@ pins-bus {
 			bias-disable;
 		};
 	};
+
+	trackpad_pins: trackpad-default-pins {
+		pins-int-n {
+			pinmux = <PINMUX_GPIO15__FUNC_GPIO15>;
+			input-enable;
+			mediatek,pull-up-adv = <3>;
+		};
+	};
 };
 
 &spi1 {
-- 
2.36.1

