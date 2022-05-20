Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38BA52EF11
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350779AbiETPXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350764AbiETPXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:23:43 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC361778BD;
        Fri, 20 May 2022 08:23:41 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id B1C6D40002;
        Fri, 20 May 2022 15:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653060220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vV05Ae2wXWoOh3lcUOps/wlA6rJMqGUyhxwDB5ig5KE=;
        b=kndlrVfJL880TKddg9H9kjgcbbaFl2VZORnOwrzDErOvQk5umiUh3wTBbEOTvYwc23Fa63
        DjH9T/F3+EjSbWZA2Kive9AVDFrkEdOGQu80+5sKvwgB9HAy6qmkdsMZOtc9m/Ymlfks9L
        wRYG8XXjh4SbHh3NsTMqBPsBdt341LNjfSXo/1egAkplqPQBGgOzf0B9ocOsfjkLN5vMRs
        yoa91Z94dktfasZDFNR/Y5q46TBh+D3rFTWsCOk54MeZa4jGFjWkT1kiLxmZ1wIFQeSJwm
        63ATHisY/PZfholk9gtCDUazmPsG8PEgtyQmQ8H91rBUXyavpKK9VHndTBGpig==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 0/3] Microchip LAN966x USB device support
Date:   Fri, 20 May 2022 17:23:32 +0200
Message-Id: <20220520152335.352537-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series add support for the USB device controller available on
the Microchip LAN966x SOCs (LAN9662 and LAN9668).

Both SOCs have the same controller and this controller is also the
same as the one present on the SAMAD3 SOC.

Regards,
Herve

Changes v2:
- Avoid wildcards in the DT compatible string
- Rename the DT node

Herve Codina (3):
  clk: lan966x: Fix the lan966x clock gate register address
  dt-bindings: usb: atmel: Add Microchip LAN9662 compatible string
  ARM: dts: lan966x: Add UDPHS support

 Documentation/devicetree/bindings/usb/atmel-usb.txt |  3 +++
 arch/arm/boot/dts/lan966x.dtsi                      | 11 +++++++++++
 drivers/clk/clk-lan966x.c                           |  2 +-
 3 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.35.1

