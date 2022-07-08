Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9918456BC43
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 17:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbiGHOjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbiGHOjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:39:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E0427CEC;
        Fri,  8 Jul 2022 07:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657291175; x=1688827175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fnl5CGvXmbwoIcy91psfgiwxnD3o6LZLHepJqwb/OE0=;
  b=hamohxFVG8Q5km82YgwjCPMOexmesrWusbDnawCTRcDXFZ/4ndJ0XjN+
   tAZltiVvkXbsgtkhqy5kXcCBt3gR9UI1WJ2w2cpDzP8n74PCcSb1xq54b
   BdNy7ikCmUA/bIYCChvgHX/RSXPLRtlRhgZmE0OBpYD2EcV3Z+9diU1r0
   UJnbiiFRImkelU56fA0A9NpNwIi4cuFHySoA0/TSxQ2HSJfBA0M6/+Tvc
   vGeayOznobifO8OEvvFQLAB+NlK99Xez0LJkegbto1h24BpgsXdFAcJKV
   ONjx3fA3iq62C2ne9bU1GcjL/5uWblYFAMD9pgiuw4jIge4DZscsBCjoh
   w==;
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="167013024"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jul 2022 07:39:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 8 Jul 2022 07:39:33 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 8 Jul 2022 07:39:31 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Lee Jones" <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 4/4] MAINTAINERS: add pwm to PolarFire SoC entry
Date:   Fri, 8 Jul 2022 15:39:23 +0100
Message-ID: <20220708143923.1129928-5-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220708143923.1129928-1-conor.dooley@microchip.com>
References: <20220708143923.1129928-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index d64d79eb36a2..f023ae8442ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17429,6 +17429,7 @@ L:	linux-riscv@lists.infradead.org
 S:	Supported
 F:	arch/riscv/boot/dts/microchip/
 F:	drivers/mailbox/mailbox-mpfs.c
+F:	drivers/pwm/pwm-microchip-core.c
 F:	drivers/rtc/rtc-mpfs.c
 F:	drivers/soc/microchip/
 F:	drivers/spi/spi-microchip-core.c
-- 
2.36.1

