Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2E658C37C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 08:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbiHHGqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 02:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiHHGqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 02:46:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF56101CF;
        Sun,  7 Aug 2022 23:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659941198; x=1691477198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sRrPvzZiZQPJlT6IXRX52Troeqlzp0guhOXogiccTGM=;
  b=VeXYnrSq0rh+A22y5YmCbZvNn0hpo33UbtMft0GO785yF8qprjaMj+Mm
   zWNWh5njjyaRNTNwMRsnmLHkQK69BD1Zq436vugo+LrFqlhtpqcrY/wrf
   lqxj0l5gFOa1xP3C2uFO7PQ1CBdDSITPhBSDVIrhFR0mjJLqLV+emS2pz
   r4Z4d2weJFTXPWkTf886rlpcfhK9L8JH0II0Pz4ASR8JJVRZOPdSwfl4J
   Kj7vBpfoHKrp5RSOTr6mhkHbIJhHLXovzXWF25A4RTLbe6PVoRAQTfFZy
   spmajUhcYhlAbxSXNob1nxY7LFp2+9dURXS4iRrs7sZZ2LPdUSD16hrcN
   w==;
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="107987869"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Aug 2022 23:46:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 7 Aug 2022 23:46:35 -0700
Received: from microchip-OptiPlex-5040.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Sun, 7 Aug 2022 23:46:31 -0700
From:   Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor.dooley@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <Valentina.FernandezAlanis@microchip.com>,
        Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/4] spi: dt-binding: document microchip coreQSPI
Date:   Mon, 8 Aug 2022 12:16:00 +0530
Message-ID: <20220808064603.1174906-2-nagasuresh.relli@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220808064603.1174906-1-nagasuresh.relli@microchip.com>
References: <20220808064603.1174906-1-nagasuresh.relli@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add microchip coreQSPI compatible string and update the title/description
to reflect this addition.

Signed-off-by: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/spi/microchip,mpfs-spi.yaml        | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
index 7326c0a28d16..a47d4923b51b 100644
--- a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
@@ -4,7 +4,11 @@
 $id: http://devicetree.org/schemas/spi/microchip,mpfs-spi.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Microchip MPFS {Q,}SPI Controller Device Tree Bindings
+title: Microchip FPGA {Q,}SPI Controllers
+
+description:
+  SPI and QSPI controllers on Microchip PolarFire SoC and the "soft"/
+  fabric IP cores they are based on
 
 maintainers:
   - Conor Dooley <conor.dooley@microchip.com>
@@ -17,6 +21,7 @@ properties:
     enum:
       - microchip,mpfs-spi
       - microchip,mpfs-qspi
+      - microchip,coreqspi-rtl-v2 # FPGA QSPI
 
   reg:
     maxItems: 1
-- 
2.25.1

