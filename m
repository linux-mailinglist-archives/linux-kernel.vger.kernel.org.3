Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2310C49458A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 02:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358078AbiATB0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 20:26:11 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:17820 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1345516AbiATB0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 20:26:03 -0500
X-IronPort-AV: E=Sophos;i="5.88,300,1635174000"; 
   d="scan'208";a="107627278"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Jan 2022 10:26:01 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id B9A7C416F260;
        Thu, 20 Jan 2022 10:25:58 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2] media: dt-bindings: media: renesas,csi2: Update data-lanes property
Date:   Thu, 20 Jan 2022 01:25:53 +0000
Message-Id: <20220120012553.23295-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CSI-2 (CSI4LNK0) on R-Car and RZ/G2 supports 4-lane mode which is already
handled by rcar-csi2.c driver. This patch updates the data-lanes property
to describe the same.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi All,

Instead of adding uniqueItems:true into SoC binding doc's I think we could
add this in video-interfaces.yaml for data-lanes property. Any thoughts on this?

Cheers,
Prabhakar

v1->v2
* Dropped const items
* Added uniqueItems

v1:
https://lore.kernel.org/lkml/20220118163413.ge2b4g75yhfqvq3x@uno.localdomain/T/
---
 Documentation/devicetree/bindings/media/renesas,csi2.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/renesas,csi2.yaml b/Documentation/devicetree/bindings/media/renesas,csi2.yaml
index e6a036721082..a5a1b570025a 100644
--- a/Documentation/devicetree/bindings/media/renesas,csi2.yaml
+++ b/Documentation/devicetree/bindings/media/renesas,csi2.yaml
@@ -67,7 +67,11 @@ properties:
                 maxItems: 1
 
               data-lanes:
-                maxItems: 1
+                minItems: 1
+                maxItems: 4
+                uniqueItems: true
+                items:
+                  maximum: 4
 
             required:
               - clock-lanes
-- 
2.17.1

