Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAF8599BFE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348927AbiHSM2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiHSM2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:28:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD45243;
        Fri, 19 Aug 2022 05:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660912090; x=1692448090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qCodOvHAAWV9jjEol1BPCacoYzYl6MK5PiY5naSU1RI=;
  b=zLSA7ppsB2z7Xsfslg9bagwvFm7rn1HKnKTTnObFdAGT8PBz4H7wFlem
   BSp2Q4ZNJd5wJlWzjRUJYrZ9jq/2qtaLjgmeqbgleZ1vMtnlfOA1Zm9cZ
   9xewXI7VFghgP+D0alic2OZ7LvqCxr86znifJxJYN/VF4JsX28tNvJafn
   mQeHtGnYitYqOUm4Oc3zCBYKgDwHgYoJ3R0mcK74+zYYwI9DUXS7xgAUd
   7zXi2P5VLArfPH1YeX30gxJSnKJEtpizEjTlDuHIKmSVmCkgj6SOc3KQx
   xl2EWgv1jvhg8RlZXmlb4l6Cjk/0wG/tvbyNE6U11N0/7AM5FtR8IU9Yy
   A==;
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="176919046"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Aug 2022 05:28:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 19 Aug 2022 05:28:08 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Fri, 19 Aug 2022 05:28:06 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: [PATCH 1/6] dt-bindings: clk: rename mpfs-clkcfg binding
Date:   Fri, 19 Aug 2022 13:22:55 +0100
Message-ID: <20220819122259.183600-2-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220819122259.183600-1-conor.dooley@microchip.com>
References: <20220819122259.183600-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The filename for a binding is supposed to match the first compatible,
but the mpfs-clkcfg file did not follow this policy. Rename it to match
so that when other mpfs clock bindings are added things make more sense.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../clock/{microchip,mpfs.yaml => microchip,mpfs-clkcfg.yaml}   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/clock/{microchip,mpfs.yaml => microchip,mpfs-clkcfg.yaml} (96%)

diff --git a/Documentation/devicetree/bindings/clock/microchip,mpfs.yaml b/Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml
similarity index 96%
rename from Documentation/devicetree/bindings/clock/microchip,mpfs.yaml
rename to Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml
index 016a4f378b9b..212228734ffd 100644
--- a/Documentation/devicetree/bindings/clock/microchip,mpfs.yaml
+++ b/Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/clock/microchip,mpfs.yaml#
+$id: http://devicetree.org/schemas/clock/microchip,mpfs-clkcfg.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Microchip PolarFire Clock Control Module Binding
-- 
2.36.1

