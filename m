Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFBF5A3245
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345380AbiHZW5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiHZW5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:57:22 -0400
X-Greylist: delayed 1800 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Aug 2022 15:57:20 PDT
Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [IPv6:2001:690:2100:1::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D410FE9906;
        Fri, 26 Aug 2022 15:57:20 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id 1F5D96007C1E;
        Fri, 26 Aug 2022 23:02:20 +0100 (WEST)
X-Virus-Scanned: by amavisd-new-2.11.0 (20160426) (Debian) at
        tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
        by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavisd-new, port 10025)
        with LMTP id 6_Qd847GxDqz; Fri, 26 Aug 2022 23:02:17 +0100 (WEST)
Received: from mail2.tecnico.ulisboa.pt (mail2.ist.utl.pt [IPv6:2001:690:2100:1::4750:b5b4])
        by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id AA140600087B;
        Fri, 26 Aug 2022 23:02:17 +0100 (WEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tecnico.ulisboa.pt;
        s=mail; t=1661551337;
        bh=pBW9/6ZWzjlfBYVewQv7OgakWHFw5D0L/WyojUAzzW8=;
        h=Date:From:To:Cc:Subject;
        b=aAbu+86kadOAXTMTHYuRWjd+giU5LCOkKiwMgs3nOLA0kcimEkbuY1JZdpbqmXbwz
         0tGzyOLMYZ8Hry0HmERNOljDb0PI4pBayspiCfH94v9nyTLXnK3NpUDA1sbztAbsrY
         tjWULiT5kWcoZswmixuru0Nj7dKKQ3JCLbxXzAog=
Received: from archlinux (unknown [IPv6:2001:818:dcb5:dc00:7a88:7f12:8ed8:518d])
        (Authenticated sender: ist187313)
        by mail2.tecnico.ulisboa.pt (Postfix) with ESMTPSA id 0B7385600BD;
        Fri, 26 Aug 2022 23:02:17 +0100 (WEST)
Date:   Fri, 26 Aug 2022 23:02:18 +0100
From:   Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
To:     diogo.ivo@tecnico.ulisboa.pt
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: tegra: smaug: Add Bluetooth node
Message-ID: <20220826220218.abgj6zplibwqvqc7@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Google Pixel C contains a BRCM4354 Bluetooth module.
Add a DT node for it. Tested on Pixel C.

Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
---
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
index 8a8ca9c48f42..afd05391e78a 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
@@ -17,6 +17,7 @@ / {
 
 	aliases {
 		serial0 = &uarta;
+		serial3 = &uartd;
 	};
 
 	chosen {
@@ -1340,6 +1341,22 @@ serial@70006000 {
 		status = "okay";
 	};
 
+	uartd: serial@70006300 {
+		compatible = "nvidia,tegra30-hsuart";
+		status = "okay";
+
+		bluetooth {
+			compatible = "brcm,bcm43540-bt";
+			max-speed = <4000000>;
+			brcm,bt-pcm-int-params = [01 02 00 01 01];
+			device-wakeup-gpios = <&gpio TEGRA_GPIO(H, 3) GPIO_ACTIVE_HIGH>;
+			shutdown-gpios = <&gpio TEGRA_GPIO(H, 4) GPIO_ACTIVE_HIGH>;
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_GPIO(H, 5) IRQ_TYPE_EDGE_FALLING>;
+			interrupt-names = "host-wakeup";
+		};
+	};
+
 	i2c@7000c400 {
 		status = "okay";
 		clock-frequency = <1000000>;
-- 
2.37.2

