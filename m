Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D88F483B57
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 05:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbiADExa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 23:53:30 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:40548 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232860AbiADExa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 23:53:30 -0500
X-UUID: 0f55ffbb5e0f45cb9774ee8122d98023-20220104
X-UUID: 0f55ffbb5e0f45cb9774ee8122d98023-20220104
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2129823383; Tue, 04 Jan 2022 12:53:26 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 4 Jan 2022 12:53:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 4 Jan 2022 12:53:24 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        "Weiyi Lu" <weiyi.lu@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     John Crispin <john@phrozen.org>, Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH v8 1/3] dt-bindings: clock: mediatek: document clk bindings for mediatek mt7986 SoC
Date:   Tue, 4 Jan 2022 12:52:41 +0800
Message-ID: <20220104045243.21521-2-sam.shih@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220104045243.21521-1-sam.shih@mediatek.com>
References: <20220104045243.21521-1-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the binding documentation for topckgen, apmixedsys,
infracfg, and ethernet subsystem clocks.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Ryder Lee <ryder.lee@kernel.org>
---
v8: add a Reviewed-by tag
v7: exclude DTS changes in the patch series
v4: separate clock part into a single patch series

Original thread:
https://lore.kernel.org/linux-arm-kernel/20210914085137.31761-2-sam.shih@mediatek.com/

v3: Added an Acked-by tag
v2: remove compatiable string 'mt7986-sgmiisys'
---
---
 .../devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt    | 1 +
 .../devicetree/bindings/arm/mediatek/mediatek,ethsys.txt        | 1 +
 .../devicetree/bindings/arm/mediatek/mediatek,infracfg.txt      | 1 +
 .../devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt      | 2 ++
 .../devicetree/bindings/arm/mediatek/mediatek,topckgen.txt      | 1 +
 5 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
index ea827e8763de..3fa755866528 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
@@ -14,6 +14,7 @@ Required Properties:
 	- "mediatek,mt7622-apmixedsys"
 	- "mediatek,mt7623-apmixedsys", "mediatek,mt2701-apmixedsys"
 	- "mediatek,mt7629-apmixedsys"
+	- "mediatek,mt7986-apmixedsys"
 	- "mediatek,mt8135-apmixedsys"
 	- "mediatek,mt8167-apmixedsys", "syscon"
 	- "mediatek,mt8173-apmixedsys"
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
index 6b7e8067e7aa..0502db73686b 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
@@ -10,6 +10,7 @@ Required Properties:
 	- "mediatek,mt7622-ethsys", "syscon"
 	- "mediatek,mt7623-ethsys", "mediatek,mt2701-ethsys", "syscon"
 	- "mediatek,mt7629-ethsys", "syscon"
+	- "mediatek,mt7986-ethsys", "syscon"
 - #clock-cells: Must be 1
 - #reset-cells: Must be 1
 
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
index eb3523c7a7be..f66bd720571d 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
@@ -15,6 +15,7 @@ Required Properties:
 	- "mediatek,mt7622-infracfg", "syscon"
 	- "mediatek,mt7623-infracfg", "mediatek,mt2701-infracfg", "syscon"
 	- "mediatek,mt7629-infracfg", "syscon"
+	- "mediatek,mt7986-infracfg", "syscon"
 	- "mediatek,mt8135-infracfg", "syscon"
 	- "mediatek,mt8167-infracfg", "syscon"
 	- "mediatek,mt8173-infracfg", "syscon"
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt
index 30cb645c0e54..29ca7a10b315 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt
@@ -8,6 +8,8 @@ Required Properties:
 - compatible: Should be:
 	- "mediatek,mt7622-sgmiisys", "syscon"
 	- "mediatek,mt7629-sgmiisys", "syscon"
+	- "mediatek,mt7986-sgmiisys_0", "syscon"
+	- "mediatek,mt7986-sgmiisys_1", "syscon"
 - #clock-cells: Must be 1
 
 The SGMIISYS controller uses the common clk binding from
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
index 5ce7578cf274..b82422bb717f 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
@@ -14,6 +14,7 @@ Required Properties:
 	- "mediatek,mt7622-topckgen"
 	- "mediatek,mt7623-topckgen", "mediatek,mt2701-topckgen"
 	- "mediatek,mt7629-topckgen"
+	- "mediatek,mt7986-topckgen", "syscon"
 	- "mediatek,mt8135-topckgen"
 	- "mediatek,mt8167-topckgen", "syscon"
 	- "mediatek,mt8173-topckgen"
-- 
2.29.2

