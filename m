Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEF4488D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 01:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237653AbiAJA70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 19:59:26 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:41196 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237643AbiAJA7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 19:59:25 -0500
X-UUID: 81431f3ba0ab4c5d960a72f087e75100-20220110
X-UUID: 81431f3ba0ab4c5d960a72f087e75100-20220110
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2072794757; Mon, 10 Jan 2022 08:59:20 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 10 Jan 2022 08:59:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 Jan 2022 08:59:18 +0800
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [v2 0/3] Integrate vppsys with mtk-mmsys in MT8195
Date:   Mon, 10 Jan 2022 08:58:59 +0800
Message-ID: <20220110005902.27148-1-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is based on 5.16-rc6.

change since v1:
- remove vppsys in clock document
- unregister clock when fail to add clock provider

Chun-Jie Chen (3):
  clk: mediatek: Add error handle when fail to register clock provider
  dt-bindings: ARM: Mediatek: Remove vppsys in MT8195 clock document
  clk: mediatek: Integrate vppsys with mtk-mmsys in MT8195

 .../arm/mediatek/mediatek,mt8195-clock.yaml   | 16 -------
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c  |  5 ++-
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c  |  5 ++-
 drivers/clk/mediatek/clk-mt8195-topckgen.c    |  5 ++-
 drivers/clk/mediatek/clk-mt8195-vdo0.c        |  5 ++-
 drivers/clk/mediatek/clk-mt8195-vdo1.c        |  5 ++-
 drivers/clk/mediatek/clk-mt8195-vpp0.c        | 42 ++++++++++++-------
 drivers/clk/mediatek/clk-mt8195-vpp1.c        | 42 ++++++++++++-------
 drivers/clk/mediatek/clk-mtk.c                | 14 ++++++-
 drivers/clk/mediatek/clk-mtk.h                |  1 +
 10 files changed, 89 insertions(+), 51 deletions(-)

--
2.18.0

