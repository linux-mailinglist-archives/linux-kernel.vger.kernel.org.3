Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D7C4C835C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 06:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbiCAFih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 00:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbiCAFib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 00:38:31 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BF441F91;
        Mon, 28 Feb 2022 21:37:47 -0800 (PST)
X-UUID: e1987f8a3a934cd3aecc0c7d20582f6d-20220301
X-UUID: e1987f8a3a934cd3aecc0c7d20582f6d-20220301
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 756417158; Tue, 01 Mar 2022 13:37:36 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 1 Mar 2022 13:37:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Mar 2022 13:37:34 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <runyang.chen@mediatek.com>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH V2 0/3] Add watchdog support for MT8186 SoC
Date:   Tue, 1 Mar 2022 13:37:30 +0800
Message-ID: <20220301053733.24755-1-rex-bc.chen@mediatek.com>
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

v2:
1. Squash [1] into [2] in v1.
2. Add tags of acked-by and reviewed-by.

[1]: [3/4] dt-bindings: reset: mt8186: add DSI reset bit for MMSYS
[2]: [2/4] dt-bindings: reset: mt8186: add toprgu reset-controller header file

v1:
1. Add mt8186-resets.h to define definition of reset bits.
2. Add wdt compatible for MT8186.

Rex-BC Chen (1):
  dt-bindings: watchdog: Add compatible for MediaTek MT8186

Runyang Chen (2):
  dt-bindings: reset: mt8186: add reset-controller header file
  watchdog: mediatek: mt8186: add wdt support

 .../devicetree/bindings/watchdog/mtk-wdt.txt  |  1 +
 drivers/watchdog/mtk_wdt.c                    |  6 ++++
 include/dt-bindings/reset/mt8186-resets.h     | 36 +++++++++++++++++++
 3 files changed, 43 insertions(+)
 create mode 100644 include/dt-bindings/reset/mt8186-resets.h

-- 
2.18.0

