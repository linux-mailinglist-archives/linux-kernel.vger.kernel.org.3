Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244AC562C4C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbiGAHJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbiGAHJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:09:38 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869E868A09;
        Fri,  1 Jul 2022 00:09:36 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 7A183100008;
        Fri,  1 Jul 2022 07:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656659375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uykJuESLKoGztXK9aYx8peves7aizxm3hOTH9nKfMSU=;
        b=firAHOqESXQ2o/Ulp+TSwtHzoj2Zw5biupcjCRSxoDzmZNXp+SBJavUHmslGjiSFbGt/E3
        rINiMDJ029uiMS3BlcXgoVwL7mQH+Oo6VeskQjhnPYB500QEhxiu189nvXvIFAOVps0+G8
        MR7rMHUZIiGtLQaTTsBOrx1IQF41SROJuv4tApprayq35jaKdWP5dxJhRXiWaJPgIORdNX
        9G2bJbKZ5RN5CqeVmJRZELiLsfJr/W6UeUDlRHg7fP9s9f3QQXnVZYo4GMJcD7nPRp4j0g
        VAyLcTM2efcVIeFvHKW9scqUqzPo2srk1Tver48j/97r60T21wMtWIl4JEdaqg==
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
Subject: [PATCH v4 0/3] Microchip LAN966x USB device support
Date:   Fri,  1 Jul 2022 09:09:25 +0200
Message-Id: <20220701070928.459135-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.3
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

Changes v3:
- Add Krzysztof's 'Acked-by' on patch 2/3
- Change node insertion point (sort nodes by base addresses) on patch 3/3

Changes v4:
- rebase on top of v5.19-rc1

Herve Codina (3):
  clk: lan966x: Fix the lan966x clock gate register address
  dt-bindings: usb: atmel: Add Microchip LAN9662 compatible string
  ARM: dts: lan966x: Add UDPHS support

 Documentation/devicetree/bindings/usb/atmel-usb.txt |  3 +++
 arch/arm/boot/dts/lan966x.dtsi                      | 11 +++++++++++
 drivers/clk/clk-lan966x.c                           |  2 +-
 3 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.35.3

