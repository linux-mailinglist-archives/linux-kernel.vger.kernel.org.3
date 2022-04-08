Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEE14F9D03
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238866AbiDHSkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238794AbiDHSkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:40:21 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEC06307;
        Fri,  8 Apr 2022 11:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649443085;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=pNpkln2hYOa7ltH/rl/3AxJhi2rBCEU80BdtJRG6SuE=;
    b=mmqjTW+qYqHH60LNNfdjZdgIlfWGEWIwpAEWszIV0jwyp12w9mmIuAyEkaS44sGZVB
    siFoPuIUgxXSoRMgg9qqo7zO2vGAurAsOAIYnuw+iP/6iddvgdOLhB6zwoSvyYwMrVZg
    7x17HHXmxND675EjmmKepYvgKAA8gSXYuBmLhyjsw8ejYx1u6J3RPjzHbdiaeVReTk4a
    IrppBVgJ7XLiHNWG5tX8RLAD0YzFMsqspYVn+QAN5amKmV8ctqjWiQibmMP8hkPxnDqR
    Bp8z2Ka60Wli7urc4PUvLECSWGBjXUHIqUeuDa9mhpNmBPOgup/dWp7si64HXyQyRvlW
    jmvg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbgdr/a"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy38Ic5so1
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 8 Apr 2022 20:38:05 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 10/18] MIPS: DTS: jz4780: fix uart dmas as reported by dtbscheck
Date:   Fri,  8 Apr 2022 20:37:53 +0200
Message-Id: <00ec9d965cac78b252e14444deed8c93f5116bca.1649443080.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1649443080.git.hns@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/mips/boot/dts/ingenic/ci20.dtb: serial@10030000: 'dmas' is a required property
	From schema: Documentation/devicetree/bindings/serial/ingenic,uart.yaml
arch/mips/boot/dts/ingenic/ci20.dtb: serial@10030000: 'dma-names' is a required property
	From schema: Documentation/devicetree/bindings/serial/ingenic,uart.yaml
arch/mips/boot/dts/ingenic/ci20.dtb: serial@10031000: 'dmas' is a required property
	From schema: Documentation/devicetree/bindings/serial/ingenic,uart.yaml
arch/mips/boot/dts/ingenic/ci20.dtb: serial@10031000: 'dma-names' is a required property
	From schema: Documentation/devicetree/bindings/serial/ingenic,uart.yaml
arch/mips/boot/dts/ingenic/ci20.dtb: serial@10032000: 'dmas' is a required property
	From schema: Documentation/devicetree/bindings/serial/ingenic,uart.yaml
arch/mips/boot/dts/ingenic/ci20.dtb: serial@10032000: 'dma-names' is a required property
	From schema: Documentation/devicetree/bindings/serial/ingenic,uart.yaml
arch/mips/boot/dts/ingenic/ci20.dtb: serial@10033000: 'dmas' is a required property
	From schema: Documentation/devicetree/bindings/serial/ingenic,uart.yaml
arch/mips/boot/dts/ingenic/ci20.dtb: serial@10033000: 'dma-names' is a required property
	From schema: Documentation/devicetree/bindings/serial/ingenic,uart.yaml
arch/mips/boot/dts/ingenic/ci20.dtb: serial@10034000: 'dmas' is a required property
	From schema: Documentation/devicetree/bindings/serial/ingenic,uart.yaml
arch/mips/boot/dts/ingenic/ci20.dtb: serial@10034000: 'dma-names' is a required property
	From schema: Documentation/devicetree/bindings/serial/ingenic,uart.yaml
arch/mips/boot/dts/ingenic/ci20.dtb: i2c@10050000: 'dmas' is a required property

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index dc88f9e813453..73cd05cf26472 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -283,6 +283,10 @@ uart0: serial@10030000 {
 		clocks = <&ext>, <&cgu JZ4780_CLK_UART0>;
 		clock-names = "baud", "module";
 
+		dmas = <&dma JZ4780_DMA_UART0_RX 0xffffffff>,
+		       <&dma JZ4780_DMA_UART0_TX 0xffffffff>;
+		dma-names = "rx", "tx";
+
 		status = "disabled";
 	};
 
@@ -296,6 +300,10 @@ uart1: serial@10031000 {
 		clocks = <&ext>, <&cgu JZ4780_CLK_UART1>;
 		clock-names = "baud", "module";
 
+		dmas = <&dma JZ4780_DMA_UART1_RX 0xffffffff>,
+		       <&dma JZ4780_DMA_UART1_TX 0xffffffff>;
+		dma-names = "rx", "tx";
+
 		status = "disabled";
 	};
 
@@ -309,6 +317,10 @@ uart2: serial@10032000 {
 		clocks = <&ext>, <&cgu JZ4780_CLK_UART2>;
 		clock-names = "baud", "module";
 
+		dmas = <&dma JZ4780_DMA_UART2_RX 0xffffffff>,
+		       <&dma JZ4780_DMA_UART2_TX 0xffffffff>;
+		dma-names = "rx", "tx";
+
 		status = "disabled";
 	};
 
@@ -322,6 +334,10 @@ uart3: serial@10033000 {
 		clocks = <&ext>, <&cgu JZ4780_CLK_UART3>;
 		clock-names = "baud", "module";
 
+		dmas = <&dma JZ4780_DMA_UART3_RX 0xffffffff>,
+		       <&dma JZ4780_DMA_UART3_TX 0xffffffff>;
+		dma-names = "rx", "tx";
+
 		status = "disabled";
 	};
 
@@ -335,6 +351,10 @@ uart4: serial@10034000 {
 		clocks = <&ext>, <&cgu JZ4780_CLK_UART4>;
 		clock-names = "baud", "module";
 
+		dmas = <&dma JZ4780_DMA_UART4_RX 0xffffffff>,
+		       <&dma JZ4780_DMA_UART4_TX 0xffffffff>;
+		dma-names = "rx", "tx";
+
 		status = "disabled";
 	};
 
-- 
2.33.0

