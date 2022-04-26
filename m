Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D0850F2AE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344192AbiDZHjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344081AbiDZHif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:38:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2408DB1D1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:35:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1njFjB-00056p-0H; Tue, 26 Apr 2022 09:35:17 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1njFj8-005InS-Eo; Tue, 26 Apr 2022 09:35:13 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1njFj5-004roY-Sb; Tue, 26 Apr 2022 09:35:11 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/4] mainline Protonic PRTT1x boards 
Date:   Tue, 26 Apr 2022 09:35:07 +0200
Message-Id: <20220426073511.1160119-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes v4:
- reorder prtt1X compatible again
- remove spaces in stm32mp151a-prtt1c.dts

changes v3:
- add silabs,wfx compatible
- move spi pin configuration to stm32mp15-pinctrl.dtsi
- move prtt1X compatible in alphabetical order
- add watchdog and thermal nodes

changes v2:
- cleanup mmc nodes
- disabled dma for uart4 (this is console interface and it should work
  as simple as possible)

Oleksij Rempel (4):
  dt-bindings: arm: stm32: Add compatible strings for Protonic T1L
    boards
  dt-bindings: net: silabs,wfx: add prt,prtt1c-wfm200 antenna variant
  ARM: dts: stm32: stm32mp15-pinctrl: add spi1-1 pinmux group
  ARM: dts: stm32: add support for Protonic PRTT1x boards

 .../devicetree/bindings/arm/stm32/stm32.yaml  |   8 +
 .../staging/net/wireless/silabs,wfx.yaml      |   1 +
 arch/arm/boot/dts/Makefile                    |   3 +
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi      |  15 +
 arch/arm/boot/dts/stm32mp151a-prtt1a.dts      |  52 +++
 arch/arm/boot/dts/stm32mp151a-prtt1c.dts      | 304 ++++++++++++++++++
 arch/arm/boot/dts/stm32mp151a-prtt1l.dtsi     | 229 +++++++++++++
 arch/arm/boot/dts/stm32mp151a-prtt1s.dts      |  63 ++++
 8 files changed, 675 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32mp151a-prtt1a.dts
 create mode 100644 arch/arm/boot/dts/stm32mp151a-prtt1c.dts
 create mode 100644 arch/arm/boot/dts/stm32mp151a-prtt1l.dtsi
 create mode 100644 arch/arm/boot/dts/stm32mp151a-prtt1s.dts

-- 
2.30.2

