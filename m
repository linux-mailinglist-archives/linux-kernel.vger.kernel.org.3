Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CCE46E50F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236011AbhLIJJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:09:22 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39916 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbhLIJIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:08:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 371B7B823BD;
        Thu,  9 Dec 2021 09:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D61EC341C3;
        Thu,  9 Dec 2021 09:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639040707;
        bh=nhM6FAfawSp8ox2QppOpEA1hlDsMTl6ElG2mFrppNuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pi3FOi8tsqETYnRRjfBniPDSm7WWwuh2BXmZtmg4NsI90xq2gcsT2bKUGBxGzcGsH
         9tupH6+02Yc9p1Q/7jt+Z7MkNUuRAe/uPGmBEcn/BLPlFAAXtikZuub8/0OUTQ8E7M
         xaRr90A5yJpV5/VeESbxmwAOJrLPtpPFPSVXQg+t/B5cGapy5/hsSTQ1Ze8JOP0b5Z
         PLNe8rVOe4uatuJb3IX27f1uNkye5sxFHN/Kb5A4cUJGw3vwErtKOkM92J4Acyw4yt
         4xSp620ESEK5wvR2Dr4PSzHXxGm01z6tPgau/j/IImDP1uRa04PK1HxNtnSJuGvPKF
         xQLAn0tEIDz/g==
From:   Roger Quadros <rogerq@kernel.org>
To:     miquel.raynal@bootlin.com, richard@nod.at
Cc:     vigneshr@ti.com, kishon@ti.com, nm@ti.com, tony@atomide.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 1/6] dt-bindings: mtd: ti,gpmc-nand: Add compatible for AM64 NAND
Date:   Thu,  9 Dec 2021 11:04:53 +0200
Message-Id: <20211209090458.24830-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209090458.24830-1-rogerq@kernel.org>
References: <20211209090458.24830-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM64 SoC contains the GPMC NAND controller. Add compatible for it.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml b/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
index beb26b9bcfb2..666ae4a78544 100644
--- a/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
@@ -16,7 +16,10 @@ description:
 
 properties:
   compatible:
-    const: ti,omap2-nand
+    items:
+      - enum:
+          - ti,am64-nand
+          - ti,omap2-nand
 
   reg:
     maxItems: 1
-- 
2.17.1

