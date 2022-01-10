Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF4F489A79
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbiAJNrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:47:13 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:7529 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233794AbiAJNrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:47:12 -0500
X-IronPort-AV: E=Sophos;i="5.88,277,1635174000"; 
   d="scan'208";a="106558126"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Jan 2022 22:47:11 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id ED6F242E3548;
        Mon, 10 Jan 2022 22:47:09 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 01/12] dt-bindings: power: renesas,rzg2l-sysc: Document RZ/V2L SoC
Date:   Mon, 10 Jan 2022 13:46:48 +0000
Message-Id: <20220110134659.30424-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biju Das <biju.das.jz@bp.renesas.com>

Add DT binding documentation for SYSC controller found on RZ/V2L SoC.
SYSC controller found on the RZ/V2L SoC is almost identical to one found
on the RZ/G2L SoC's only difference being that the RZ/V2L has an
additional register to control the DRP-AI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
---
v1->v2
* Included ACK from ROB
---
 .../devicetree/bindings/power/renesas,rzg2l-sysc.yaml      | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/renesas,rzg2l-sysc.yaml b/Documentation/devicetree/bindings/power/renesas,rzg2l-sysc.yaml
index 84ddc772b003..bb433e75a0ee 100644
--- a/Documentation/devicetree/bindings/power/renesas,rzg2l-sysc.yaml
+++ b/Documentation/devicetree/bindings/power/renesas,rzg2l-sysc.yaml
@@ -4,14 +4,14 @@
 $id: "http://devicetree.org/schemas/power/renesas,rzg2l-sysc.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
-title: Renesas RZ/G2L System Controller (SYSC)
+title: Renesas RZ/{G2L,V2L} System Controller (SYSC)
 
 maintainers:
   - Geert Uytterhoeven <geert+renesas@glider.be>
 
 description:
-  The RZ/G2L System Controller (SYSC) performs system control of the LSI and
-  supports following functions,
+  The RZ/{G2L,V2L} System Controller (SYSC) performs system control of the LSI
+  and supports following functions,
   - External terminal state capture function
   - 34-bit address space access function
   - Low power consumption control
@@ -21,6 +21,7 @@ properties:
   compatible:
     enum:
       - renesas,r9a07g044-sysc # RZ/G2{L,LC}
+      - renesas,r9a07g054-sysc # RZ/V2L
 
   reg:
     maxItems: 1
-- 
2.17.1

