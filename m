Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A685A4E63
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiH2NmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiH2NmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:42:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C57F8FD50;
        Mon, 29 Aug 2022 06:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661780537; x=1693316537;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Dm77TZdDOsxyEUyf3mIDyCgCwIVjRlmyzDrQ7gf/weQ=;
  b=syv2Uck76t7FxDhBNmfPDEbPS08tHJ5EcpFUYNvzdbo7hmlH9OeulUve
   eKcyEBwbNlQ2Uwef3d+A2mog2JkdnBiCprgLBvHYpbHiITn1nKwISPGgw
   THgNxicjc3jzPaCTNsa+yJtv0NC2MUZNR9otA3c8kw+G4PwLtgkkUCvqF
   Fp4TGNwIOLKwCvqAxAxBSYhfkZZDD4/TPYQBUxUdqaTPHlVVngkl7aByt
   Clr6SbUM/bOIhiDa9JbhoOah6Z+ErZ1sC18ajisT9Z46721WghO1ZeppY
   LCwTmTbWR5iq/n4UE3DSFUEhdHdyUWNruzFa/u2N/kM4RFh6g2IKyi68+
   A==;
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="174633417"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Aug 2022 06:42:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 29 Aug 2022 06:42:16 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Mon, 29 Aug 2022 06:42:13 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     Cyril Jean <cyril.jean@microchip.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: riscv: update microchip.yaml's maintainership
Date:   Mon, 29 Aug 2022 14:41:04 +0100
Message-ID: <20220829134102.1248504-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
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

Daire and I are the platform maintainers for Microchip's RISC-V
FPGAs. Update the maintainers in microchip.yaml to reflect this and
explicitly add the binding to the SoC's MAINTAINERS entry.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Two patches seemed overkill for this, but scream and I will split them.
I figured I would take this for 6.1 myself on top of my other changes
to microchip.yaml.
---
 Documentation/devicetree/bindings/riscv/microchip.yaml | 4 ++--
 MAINTAINERS                                            | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
index 37f97ee4fe46..9eaa21769457 100644
--- a/Documentation/devicetree/bindings/riscv/microchip.yaml
+++ b/Documentation/devicetree/bindings/riscv/microchip.yaml
@@ -7,8 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Microchip PolarFire SoC-based boards
 
 maintainers:
-  - Cyril Jean <Cyril.Jean@microchip.com>
-  - Lewis Hanly <lewis.hanly@microchip.com>
+  - Conor Dooley <conor.dooley@microchip.com>
+  - Daire McNamara <daire.mcnamara@microchip.com>
 
 description:
   Microchip PolarFire SoC-based boards
diff --git a/MAINTAINERS b/MAINTAINERS
index cc549debe20c..7d788e064390 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17572,6 +17572,7 @@ F:	Documentation/devicetree/bindings/i2c/microchip,corei2c.yaml
 F:	Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.yaml
 F:	Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
 F:	Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml
+F:	Documentation/devicetree/bindings/riscv/microchip.yaml
 F:	Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml
 F:	Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
 F:	Documentation/devicetree/bindings/usb/microchip,mpfs-musb.yaml
-- 
2.36.1

