Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFFB5A232F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343743AbiHZIh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343516AbiHZIhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:37:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770D8D570B;
        Fri, 26 Aug 2022 01:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661503048; x=1693039048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v4zsensQQvholXim790vjmpC9/l/eE/p7Tv+g5+KkXg=;
  b=WNwwA196fP1+tSlJ/W+Nl1XjeLs1dxq2S+PRFdKXo+bWzlYxQPeIwLBr
   XUh9ynFy8VXHUWZFxfHqnh4Ke8pZQngt30c+z+LFT00Gau/FBUnas6/FG
   DTJDRmHaS5GKi6Oz5G9MQYcb8UCWYNe/pw/9rz8ZLA5WbhZr4kmSdi06B
   JuBvq4+rNTc8LQBoeQVhXLk+nlhS3RY+7luMI0lkMNDC4souFJEUfJY1h
   r3dChjvZwMCBaFpoKT8TugSKgO1tWpfgE2Y0NFGm3LG4R107EalWTCtMX
   M5uOxV6t2iNNuYW2VNL7qAEXpdPzea2bL6w1Ko+iMp5JNuCJQ80COoATE
   A==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="188164712"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2022 01:37:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 26 Aug 2022 01:37:27 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Fri, 26 Aug 2022 01:37:25 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux@armlinux.org.uk>,
        <arnd@arndb.de>
CC:     <cristian.birsan@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/9] ARM: dts: at91: sama5d27_wlsom1: don't keep ldo2 enabled all the time
Date:   Fri, 26 Aug 2022 11:39:25 +0300
Message-ID: <20220826083927.3107272-8-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220826083927.3107272-1-claudiu.beznea@microchip.com>
References: <20220826083927.3107272-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ldo2 is not used by any consumer on sama5d27_wlsom1 board, thus
don't keep it enabled all the time.

Fixes: 5d4c3cfb63fe ("ARM: dts: at91: sama5d27_wlsom1: add SAMA5D27 wlsom1 and wlsom1-ek")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
index 342fcfd974d7..83bcf9fe0152 100644
--- a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
+++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
@@ -177,7 +177,6 @@ LDO2 {
 				regulator-name = "LDO2";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
 
 				regulator-state-standby {
 					regulator-on-in-suspend;
-- 
2.34.1

