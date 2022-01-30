Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2764A36C5
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 15:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347225AbiA3OkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 09:40:02 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:47382 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239952AbiA3Oj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 09:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643553600; x=1675089600;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uEEQeO/Eh89v4YMamB0V1pn92PXWSNezWO1prkfXii8=;
  b=o7hEYwMruKYekqQx1YgaRIfDnniLAZ94O8xEAssVWo/i9GzAL9X5GhAO
   1luBbZ/mUDu/uRj4/Uv1qxpa7MJ+ONwMfQJL1x5mzLM7pu7bJrB4Dn+v6
   OCpNmet4WUkSF11vA3nFksPrSIwXYsPpEWOVY5gTAc6Wn8s2TD8o0V6rP
   iLxJjG8AQVch2uDnjAUTpXHPotn4fiucteWxFVfJ1kSaggjhTBUf3/YK/
   4t9QHq0nRVuHAzct7+2ah/1ucJ6ASDExg+3nuTivOtPx7gj1Hz4bXYTTj
   aabtH4rvm2lIMzvBBLByJHYVBh4v/talNE88vVm/z0q5wByftlfVQEf+g
   g==;
IronPort-SDR: vpZEmE08hS48EWNgafJx5PuqniuKSfZr9ksx1uA4mGmGn7G84tNrVHPWN2z/hHAodsSkLdL6lP
 p74UUwG7eB9B5IQs01QaOskF6MQH8o8lUmMxsbryifVBH57bo+l/K76xarhbx3ffl070pdBzhn
 uz6Xcn/SyDA3lF6QIeXHCNdsBo7Ws9eLYnYj80QXNVFjT0JWQBDvI2AfYB6+097RiVdWsAshCk
 kCVc22IaAGoFWWsjfocifGfM949aqLTFAw9jtIYLPxkREr12+HbNJ6I7SwNgvGnAIi1GO9Jfym
 zWA8Bp7ui26kxp9lUGQLmqtJ
X-IronPort-AV: E=Sophos;i="5.88,328,1635231600"; 
   d="scan'208";a="147058376"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jan 2022 07:39:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 30 Jan 2022 07:39:58 -0700
Received: from ness.home (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Sun, 30 Jan 2022 07:39:57 -0700
From:   <nicolas.ferre@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 1/2] MAINTAINERS: replace a Microchip AT91 maintainer
Date:   Sun, 30 Jan 2022 15:39:35 +0100
Message-ID: <23819d8baa635815d0893955197561fe4f044d5e.1643553501.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

As Ludovic is more focusing on other aspects of the Microchip
Linux-based development, replace him with Claudiu.
Entry is added to the CREDITS file.

Thanks Ludovic for these great contributions in the kernel space!

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 CREDITS     | 6 ++++++
 MAINTAINERS | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index b97256d5bc24..7e85a53b6a88 100644
--- a/CREDITS
+++ b/CREDITS
@@ -895,6 +895,12 @@ S: 3000 FORE Drive
 S: Warrendale, Pennsylvania 15086
 S: USA
 
+N: Ludovic Desroches
+E: ludovic.desroches@microchip.com
+D: Maintainer for ARM/Microchip (AT91) SoC support
+D: Author of ADC, pinctrl, XDMA and SDHCI drivers for this platform
+S: France
+
 N: Martin Devera
 E: devik@cdi.cz
 W: http://luxik.cdi.cz/~devik/qos/
diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c914384..674d13708324 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2250,7 +2250,7 @@ F:	drivers/phy/mediatek/
 ARM/Microchip (AT91) SoC support
 M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
-M:	Ludovic Desroches <ludovic.desroches@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@microchip.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 W:	http://www.linux4sam.org
-- 
2.32.0

