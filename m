Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E024F9D12
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238953AbiDHSld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238832AbiDHSkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:40:32 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761A032ECF;
        Fri,  8 Apr 2022 11:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649443085;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=gcUekKrTLPRq8EGHHTRZ7CwmCNdjRQBiU/2KaAknpeo=;
    b=ejq19stivQSMvn+YP2dF5MyfVFSeBQ7a2VsIDZoqct+4OxnG5XOUhtEE8Aq0fRvLS/
    204HeDajMxo84m9C5rx0N6dEZm7fR6g46QPGlriP1Z7yUE2An0pA/nqHCwwniae4lqQj
    RTCXfz3FYLei9mQIXLYTzuWartb9DNvN59VvfqQyUKM/4YBvMUnJlD56oCz9tEt7Spip
    EuZ1yvvpVrsYhdXo3aZdjVOjCD4Px1poWp9FwydD5I5dzMFGiJJiqfyhrtF2ahOTfUxZ
    pClPSGuIBz8C5F4moLXUSaqZHguD/0lRfHP/PdyP/GEwFf2Yf4HqmawcInZeN0d6cPKV
    rs5Q==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbgdr/a"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy38Ic5so2
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
Subject: [PATCH 11/18] MIPS: DTS: jz4780: fix i2c dmas as reported by dtbscheck
Date:   Fri,  8 Apr 2022 20:37:54 +0200
Message-Id: <e9ec735684b3ab8393bfa87c692ba030e669795c.1649443080.git.hns@goldelico.com>
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

arch/mips/boot/dts/ingenic/ci20.dtb: i2c@10050000: 'dma-names' is a required property
	From schema: Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml
arch/mips/boot/dts/ingenic/ci20.dtb: i2c@10051000: 'dmas' is a required property
	From schema: Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml
arch/mips/boot/dts/ingenic/ci20.dtb: i2c@10051000: 'dma-names' is a required property
	From schema: Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml
arch/mips/boot/dts/ingenic/ci20.dtb: i2c@10052000: 'dmas' is a required property
	From schema: Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml
arch/mips/boot/dts/ingenic/ci20.dtb: i2c@10052000: 'dma-names' is a required property
	From schema: Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml
arch/mips/boot/dts/ingenic/ci20.dtb: i2c@10053000: 'dmas' is a required property
	From schema: Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml
arch/mips/boot/dts/ingenic/ci20.dtb: i2c@10053000: 'dma-names' is a required property
	From schema: Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml
arch/mips/boot/dts/ingenic/ci20.dtb: i2c@10054000: 'dmas' is a required property
	From schema: Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml
arch/mips/boot/dts/ingenic/ci20.dtb: i2c@10054000: 'dma-names' is a required property
	From schema: Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 73cd05cf26472..dcb93d0158856 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -392,6 +392,10 @@ i2c0: i2c@10050000 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pins_i2c0_data>;
 
+		dmas = <&dma JZ4780_DMA_SMB0_RX 0xffffffff>,
+		       <&dma JZ4780_DMA_SMB0_TX 0xffffffff>;
+		dma-names = "rx", "tx";
+
 		status = "disabled";
 	};
 
@@ -409,6 +413,10 @@ i2c1: i2c@10051000 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pins_i2c1_data>;
 
+		dmas = <&dma JZ4780_DMA_SMB1_RX 0xffffffff>,
+		       <&dma JZ4780_DMA_SMB1_TX 0xffffffff>;
+		dma-names = "rx", "tx";
+
 		status = "disabled";
 	};
 
@@ -426,6 +434,10 @@ i2c2: i2c@10052000 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pins_i2c2_data>;
 
+		dmas = <&dma JZ4780_DMA_SMB2_RX 0xffffffff>,
+		       <&dma JZ4780_DMA_SMB2_TX 0xffffffff>;
+		dma-names = "rx", "tx";
+
 		status = "disabled";
 	};
 
@@ -443,6 +455,10 @@ i2c3: i2c@10053000 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pins_i2c3_data>;
 
+		dmas = <&dma JZ4780_DMA_SMB3_RX 0xffffffff>,
+		       <&dma JZ4780_DMA_SMB3_TX 0xffffffff>;
+		dma-names = "rx", "tx";
+
 		status = "disabled";
 	};
 
@@ -460,6 +476,10 @@ i2c4: i2c@10054000 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pins_i2c4_data>;
 
+		dmas = <&dma JZ4780_DMA_SMB4_RX 0xffffffff>,
+		       <&dma JZ4780_DMA_SMB4_TX 0xffffffff>;
+		dma-names = "rx", "tx";
+
 		status = "disabled";
 	};
 
-- 
2.33.0

