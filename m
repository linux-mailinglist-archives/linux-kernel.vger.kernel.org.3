Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76757495755
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 01:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378392AbiAUA0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 19:26:32 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:46707 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230379AbiAUA0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 19:26:31 -0500
X-IronPort-AV: E=Sophos;i="5.88,303,1635174000"; 
   d="scan'208";a="107746441"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Jan 2022 09:26:29 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2B3BE4164C09;
        Fri, 21 Jan 2022 09:26:26 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3] media: dt-bindings: media: renesas,csi2: Update data-lanes property
Date:   Fri, 21 Jan 2022 00:26:22 +0000
Message-Id: <20220121002622.30359-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CSI-2 (CSI4LNK0) on R-Car and RZ/G2 supports 4-lane mode which is already
handled by rcar-csi2.c driver. This patch updates the data-lanes property
to describe the same.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
v2->v3
* Dropped uniqueItems constraint as a patch [0] to schema already exists.
* Included RB tag from Jacopo

[0] https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20211223191615.17803-13-p.yadav@ti.com/

v1->v2
* Dropped const items
* Added uniqueItems

v1:
https://lore.kernel.org/lkml/20220118163413.ge2b4g75yhfqvq3x@uno.localdomain/T/
---
 Documentation/devicetree/bindings/media/renesas,csi2.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/renesas,csi2.yaml b/Documentation/devicetree/bindings/media/renesas,csi2.yaml
index e6a036721082..b520d6c5c102 100644
--- a/Documentation/devicetree/bindings/media/renesas,csi2.yaml
+++ b/Documentation/devicetree/bindings/media/renesas,csi2.yaml
@@ -67,7 +67,10 @@ properties:
                 maxItems: 1
 
               data-lanes:
-                maxItems: 1
+                minItems: 1
+                maxItems: 4
+                items:
+                  maximum: 4
 
             required:
               - clock-lanes
-- 
2.17.1

