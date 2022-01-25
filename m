Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB2F49B4EB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576430AbiAYNVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:21:48 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:24122 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1575981AbiAYNSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:18:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643116714; x=1674652714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vvI7xxALN8Ca1rL4bFGP5vkD357sP5EjMT1bx/alGhk=;
  b=lr5754exLlxygaLWBwfcMs3oqiNx33q6INHnyoQrSL38ZGk83IssPlp8
   y99zSLTnjZ2I7RU3maHSW0AJbasN0/cRqL6TmBI2022HRbCFdLrcSLt1e
   Ms5lg+ChkD7U0/pQt4x5OcTQxiWZNBvW5hl2+QjZAFcV1ZyktgdQJuJrn
   opckjpX1rH5cotPRn2ZPO3Q6pavgZwTvzTkf7G8XIwAC07BY6AK9PiyYq
   QCDyTroD+LgMwtBMducawRAxWSATv3BOFJ+vX7UYZAcZQYYzeLYW0cu9J
   fsLcMk6KcVehDH4Eqv1rnMQk3KiD4vDinTy14o2wmhHGv/0Ajmx9Gc4BK
   w==;
IronPort-SDR: HBC1ECpJBB1aDF8AZul142f1LxsTDJueQ7lEvq/YRoLXqZ8R0oqYkhjFQy08LldkYgzrt/6SOv
 sjil7+OU+6PAzyYeIFOT3T2/LUho1HwHuDMQeBhZQPR8ZfN0ylzSUAbDN48HuU+JRuh9JAlZmn
 tg2Fe5nfHmVJt2SEQ9PBy74TA5b0P/lNDEi0uGzp5cCdqu0WmolQ834vgU+5nWX3nSgMlXmqaS
 PpACcLNGnIsrXDQJq+gLEFvjhe2/oGstytZKZ2ugzcYdvHRLXI2ZU0EIAaOwhAyyoDElkU07kS
 DdadiCCRncldV3JQdX16i8we
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="83600692"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jan 2022 06:18:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 25 Jan 2022 06:18:23 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 25 Jan 2022 06:18:22 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH 1/2] dt-bindings: pinctrl: ocelot: Add ServalT SoC support
Date:   Tue, 25 Jan 2022 14:18:57 +0100
Message-ID: <20220125131858.309237-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220125131858.309237-1-horatiu.vultur@microchip.com>
References: <20220125131858.309237-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the documentation for the Microsemi ServalT pinmuxing and gpio
controller.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt       | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt
index 3bb76487669f..5d84fd299ccf 100644
--- a/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.txt
@@ -4,8 +4,8 @@ Microsemi Ocelot pin controller Device Tree Bindings
 Required properties:
  - compatible		: Should be "mscc,ocelot-pinctrl",
 			  "mscc,jaguar2-pinctrl", "microchip,sparx5-pinctrl",
-			  "mscc,luton-pinctrl", "mscc,serval-pinctrl" or
-			  "microchip,lan966x-pinctrl"
+			  "mscc,luton-pinctrl", "mscc,serval-pinctrl",
+			  "microchip,lan966x-pinctrl" or "mscc,servalt-pinctrl"
  - reg			: Address and length of the register set for the device
  - gpio-controller	: Indicates this device is a GPIO controller
  - #gpio-cells		: Must be 2.
-- 
2.33.0

