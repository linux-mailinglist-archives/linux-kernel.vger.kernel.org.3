Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B970B580F63
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbiGZIrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238527AbiGZIrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:47:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DC930543;
        Tue, 26 Jul 2022 01:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658825229; x=1690361229;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9U1mkdUyKbzCBO7q90cuU9y68G122KuYrTFj1QB3h2g=;
  b=Mif2jgEO+CBjnj1OI9umnP/u8/jjjzhQboX6dA6HbbQQpwhUGRfwiXFf
   e06SfaC8Pmo4KO3c3/RfQOTcvjdnSOC4zAE3IaiMZS30+Suiz1CiIHvx0
   yJHLuKcpXcwC1JLYBiw1euixA3pdZaToqR3W+H4Grh+DRtQ5y2b3zbwET
   80r2wQCmFUu4KnRJ7W8R77/gMWqVa/HFuHVjvdnfz0I0SDyddjaNWhOk+
   p8gSuSbCiC8FMRN7EgNqsEORVL3SXgR2aEe8Z1k8D/zTWA9VGZqDwePUx
   x0jKhFhgLFTdpZa1wGSPMpHhPtRjk+LRnl9ae69ULvJF+ZCBB6ieaFjgC
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="173643989"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jul 2022 01:47:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 26 Jul 2022 01:47:08 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 26 Jul 2022 01:47:05 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <arnd@arndb.de>, <olof@lixom.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <soc@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] ARM: dts: lan966x: keep lan966 entries alphabetically sorted
Date:   Tue, 26 Jul 2022 11:49:31 +0300
Message-ID: <20220726084931.1789855-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep LAN966 entries alphabetically sorted.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

This is based on [1] which is at the moment only in at91-dt branch.

Thank you,
Claudiu Beznea

[1] https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git/commit/?h=at91-dt&id=6239b21bbc538e94a4362eb21b0d1479e2a0a1df

 arch/arm/boot/dts/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 6a6166e3a405..f12c5c1b1c93 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -770,9 +770,9 @@ dtb-$(CONFIG_SOC_IMX7ULP) += \
 dtb-$(CONFIG_SOC_IMXRT) += \
 	imxrt1050-evk.dtb
 dtb-$(CONFIG_SOC_LAN966) += \
-	lan966x-pcb8291.dtb \
 	lan966x-kontron-kswitch-d10-mmt-6g-2gs.dtb \
 	lan966x-kontron-kswitch-d10-mmt-8g.dtb \
+	lan966x-pcb8291.dtb \
 	lan966x-pcb8309.dtb
 dtb-$(CONFIG_SOC_LS1021A) += \
 	ls1021a-iot.dtb \
-- 
2.34.1

