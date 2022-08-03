Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49C5588A25
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237761AbiHCKIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237063AbiHCKIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:08:31 -0400
X-Greylist: delayed 2430 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 03 Aug 2022 03:08:29 PDT
Received: from cassarossa.samfundet.no (cassarossa.samfundet.no [IPv6:2001:67c:29f4::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B77E12AFF
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 03:08:29 -0700 (PDT)
Received: from egtvedt by cassarossa.samfundet.no with local (Exim 4.94.2)
        (envelope-from <egtvedt@samfundet.no>)
        id 1oJAfS-00DURx-CF; Wed, 03 Aug 2022 11:27:54 +0200
Date:   Wed, 3 Aug 2022 11:27:54 +0200
From:   Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
To:     torvalds@linux-foundation.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>, hskinnemoen@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] AVR32 change for 6.0 - outstanding cleanups
Message-ID: <Yuo/mq0VrqTH9BS+@samfundet.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull

git://git.kernel.org/pub/scm/linux/kernel/git/egtvedt/linux-avr32.git for-linus

to receive the following AVR32 related changes for 6.0 (no-op's)

Hans-Christian Noren Egtvedt (8):
      dma:dw: remove reference to AVR32 architecture in core.c
      mfd: remove reference to AVR32 architecture in atmel-smc.c
      misc: update maintainer email address and description for atmel-ssc
      net: remove cdns,at32ap7000-macb device tree entry
      sound:spi: remove reference to AVR32 in Atmel AT73C213 DAC driver
      usb:udc: remove reference to AVR32 architecture in Atmel USBA Kconfig
      video: remove support for non-existing atmel,at32ap-lcdc in atmel_lcdfb
      video:backlight: remove reference to AVR32 architecture in ltv350qv

Mostly changes to documentation and comments.

 Documentation/devicetree/bindings/display/atmel,lcdc.txt | 1 -
 Documentation/devicetree/bindings/net/cdns,macb.yaml     | 3 +--
 drivers/dma/dw/core.c                                    | 3 ---
 drivers/mfd/atmel-smc.c                                  | 4 ++--
 drivers/misc/atmel-ssc.c                                 | 4 ++--
 drivers/net/ethernet/cadence/macb_main.c                 | 1 -
 drivers/usb/gadget/udc/Kconfig                           | 4 ++--
 drivers/video/backlight/ltv350qv.c                       | 3 +--
 sound/spi/Kconfig                                        | 2 +-
 9 files changed, 9 insertions(+), 16 deletions(-)

-- 
Best regards,
Hans-Christian Noren Egtvedt
