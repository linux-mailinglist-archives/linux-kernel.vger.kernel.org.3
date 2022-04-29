Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E977514710
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 12:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357709AbiD2Kp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 06:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357662AbiD2KpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 06:45:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E227C6EEE;
        Fri, 29 Apr 2022 03:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651228904; x=1682764904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yQ9QYB2JjFXnMYslA5NperKokygkNZy0pzOs2BM201E=;
  b=X02XlPlA5FCJoKGNVJOhCr58uNih96SMTDhXir9hi+0guSpq4MEh5eiJ
   bYisYvETpO2vfAZvd8AxwTw2JDzwnk1pYxGB72Y5ZmyNdhSqelVy7+L/T
   uVqX5njEATuW7052xR433RKcGTnn5FirOPe1dNFmaAhyYRbvfQV6rHVjn
   +QGgSJ/1LtIJPS5N7IvDcJCa6+ubytJCskr4ISEniYuXVEZEP5ytx0ggy
   RsosKxIDkA2c8BlcXssjOxpebr0h+KLgJx0il5/d7H7uJCKPoA1xHxq4Z
   OKM6vk1BAvTGNi70ZH9O4ozlh5cmT4TXK+CUnshsCSUpTFQNEr0CJ2AlR
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="171406907"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Apr 2022 03:41:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 29 Apr 2022 03:41:43 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 29 Apr 2022 03:41:41 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Cyril Jean <Cyril.Jean@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "Arnd Bergmann" <arnd@arndb.de>
Subject: [PATCH v1 6/8] dt-bindings: vendor-prefixes: add Sundance DSP
Date:   Fri, 29 Apr 2022 11:40:39 +0100
Message-ID: <20220429104040.197161-7-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220429104040.197161-1-conor.dooley@microchip.com>
References: <20220429104040.197161-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sundance DSP Inc. (https://www.sundancedsp.com/) is a supplier of
high-performance DSP and FPGA processor boards and I/O modules.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 01430973ecec..1d47a38c2a2e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1197,6 +1197,8 @@ patternProperties:
     description: Summit microelectronics
   "^sunchip,.*":
     description: Shenzhen Sunchip Technology Co., Ltd
+  "^sundance,.*":
+    description: Sundance DSP Inc.
   "^sunplus,.*":
     description: Sunplus Technology Co., Ltd.
   "^SUNW,.*":
-- 
2.35.2

