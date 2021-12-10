Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBCD4707B2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244771AbhLJR4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:56:08 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:50034 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244580AbhLJR4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:56:06 -0500
X-UUID: 750d8da7b15046a79f66ff161d903c06-20211211
X-UUID: 750d8da7b15046a79f66ff161d903c06-20211211
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 863685110; Sat, 11 Dec 2021 01:52:27 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 11 Dec 2021 01:52:26 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 11 Dec
 2021 01:52:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Dec 2021 01:52:25 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Flora Fu <flora.fu@mediatek.com>,
        "JB Tsai" <jb.tsai@mediatek.com>
Subject: [PATCH 00/12] MediaTek MT8195 APU
Date:   Sat, 11 Dec 2021 01:52:11 +0800
Message-ID: <20211210175223.31131-1-flora.fu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8195 SOC has APU hardware and this series add support
for MT8195 APU driver. The initial APU driver is implemented in
MT8192 APU driver[1] and we add MT8195 platform configuration to enable
APU functions.
The MT8195 APU drivers uses the MT8195 apu power domain[2].
[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=593825
[2] https://patchwork.kernel.org/project/linux-mediatek/list/?series=593841

Flora Fu (12):
  dt-bindings: memory: mediatek: Add MT8195 apu iommu bindings
  dt-bindings: remoteproc: mediatek: Add MT8195 in apu rproc
  dt-bindings: soc: mediatek: apu: Add MT8195 APU power bindings
  iommu/mediatek: Add APU iommu data for mt8195
  remoteproc: mediatek: Add MT8195 APU remoteproc support
  soc: mediatek: apu: Add MT8195 APU power driver
  arm64: dts: mt8195: Add APU mtk-apu-mailbox node
  arm64: dts: mt8195: Add APU-IOMMU nodes
  arm64: dts: mt8195: Add apu tinysys node
  arm64: dts: mt8195: Add APU power nodes
  arm64: dts: mt8195: Add apu-sw-logger node
  arm64: dts: mt8195: Set up regulators for APU subsys

 .../bindings/iommu/mediatek,iommu.yaml        |  3 +
 .../bindings/remoteproc/mediatek,apu-rv.yaml  |  1 +
 .../soc/mediatek/mediatek,apu-pwr.yaml        | 23 ++++-
 arch/arm64/boot/dts/mediatek/mt8195-evb.dts   |  5 ++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 84 +++++++++++++++++++
 drivers/iommu/mtk_iommu.c                     | 20 +++++
 drivers/remoteproc/mtk-apu-rproc.c            | 15 ++++
 drivers/soc/mediatek/apusys/apu-pwr.c         | 34 +++++++-
 .../dt-bindings/memory/mt8195-memory-port.h   |  4 +
 9 files changed, 187 insertions(+), 2 deletions(-)

-- 
2.18.0

