Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A0958C376
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 08:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbiHHGqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 02:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbiHHGql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 02:46:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5751C101CA;
        Sun,  7 Aug 2022 23:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659941200; x=1691477200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k48ZxfqlHPtjRTRclgEvPB8AlCuk8oX0sn265mzICoM=;
  b=KmBMRmqDrvm2UlLJLgA1XpCfrdEznBg3ELMwNK6Ano053xmLsc5MtbhK
   FNBnpPEtDigfGYreD6mGJDPxLyxf5SCFEHHN2CvogU/XsyGnv1nvu0GLJ
   U1wkH+XMyvdszG5FHc0wvFd5HLVQCTjf7Hr1IwdPCP8GcmuchTSPJMT2p
   kW8JM21oVXIVGNO0eNRiSsVkHlmQuNrY6n0NpU/hrwBo2P+5YlX9szwvb
   SyMC/Zx9eGjb+R9hfEmCanO0UfXOyW9cAPXySaB1Qcqo0G88Vcs5vSWO0
   1amZgKg8HwJUkt6i0pCaystKbsF31u7hMtop26aSGCoGC7SsifMUtQMMJ
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="107987890"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Aug 2022 23:46:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 7 Aug 2022 23:46:38 -0700
Received: from microchip-OptiPlex-5040.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Sun, 7 Aug 2022 23:46:35 -0700
From:   Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor.dooley@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <Valentina.FernandezAlanis@microchip.com>,
        Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 2/4] spi: dt-binding: add coreqspi as a fallback for mpfs-qspi
Date:   Mon, 8 Aug 2022 12:16:01 +0530
Message-ID: <20220808064603.1174906-3-nagasuresh.relli@microchip.com>
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

Microchip's PolarFire SoC QSPI IP core is based on coreQSPI,
so add coreqspi as a fallback to mpfs-qspi.

Signed-off-by: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/spi/microchip,mpfs-spi.yaml    | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
index a47d4923b51b..1051690e3753 100644
--- a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
@@ -18,10 +18,12 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - microchip,mpfs-spi
-      - microchip,mpfs-qspi
-      - microchip,coreqspi-rtl-v2 # FPGA QSPI
+    oneOf:
+      - items:
+          - const: microchip,mpfs-qspi
+          - const: microchip,coreqspi-rtl-v2
+      - const: microchip,coreqspi-rtl-v2 #FPGA QSPI
+      - const: microchip,mpfs-spi
 
   reg:
     maxItems: 1
-- 
2.25.1

