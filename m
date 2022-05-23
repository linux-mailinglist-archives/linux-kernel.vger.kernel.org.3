Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293FA530D80
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiEWJYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbiEWJY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:24:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33C14839F
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653297865; x=1684833865;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ovfG+iUqK4g8+tNFFLcbn4GufljfmeMEgiuNaE//12w=;
  b=NOXtloHSMRiJ9pTtfI1d9JPVaxqhuFovmq/an/10HIpOz4pKRB7Vhieq
   n/cBfRzN3m9ooF87W8zAg7wxw9wcr7iPn0SOhojhs/mHaxnzEV+O/xqd4
   ZOZ2O1bQewlzam78vYBQJ23BHK6ndDnPFL4dUdfFAaUoUQm6YxPgnINMD
   ZUCE6u0CeNmK/MR1hiojonl2RL48125aqi1mMibM339jc/B//GGSUstex
   ZiGZIEPPu2tcNwZ3gNgpdUzrl/qQ7nz+oGKihbj1f6YazVNjnn1aDIKMX
   iyrj/7pX4jXfBhno4zWMnntvPXWgETUfl+6OLKpocK+RKC3dH2TLXmWx9
   A==;
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="160174276"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 May 2022 02:24:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 23 May 2022 02:24:24 -0700
Received: from ROB-ULT-M18063.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 23 May 2022 02:24:22 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>
CC:     <sboyd@kernel.org>, <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 0/3] ARM: at91: pm: fix wakeup from RTC for ULP1
Date:   Mon, 23 May 2022 12:24:18 +0300
Message-ID: <20220523092421.317345-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Series fixes the wakeup from RTC alarm for ULP1 on SAM9X60 and SAMA7G5.
I kept them as 3 patches to be able to be backported to proper kernels.

Thank you,
Claudiu Beznea

Changes in v2:
- added patch with title
  "ARM: at91: pm: use proper compatibles for sama5d2's rtc"

Claudiu Beznea (3):
  ARM: at91: pm: use proper compatibles for sama5d2's rtc
  ARM: at91: pm: use proper compatibles for sam9x60's rtc and rtt
  ARM: at91: pm: use proper compatibles for sama7g5's rtc and rtt

 arch/arm/mach-at91/pm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.34.1

