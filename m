Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C032577BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 08:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbiGRGoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 02:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbiGRGoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 02:44:09 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616B613F21;
        Sun, 17 Jul 2022 23:44:08 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id m8so489909edd.9;
        Sun, 17 Jul 2022 23:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MU6KvRw9oUiosk9iNJZEva46TvY9a6ly1/UmmRb7+pc=;
        b=eE+WuVP5QBk/uvd2VNurfHx4gbXUdV/PTPdGQJtEzGqYqlWTmNjwAvbQHQBqbypXUC
         JrCduep2LlxYAaJL8H3nu4+Lqq5dausufRlrhr/QnNxMjtKTdQfzrSpYN00EdEoNFm3p
         xCG57Zs8AWOd7yWD6cwdaLn4P+GMg4NegGcz+SV+ZhbsFOxXeAwyWVIBQa41wWlIkOyv
         ouQDDM019CzszLh+NuOTwnUdiIU4A3DWWlPfGJw80hNtgLaS8ZrLgNEecMHHZDak28j0
         Lz8j+xHyZou5CHaM/NxxBiTLRdxyFjMjxS9B0JbMQcJE9zgaq7IT3dG6kg9+UFfkN8du
         npiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MU6KvRw9oUiosk9iNJZEva46TvY9a6ly1/UmmRb7+pc=;
        b=aPO3nJ3IFwklRW82uMWptSKnebX17tg1/1OSRiyFRN2Il6+SgGmvkEpTXfPMHhie2i
         vUcS+1qPL0vI/yEVC7QfuqlEckrOmK+hZ6EClbN28sOZ23ivm0IWV6yhwPlQFy+ktUNw
         uPO6hpXuRYbJE+PiM/YayB88LcD7zMUUWCzDHfW6yobj7hDJ22wUB4+dsMlF63flFnsm
         f/n4hpu09eyyzs45QXR94fiq/9DCnd13N4Bo2sBAlka/p4FCyfek3SaFCmjndTtEwFCW
         rlz0bcesk8ji6I8VOTazTmK6/1YxIReXEqDlmMQqhSnRJicNyaceyxRERkCPK2gRVGEy
         YNmQ==
X-Gm-Message-State: AJIora+M2CMQTF+4xnaj5RCnYfCQ/G+hi54NWARsprFo+n4scSUdpm88
        O+Egsp3UC1ziFHex/RuP9W8=
X-Google-Smtp-Source: AGRyM1tEkwjOYckD6D53C0eCd+2u0KOttLBEhE46rvAyaRUFkVfkcucNiFKo3R9kCMN5l0dmS4QLTw==
X-Received: by 2002:a05:6402:2895:b0:43b:1e47:c132 with SMTP id eg21-20020a056402289500b0043b1e47c132mr28987655edb.425.1658126646909;
        Sun, 17 Jul 2022 23:44:06 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id h10-20020aa7cdca000000b0043ab5939ecbsm8030847edw.59.2022.07.17.23.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 23:44:06 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Add analog audio output on quartz64-b
Date:   Mon, 18 Jul 2022 08:43:36 +0200
Message-Id: <20220718064336.822773-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the necessary device tree changes to enable analog
audio output on the PINE64 Quartz64 Model B with its RK809
codec.

The headphone detection pin is left out for now because I couldn't
get it to work and am not sure if it even matters, but for future
reference: It's pin GPIO4 RK_PC4, named HP_DET_L_GPIO4_C4 in the
schematic.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 .../boot/dts/rockchip/rk3566-quartz64-b.dts   | 32 ++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
index 02d5f5a8ca03..a53cf81494fd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
@@ -42,6 +42,21 @@ led-user {
 		};
 	};
 
+	rk809-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,name = "Analog RK809";
+		simple-audio-card,mclk-fs = <256>;
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s1_8ch>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&rk809>;
+		};
+	};
+
 	sdio_pwrseq: sdio-pwrseq {
 		status = "okay";
 		compatible = "mmc-pwrseq-simple";
@@ -177,11 +192,16 @@ rk809: pmic@20 {
 		reg = <0x20>;
 		interrupt-parent = <&gpio0>;
 		interrupts = <RK_PA7 IRQ_TYPE_LEVEL_LOW>;
+		assigned-clocks = <&cru I2S1_MCLKOUT_TX>;
+		assigned-clock-parents = <&cru CLK_I2S1_8CH_TX>;
+		clock-names = "mclk";
+		clocks = <&cru I2S1_MCLKOUT_TX>;
 		clock-output-names = "rk808-clkout1", "rk808-clkout2";
 
 		pinctrl-names = "default";
-		pinctrl-0 = <&pmic_int>;
+		pinctrl-0 = <&pmic_int>, <&i2s1m0_mclk>;
 		rockchip,system-power-controller;
+		#sound-dai-cells = <0>;
 		wakeup-source;
 		#clock-cells = <1>;
 
@@ -420,6 +440,16 @@ &i2c5 {
 	status = "disabled";
 };
 
+&i2s1_8ch {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2s1m0_sclktx
+		     &i2s1m0_lrcktx
+		     &i2s1m0_sdi0
+		     &i2s1m0_sdo0>;
+	rockchip,trcm-sync-tx-only;
+	status = "okay";
+};
+
 &mdio1 {
 	rgmii_phy1: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-- 
2.37.1

