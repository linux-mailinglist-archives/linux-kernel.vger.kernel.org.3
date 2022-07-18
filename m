Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5DF578B50
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbiGRT5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbiGRT47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:56:59 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26A1C2D1FE;
        Mon, 18 Jul 2022 12:56:58 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,281,1650898800"; 
   d="scan'208";a="128258229"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 19 Jul 2022 04:56:57 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 75F5C40EE277;
        Tue, 19 Jul 2022 04:56:54 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/5] Add IRQC support to Renesas RZ/G2L and RZ/V2L SoC
Date:   Mon, 18 Jul 2022 20:56:46 +0100
Message-Id: <20220718195651.7711-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series adds IRQC support to handle GPIO and external interrupts
support to RZ/G2L and RZ/V2L SoC's. Alongside enables PHY interrupt
support to ETH0/1 on SMARC EVK.

Note: The driver patches are in -next and the DT binding patch for RZ/V2L
is posted [0].

[0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/
20220718193745.7472-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (5):
  arm64: dts: renesas: r9a07g044: Add IRQC node to SoC DTSI
  arm64: dts: renesas: r9a07g044: Update pinctrl node to handle GPIO
    interrupts
  arm64: dts: renesas: r9a07g054: Add IRQC node to SoC DTSI
  arm64: dts: renesas: r9a07g054: Update pinctrl node to handle GPIO
    interrupts
  arm64: dts: renesas: rzg2l-smarc-som: Add PHY interrupt support for
    ETH{0/1}

 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    | 59 +++++++++++++++++++
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    | 59 +++++++++++++++++++
 .../boot/dts/renesas/rzg2l-smarc-som.dtsi     | 10 +++-
 3 files changed, 126 insertions(+), 2 deletions(-)

-- 
2.25.1

