Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7B858ABCE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 15:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240611AbiHENtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 09:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiHENto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 09:49:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A6B4D151;
        Fri,  5 Aug 2022 06:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659707374; x=1691243374;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t5KjsovnLft0eC6PhANCf5G4JupnQ193gjR6obVUIxY=;
  b=ip9nnkAgIzQoesVAzwLEBQUIdyl2yJhoZ9iRMFOkMzaYENGZeAHiF2x+
   IAdPUjqaaZd4Vh+CLsPdNxtbiRmVbM5DpTXfNrROL1U9y8Bv80sDZJd/f
   mHCdCxoNJ7HOi9c98F8tPv8kcRHPJhcSDLk82Uy0YpoGDfFtUt32e76dj
   9SRWU0iUQUp1PKOrLf3MMjPAWh/L44LGLBtzuc6RCMa+1VCONofszhzFQ
   NQwQASPguHFH775EW1+0heJ2y0zi2b8cnLX6t4pHZoOJd2WULh+0SZr1N
   2tN/2gIwH6tx3IwG7Mow5JF1K5JSPhzpEYH86Bu/E75a/5gm7+2pcLuDU
   g==;
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="107754683"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Aug 2022 06:49:32 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 5 Aug 2022 06:49:25 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 06:49:22 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        "Wolfram Sang" <wsa@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Jassi Brar" <jassisinghbrar@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH] MAINTAINERS: add PolarFire SoC dt bindings
Date:   Fri, 5 Aug 2022 14:49:09 +0100
Message-ID: <20220805134908.749935-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far when I added bindings for the platform I never added them to
our MAINTAINERS entry. No time like the present to improve the coverage.

Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
I have another maintainers change queued, I'll send this via soc along
with it unless there are any objections.

CC: Mark Brown <broonie@kernel.org>
CC: Wolfram Sang <wsa@kernel.org>
CC: Thierry Reding <thierry.reding@gmail.com>
CC: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
CC: Jassi Brar <jassisinghbrar@gmail.com>
CC: Linus Walleij <linus.walleij@linaro.org>
CC: Bartosz Golaszewski <brgl@bgdev.pl>
CC: Wolfgang Grandegger <wg@grandegger.com>
CC: Marc Kleine-Budde <mkl@pengutronix.de>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Olof Johansson <olof@lixom.net>
CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@kernel.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf7906eaa5ca..295941b6a413 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17525,6 +17525,15 @@ M:	Conor Dooley <conor.dooley@microchip.com>
 M:	Daire McNamara <daire.mcnamara@microchip.com>
 L:	linux-riscv@lists.infradead.org
 S:	Supported
+F:	Documentation/devicetree/bindings/clock/microchip,mpfs.yaml
+F:	Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
+F:	Documentation/devicetree/bindings/i2c/microchip,corei2c.yaml
+F:	Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.yaml
+F:	Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
+F:	Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml
+F:	Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml
+F:	Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
+F:	Documentation/devicetree/bindings/usb/microchip,mpfs-musb.yaml
 F:	arch/riscv/boot/dts/microchip/
 F:	drivers/char/hw_random/mpfs-rng.c
 F:	drivers/clk/microchip/clk-mpfs.c

base-commit: 899926f2ccb4453c51943f6738a71b2c5ad98b71
-- 
2.36.1

