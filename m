Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9413C4D765A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 16:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbiCMPbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 11:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbiCMPbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 11:31:00 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E59838DA9;
        Sun, 13 Mar 2022 08:29:51 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3B59622438;
        Sun, 13 Mar 2022 16:29:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1647185389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3/jJPQNTYcscMExGs+f7OHojmn6MFY4V2UBkBJ0zayk=;
        b=KUBxIRbgQqOpPnYnojPVvo44Vma2rf8pFgAO5tLGcaptKcF3NtgMu/MDqdyU9F6oShT5CZ
        MIBmB85uIGWJiWLDhTsYN/6pQEtiteFZl1XDXzv4bT1PN5tR53B10hGVUttD94K2in9H3r
        NvhnFcZb8Ewkr7IYoA5TEBS6SeDy93I=
From:   Michael Walle <michael@walle.cc>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Antoine Tenart <atenart@kernel.org>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        UNGLinuxDriver@microchip.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v1 4/8] MIPS: mscc: ocelot: fix load/save GPIO pinctrl name
Date:   Sun, 13 Mar 2022 16:29:20 +0100
Message-Id: <20220313152924.61931-5-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220313152924.61931-1-michael@walle.cc>
References: <20220313152924.61931-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pinctrl device tree binding will be converted to YAML format. All
the pin nodes should end with "-pins". Fix them.

Fixes: 15324652f612 ("MIPS: dts: ocelot: describe the load/save GPIO")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/mips/boot/dts/mscc/ocelot_pcb120.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/mscc/ocelot_pcb120.dts b/arch/mips/boot/dts/mscc/ocelot_pcb120.dts
index cda6c5ff58ad..d348742c233d 100644
--- a/arch/mips/boot/dts/mscc/ocelot_pcb120.dts
+++ b/arch/mips/boot/dts/mscc/ocelot_pcb120.dts
@@ -27,7 +27,7 @@ phy_int_pins: phy-int-pins {
 		function = "gpio";
 	};
 
-	phy_load_save_pins: phy_load_save_pins {
+	phy_load_save_pins: phy-load-save-pins {
 		pins = "GPIO_10";
 		function = "ptp2";
 	};
-- 
2.30.2

