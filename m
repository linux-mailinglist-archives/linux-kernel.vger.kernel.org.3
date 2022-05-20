Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48BC52EC05
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349211AbiETMWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349066AbiETMWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:22:32 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EA4633AA;
        Fri, 20 May 2022 05:22:26 -0700 (PDT)
X-UUID: fe6414916f2d4efeaa4d8097663b7743-20220520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:1de32e49-7415-4c35-b120-22d49b7567f1,OB:10,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:95
X-CID-INFO: VERSION:1.1.5,REQID:1de32e49-7415-4c35-b120-22d49b7567f1,OB:10,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:95
X-CID-META: VersionHash:2a19b09,CLOUDID:d5a2f4e2-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:19ab49d313ef,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: fe6414916f2d4efeaa4d8097663b7743-20220520
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1490102431; Fri, 20 May 2022 20:22:19 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 20 May 2022 20:22:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 20 May 2022 20:22:18 +0800
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
Subject: [PATCH v11 0/3] Add basic node support for MediaTek MT8186 SoC
Date:   Fri, 20 May 2022 20:22:14 +0800
Message-ID: <20220520122217.30716-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
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

Based on next-20220519, linux-next/master

changes since v9:
 - remove some merged PATCHs from series
 - reorder nodes in dts (cpu-map)
 - remove okay status in auxadc
 - remove unnecessary suffix node name for i2c
 - add pwm node 
 - add dsi-phy node 
 - add dpi node 

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

Allen-KH Cheng (3):
  dt-bindings: arm: mediatek: Add mt8186 pericfg compatible
  dt-bindings: arm: Add compatible for MediaTek MT8186
  arm64: dts: Add MediaTek SoC MT8186 dts and evaluation board and
    Makefile

 .../devicetree/bindings/arm/mediatek.yaml     |    4 +
 .../arm/mediatek/mediatek,pericfg.yaml        |    1 +
 arch/arm64/boot/dts/mediatek/Makefile         |    1 +
 arch/arm64/boot/dts/mediatek/mt8186-evb.dts   |  232 ++++
 arch/arm64/boot/dts/mediatek/mt8186.dtsi      | 1016 +++++++++++++++++
 5 files changed, 1254 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186.dtsi

-- 
2.18.0

