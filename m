Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E660C5A99D5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbiIAOOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbiIAOOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:14:05 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCDF67CA2;
        Thu,  1 Sep 2022 07:14:01 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 281EDli8008793;
        Thu, 1 Sep 2022 09:13:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662041627;
        bh=jpTQjZ3OADtxYbKq9HWfY4ToEkXCz2T6F6WeWDtFcGM=;
        h=From:To:CC:Subject:Date;
        b=YadsnTvTcw/ARGx+BJ+dtYe0WHnyGRHTcaz7HNIPcBZCeLZz2sO/EtuH1Y4Dfn2YY
         6GG5bN1omn+f6hhf4GYG7SPZn9o6kz/tnqA+F2VCUGkRVBkVTKXRraqaN1EjFAKm3R
         SHSwhgNShzE0P7AIEbJELDrOtx+MHGcrbKuxTuC0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 281EDl00048566
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Sep 2022 09:13:47 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 1 Sep
 2022 09:13:47 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 1 Sep 2022 09:13:47 -0500
Received: from uda0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 281EDhdR015476;
        Thu, 1 Sep 2022 09:13:44 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 0/5] arm64: dts: ti: Add support for AM62A family of SoCs
Date:   Thu, 1 Sep 2022 19:43:23 +0530
Message-ID: <20220901141328.899100-1-vigneshr@ti.com>
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

Bootlog: https://gist.github.com/r-vignesh/4d88f53bb0489f1675fa78f993e95d3f
Tech Ref manual: https://www.ti.com/lit/zip/spruj16
Schematics: https://www.ti.com/lit/zip/sprr459

v2:
* Add new patch 1/5 to sort pinmux macros alphabetically
* Rebase onto latest -next for so that SoC bindings are sorted
* Add soc specific compatible for SoC syscon nodes
* Address misc comments from Krzysztof

v1: lore.kernel.org/r/20220829082200.241653-1-vigneshr@ti.com

Vignesh Raghavendra (5):
  dt-bindings: arm: ti: Rearrange IOPAD macros alphabetically
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
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts       | 223 +++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a7.dtsi         | 103 ++++++
 include/dt-bindings/pinctrl/k3.h              |  15 +-
 9 files changed, 856 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a7.dtsi

-- 
2.37.2

