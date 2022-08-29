Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753A55A44F3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiH2IWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiH2IWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:22:37 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51FD564D2;
        Mon, 29 Aug 2022 01:22:36 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27T8MBWT018172;
        Mon, 29 Aug 2022 03:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661761331;
        bh=Y/zAddsITmLX4hBkyhD03ZBy/2WYTHJi+HzHzt3vYUo=;
        h=From:To:CC:Subject:Date;
        b=pFVuV9rE0d06RQZdyvtZ0trgMnKDCET2VKeWdiWCVLJsTL+fWeh4mVMVDw4TXQ3GQ
         GPkL4TW2LI6FTNyWQ6PzgpQ+zCKTFia52pq91VAmhGj89E/Ufrx5WHVXcmxo18fSst
         guhRF8ANcUjzpXowe1gkgEmMaMSvlns+WARrXg00=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27T8MBeZ029531
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Aug 2022 03:22:11 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 29
 Aug 2022 03:22:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 29 Aug 2022 03:22:11 -0500
Received: from uda0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27T8M7YZ059309;
        Mon, 29 Aug 2022 03:22:08 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 0/4] arm64: dts: ti: Add support for AM62A family of SoCs
Date:   Mon, 29 Aug 2022 13:51:56 +0530
Message-ID: <20220829082200.241653-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds basic boot support for AM62A SoCs with UART, MMC/SD and
GPIO support on AM62A SK EVM

Bootlog: https://gist.github.com/r-vignesh/f94d274f73e734526ab589d71ef2e41a
Tech Ref manual: https://www.ti.com/lit/zip/spruj16
Schematics: https://www.ti.com/lit/zip/sprr459

Vignesh Raghavendra (4):
  dt-bindings: arm: ti: Add bindings for AM62A7 SoC
  dt-bindings: pinctrl: k3: Introduce pinmux definitions for AM62A
  arm64: dts: ti: Introduce AM62A7 family of SoCs
  arm64: dts: ti: Add support for AM62A7-SK

 .../devicetree/bindings/arm/ti/k3.yaml        |   6 +
 arch/arm64/boot/dts/ti/Makefile               |   2 +
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     | 298 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi      |  39 +++
 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi   |  54 ++++
 arch/arm64/boot/dts/ti/k3-am62a.dtsi          | 122 +++++++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts       | 224 +++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a7.dtsi         | 103 ++++++
 include/dt-bindings/pinctrl/k3.h              |   2 +
 9 files changed, 850 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a7.dtsi

-- 
2.25.1

