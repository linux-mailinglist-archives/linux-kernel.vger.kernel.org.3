Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFA95691E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbiGFSew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbiGFSeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:34:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE28F186F1;
        Wed,  6 Jul 2022 11:34:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79AA262022;
        Wed,  6 Jul 2022 18:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65D3C3411C;
        Wed,  6 Jul 2022 18:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657132488;
        bh=tdhbHRpjTdh0jLJq87r0ykUnbSyUx7D2m6eJLr6vJG4=;
        h=From:To:Cc:Subject:Date:From;
        b=Xjg/qMVcpW7nAsDPPTnx9mX520shW0tsKY/G5PfEFxgKLu5Svhi+2uOl3uoA08/kg
         96mYYvNNeYLW7CBPJcv9wOgSLz2G/XqhDO1GC1vbHatPB7C5vqQ00VAs2Rauxhk2vr
         hl19gXfziF9DpHXIoppesGt8nfWDeVOo1fqsC6K1Ra3ao69LedrqC1Gi9N9P/GVIud
         B46gVzXVJCQMaWZ0T4PUM5mvWRhL+dQ9DMBvm/jurQv/powltTfiCtHqq8UY/Jc8A2
         hkeBV06xt3RJkPrC535UE5kCkXy3bUc6o3P4S0/sz97RZ7umTb6LTYD5DT8Mxv97C/
         nrx2cqSIOKszQ==
Received: by pali.im (Postfix)
        id 748067BA; Wed,  6 Jul 2022 20:34:45 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] ARM: dts: mvebu: Add definitions for PCIe legacy INTx interrupts
Date:   Wed,  6 Jul 2022 20:31:03 +0200
Message-Id: <20220706183114.30783-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add definitions for PCIe legacy INTx interrupts into
every DTS file used by the pci-mvebu.c controller driver.

It was tested on 88F6820 (A385) and 88F6281 (Kirkwood) SoCs.

Pali Rohár (11):
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
  ARM: dts: armada-385.dtsi: Add definitions for PCIe legacy INTx
    interrupts
  ARM: dts: armada-39x.dtsi: Add definitions for PCIe legacy INTx
    interrupts

 arch/arm/boot/dts/armada-370.dtsi         |  28 ++++-
 arch/arm/boot/dts/armada-375.dtsi         |  28 ++++-
 arch/arm/boot/dts/armada-380.dtsi         |  42 ++++++-
 arch/arm/boot/dts/armada-385.dtsi         |  52 ++++++--
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
 14 files changed, 560 insertions(+), 94 deletions(-)

-- 
2.20.1

