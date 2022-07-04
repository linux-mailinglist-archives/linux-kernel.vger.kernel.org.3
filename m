Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C8B564AB6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 02:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiGDAVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 20:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiGDAU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 20:20:59 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8452D2AD1;
        Sun,  3 Jul 2022 17:20:57 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 04 Jul 2022 09:20:55 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 0178D2058B4F;
        Mon,  4 Jul 2022 09:20:55 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 4 Jul 2022 09:20:55 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 959D51DDD;
        Mon,  4 Jul 2022 09:20:54 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/9] Update UniPhier armv7 devicetree
Date:   Mon,  4 Jul 2022 09:20:17 +0900
Message-Id: <1656894026-15707-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update devicetree sources for UniPhier armv7 SoCs to remove dtschema
warnings, add support existing features that haven't yet been
described, and replace constants with macros.

Kunihiko Hayashi (9):
  ARM: dts: uniphier: Fix USB interrupts for PXs2 SoC
  ARM: dts: uniphier: Rename pvtctl node to thermal-sensor
  ARM: dts: uniphier: Rename usb-phy node to usb-glue
  ARM: dts: uniphier: Rename gpio-hog node
  ARM: dts: uniphier: Use GIC interrupt definitions
  ARM: dts: uniphier: Add ahci controller and glue layer nodes for Pro4
  ARM: dts: uniphier: Add ahci controller and glue layer nodes for PXs2
  ARM: dts: uniphier: Move interrupt-parent property to each child node
    in uniphier-support-card
  ARM: dts: uniphier: Remove compatible "snps,dw-pcie-ep" from Pro5
    pcie-ep node

 arch/arm/boot/dts/uniphier-ld4-ref.dts       |   6 +-
 arch/arm/boot/dts/uniphier-ld4.dtsi          |  49 +++---
 arch/arm/boot/dts/uniphier-ld6b-ref.dts      |   6 +-
 arch/arm/boot/dts/uniphier-pro4-ace.dts      |   8 +
 arch/arm/boot/dts/uniphier-pro4-ref.dts      |  14 +-
 arch/arm/boot/dts/uniphier-pro4.dtsi         | 163 ++++++++++++++++---
 arch/arm/boot/dts/uniphier-pro5.dtsi         |  53 +++---
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts   |   4 +
 arch/arm/boot/dts/uniphier-pxs2.dtsi         | 102 ++++++++----
 arch/arm/boot/dts/uniphier-sld8-ref.dts      |   6 +-
 arch/arm/boot/dts/uniphier-sld8.dtsi         |  49 +++---
 arch/arm/boot/dts/uniphier-support-card.dtsi |   3 +-
 12 files changed, 331 insertions(+), 132 deletions(-)

-- 
2.25.1

