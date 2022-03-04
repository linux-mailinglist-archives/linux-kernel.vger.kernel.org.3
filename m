Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20DF4CDC37
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241663AbiCDSTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241648AbiCDSTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:19:30 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E5391AD9;
        Fri,  4 Mar 2022 10:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646417916; x=1677953916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LnGVi4wQp+RSBULtW1beO+C3G4Ky2NJaGYf1CEN4/BU=;
  b=UJwnUgKhEhsRyCScifD5NWBWWYR7fVyiT+qfrR7VSOHQxSkSfk69xXSO
   U3Ry4I0hFEKmwxViaU30DZSSlDx2I6SPAvu6vlStJRLgCzl1mGGT903bh
   QR/5Km7eQ118+td9RGhD6e38ptqbZJLKTv9OPddoJQv3gWMLNRyoJCZyz
   Wk+vFUjZb6o3imzOLwHVUmkPHFcirPE54PCn3VxQcRzf+jHjOtd2hFiIE
   bTsuFLRjHCEk0hr3F4SesGDK/2VpZgv7gJTOFLgmGVdhfaUh7nAxfY5iL
   hnyDBniRJW9dbSNRY9Wfig5va8/7izz6NjnqCNMb2F2woa13D8lymntbq
   w==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="150898174"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 11:18:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 11:18:35 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 4 Mar 2022 11:18:32 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lars@metafoo.de>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH 6/6] ARM: configs: at91: sama7_defconfig: add MCHP PDMC and DMIC drivers
Date:   Fri, 4 Mar 2022 20:17:56 +0200
Message-ID: <20220304181756.1894561-7-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304181756.1894561-1-codrin.ciubotariu@microchip.com>
References: <20220304181756.1894561-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable drivers needed for Microchip's PDMC and PDM microphones.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 arch/arm/configs/sama7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index 0368068e04d9..bc29badab890 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -138,6 +138,8 @@ CONFIG_SND_SOC_MIKROE_PROTO=m
 CONFIG_SND_MCHP_SOC_I2S_MCC=y
 CONFIG_SND_MCHP_SOC_SPDIFTX=y
 CONFIG_SND_MCHP_SOC_SPDIFRX=y
+CONFIG_SND_MCHP_SOC_PDMC=y
+CONFIG_SND_SOC_DMIC=y
 CONFIG_SND_SOC_PCM5102A=y
 CONFIG_SND_SOC_SPDIF=y
 CONFIG_SND_SIMPLE_CARD=y
-- 
2.32.0

