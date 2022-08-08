Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6CA58C37A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 08:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236962AbiHHGq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 02:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236542AbiHHGqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 02:46:48 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B38112772;
        Sun,  7 Aug 2022 23:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659941207; x=1691477207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X47q7DThyrWu/kkT8n4MueOYo1D/I729fdsIdMKG9zk=;
  b=p2iJVroYzdNxtGlyOgLFWbG3MpfJrHzHFm/IDtdfBhFEVvH+RwHeL+r/
   DGVPL8ckkXB6II9kUdcn5fc/2q+sLRlMU/xi4+VcuEj6UX3aGbKnTw7xo
   Gxbz8O6cakOUcZc7ecq023NL5/C3xsvPKopFfkQAp4UH+bwINEAAAlaHA
   q5tnRW7yYaa4+IxdRSjFzoSiEpPEHXVAIFGjKUn135xurbxQbXTwJeNHd
   YIs9NjY0rVpQlKlKMtlUUkFc6uhHx81n1KUcpvhmJzR/ZxGYpUoxgvyZp
   lBpuXrNjConPIvA0fCgqV8mUQjX0LL8izsa7MCNyu8QKl5E5IhFo1rUfu
   g==;
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="107987926"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Aug 2022 23:46:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 7 Aug 2022 23:46:46 -0700
Received: from microchip-OptiPlex-5040.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Sun, 7 Aug 2022 23:46:42 -0700
From:   Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor.dooley@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <Valentina.FernandezAlanis@microchip.com>,
        Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
Subject: [PATCH v4 4/4] MAINTAINERS: add qspi to Polarfire SoC entry
Date:   Mon, 8 Aug 2022 12:16:03 +0530
Message-ID: <20220808064603.1174906-5-nagasuresh.relli@microchip.com>
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

