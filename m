Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BA05112F8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359178AbiD0H5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359139AbiD0H45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:56:57 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718BA144DF0;
        Wed, 27 Apr 2022 00:53:47 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7468922249;
        Wed, 27 Apr 2022 09:53:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1651046025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gcuTyEAl8fBHDAyAKfO+ZMUc6CSNaKRTQvrLjq6mLNE=;
        b=B1q+Beee7HfLZkfm6FkYoks+RrPjBNjysiTOwYe6lQdWX3aoG/8Jw4NZjrNbBHHSgEAAHm
        3o0ChWtJiZeuSYBgvgcfSjRPcjs2wXQgZ8Ky1BRGMBRcQCYSXTgO6UAEFs0o/ZwNbNT9y2
        PnNBTGv0efFpFqMcrEQNgob1T1PDimo=
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>,
        Shawn Guo <shawnguo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] arm64: dts: freescale: reduce the interrup-map-mask
Date:   Wed, 27 Apr 2022 09:53:36 +0200
Message-Id: <20220427075338.1156449-3-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220427075338.1156449-1-michael@walle.cc>
References: <20220427075338.1156449-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce the interrupt-map-mask of the external interrupt controller to
0xf to align with the devicetree schema.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 35d1939e690b..46cc8d45ca65 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -335,7 +335,7 @@ extirq: interrupt-controller@1ac {
 					<9 0 &gic GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
 					<10 0 &gic GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
 					<11 0 &gic GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-map-mask = <0xffffffff 0x0>;
+				interrupt-map-mask = <0xf 0x0>;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 4e7bd04d9798..3e8def8fe1b4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -341,7 +341,7 @@ extirq: interrupt-controller@1ac {
 					<9 0 &gic GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
 					<10 0 &gic GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
 					<11 0 &gic GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-map-mask = <0xffffffff 0x0>;
+				interrupt-map-mask = <0xf 0x0>;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 18e529118476..33c5ad1b9b96 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -265,7 +265,7 @@ extirq: interrupt-controller@14 {
 					<9 0 &gic GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
 					<10 0 &gic GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
 					<11 0 &gic GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-map-mask = <0xffffffff 0x0>;
+				interrupt-map-mask = <0xf 0x0>;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 1282b61da8a5..3f767994b02d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -305,7 +305,7 @@ extirq: interrupt-controller@14 {
 					<9 0 &gic GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
 					<10 0 &gic GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
 					<11 0 &gic GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-map-mask = <0xffffffff 0x0>;
+				interrupt-map-mask = <0xf 0x0>;
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 82bd8c0f318b..47ea854720ce 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -698,7 +698,7 @@ extirq: interrupt-controller@14 {
 					<9 0 &gic GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
 					<10 0 &gic GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
 					<11 0 &gic GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-map-mask = <0xffffffff 0x0>;
+				interrupt-map-mask = <0xf 0x0>;
 			};
 		};
 
-- 
2.30.2

