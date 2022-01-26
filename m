Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F2349C5EA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238842AbiAZJMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:12:43 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:37706 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230488AbiAZJMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:12:41 -0500
X-UUID: c8df4e01a67146da9e049773fb53051c-20220126
X-UUID: c8df4e01a67146da9e049773fb53051c-20220126
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <guochun.mao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1566007041; Wed, 26 Jan 2022 17:12:37 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 26 Jan 2022 17:12:36 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Jan 2022 17:12:35 +0800
From:   <guochun.mao@mediatek.com>
To:     Mark Brown <broonie@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Bayi Cheng <bayi.cheng@mediatek.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Bin Zhang <bin.zhang@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <project_global_chrome_upstream_group@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Guochun Mao <guochun.mao@mediatek.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] spi: spi-mtk-nor: make some internal variables static
Date:   Wed, 26 Jan 2022 17:11:59 +0800
Message-ID: <20220126091159.27513-1-guochun.mao@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guochun Mao <guochun.mao@mediatek.com>

Variables mtk_nor_caps_mt8173, mtk_nor_caps_mt8186 and
mtk_nor_caps_mt8192 are not declared.
Make them static.

Fixes: 5b177234e9fd ("spi: spi-mtk-nor: improve device table for adding more capabilities")
Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/spi/spi-mtk-nor.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 455b4dcb26e9..94fb09696677 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -770,17 +770,17 @@ static const struct spi_controller_mem_ops mtk_nor_mem_ops = {
 	.exec_op = mtk_nor_exec_op
 };
 
-const struct mtk_nor_caps mtk_nor_caps_mt8173 = {
+static const struct mtk_nor_caps mtk_nor_caps_mt8173 = {
 	.dma_bits = 32,
 	.extra_dummy_bit = 0,
 };
 
-const struct mtk_nor_caps mtk_nor_caps_mt8186 = {
+static const struct mtk_nor_caps mtk_nor_caps_mt8186 = {
 	.dma_bits = 32,
 	.extra_dummy_bit = 1,
 };
 
-const struct mtk_nor_caps mtk_nor_caps_mt8192 = {
+static const struct mtk_nor_caps mtk_nor_caps_mt8192 = {
 	.dma_bits = 36,
 	.extra_dummy_bit = 0,
 };
-- 
2.25.1

