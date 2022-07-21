Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F4457D215
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbiGUQ50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbiGUQ5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:57:20 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 056F289A6B;
        Thu, 21 Jul 2022 09:57:15 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,183,1654527600"; 
   d="scan'208";a="126927668"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 22 Jul 2022 01:57:14 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id B3FE24011419;
        Fri, 22 Jul 2022 01:57:11 +0900 (JST)
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
Subject: [PATCH v2 0/2] Add PHY interrupt support for ETH{0,1} on RZ/G2L and RZ/V2L SMARC EVK
Date:   Thu, 21 Jul 2022 17:56:59 +0100
Message-Id: <20220721165701.17888-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
picked up by Geert for v5.21. Patch 1 introduces macros for IRQ0-7 and
second patch adds PHY interrupt support for ETH{0,1}.

v1->v2:
* Fixed review comments pointed by Geert

v1: [0]

[0] https://patchwork.kernel.org/project/linux-renesas-soc/cover/
20220718195651.7711-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (2):
  dt-bindings: pinctrl: rzg2l-pinctrl: Add macros for IRQ0-7
  arm64: dts: renesas: rzg2l-smarc-som: Add PHY interrupt support for
    ETH{0/1}

 arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi | 10 ++++++++--
 include/dt-bindings/pinctrl/rzg2l-pinctrl.h      | 10 ++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.25.1

