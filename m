Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2654E54F6EE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381904AbiFQLqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381619AbiFQLqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:46:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB74E6CF48;
        Fri, 17 Jun 2022 04:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655466392; x=1687002392;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Py8zRXdzOiFvbMocJpc5Z5DwAynLOWkd9TOuzKCbQu8=;
  b=iiLRrKVSqLvKNeebaytrhjb1HNbSlYFgq2RZSxB2vf5aLZyHDUT1tvoJ
   HtPNOOHWHpl5PMmW+ZLNX3fhklItVztSrA/TrTJsCZIillqvAw2zhHcEt
   2lGtf+o0otvJ1f8bs514yP15c8FBji3cGxvwRhvUHgegsSco0B1HBY6WI
   wDDdB6bANW4bOZe3lrUwqHEJx5/FrMLoc5+5nAePVkkrboQ3YKeIXxZQW
   ShKqtpoHn/JPgUtrQi5dtxNhLCVx/oi3Wu+eellkWQpge2MIBIb0gIRzK
   oFQUBgA/O5Q+CBgj5EIHV8oF9Ir/pzFTreAS4j+A8/uizMc4Lpb/ydfFw
   A==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="163847732"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jun 2022 04:46:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Jun 2022 04:46:30 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 17 Jun 2022 04:46:28 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Lee Jones" <lee.jones@linaro.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/2] MAINTAINERS: add pwm to PolarFire SoC entry
Date:   Fri, 17 Jun 2022 12:44:43 +0100
Message-ID: <20220617114442.998357-3-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220617114442.998357-1-conor.dooley@microchip.com>
References: <20220617114442.998357-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the newly introduced pwm driver to the existing PolarFire SoC entry.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f1b4b77daa5f..d0b39fa4f309 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17091,6 +17091,7 @@ L:	linux-riscv@lists.infradead.org
 S:	Supported
 F:	arch/riscv/boot/dts/microchip/
 F:	drivers/mailbox/mailbox-mpfs.c
+F:	drivers/pwm/pwm-microchip-core.c
 F:	drivers/soc/microchip/
 F:	include/soc/microchip/mpfs.h
 
-- 
2.36.1

