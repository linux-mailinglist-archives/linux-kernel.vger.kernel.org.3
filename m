Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81C24A36C6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 15:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354934AbiA3OkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 09:40:04 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:29367 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347222AbiA3OkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 09:40:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643553601; x=1675089601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8MtRu85VEGi0pRjIze7j3jKTfRRFLZYKaHo61yeGeCM=;
  b=E30CZB8mTptUkssXrqB5gqHunnMNK4ylAqMpts/0+0EE7Um59Bq4nUF+
   QjsOzqRO6xOslmA0YRVbYQE99T3XW40//qCd3A+08SDMxOjm49UlKRRyO
   LV+6WcPYFCpxRv3RXCjnu/HFmaSCa6YVhLEbDlEhhzq0shwNdNI/5R2Ut
   MgBtQ1bm1kBxpPwnQEyTImH7pL1lxAG2xWWY7pFGJvhCLujQ7zutM1WOU
   Kq5wd6e7zW4Z0ZrttMUx7AJuq5l+crT5ncUEeLnjTP/mbeJqTZfz8x0eQ
   wEHUOy/EyjoPPoZ6kUXuKNxJReLLcQXnruVuOKmWv74nsGUS3rDzrZDpL
   w==;
IronPort-SDR: RYGuPw3yMkHpFKKcPVpMz23VRh+2wST1aM34Oa+uRLeP9yLL9oKBXnOR4G+vHmT4+ARnzLX562
 28eq3wAPEeEDKPGMn8pp0PBmvyK5w1tbtcaNB7/dxWHc7gpGml9PMO5xUblXoxQijNqhADgol/
 RowaKdVCYQUe0AMcLDHDFmSQadNJHLWEMJ/xoizvSZq8YBF0b6fDr1ApmIKQdjcZ4i5LSSf4pc
 VnxiyqcZlv3s9FXyZ51WC0x2tIZjRrLVMnFGYzGy8OdC0++6hduVW1P7DuoIPfm2LnczVQP7GA
 k/1cnSzh7eDKu1kANjCTkUQr
X-IronPort-AV: E=Sophos;i="5.88,328,1635231600"; 
   d="scan'208";a="160486000"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jan 2022 07:40:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 30 Jan 2022 07:40:00 -0700
Received: from ness.home (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Sun, 30 Jan 2022 07:39:58 -0700
From:   <nicolas.ferre@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 2/2] dt-bindings: ARM: at91: update maintainers entry
Date:   Sun, 30 Jan 2022 15:39:36 +0100
Message-ID: <5bf9873eeee3cd49c52a8952a7cd4cb60b61d50a.1643553501.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <23819d8baa635815d0893955197561fe4f044d5e.1643553501.git.nicolas.ferre@microchip.com>
References: <23819d8baa635815d0893955197561fe4f044d5e.1643553501.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Align the binding documentation with the newly updated MAINTAINERS
entry.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index c612e1f48dba..ff91df04f9f4 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -8,7 +8,8 @@ title: Atmel AT91 device tree bindings.
 
 maintainers:
   - Alexandre Belloni <alexandre.belloni@bootlin.com>
-  - Ludovic Desroches <ludovic.desroches@microchip.com>
+  - Claudiu Beznea <claudiu.beznea@microchip.com>
+  - Nicolas Ferre <nicolas.ferre@microchip.com>
 
 description: |
   Boards with a SoC of the Atmel AT91 or SMART family shall have the following
-- 
2.32.0

