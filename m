Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463E252606C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356296AbiEMK7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiEMK7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:59:00 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07BA2631CD;
        Fri, 13 May 2022 03:58:58 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 42F6910000F;
        Fri, 13 May 2022 10:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652439537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=V7HV2NTmzcCN16ibcu3Q3W2nDoKyhG9npg9pAxNIlw4=;
        b=A8tCz3pU/nOMdlKXCbD8l8tqR4dn85K2T2JYzi9RM+e/rHRAbi5XHaK1FWfD+SqGsDvPHL
        YMzT2FpNll4YAtsUHlIBrp68bZL35oUoYePe89BAkkFHAlenvVthEOwFqQJKIA0GjqdcEz
        uqrX/M34hnDSWti/6oy9aKuq0HOnzbt0kdV1pQMAJKkG2sFQ8AeaG8kSCgo4jVk2iglYJ0
        BgKPEWDDV+Si33qqxcGzuM3UHiEucjXbMj3XeDfYcIrb8hA9iar/+NxuETtxmCLdZ2xd6I
        LX3Mqxnkm8RwEUmlF66pBs6R+VwdOmdDpYeL9iI1rI6Ctq6e4ACYKiI0uNF1SA==
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
Date:   Fri, 13 May 2022 12:58:47 +0200
Message-Id: <20220513105850.310375-1-herve.codina@bootlin.com>
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
the Microchip LAN966x SOCs.

This controller is the same as the one present on the SAMAD3 SOC.

Regards,
Herve

Herve Codina (3):
  clk: lan966x: Fix the lan966x clock gate register address
  dt-bindings: usb: atmel: Add Microchip LAN966x compatible string
  ARM: dts: lan966x: Add UDPHS support

 Documentation/devicetree/bindings/usb/atmel-usb.txt |  3 +++
 arch/arm/boot/dts/lan966x.dtsi                      | 11 +++++++++++
 drivers/clk/clk-lan966x.c                           |  2 +-
 3 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.35.1

