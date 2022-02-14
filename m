Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767964B5270
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbiBNN5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:57:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354666AbiBNN5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:57:22 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3197C4A90B;
        Mon, 14 Feb 2022 05:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644847029; x=1676383029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MUwu9Fdq/MRDAHV6UL3afCTA6/6dxR2I/gfuI0/01w0=;
  b=WmQHAx+COFzzHioV+l5+6P6XvNaC9cb1e+KnDS4oQyJC40mWGONOPhkn
   4ut2Np2fRbmr/UIFS1uLbX6unAn8gbebD7quu+AxXdqvnXSQFmA4G3l/r
   9JqeJlFAB2RM/NEGIgDvbNeXVNyfALBWQOgo+uz41Fwr1HZWRJY14Sq9O
   4+P3yUwV1x1sA7RYN1wrj8zAquvt3SZIPXrL0TcsB7aJ1QXZNCGvZiApc
   l5gxAaQt7BLtJ8Ch2YzgJ5r0LL1sV/blTTpj7uvzD72NyXifXYgCnFKUZ
   LCpc8nURzSV0EmrrndMsuIY/ou9GEXnWhGjvcH2p4pahZ9GrxJk3v3NzS
   Q==;
IronPort-SDR: kdqWLspQOOwf9G7rdt6GXhstA0tSrtetAQSQuUrB+kVWOTXjZ1u4sreZnGJiur6ujtgNfNlRWO
 ylnJnPTm8+Rj8P/JZ+VrZlCPwryivA9NBVMi17O/ZDaXZCssECByaiB/KhUb+wydCiekXzb1fh
 oR6zXRx1+NdZrvDMfCqXTb6g8s+ApLr8e5PloqnFMvlC7fKHXZLKqRm6vC1EpKqgHH7rJWSjPP
 wLmS46L8/NtCIzQHPeFEIp/BnLi/Gs4OzsUzuTuPnGA7b4gDgmnrtPVYNb/hKxFsqLwu23eTXt
 kpN2CztfMqj/piID4UfB5nY4
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="152982610"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2022 06:57:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 14 Feb 2022 06:57:07 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 14 Feb 2022 06:57:02 -0700
From:   <conor.dooley@microchip.com>
To:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <robh+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <lee.jones@linaro.org>,
        <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <geert@linux-m68k.org>,
        <krzysztof.kozlowski@canonical.com>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
CC:     <lewis.hanly@microchip.com>, <conor.dooley@microchip.com>,
        <daire.mcnamara@microchip.com>, <ivan.griffin@microchip.com>,
        <atishp@rivosinc.com>, Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v7 11/11] MAINTAINERS: update riscv/microchip entry
Date:   Mon, 14 Feb 2022 13:58:41 +0000
Message-ID: <20220214135840.168236-12-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220214135840.168236-1-conor.dooley@microchip.com>
References: <20220214135840.168236-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Update the RISC-V/Microchip entry by adding the microchip dts
directory and myself as maintainer

Reviewed-by: Lewis Hanly <lewis.hanly@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c914384..779a550dc95b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16575,8 +16575,10 @@ K:	riscv
 
 RISC-V/MICROCHIP POLARFIRE SOC SUPPORT
 M:	Lewis Hanly <lewis.hanly@microchip.com>
+M:	Conor Dooley <conor.dooley@microchip.com>
 L:	linux-riscv@lists.infradead.org
 S:	Supported
+F:	arch/riscv/boot/dts/microchip/
 F:	drivers/mailbox/mailbox-mpfs.c
 F:	drivers/soc/microchip/
 F:	include/soc/microchip/mpfs.h
-- 
2.35.1

