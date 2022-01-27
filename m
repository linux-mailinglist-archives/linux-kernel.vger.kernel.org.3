Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC77B49E5AB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242912AbiA0PRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:17:11 -0500
Received: from out28-121.mail.aliyun.com ([115.124.28.121]:35882 "EHLO
        out28-121.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242859AbiA0PRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:17:04 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4093572|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.096465-0.000677537-0.902857;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=icenowy@nucleisys.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.Mj85Ozd_1643296619;
Received: from ice-e5v2.lan(mailfrom:icenowy@nucleisys.com fp:SMTPD_---.Mj85Ozd_1643296619)
          by smtp.aliyun-inc.com(33.45.46.134);
          Thu, 27 Jan 2022 23:17:00 +0800
From:   Icenowy Zheng <icenowy@nucleisys.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, Icenowy Zheng <icenowy@nucleisys.com>
Subject: [PATCH 03/12] dt-bindings: riscv: add compatible strings for Nuclei UX600 series
Date:   Thu, 27 Jan 2022 23:16:38 +0800
Message-Id: <20220127151647.2375449-4-icenowy@nucleisys.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127151647.2375449-1-icenowy@nucleisys.com>
References: <20220127151647.2375449-1-icenowy@nucleisys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nuclei UX600 series are 64-bit, MMU-equipped CPUs, which can run Linux.

Add compatible strings for these CPU cores.

Signed-off-by: Icenowy Zheng <icenowy@nucleisys.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index aa5fb64d57eb..f50f5c3dcc06 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -45,6 +45,13 @@ properties:
               - sifive,u54-mc
           - const: sifive,rocket0
           - const: riscv
+      - items:
+          - enum:
+              - nuclei,ux605
+              - nuclei,ux607
+              - nuclei,ux608
+          - const: nuclei,ux600
+          - const: riscv
       - const: riscv    # Simulator only
     description:
       Identifies that the hart uses the RISC-V instruction set
-- 
2.30.2

