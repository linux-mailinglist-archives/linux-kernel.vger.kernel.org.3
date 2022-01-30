Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152DC4A36E6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 15:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355176AbiA3Orb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 09:47:31 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:10913 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355139AbiA3Or1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 09:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643554047; x=1675090047;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UhHNiXx69gpQDiVL4ThrTpVjnBHgjFuy06EgsxtjySA=;
  b=l0ZbBdgnOHU92wQza1c19YVhq7EnbqPGKNs7IvWkcbtyGATAvF/YS+06
   Awrh7jk6euyr69k9Mn9qlwKleObBeLddcdHhevn3Eo3aYglGHkMH/tz8X
   7ewcN2FDdYsI+n/CdDFq1iGXvvxVH5sLydkzUSlFPmMoObY99g8q4Qt29
   eu1/X/G9viERd42I2ckSzDwEvvA4LZvSmJVCwAfDRwWv5YSIeHk2d9lJr
   5cEKbKgqN+mU6KoDYL6q77QSdmiqJpP+Y3t54Iitco6cbCyCRHsYRkL+Z
   jvk/p7n/FYkta52nzxcRrVjitwFtnYBin7ePFA+TjWzcfo1prCSAImXpN
   g==;
IronPort-SDR: YhRO6tvz9JO1zCj2s1DRMZIEAsNKisA3cAGuDZFgoLrAvrLO/TVjUySzRPEOeYB2ZwVBTsSpsh
 3nH6Gr9Ock3wLICS4riSk4OaveNgSu4WVPWSHebuw81GuQQJ9z9IIU28jv01Ks/PHxksKLCMCw
 g29rG9qsrrkXmJ18OyrhCnN8Rh9JJqL0tFLgN7ZZkj1n/2g5UfldaxwbqBV9WyLcqOoUk9Mp+s
 U+Hl/48aBfwDb/5nV/67XpnMx3sLBMJKLjST8iTXDX+cMxm1xa0vPBmXfjIlCkslNJ3V7Yio99
 hDvHYKYmaUNWCsqxPcbSiDkN
X-IronPort-AV: E=Sophos;i="5.88,328,1635231600"; 
   d="scan'208";a="147058656"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jan 2022 07:47:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 30 Jan 2022 07:47:26 -0700
Received: from ness.home (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Sun, 30 Jan 2022 07:47:24 -0700
From:   <nicolas.ferre@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH] dt-bindings: rng: atmel,at91-trng: update maintainers entry
Date:   Sun, 30 Jan 2022 15:47:08 +0100
Message-ID: <d84760e0b81c338e01f7856e1ce3c5b600b08f23.1643553619.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Update according to new MAINTAINERS entry.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
Hi,

Patch for new MAINTAINERS entry is here:
https://lore.kernel.org/linux-arm-kernel/23819d8baa635815d0893955197561fe4f044d5e.1643553501.git.nicolas.ferre@microchip.com/

Regards,
  Nicolas

 Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
index c1527637eb74..3ce45456d867 100644
--- a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
+++ b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
@@ -9,7 +9,7 @@ title: Atmel AT91 True Random Number Generator
 maintainers:
   - Nicolas Ferre <nicolas.ferre@microchip.com>
   - Alexandre Belloni <alexandre.belloni@bootlin.com>
-  - Ludovic Desroches <ludovic.desroches@microchip.com>
+  - Claudiu Beznea <claudiu.beznea@microchip.com>
 
 properties:
   compatible:
-- 
2.32.0

