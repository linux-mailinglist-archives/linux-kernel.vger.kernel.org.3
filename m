Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96DF481BCE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 12:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239062AbhL3Lta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 06:49:30 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:55988 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239038AbhL3Lt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 06:49:29 -0500
X-UUID: a912f40f94644450b08fa19fa427abd9-20211230
X-UUID: a912f40f94644450b08fa19fa427abd9-20211230
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 598780038; Thu, 30 Dec 2021 19:49:24 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 30 Dec 2021 19:49:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 30 Dec 2021 19:49:23 +0800
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>
Subject: [PATCH 2/2] dt-bindings: mediatek: add compatible for MT8186 pwrap
Date:   Thu, 30 Dec 2021 19:49:13 +0800
Message-ID: <20211230114913.9829-3-johnson.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211230114913.9829-1-johnson.wang@mediatek.com>
References: <20211230114913.9829-1-johnson.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds dt-binding documentation of pwrap for Mediatek MT8186
SoCs Platform.

Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
---
 Documentation/devicetree/bindings/soc/mediatek/pwrap.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
index d74a7a5ae9f2..214a34633824 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
@@ -27,6 +27,7 @@ Required properties in pwrap device node.
 	"mediatek,mt8135-pwrap" for MT8135 SoCs
 	"mediatek,mt8173-pwrap" for MT8173 SoCs
 	"mediatek,mt8183-pwrap" for MT8183 SoCs
+	"mediatek,mt8186-pwrap" for MT8186 SoCs
 	"mediatek,mt8195-pwrap" for MT8195 SoCs
 	"mediatek,mt8516-pwrap" for MT8516 SoCs
 - interrupts: IRQ for pwrap in SOC
-- 
2.18.0

