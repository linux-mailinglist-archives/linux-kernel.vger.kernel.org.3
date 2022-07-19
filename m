Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4049657A80B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 22:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240105AbiGSUIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 16:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240058AbiGSUId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:08:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BFC25E9C;
        Tue, 19 Jul 2022 13:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658261312; x=1689797312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yTMxPZT11uI8z3/idJoE8G2YYGC0jI6IgeTomr6k1+k=;
  b=nvAk/ba8gJHqttCB/+GXJ7cNPc7q/leM5XrtdNglSGOuVQbiRbkHmvR3
   ddufeNxhcmFQJ/GB+dkG72dquxltHJmtL5/FylTV5u7GYCc1efzgu6JNE
   hXRAT4dvgp++AJyJp0wEjTTT6RdKNgqJaSW2VUY7GvRBt1OXLcp29g2I4
   QBbjRQD6BC2mPvYxJX33TP0k/iKMnxR5Nzh5HXig0SiltjdGfjwnAjFUm
   FOAUzz09Qigdb6Q37yAO+sDseQPhLLK6LljG2+GM3gDsTtfCiA0gUz3Pd
   u/B3pJ3FRlN0YIsw+9e9FhJX5Sjd4Skh4VYUQadoB9MZUm9pH0yGbJZ64
   A==;
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="105217557"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2022 13:08:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Jul 2022 13:08:32 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 19 Jul 2022 13:08:30 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <claudiu.beznea@microchip.com>, <nicolas.ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <maxime.chevallier@bootlin.com>,
        "Horatiu Vultur" <horatiu.vultur@microchip.com>
Subject: [PATCH v2 1/3] ARM: dts: lan966x: Add gpio-restart
Date:   Tue, 19 Jul 2022 22:11:56 +0200
Message-ID: <20220719201158.1696168-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220719201158.1696168-1-horatiu.vultur@microchip.com>
References: <20220719201158.1696168-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pcb8291 can be rebooted by toggling the GPIO 56. Therefore enable
this in DT.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 arch/arm/boot/dts/lan966x-pcb8291.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/lan966x-pcb8291.dts b/arch/arm/boot/dts/lan966x-pcb8291.dts
index d56d2054c38d..02fbf7371a8d 100644
--- a/arch/arm/boot/dts/lan966x-pcb8291.dts
+++ b/arch/arm/boot/dts/lan966x-pcb8291.dts
@@ -16,6 +16,12 @@ chosen {
 	aliases {
 		serial0 = &usart3;
 	};
+
+	gpio-restart {
+		compatible = "gpio-restart";
+		gpios = <&gpio 56 GPIO_ACTIVE_LOW>;
+		priority = <200>;
+	};
 };
 
 &gpio {
-- 
2.33.0

