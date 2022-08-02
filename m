Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72AF587774
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbiHBHGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbiHBHGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:06:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565292AE14;
        Tue,  2 Aug 2022 00:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659423973; x=1690959973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u16gV5XfrDHEjFfKUBd6PibgcByRZEIzej3svkcjlKU=;
  b=0bI+uVG+hwA7LrUnHP6v0uFIXc4T062PpMDj/A8KEkRRjKLaD5yDT7eI
   oUwFEhCZ7u4WLNrhn0yY8ZvYyTFUEKZA1t6VpdGpgOXBflruR0cJFbJA5
   FI7htEJ+WLakVzoISrtjhnI/DieXx2bitXhzr8Me92lMlrbJ6Rs9DGbin
   b5kWFeYc/VdcdYPD+LOWtvPjjyQTnNYfsgeYczX2Ia8bh+qFjkPlPJoKN
   UoE3yTINJInezGCg9hpi+CgKOTlHKLMPWg14p4lGuUO8wHhkE0Mh4ivd1
   oZSNESrTj5Mv7xDM6aVbKEWkNV8dPleZbsfJR1m2dhO5appLV3CBZoora
   A==;
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="174693310"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Aug 2022 00:06:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 2 Aug 2022 00:06:10 -0700
Received: from microchip-OptiPlex-5040.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Tue, 2 Aug 2022 00:06:07 -0700
From:   Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor.dooley@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
Subject: [PATCH v2 3/3] MAINTAINERS: add qspi to Polarfire SoC entry
Date:   Tue, 2 Aug 2022 12:35:18 +0530
Message-ID: <20220802070518.855951-4-nagasuresh.relli@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220802070518.855951-1-nagasuresh.relli@microchip.com>
References: <20220802070518.855951-1-nagasuresh.relli@microchip.com>
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

Add the qspi driver to the existing Polarfire SoC entry.

Signed-off-by: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 295ca16a415b..0329dca23fe2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17146,6 +17146,7 @@ S:	Supported
 F:	arch/riscv/boot/dts/microchip/
 F:	drivers/mailbox/mailbox-mpfs.c
 F:	drivers/soc/microchip/
+F:	drivers/spi/spi-microchip-core-qspi.c
 F:	drivers/spi/spi-microchip-core.c
 F:	include/soc/microchip/mpfs.h
 
-- 
2.25.1

