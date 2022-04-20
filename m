Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AE65090A0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 21:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381827AbiDTTp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 15:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238966AbiDTTpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 15:45:25 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A15813FB1;
        Wed, 20 Apr 2022 12:42:38 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D1D9222249;
        Wed, 20 Apr 2022 21:42:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650483757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CcKMlvsJ2zGYREfNKDk44FnRPa9PCrsCRIPcLBzTzlI=;
        b=Uxo9gF6+auz49tDakvZ3xsJZBlZCz2yWEietwfl7IoCk0/8/4DLEeJ6J6hPWCgskCldRMx
        yH8d+kaiSzKqWkTmc9y4GmirJi/Z0HC5aMWpebWjEiYpeJBUq0PqHU7XBG50CKO7MJgVdQ
        5YEvkDApgSea2veP1tenY6QkG/fq7Lc=
From:   Michael Walle <michael@walle.cc>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH] ARM: dts: lan966x: rename pinctrl nodes
Date:   Wed, 20 Apr 2022 21:42:30 +0200
Message-Id: <20220420194230.3415663-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
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

The pinctrl device tree binding will be converted to YAML format. Rename
the pin nodes so they end with "-pins" to match the schema.

Signed-off-by: Michael Walle <michael@walle.cc>
---
The YAML conversion patch is alread in
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel

 arch/arm/boot/dts/lan966x-pcb8291.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/lan966x-pcb8291.dts b/arch/arm/boot/dts/lan966x-pcb8291.dts
index 3281af90ac6d..3c7e3a7d6f14 100644
--- a/arch/arm/boot/dts/lan966x-pcb8291.dts
+++ b/arch/arm/boot/dts/lan966x-pcb8291.dts
@@ -35,7 +35,7 @@ fc3_b_pins: fcb3-spi-pins {
 		function = "fc3_b";
 	};
 
-	can0_b_pins:  can0_b_pins {
+	can0_b_pins:  can0-b-pins {
 		/* RX, TX */
 		pins = "GPIO_35", "GPIO_36";
 		function = "can0_b";
-- 
2.30.2

