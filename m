Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662544A36EB
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 15:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355190AbiA3OuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 09:50:25 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:9743 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347259AbiA3OuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 09:50:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643554222; x=1675090222;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FJIF3Ym7W2GedFgY8vVihKuSIe0hGh7F+YW1ik4rU9M=;
  b=mzT+FV/bFRsEcTWmRd6N3DU3+HCqelvhRNEPWJCnEIGoOt2K8bnRP3MP
   rNAAmVAGby4J3dXO3YTzMgPjGgxuNQMnemXTZR64fxJHNoI8g39H/BeN1
   no5E4toAaIqqcU9O1TIN7E7LUryaNGHUe0JGQ8lohYh1Gu2zf+noQOlbJ
   B30vN6WZCvGbnpvaVisz+UA2kljGial82/SnHKZoc+8nOJi3Y0OyLMhDm
   lo/NXX2DjgWtFQglEk+wZ330qAk/RsC6cwiIM0eXsa5Zas3bmuG2L23ZK
   mny03SK1ezkWii2HkgMASgPAAvpt+oLoo7S9+u4hLz87UYuv+gf17kVn3
   A==;
IronPort-SDR: 7bHwPrJtn3Cw+MpFB4tKb5ygCsHG0Yhs5iZOFISiS39dncdf9jmqdolJ+QF0/Cn8Hvp8FmOg/S
 fniARjOU6g2leBOeoXZ7dU5EcMUEVwgORXO+j7WMefheYnxFlAFMXiIrxkI9o9510l953bxDJP
 NEauPgQ9OCCzdU7ntN/PM3rvWuc6b/Jp43ML6py4FaPgbg/75A+4oWwkYZk7TUPLwDGAyXBBeP
 vcgLIgI+COovX/8dHF4iKJiYMe9ucEk/q36q0IB20opoIIiANxDGCw1m+L+A5YEkJ7+9kNrvrn
 esP+YSZbK++RKmeU8fccHskw
X-IronPort-AV: E=Sophos;i="5.88,328,1635231600"; 
   d="scan'208";a="147058778"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jan 2022 07:50:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 30 Jan 2022 07:50:20 -0700
Received: from ness.home (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Sun, 30 Jan 2022 07:50:18 -0700
From:   <nicolas.ferre@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 1/1] dt-bindings: iio: adc: at91-sama5d2: update maintainers entry
Date:   Sun, 30 Jan 2022 15:50:08 +0100
Message-ID: <6acdb66592baf395a77a431c0cb9a37b0f178097.1643554065.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Update the maintainers entry to match the changes made back in
mid-2020 with 853fa48717c2 ("MAINTAINERS: adc: at91-sama5d2_adc:
remove myself as co-maintainer").

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
Hi,

Patch for new MAINTAINERS entry is here:
https://lore.kernel.org/linux-arm-kernel/23819d8baa635815d0893955197561fe4f044d5e.1643553501.git.nicolas.ferre@microchip.com/

Regards,
  Nicolas

 Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml b/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
index efed361215b4..9a2292e7defc 100644
--- a/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
@@ -7,7 +7,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: AT91 SAMA5D2 Analog to Digital Converter (ADC)
 
 maintainers:
-  - Ludovic Desroches <ludovic.desroches@atmel.com>
   - Eugen Hristev <eugen.hristev@microchip.com>
 
 properties:
-- 
2.32.0

