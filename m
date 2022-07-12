Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CE0572122
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiGLQlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGLQlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:41:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0A4B31ED;
        Tue, 12 Jul 2022 09:41:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EB1EB817B7;
        Tue, 12 Jul 2022 16:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB63C3411C;
        Tue, 12 Jul 2022 16:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657644073;
        bh=+b/1grUJCSsyjFjJCmNeot/mVBQ8tWbodPZ1hw/Xajk=;
        h=From:To:Cc:Subject:Date:From;
        b=kCaLjL3oZZ1xJvU+6VYFFQowoautaX1XwiRc9vWzUY+4+B7K9wKu31QkxqGisnbcT
         tAN5nu35aVCAjbvgoHwhoBRAbS9psVz/e4wxAd2LzpXkUxnzhVRhSo8qw8L3CAbBNM
         otoxB4D/29bLmiaslhlPHq7bR+3JxNTi6cQkujo1D2vMa6Llt8Hb5vYFgSJju3HXl+
         phfwOKaZg6IVeE8PXRHAQh+3TqNH3FfbyK/iZdN9zhKTdOLC67Va6fD3A4so7H7oz6
         7hKrcmJMArcOq0XNusfbSa1SGPglPrNmd/SFma7BHIHTXZHdFjKCDdlYY99fWfo4Pg
         Y2JwTg4AZ1z2A==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 00/10] ARM: dts: mvebu: Add definitions for PCIe legacy INTx interrupts
Date:   Tue, 12 Jul 2022 18:40:58 +0200
Message-Id: <20220712164108.30262-1-kabel@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Gregory [1] (although he suggested it only for armada
380), add definitions for PCIe legacy INTx interrupts into every DTS
file used by the pci-mvebu.c controller driver.

It was tested on 88F6820 (A385) and 88F6281 (Kirkwood) SoCs.

[1] https://lore.kernel.org/linux-arm-kernel/87wnhxjxlq.fsf@BL-laptop/

Changes since v1:
- dropped armada-385 patch, which was already applied
- added commit messages

Pali Rohár (10):
  ARM: dts: kirkwood: Add definitions for PCIe legacy INTx interrupts
  ARM: dts: dove: Add definitions for PCIe legacy INTx interrupts
  ARM: dts: armada-370.dtsi: Add definitions for PCIe legacy INTx
    interrupts
  ARM: dts: armada-xp-98dx3236.dtsi: Add definitions for PCIe legacy
    INTx interrupts
  ARM: dts: armada-xp-mv78230.dtsi: Add definitions for PCIe legacy INTx
    interrupts
  ARM: dts: armada-xp-mv78260.dtsi: Add definitions for PCIe legacy INTx
    interrupts
  ARM: dts: armada-xp-mv78460.dtsi: Add definitions for PCIe legacy INTx
    interrupts
  ARM: dts: armada-375.dtsi: Add definitions for PCIe legacy INTx
    interrupts
  ARM: dts: armada-380.dtsi: Add definitions for PCIe legacy INTx
    interrupts
  ARM: dts: armada-39x.dtsi: Add definitions for PCIe legacy INTx
    interrupts

 arch/arm/boot/dts/armada-370.dtsi         |  28 ++++-
 arch/arm/boot/dts/armada-375.dtsi         |  28 ++++-
 arch/arm/boot/dts/armada-380.dtsi         |  42 ++++++-
 arch/arm/boot/dts/armada-39x.dtsi         |  56 +++++++--
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi |  14 ++-
 arch/arm/boot/dts/armada-xp-mv78230.dtsi  |  70 +++++++++--
 arch/arm/boot/dts/armada-xp-mv78260.dtsi  | 126 ++++++++++++++++---
 arch/arm/boot/dts/armada-xp-mv78460.dtsi  | 140 ++++++++++++++++++----
 arch/arm/boot/dts/dove.dtsi               |  28 ++++-
 arch/arm/boot/dts/kirkwood-6192.dtsi      |  14 ++-
 arch/arm/boot/dts/kirkwood-6281.dtsi      |  14 ++-
 arch/arm/boot/dts/kirkwood-6282.dtsi      |  28 ++++-
 arch/arm/boot/dts/kirkwood-98dx4122.dtsi  |  14 ++-
 13 files changed, 516 insertions(+), 86 deletions(-)

-- 
2.35.1

