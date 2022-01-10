Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B3C489E09
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237944AbiAJRKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:10:14 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:44912 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237934AbiAJRKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:10:12 -0500
X-UUID: 6368be640fcc4341b339ff509a40f23c-20220111
X-UUID: 6368be640fcc4341b339ff509a40f23c-20220111
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1733057388; Tue, 11 Jan 2022 01:10:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 11 Jan 2022 01:10:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 11 Jan 2022 01:10:07 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Miles Chen <miles.chen@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] clk: mediatek: export mtk_clk_simple_probe
Date:   Tue, 11 Jan 2022 01:09:57 +0800
Message-ID: <20220110171000.24316-2-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220110171000.24316-1-miles.chen@mediatek.com>
References: <20220110171000.24316-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export mtk_clk_simple_probe() to support mt8192 module build.

Cc: Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mtk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 8d5791b3f460..807dea08d7de 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -332,5 +332,6 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 	mtk_free_clk_data(clk_data);
 	return r;
 }
+EXPORT_SYMBOL_GPL(mtk_clk_simple_probe);
 
 MODULE_LICENSE("GPL");
-- 
2.18.0

