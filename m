Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F008533710
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 09:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244240AbiEYHK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 03:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243985AbiEYHKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 03:10:48 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A294E9;
        Wed, 25 May 2022 00:10:46 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 34E00100004;
        Wed, 25 May 2022 07:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653462644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QaLA+/fmAKnmAH5cylenwfL37+xRZpiIvhjB9RDhW1A=;
        b=oOXemAV0wkCHsRuDmqhLSoWnLjpKDaGFYjgsUgfAlEwN52eNVKz+yH1MQwFc1NIpvzciCS
        Dk7cyXr6ys6CQ4kt6P8K07C6J6MKPYE3MIFPxIkQ7XsVou6hGtsl0H+bJHn/BkKGbvMd16
        Bc8px1G3XZl0OBWvSMCOqG3ka63p3vHc1H6qjS3gIjiQxAAPcVJgklFatOZ5qivfrz6E8e
        C9M3WzzXX4irTaihy2odB2tpTVwc8hFTFigeD8LydNBTxsRIAodY13N+qpVVOLrAPj4afd
        zp98WVmRi/JKG/64b6wuA6nIet9PUiLswPteG/SRrAVRPf53Gs+0ma8gvzH3dQ==
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
Subject: [PATCH v3 0/3] Microchip LAN966x USB device support
Date:   Wed, 25 May 2022 09:10:33 +0200
Message-Id: <20220525071036.223396-1-herve.codina@bootlin.com>
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

