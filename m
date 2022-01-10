Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE262489433
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241945AbiAJIue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:50:34 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:46282 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241894AbiAJIsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:48:55 -0500
X-UUID: bcbef3abeacb4e5dbf3380a906d351b4-20220110
X-UUID: bcbef3abeacb4e5dbf3380a906d351b4-20220110
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <guodong.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 133015203; Mon, 10 Jan 2022 16:48:47 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 10 Jan 2022 16:48:45 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 Jan 2022 16:48:45 +0800
From:   Guodong Liu <guodong.liu@mediatek.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Guodong Liu <guodong.liu@mediatek.com>
Subject: [PATCH v1 2/2] iio: adc: mt8186: Add compatible node for mt8186
Date:   Mon, 10 Jan 2022 16:48:41 +0800
Message-ID: <20220110084841.575-2-guodong.liu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220110084841.575-1-guodong.liu@mediatek.com>
References: <20220110084841.575-1-guodong.liu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds mt8186 compatible node.

Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>
---
 drivers/iio/adc/mt6577_auxadc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
index d4fccd52ef08..fb08d761589a 100644
--- a/drivers/iio/adc/mt6577_auxadc.c
+++ b/drivers/iio/adc/mt6577_auxadc.c
@@ -46,6 +46,11 @@ struct mt6577_auxadc_device {
 	const struct mtk_auxadc_compatible *dev_comp;
 };
 
+static const struct mtk_auxadc_compatible mt8186_compat = {
+	.sample_data_cali = false,
+	.check_global_idle = false,
+};
+
 static const struct mtk_auxadc_compatible mt8173_compat = {
 	.sample_data_cali = false,
 	.check_global_idle = true,
@@ -334,6 +339,7 @@ static const struct of_device_id mt6577_auxadc_of_match[] = {
 	{ .compatible = "mediatek,mt2712-auxadc", .data = &mt8173_compat},
 	{ .compatible = "mediatek,mt7622-auxadc", .data = &mt8173_compat},
 	{ .compatible = "mediatek,mt8173-auxadc", .data = &mt8173_compat},
+	{ .compatible = "mediatek,mt8186-auxadc", .data = &mt8186_compat},
 	{ .compatible = "mediatek,mt6765-auxadc", .data = &mt6765_compat},
 	{ }
 };
-- 
2.25.1

