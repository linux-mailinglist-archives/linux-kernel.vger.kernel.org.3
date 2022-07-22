Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5774857E37A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 17:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbiGVPMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 11:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiGVPMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 11:12:06 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0EE6951C3;
        Fri, 22 Jul 2022 08:12:05 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,186,1654527600"; 
   d="scan'208";a="127045513"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 23 Jul 2022 00:12:04 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7B297432D9F0;
        Sat, 23 Jul 2022 00:12:01 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 0/3] Add PHY interrupt support for ETH{0,1} on RZ/G2L and RZ/V2L SMARC EVK
Date:   Fri, 22 Jul 2022 16:11:52 +0100
Message-Id: <20220722151155.21100-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series is a subset of [0] as patches 1-4 have been already
picked up by Geert for v5.21. Patch 1 introduces macros for NMI/IRQ0-7,
second patch updates the binding doc and the third patch adds PHY
interrupt support for ETH{0,1}.

v2->v3:
* Added a new file irqc-rzg2l.h to include macros as suggested by
  Biju and Geert.
* Updated binding doc
* Updated rzg2l-smarc-som.dtsi to include the header

v1->v2:
* Fixed review comments pointed by Geert

v1: [0]

[0] https://patchwork.kernel.org/project/linux-renesas-soc/cover/
20220718195651.7711-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (3):
  dt-bindings: interrupt-controller: Add macros for NMI and IRQ0-7
    interrupts present on RZ/G2L SoC
  dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Update
    description for '#interrupt-cells' property
  arm64: dts: renesas: rzg2l-smarc-som: Add PHY interrupt support for
    ETH{0/1}

 .../renesas,rzg2l-irqc.yaml                   |  5 ++--
 .../boot/dts/renesas/rzg2l-smarc-som.dtsi     | 11 ++++++--
 .../interrupt-controller/irqc-rzg2l.h         | 25 +++++++++++++++++++
 3 files changed, 37 insertions(+), 4 deletions(-)
 create mode 100644 include/dt-bindings/interrupt-controller/irqc-rzg2l.h

-- 
2.25.1

