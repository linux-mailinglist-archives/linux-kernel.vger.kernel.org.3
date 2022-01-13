Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF3048D19D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 05:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiAMESf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 23:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiAMER6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 23:17:58 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DACC06173F;
        Wed, 12 Jan 2022 20:17:58 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id t24so18232796edi.8;
        Wed, 12 Jan 2022 20:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=77eABsbCU3dP1bKLZ3G94phln3owatljgGCcc6O8QoU=;
        b=ZVbhEzdH3jiYjDcsZqLq7E3IHGPYUd9KOeRnSnWzPr9awuxeQfhmqb5v5aISHeXEVs
         HMbj49kclfWx/i5Anoxswd9OVzGWQHqnqPAL5j1cq/ZHAN99q6KRgMPZuZ72ViV5r06F
         XnFP+iiDkOedTsXX3NrzreLfhZdH/zXiQtVXRrUG0jdL8+kJPDPDn3DNQe3Wz85t3ym4
         fAuZDrsecz3ertQP+mNBeGZa/kdS/OjpHy6ihXA8vQa0lYdyAS/H3dkVBzbvOATUgmzX
         znZoYN0yBuU1VCchMBz9qUIGzGL2n3SvBsaa98uO7cx11DyNMxDJ/9GK4sqi0GW+APRd
         878g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=77eABsbCU3dP1bKLZ3G94phln3owatljgGCcc6O8QoU=;
        b=lgn3YBhjHRcZ7mQEBm97TOCSsE1UjpqC8LGJSVrOrWsN9zASxJYL1DPSsBustCJha+
         xJvotaJh/2pIC/QhxbcoHdqWehr+QbEbmlAsQr/AMtqwd+cL9thDwe7yFpiA2bmdVp5O
         Rej/okoh5Mmi+je3LIrnKEgCLLZYQBkKq9Cpvelr5QH1nz+xfYXXXrkuiqqM2phWqG0v
         JFmZexhSCE6Le4e1ZvAPkVi2E3eHxqKb1nZyDeVUe9N0kfW33ensHMINT8jjt/T3uWGs
         UHQPyHrA5ZQ/2UBVCLWT8JRwoXf91P0+bHhGf05p+YcO7Ekq74WTOYqE7RnSGgDmD+AO
         K99Q==
X-Gm-Message-State: AOAM533avfdmXj02DygNgWdgtyMRaJfeYtyMMW2n0Kb4ol6cQcpYpVVr
        N7PWUHG3Fqj/kyrkCkLWnkc=
X-Google-Smtp-Source: ABdhPJxxqqxrczJGaeFkFoP2CvjQ6KUb+AYG/R0qYf0sCbOQG6VHmmkkIBWefBG63r0tI4h6hBrlXw==
X-Received: by 2002:a17:907:9810:: with SMTP id ji16mr2187826ejc.202.1642047476657;
        Wed, 12 Jan 2022 20:17:56 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id eb14sm651822edb.16.2022.01.12.20.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 20:17:56 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 3/3] arm64: dts: meson: remove Broadcom WiFi/BT nodes from Khadas VIM1
Date:   Thu, 13 Jan 2022 04:17:46 +0000
Message-Id: <20220113041746.16040-4-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220113041746.16040-1-christianshewitt@gmail.com>
References: <20220113041746.16040-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Broadcom WiFi/BT SDIO nodes are now inherited from the P212 common dtsi
so we can remove them from the VIM1 board dts.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../amlogic/meson-gxl-s905x-khadas-vim.dts    | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index 6ab1cc125b96..108232a5aa2e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -217,25 +217,6 @@
 	pinctrl-0 = <&pwm_e_pins>, <&pwm_f_clk_pins>;
 };
 
-&sd_emmc_a {
-	max-frequency = <100000000>;
-
-	brcmf: wifi@1 {
-		reg = <1>;
-		compatible = "brcm,bcm4329-fmac";
-	};
-};
-
-&uart_A {
-	bluetooth {
-		compatible = "brcm,bcm43438-bt";
-		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
-		max-speed = <2000000>;
-		clocks = <&wifi32k>;
-		clock-names = "lpo";
-	};
-};
-
 /* This is brought out on the Linux_RX (18) and Linux_TX (19) pins: */
 &uart_AO {
 	status = "okay";
-- 
2.17.1

