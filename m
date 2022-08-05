Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F80A58A59E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 07:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbiHEFbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 01:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiHEFbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 01:31:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A1F6E8A3;
        Thu,  4 Aug 2022 22:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659677463; x=1691213463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FFTn/WUSuy30fLyfUURXS0QSux6TbJVEEEAo7+XIsjw=;
  b=idhOY7ymXbWyEowSmMk8JW2QyVAd6dNiG69BQey8LABTHbqJaIYpCBjG
   Ud6ehlWF3eicGPSZRBqXdA4x9oCn58Bi0i2+l3luDUJGf72v+vpirgUkr
   dJ0IHA+jyfHYbR6p29ZO/mJXTZqFpWiOIeax2WSXXFylG+v/qYtYB9lP/
   LBkX04uaUFuTH5qj9/02Gks56v1rp2qn9oLg8KrSR0qyJ9UIi/q2HhUSZ
   ZDStm6vqFICrqiGEMOWbmzyJbZbeolWt7i835N39XPoMvb4x9+0SY98DT
   eqR9+aiec4/R5A3bWxWYsuhu6pkRhbfqA0O/Gn1dFq2ZFXXVSbtces9uR
   g==;
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="107686232"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Aug 2022 22:30:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 4 Aug 2022 22:30:55 -0700
Received: from microchip-OptiPlex-5040.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Thu, 4 Aug 2022 22:30:52 -0700
From:   Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor.dooley@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <Valentina.FernandezAlanis@microchip.com>,
        Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
Subject: [PATCH v3 1/4] spi: dt-binding: document microchip coreQSPI
Date:   Fri, 5 Aug 2022 11:00:16 +0530
Message-ID: <20220805053019.996484-2-nagasuresh.relli@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805053019.996484-1-nagasuresh.relli@microchip.com>
References: <20220805053019.996484-1-nagasuresh.relli@microchip.com>
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

Add microchip coreQSPI compatible string and update the title/description
to reflect this addition.

Signed-off-by: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
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

