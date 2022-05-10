Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2F4520F20
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbiEJH5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 03:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237471AbiEJH4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:56:46 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D09224310A;
        Tue, 10 May 2022 00:52:48 -0700 (PDT)
X-UUID: c6a00f00047348b0b146854772a6aa2a-20220510
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:940de508-ee53-4f92-8db6-9a7a342c635d,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:4652df16-2e53-443e-b81a-655c13977218,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: c6a00f00047348b0b146854772a6aa2a-20220510
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1983483401; Tue, 10 May 2022 15:52:38 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 10 May 2022 15:52:37 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 10 May 2022 15:52:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 10 May 2022 15:52:36 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Chen-Yu Tsai" <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>, <hsinyi@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v10 0/4] Add basic node support for MediaTek MT8186 SoC
Date:   Tue, 10 May 2022 15:52:29 +0800
Message-ID: <20220510075233.5426-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8186 is a SoC based on 64bit ARMv8 architecture.
It contains 6 CA55 and 2 CA76 cores.
MT8186 share many HW IP with MT65xx series.

This patchset was tested on MT8186 evaluation board to shell.

Based on linux-next, tag: next-20220509

changes since v9:
 - add one space before equal sign of drive-strength-adv
 - corect compatible name for big cores (ca76)
 - use upper case of address in pinctrl
 - add pwrap node
 - add pwm node

changes since v8:
 - change name from pins_bus to pins-sda-scl
 - correct email address
 - add capacity-dmips-mhz for each CPU
 - add ppi-partitions in gic node
 - change name to power-domain
 - remove status "okay" in scp node
 - update timer and pericfg compatible in series

changes since v7:
 - add scp&auxadc node

changes since v6:
 - remove unnecessary blank line

changes since v5:
 - replace Mediatek a to MediaTek
 - use GPL-2.0-only OR BSD-2-Clause

changes since v4:
 - correct driver clock of mt8186
 - add power domains controller and clock controllers
 - add pinctrl, usb host, spi and i2c nodes
 - add node status in mt8186-evb.dts
 - correct some dtbs_check warnings

changes since v3:
 - remove serial, mmc and phy patch from series. (already merged)
 - remove mcusysoff node
 - move oscillator nodes at the head of dts
 - change name from usb-phy to t-phy

changes since v2:
 - add soc {} in mt8186.dtsi

changes since v1:
 - add dt-bindings: arm: Add compatible for MediaTek MT8186

Allen-KH Cheng (4):
  dt-bindings: timer: Add compatible for Mediatek MT8186
  dt-bindings: arm: mediatek: Add mt8186 pericfg compatible
  dt-bindings: arm: Add compatible for MediaTek MT8186
  arm64: dts: Add MediaTek SoC MT8186 dts and evaluation board and
    Makefile

 .../devicetree/bindings/arm/mediatek.yaml     |   4 +
 .../arm/mediatek/mediatek,pericfg.yaml        |   1 +
 .../bindings/timer/mediatek,mtk-timer.txt     |   1 +
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 arch/arm64/boot/dts/mediatek/mt8186-evb.dts   | 232 ++++
 arch/arm64/boot/dts/mediatek/mt8186.dtsi      | 996 ++++++++++++++++++
 6 files changed, 1235 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186.dtsi

-- 
2.18.0

