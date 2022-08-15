Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821EC593180
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242502AbiHOPQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239583AbiHOPQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:16:06 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CDD7FD0B;
        Mon, 15 Aug 2022 08:16:05 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,238,1654527600"; 
   d="scan'208";a="131484137"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 16 Aug 2022 00:16:04 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id BCA0A403965B;
        Tue, 16 Aug 2022 00:16:00 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Conor Dooley <Conor.Dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 2/8] dt-bindings: riscv: Add Andes AX45MP core to the list
Date:   Mon, 15 Aug 2022 16:14:45 +0100
Message-Id: <20220815151451.23293-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP
Single) from Andes. In preparation to add support for RZ/Five SoC add
the Andes AX45MP core to the list.

More details about Andes AX45MP core can be found here:
[0] http://www.andestech.com/en/products-solutions/andescore-processors/riscv-ax45mp/

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v1->v2
* Included ack from Krzysztof
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 2a1c5ae5b0aa..1681767790c5 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -27,6 +27,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - andestech,ax45mp
               - canaan,k210
               - sifive,bullet0
               - sifive,e5
-- 
2.25.1

