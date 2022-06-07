Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB6F53F895
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238508AbiFGItJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238506AbiFGIsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:48:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B654E38A;
        Tue,  7 Jun 2022 01:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654591659; x=1686127659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Py8zRXdzOiFvbMocJpc5Z5DwAynLOWkd9TOuzKCbQu8=;
  b=CMI+JDgxVzErMKzxfJNOWN/nFuY8Rr6ExanJNKFKJWhDea7c00mMOjE5
   Uy4bFct3n4OlkXTx9H6M3VrCAdBMQkHl6kFpi9yYuDXUhJoMfAaFeLyyL
   cv4gv5cfh2otJN6e2Xy0m84feVNdU41giTmf2Bc9d9NZLRtmnwKTzE2yd
   0Rybz/VzuTd0B7TI2q58FhjoxNRD5u0E2YyAQG2EGKlWN92H0omxZYvHO
   feQg6F50LdAp6BaGOqIngh7QiJuuK+yF9XQB6OIFdWZ1MZxPpXtPbkVoA
   gVaMG8+QbXW8+EsTItZNm3NDCsu1gsGnrdNJ9wl9G3qZJuhuRcWrbdJlu
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="162191798"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jun 2022 01:47:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 7 Jun 2022 01:47:33 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 7 Jun 2022 01:47:31 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Lee Jones" <lee.jones@linaro.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH 2/2] MAINTAINERS: add pwm to PolarFire SoC entry
Date:   Tue, 7 Jun 2022 09:45:52 +0100
Message-ID: <20220607084551.2735922-3-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607084551.2735922-1-conor.dooley@microchip.com>
References: <20220607084551.2735922-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

