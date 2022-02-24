Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934954C2C53
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbiBXM7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbiBXM7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:59:37 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF02128F45A;
        Thu, 24 Feb 2022 04:59:06 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.88,393,1635174000"; 
   d="scan'208";a="112251164"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 24 Feb 2022 21:59:06 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 31E224007550;
        Thu, 24 Feb 2022 21:59:03 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 0/2] Add ADC support to Renesas RZ/V2L SoC
Date:   Thu, 24 Feb 2022 12:58:41 +0000
Message-Id: <20220224125843.29733-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

This patch series adds ADC support to Renesas RZ/V2L SoC.

Note, as the RZ/V2L SMARC EVK uses the common dts by default the
adc will be enabled on the SMARC EVK. Right now the RZG2L_ADC config
is only enabled for ARCH_R9A07G044 SoC once patch [0] hits upstream
the Kconfig dependency will be changed to ARCH_RZG2L so that it can
be enabled on all the compatible SoC's.

[0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/
20220224092114.25737-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (2):
  dt-bindings: iio: adc: renesas,rzg2l-adc: Document RZ/V2L SoC
  arm64: dts: renesas: r9a07g054: Fillup the ADC stub node

 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   |  3 +-
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    | 39 ++++++++++++++++++-
 2 files changed, 40 insertions(+), 2 deletions(-)

-- 
2.17.1

