Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81FF14707B5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244822AbhLJR4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:56:15 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:50114 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244777AbhLJR4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:56:09 -0500
X-UUID: babdb047d42a4ca28c1e225bf01d50c6-20211211
X-UUID: babdb047d42a4ca28c1e225bf01d50c6-20211211
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1950574557; Sat, 11 Dec 2021 01:52:32 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Dec 2021 01:52:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Dec 2021 01:52:31 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Flora Fu <flora.fu@mediatek.com>,
        JB Tsai <jb.tsai@mediatek.com>
Subject: [PATCH 02/12] dt-bindings: remoteproc: mediatek: Add MT8195 in apu rproc
Date:   Sat, 11 Dec 2021 01:52:13 +0800
Message-ID: <20211210175223.31131-3-flora.fu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211210175223.31131-1-flora.fu@mediatek.com>
References: <20211210175223.31131-1-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding description for the MT8195 remote processor.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>

---
 .../devicetree/bindings/remoteproc/mediatek,apu-rv.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/mediatek,apu-rv.yaml b/Documentation/devicetree/bindings/remoteproc/mediatek,apu-rv.yaml
index c390b85040eb..cb945bc33318 100644
--- a/Documentation/devicetree/bindings/remoteproc/mediatek,apu-rv.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/mediatek,apu-rv.yaml
@@ -22,6 +22,7 @@ properties:
     items:
       - enum:
           - mediatek,mt8192-apusys-rv
+          - mediatek,mt8195-apusys-rv
       - const: simple-mfd
 
   reg:
-- 
2.18.0

