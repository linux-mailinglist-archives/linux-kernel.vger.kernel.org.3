Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2FF523F91
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 23:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348334AbiEKVlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 17:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348261AbiEKVln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 17:41:43 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CDA5B3DB;
        Wed, 11 May 2022 14:41:42 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nou5O-0005NU-Ka; Wed, 11 May 2022 23:41:34 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, mick@ics.forth.gr, samuel@sholland.org,
        cmuellner@linux.com, philipp.tomsich@vrull.eu, robh+dt@kernel.org,
        krzk+dt@kernel.org, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 1/3] dt-bindings: riscv: document cbom-block-size
Date:   Wed, 11 May 2022 23:41:30 +0200
Message-Id: <20220511214132.2281431-2-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511214132.2281431-1-heiko@sntech.de>
References: <20220511214132.2281431-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Zicbom operates on a block-size defined for the cpu-core,
which does not necessarily match other cache-sizes used.

So add the necessary property for the system to know the core's
block-size.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index d632ac76532e..b179bfd155a3 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -63,6 +63,13 @@ properties:
       - riscv,sv48
       - riscv,none
 
+  riscv,cbom-block-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Blocksize in bytes for the Zicbom cache operations. The block
+      size is a property of the core itself and does not necessarily
+      match other software defined cache sizes.
+
   riscv,isa:
     description:
       Identifies the specific RISC-V instruction set architecture
-- 
2.35.1

