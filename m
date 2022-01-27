Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC32749E5B0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242895AbiA0PRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:17:14 -0500
Received: from out28-220.mail.aliyun.com ([115.124.28.220]:42813 "EHLO
        out28-220.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiA0PRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:17:08 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.510604|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.191371-0.00178411-0.806845;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=icenowy@nucleisys.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.Mj85P-L_1643296623;
Received: from ice-e5v2.lan(mailfrom:icenowy@nucleisys.com fp:SMTPD_---.Mj85P-L_1643296623)
          by smtp.aliyun-inc.com(33.45.46.134);
          Thu, 27 Jan 2022 23:17:04 +0800
From:   Icenowy Zheng <icenowy@nucleisys.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, Icenowy Zheng <icenowy@nucleisys.com>
Subject: [PATCH 05/12] dt-bindings: interrupt-controller: add compatible string for UX600 PLIC
Date:   Thu, 27 Jan 2022 23:16:40 +0800
Message-Id: <20220127151647.2375449-6-icenowy@nucleisys.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127151647.2375449-1-icenowy@nucleisys.com>
References: <20220127151647.2375449-1-icenowy@nucleisys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nuclei UX600 series CPU has an optional PLIC (recommended when running
Linux).

Add a compatible string for it.

Signed-off-by: Icenowy Zheng <icenowy@nucleisys.com>
---
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 28b6b17fe4b2..70f5bd6cb879 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -47,6 +47,7 @@ properties:
           - sifive,fu540-c000-plic
           - starfive,jh7100-plic
           - canaan,k210-plic
+          - nuclei,ux600-plic
       - const: sifive,plic-1.0.0
 
   reg:
-- 
2.30.2

