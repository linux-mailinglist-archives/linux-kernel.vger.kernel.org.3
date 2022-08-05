Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48BB58A5A4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 07:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbiHEFbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 01:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbiHEFbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 01:31:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EC872ECD;
        Thu,  4 Aug 2022 22:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659677469; x=1691213469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X47q7DThyrWu/kkT8n4MueOYo1D/I729fdsIdMKG9zk=;
  b=rVYPrL5qxVv3Q6unLblJnLAtc3cV9ybKdHXYVh5aGjrGtJIAOOT3l+Yi
   vG1IUhKUqz5eJ3qdmDYREUXC6VjO5EvyV4RKUdCKAQc4Nh1qVOCZcGF2O
   pl0An+DUMdUV216MBsj78YptrWr2HB2WiEoKx6aB0R3GK6c6qyRiT4YlT
   57Jz2aI9x3ctMRADDvA51TbAq52zuTmg726Be+J/uJCHYlrIO49z1/Fvh
   BD2kQvUYbKG1KWkw/oldd5ISAuyS7YpDyVvReKMoSctUhhhcl76ojOfTD
   D56fAzQEQCyhj/bQOVrMSYh+qf4JpLsyNc2tx5V3mJDCqpD6PbJIaz+xl
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="185227164"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Aug 2022 22:31:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 4 Aug 2022 22:31:05 -0700
Received: from microchip-OptiPlex-5040.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Thu, 4 Aug 2022 22:31:02 -0700
From:   Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor.dooley@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <Valentina.FernandezAlanis@microchip.com>,
        Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
Subject: [PATCH v3 4/4] MAINTAINERS: add qspi to Polarfire SoC entry
Date:   Fri, 5 Aug 2022 11:00:19 +0530
Message-ID: <20220805053019.996484-5-nagasuresh.relli@microchip.com>
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

Add the qspi driver to existing Polarfire SoC entry.

Signed-off-by: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 295ca16a415b..0329dca23fe2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17146,6 +17146,7 @@ S:	Supported
 F:	arch/riscv/boot/dts/microchip/
 F:	drivers/mailbox/mailbox-mpfs.c
 F:	drivers/soc/microchip/
+F:	drivers/spi/spi-microchip-core-qspi.c
 F:	drivers/spi/spi-microchip-core.c
 F:	include/soc/microchip/mpfs.h
 
-- 
2.25.1

