Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DEA565182
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbiGDKAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiGDKAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:00:37 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E075EB1D7;
        Mon,  4 Jul 2022 03:00:35 -0700 (PDT)
X-UUID: d25759d5fed34ebaafd3a5253cd25fc5-20220704
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:7fbcc016-ad25-4fcf-b62c-773c12acccc0,OB:0,LO
        B:30,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:95
X-CID-INFO: VERSION:1.1.7,REQID:7fbcc016-ad25-4fcf-b62c-773c12acccc0,OB:0,LOB:
        30,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:95
X-CID-META: VersionHash:87442a2,CLOUDID:492e7e86-57f0-47ca-ba27-fe8c57fbf305,C
        OID:e9b7b561a9ca,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: d25759d5fed34ebaafd3a5253cd25fc5-20220704
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 520530709; Mon, 04 Jul 2022 18:00:30 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 4 Jul 2022 18:00:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 4 Jul 2022 18:00:29 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v1 00/16] Add driver nodes for MT8195 SoC
Date:   Mon, 4 Jul 2022 18:00:12 +0800
Message-ID: <20220704100028.19932-1-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver nodes for MT8195 SoC.

Patchset 12 depends on 
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?id=009b21f392759ca7be91bc4be9d9534f6cee2878

Jason-JH.Lin (2):
  arm64: dts: mt8195: Add gce node
  arm64: dts: mt8195: Add display node for vdosys0

Tinghan Shen (10):
  dt-bindings: iommu: mediatek: Increase max interrupt number
  dt-bindings: memory: mediatek: Update condition for mt8195 smi node
  dt-bindings: power: mediatek: Refine multiple level power domain nodes
  arm64: dts: mt8195: Disable watchdog external reset signal
  arm64: dts: mt8195: Add vdosys and vppsys clock nodes
  arm64: dts: mt8195: Add power domains controller
  arm64: dts: mt8195: Add spmi node
  arm64: dts: mt8195: Add scp node
  arm64: dts: mt8195: Add audio related nodes
  arm64: dts: mt8195: Add iommu and smi nodes

Trevor Wu (1):
  arm64: dts: mt8195: Specify audio reset controller

Tzung-Bi Shih (1):
  arm64: dts: mt8195: Disable I2C0 node

YC Hung (1):
  arm64: dts: mt8195: Add adsp node and adsp mailbox nodes

YT Lee (1):
  arm64: dts: mt8195: Add cpufreq node

 .../bindings/iommu/mediatek,iommu.yaml        |   12 +-
 .../mediatek,smi-common.yaml                  |   10 +-
 .../power/mediatek,power-controller.yaml      |  132 +-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 1073 ++++++++++++++++-
 4 files changed, 1104 insertions(+), 123 deletions(-)

-- 
2.18.0

