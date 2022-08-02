Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1863587957
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbiHBIwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbiHBIwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:52:04 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2802F67F;
        Tue,  2 Aug 2022 01:52:02 -0700 (PDT)
X-UUID: c5605a5eb833454e9840845baab2df4f-20220802
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:a7509fb2-994b-48bf-9510-7fb81aed29df,OB:10,L
        OB:10,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,
        ACTION:release,TS:90
X-CID-INFO: VERSION:1.1.8,REQID:a7509fb2-994b-48bf-9510-7fb81aed29df,OB:10,LOB
        :10,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:90
X-CID-META: VersionHash:0f94e32,CLOUDID:49c60fd0-a6cf-4fb6-be1b-c60094821ca2,C
        OID:7d07825c97e3,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: c5605a5eb833454e9840845baab2df4f-20220802
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1209660943; Tue, 02 Aug 2022 16:51:55 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 2 Aug 2022 16:51:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 2 Aug 2022 16:51:54 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>, <hsinyi@chromium.org>,
        Allen-kh Cheng <allen-kh.cheng@mediatek.corp-partner.google.com>
Subject: [PATCH v13 0/1] Add basic node support for MediaTek MT8186 SoC
Date:   Tue, 2 Aug 2022 16:51:51 +0800
Message-ID: <20220802085152.31284-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Allen-kh Cheng <allen-kh.cheng@mediatek.corp-partner.google.com>

MT8186 is a SoC based on 64bit ARMv8 architecture. It contains 6 CA55
and 2 CA76 cores. MT8186 share many HW IP with MT65xx series. This
patchset was tested on MT8186 evaluation board to shell.

This series is based on tag: next-20220728, linux-next/master
Since we have a another dts series of mt8195 [1] which is waiting for
review from maintainers. I remove power domains controller node from
this mt8186 series and will update in another patch.

There are some corrections in mt8186 hardware bindings. We need to
apply the below patches.
https://patchwork.kernel.org/project/linux-mediatek/patch/20220725110702.11362-2-allen-kh.cheng@mediatek.com/
https://patchwork.kernel.org/project/linux-mediatek/patch/20220725110702.11362-3-allen-kh.cheng@mediatek.com/
https://patchwork.kernel.org/project/linux-mediatek/patch/20220720130604.14113-2-allen-kh.cheng@mediatek.com/
https://patchwork.kernel.org/project/linux-mediatek/patch/20220721014845.19044-2-allen-kh.cheng@mediatek.com/

[1]
https://patchwork.kernel.org/project/linux-mediatek/list/?series=663978

changes since v12:
 - remove drive-strength fom i2c pins
 - use lowercase hex addresses in pinctrl node
 - correct clk order in xhci0
 - add clk26m for dma_ck

changes since v11:
 - add #cooling-cells in cpu nodes
 - add pmu nodes for mt8186
 - change #interrupt-cells from 3 to 4
 - correct interrupts property in each nodes for 4 interrupt cells
 - remove power domains controller node
 - move #address-cells and #size-cells into mt8186.dts
 - remove unused ahb_cg clock in mmc0
 - add efuse node
 - add dsi node and remove dpi node
 - move i2c status position in mt8186-evb.dts
 - change i2c child nodee name in pio node to *-pins
 - change property from mediatek,drive-strength-adv to drive-strength-microamp in i2c child nodes of pio
 - change drive-strength value from MTK_DRIVE_4mA to 4 in i2c child nodes of pio
 - change i2c child nodes from pins-sda-sc1 to pins-bus
 - correct pintctrl clk names

changes since v10:
 - remove merged PATCHes
 - add pmu nodes
 - add #cooling-cells
 - change #interrupt-cells number from 3 to 4
 - remove power domains controller node
 - move #address-cells/#size-cells into mt8186.dts from evb dts for i2c
 - move status = 'okay' position in i2cx
 - fix pinctrl patternproperties name in pio
 - add efuse node
 - fix dsi node
 - add #reset-cells in infracfg_ao: syscon

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

Allen-KH Cheng (1):
  arm64: dts: Add MediaTek MT8186 dts and evaluation board and Makefile

 arch/arm64/boot/dts/mediatek/Makefile       |   1 +
 arch/arm64/boot/dts/mediatek/mt8186-evb.dts | 228 +++++
 arch/arm64/boot/dts/mediatek/mt8186.dtsi    | 875 ++++++++++++++++++++
 3 files changed, 1104 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186.dtsi

-- 
2.18.0

