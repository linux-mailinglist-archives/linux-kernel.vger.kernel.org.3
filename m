Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96165470777
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbhLJRl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:41:27 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:33394 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233408AbhLJRl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:41:26 -0500
X-UUID: 226ffe4d41644091ab32aff198174789-20211211
X-UUID: 226ffe4d41644091ab32aff198174789-20211211
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1858846570; Sat, 11 Dec 2021 01:37:48 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Dec 2021 01:37:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Dec 2021 01:37:46 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Flora Fu <flora.fu@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, JB Tsai <jb.tsai@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [PATCH 0/6] Add MT8195 APU Power Domain
Date:   Sat, 11 Dec 2021 01:37:37 +0800
Message-ID: <20211210173743.30906-1-flora.fu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 APU power domain.
This series is based on drivers implemented in
MT8192 apu power domain[1] and apu SMC[2].
[1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=593809
[2] https://patchwork.kernel.org/patch/12670253
The device tree depends on MT8195 dts[3] which is under reviewing.
[3] https://patchwork.kernel.org/patch/12616141

Flora Fu (6):
  dt-bindings: soc: mediatek: apu: Add MT8195 APU power domain
  dt-bindings: arm: mediatek: Add MT8195 APU bindings
  soc: mediatek: apu: Add MT8195 apu power domain
  arm64: dts: mt8195: Add APU nodes
  arm64: dts: mt8195: Add APU power domain node
  arm64: dts: mt8195: Set up apu power domain regulators

 .../arm/mediatek/mediatek,apusys.yaml         |   3 +
 .../soc/mediatek/mediatek,apu-pm.yaml         |   1 +
 arch/arm64/boot/dts/mediatek/mt8195-evb.dts   |   8 ++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  31 +++++
 drivers/soc/mediatek/apusys/mtk-apu-pm.c      | 124 ++++++++++++++++++
 5 files changed, 167 insertions(+)

-- 
2.18.0

