Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD99851C988
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385357AbiEETuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385374AbiEETub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:50:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942565E74E;
        Thu,  5 May 2022 12:46:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id D308A1F45CD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651780003;
        bh=Dj7vGkYC2BwaxdlFtxv9aMWMtotDYi0t1OanA82gQVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ob34YrajdxH8LFFr/Uzcr6LQXBusD66HfS6+XCkQgwF+9I7/dqzTSip4UumJ4ElDm
         4gctg/6716y5yLvdh//RAFfzEe8J6t0Ncmt/4HFojagHFvLoK04+slvMT7QaTb2lKE
         qGQcN6oGcWHVmnXfQLuKrvPsz3uE/IUGlkqv4X1JErzfPjIv0qPZka/2oz0Myn9dlb
         M4QnLgRAtia18gCJqu6J3PJ5UTWtGu96zvoHzyKo0/Ac5R1zUEUOTC5LGC4yin5Q+c
         3gij+MxiX93X0p3kLNn+a8K63GVV75bhsOXAPlctkv1Vx8K01hRGrRMeoPUA1SxjYx
         8HbVB94qzSN7w==
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
Subject: [PATCH v2 10/16] arm64: dts: mediatek: asurada: Add Elan eKTH3000 I2C trackpad
Date:   Thu,  5 May 2022 15:45:44 -0400
Message-Id: <20220505194550.3094656-11-nfraprado@collabora.com>
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

Add support for the Elan eKTH3000 i2c trackpad present on Asurada. It is
connected to the I2C2 bus and has address 0x15.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

(no changes since v1)

 .../boot/dts/mediatek/mt8192-asurada.dtsi      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index 5221f1d1b7dc..a15e84d86449 100644
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
2.36.0

