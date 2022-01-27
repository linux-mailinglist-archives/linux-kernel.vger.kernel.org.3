Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9233049E5B7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242985AbiA0PRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:17:17 -0500
Received: from out28-169.mail.aliyun.com ([115.124.28.169]:54771 "EHLO
        out28-169.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242890AbiA0PRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:17:10 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.5467414|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.023987-0.000137044-0.975876;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=icenowy@nucleisys.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.Mj85P-f_1643296625;
Received: from ice-e5v2.lan(mailfrom:icenowy@nucleisys.com fp:SMTPD_---.Mj85P-f_1643296625)
          by smtp.aliyun-inc.com(33.45.46.134);
          Thu, 27 Jan 2022 23:17:06 +0800
From:   Icenowy Zheng <icenowy@nucleisys.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, Icenowy Zheng <icenowy@nucleisys.com>
Subject: [PATCH 06/12] dt-bindings: serial: add compatible string for Nuclei DemoSoC UART
Date:   Thu, 27 Jan 2022 23:16:41 +0800
Message-Id: <20220127151647.2375449-7-icenowy@nucleisys.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127151647.2375449-1-icenowy@nucleisys.com>
References: <20220127151647.2375449-1-icenowy@nucleisys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nuclei DemoSoC design integrates the UART controller from SiFive.

Add a compatible string for it.

Signed-off-by: Icenowy Zheng <icenowy@nucleisys.com>
---
 Documentation/devicetree/bindings/serial/sifive-serial.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.yaml b/Documentation/devicetree/bindings/serial/sifive-serial.yaml
index 09aae43f65a7..329341a3648f 100644
--- a/Documentation/devicetree/bindings/serial/sifive-serial.yaml
+++ b/Documentation/devicetree/bindings/serial/sifive-serial.yaml
@@ -21,6 +21,7 @@ properties:
           - sifive,fu540-c000-uart
           - sifive,fu740-c000-uart
           - canaan,k210-uarths
+          - nuclei,demosoc-uart
       - const: sifive,uart0
 
     description:
-- 
2.30.2

