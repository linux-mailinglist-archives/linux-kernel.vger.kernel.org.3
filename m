Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D935250A0B4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356410AbiDUN0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244468AbiDUN0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:26:01 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E018636B7E;
        Thu, 21 Apr 2022 06:23:10 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23LDMnHp065617;
        Thu, 21 Apr 2022 08:22:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650547369;
        bh=EP8k7XQCY/wqajI+hdZuojwN/DMymzB4exFYpj/ZWQQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=L1fTwpTanY6JyIPxSYQvPVzx7x+VhaVsItBE+1KDzkNeUbX0f24emrukkc3kdVWPO
         jglFPiIZHLboGLaenn1BHrkuU3S7YV0IC16WDU/6u/mLu4jH1EsIWU+C/o7Zr0vjbU
         cCG20GhL+BMivwtDJdqm110KPS3VEZyUXTdNcBss=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23LDMnjR070373
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Apr 2022 08:22:49 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 21
 Apr 2022 08:22:48 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 21 Apr 2022 08:22:48 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23LDMmDU078721;
        Thu, 21 Apr 2022 08:22:48 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jayesh Choudhary <j-choudhary@ti.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Jai Luthra <j-luthra@ti.com>
Subject: [PATCH 2/3] ASoC: ti: davinci-mcasp: Add dma-type for bcdma
Date:   Thu, 21 Apr 2022 18:52:23 +0530
Message-ID: <20220421132224.8601-3-j-luthra@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220421132224.8601-1-j-luthra@ti.com>
References: <20220421132224.8601-1-j-luthra@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jayesh Choudhary <j-choudhary@ti.com>

Set DMA type for ti-bcdma controller for AM62-SK.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 sound/soc/ti/davinci-mcasp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index 2c146b91fca3..377be2e2b6ee 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -2047,6 +2047,8 @@ static int davinci_mcasp_get_dma_type(struct davinci_mcasp *mcasp)
 		return PCM_SDMA;
 	else if (strstr(tmp, "udmap"))
 		return PCM_UDMA;
+	else if (strstr(tmp, "bcdma"))
+		return PCM_UDMA;
 
 	return PCM_EDMA;
 }
-- 
2.17.1

