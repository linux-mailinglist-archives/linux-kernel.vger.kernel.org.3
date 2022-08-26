Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF245A232B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245110AbiHZIiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245610AbiHZIhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:37:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07866D571B;
        Fri, 26 Aug 2022 01:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661503052; x=1693039052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NhTYybz8cFKXvPDczCL3sDgZh+OWnjOmY+XsBCIQazs=;
  b=dz3bGmMHvCzh1UO4U+PzOThni5f13jYBdJ6lKoFJXvldCk91T3vhjrw+
   cqZ3jlx5/LC3NXqU7F9ui2m3sbnLjoTf4qLEyfiYnEGR5S4er3HTyw005
   SL+7gGU+esV2TbVOndsPcPOvpXXU1XHniBoUx8YoAlSlAHmklFywSBoyZ
   UDoYn73TWLSkk3fzHo3Gd74k83tLyIsEPpPa453gwe4h4tDCtJaTBuXFk
   h7tBN8t9JBuSZjWhaChZzDRGw0VZWnDEOMd7cgkBrZeDWWqckK416vWq2
   GQALTCfS4aLl5uFQUpzhzYng7blFm5ryWSP26pN9J6zsvcqo4tx4X7ld/
   w==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="188164732"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2022 01:37:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 26 Aug 2022 01:37:30 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Fri, 26 Aug 2022 01:37:27 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux@armlinux.org.uk>,
        <arnd@arndb.de>
CC:     <cristian.birsan@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 8/9] ARM: dts: at91: sama5d2_icp: don't keep vdd_other enabled all the time
Date:   Fri, 26 Aug 2022 11:39:26 +0300
Message-ID: <20220826083927.3107272-9-claudiu.beznea@microchip.com>
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

VDD_OTHER is not connected to any on board consumer thus it is not
needed to keep it enabled all the time.

Fixes: 68a95ef72cef ("ARM: dts: at91: sama5d2-icp: add SAMA5D2-ICP")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_icp.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_icp.dts b/arch/arm/boot/dts/at91-sama5d2_icp.dts
index 6296e3ffd303..dd1dec9d4e07 100644
--- a/arch/arm/boot/dts/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_icp.dts
@@ -257,7 +257,6 @@ VDD_OTHER {
 					regulator-max-microvolt = <1850000>;
 					regulator-initial-mode = <2>;
 					regulator-allowed-modes = <2>, <4>;
-					regulator-always-on;
 
 					regulator-state-standby {
 						regulator-on-in-suspend;
-- 
2.34.1

