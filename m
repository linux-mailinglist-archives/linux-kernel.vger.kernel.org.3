Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F844CD699
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239888AbiCDOnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbiCDOnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:43:09 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60651BD043;
        Fri,  4 Mar 2022 06:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646404941; x=1677940941;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qHEsIP7QjkyHZxZrAhKQ/Mqa3BKqYR3R5+C9b+jpTZs=;
  b=T5FCxBCDwtYo0DEdjjZ+UuMItDyR723+koqCvbsGFqam8h4nj1xr71OC
   EPhvSj01/gjcy5iJrOHKzFu2tSPvXD5ESWHmPoSzMDA1KiCeL9o+zwKB1
   N8GsWlVpLpjdIb6BDzuXUOv06MLgvZQ6PbBp/jrW/n0rg8RSZVoFKUMYI
   znalxvbSC8wiqZLaA81m/MWV/DL0awB0EMQYCvcbrHyGEzmJBpp2+Z6o0
   vcgp0pbcVKUGU90FqLG4zGyxzQLkTYS7Sb7DfKzQuzcJlNBYIRfAzIGrU
   xRpiRIOBv9Xu+gt355WXOjnj/i12LLyMDRQf+wzZg0Jd7AafgjkR/d9DO
   A==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="164547280"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 07:42:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 07:42:20 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 4 Mar 2022 07:42:18 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <colin.foster@in-advantage.com>,
        <andriy.shevchenko@linux.intel.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH v2 0/2] pinctrl: ocelot: Add fixes for ocelot driver
Date:   Fri, 4 Mar 2022 15:44:30 +0100
Message-ID: <20220304144432.3397621-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This contains two fixes for the ocelot pinctrl:
- first fixes the memory resource index for pincfg
- second fixes the interrupt parsing

v1->v2:
- add Reviewed-by tag for patch 1
- use platform_get_irq_optional instead of irq_of_parse_and_map

Horatiu Vultur (2):
  pinctrl: ocelot: Fix the pincfg resource.
  pinctrl: ocelot: Fix interrupt parsing

 drivers/pinctrl/pinctrl-ocelot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.33.0

