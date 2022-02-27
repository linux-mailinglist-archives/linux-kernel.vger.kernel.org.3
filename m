Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3135C4C5EAD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 21:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiB0Uig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 15:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiB0Uif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 15:38:35 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0129733359;
        Sun, 27 Feb 2022 12:37:56 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.90,141,1643641200"; 
   d="scan'208";a="111718863"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 28 Feb 2022 05:37:55 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 684D940175FE;
        Mon, 28 Feb 2022 05:37:53 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 00/12] Renesas RZ/V2L add support for SDHI/CANFD/I2C/OSTM/USB2/SBC/RSPI/WDT/SSI
Date:   Sun, 27 Feb 2022 20:37:32 +0000
Message-Id: <20220227203744.18355-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series adds support for below IP blocks to Renesas RZ/V2L SoC:
* SDHI
* CANFD
* I2C
* OSTM
* WDT
* SSI
* USB2
* RPC-IF (SBC)
* RSPI

The above peripherals can now be operational on Renesas RZ/V2L SMARC EVK
with this series.

Note:
* Im just sending the DTS/I changes as separate series and shall post the
binding doc changes individually to the corresponding subsystems.
* Patch 05/12 depends on [0]
* For OSTM/SSI/USB to work on RZ/V2L SoC ARCH_R9A07G044 needs to be
enabled as the corresponding drivers have ARCH_R9A07G044 as dependency
which I intend to change it to ARCH_RZG2L. This will be updated once patch
[1] is part of -rc* cycle.
* Patch series applies on top of [2].

[0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/
20220209232232.18461-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
[1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/
20220224092114.25737-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
[2] https://patchwork.kernel.org/project/linux-renesas-soc/cover/
20220224125843.29733-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (12):
  arm64: dts: renesas: r9a07g054: Fillup the SDHI{0,1} stub nodes
  arm64: dts: renesas: r9a07g054l2-smarc: Drop deleting gpio-hog pins
    related to SDHI
  arm64: dts: renesas: r9a07g054: Fillup the CANFD stub node
  arm64: dts: renesas: r9a07g054l2-smarc: Drop deleting can{0,1}-stb-hog
    nodes
  arm64: dts: renesas: r9a07g054: Fillup the I2C{0,1,2,3} stub nodes
  arm64: dts: renesas: r9a07g054: Fillup the sbc stub node
  arm64: dts: renesas: r9a07g054: Fillup the OSTM{0,1,2} stub nodes
  arm64: dts: renesas: r9a07g054: Fillup the WDT{0,1,2} stub nodes
  arm64: dts: renesas: r9a07g054: Add SSI{1,2,3} nodes and fillup the
    SSI0 stub node
  arm64: dts: renesas: r9a07g054: Add USB2.0 phy and host support
  arm64: dts: renesas: r9a07g054: Add USB2.0 device support
  arm64: dts: renesas: r9a07g054: Add SPI{0,2} nodes and fillup SPI1
    stub node

 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    | 413 +++++++++++++++++-
 .../boot/dts/renesas/r9a07g054l2-smarc.dts    |   8 -
 2 files changed, 390 insertions(+), 31 deletions(-)

-- 
2.17.1

