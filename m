Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2C4565256
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbiGDK3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbiGDK27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:28:59 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B922719;
        Mon,  4 Jul 2022 03:28:57 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 759BE24000B;
        Mon,  4 Jul 2022 10:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656930536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bY9k2hKqsyHlaoLqP64+/s43+QLgOGGKL1kqn0fNDuQ=;
        b=i7nVJZbB8VxaaFclnvCzIxKQ98p0wqQrMaWfZUnEgL/mVJQPMg6gGiAm0gcyyb17GxBlxq
        gQkrUQ31+oUIU3+TBsnoR9PNIgBfId7N8wXP8iHXiVcjxtK+PoRR6hX+Y3Bfk63aPCYd1S
        NDXzVzxgbWFmvtjw6aEgrHPLHgFZyvcCALyHrGM4gjJSLPk6Ntrg8ioXmhwTHdvJRTGKJo
        phV395wb41erTzCxiaE6xh1jSFYV5P2mXM29eie9xhOedFsoCLTaDRx4Yc0WK+bvAC7M5u
        ZYQYfrH6CNhPUXkqkaymGmHJiIh78fUSbzIsSsysCFZI6RMteqorptrr5LfZ+g==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 2/3] dt-bindings: usb: atmel: Add Microchip LAN9662 compatible string
Date:   Mon,  4 Jul 2022 12:28:44 +0200
Message-Id: <20220704102845.168438-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220704102845.168438-1-herve.codina@bootlin.com>
References: <20220704102845.168438-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB device controller available in the Microchip LAN9662 SOC
is the same IP as the one present in the SAMA5D3 SOC.

Add the LAN9662 compatible string and set the SAMA5D3 compatible
string as a fallback for the LAN9662.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/usb/atmel-usb.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt b/Documentation/devicetree/bindings/usb/atmel-usb.txt
index f512f0290728..12183ef47ee4 100644
--- a/Documentation/devicetree/bindings/usb/atmel-usb.txt
+++ b/Documentation/devicetree/bindings/usb/atmel-usb.txt
@@ -87,6 +87,9 @@ Required properties:
 	       "atmel,at91sam9g45-udc"
 	       "atmel,sama5d3-udc"
 	       "microchip,sam9x60-udc"
+	       "microchip,lan9662-udc"
+	       For "microchip,lan9662-udc" the fallback "atmel,sama5d3-udc"
+	       is required.
  - reg: Address and length of the register set for the device
  - interrupts: Should contain usba interrupt
  - clocks: Should reference the peripheral and host clocks
-- 
2.35.3

