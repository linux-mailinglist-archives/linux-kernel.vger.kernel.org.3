Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66005822B3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiG0JF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiG0JFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:05:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C28E4333B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658912753; x=1690448753;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YkUS4VT+nAqLrUuOLwypQQDGOIVF2886Ab8ulGKy5xk=;
  b=bnWer+p8WLXHv/wMxCqN+SlZ4g6y7U6fuKMRvUfkilaq7qlsSCGe1M8V
   LE6BWcQPZZmGXHmfYltYt3Vq3x44kA1UHUXbM5z4W9fuQnAc5nmbfi6e9
   E/TF9HflYwYKxamwoZNprnC+fuLtDebVBN7QI6pVhQ+QtjDGBD6as3GZs
   rUlx6krmXMXunPVemuhWvV7QZMUW9xdCBvVMDGKeWmDElpecpGI6IdGDe
   DoGxpRnaGKpJ+tewygSFEpt8skB8cFOW9YK6/eP44Smo7NZEPeLZRVf/V
   5KG18CgMO4cyAXAwKWcJ/sJWrxZtJXG5SYvOMPSRv62TiiHG2iA8JqHmz
   A==;
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="169710941"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2022 02:05:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 27 Jul 2022 02:05:50 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 27 Jul 2022 02:05:48 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 0/2] ASoC: atmel: one fix and one cleanup
Date:   Wed, 27 Jul 2022 12:08:12 +0300
Message-ID: <20220727090814.2446111-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
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

Hi,

The series adds one fix for mchp-spdifrx and one cleanups for
mchp-spdifrx and mchp-spdifrx drivers.

Thank you,
Claudiu Beznea

Changes in v3:
- changed cover letter title s/few/one, s/cleanups/cleanup
- fix compilation error and warnings
- keep only patch 1/5 and patch 3/5 from previous version as the rest
  of them were integrated

Changes in v2:
- s/tag/tab in the title of patch 2/5

Claudiu Beznea (2):
  ASoC: mchp-spdifrx: disable end of block interrupt on failures
  ASoC: mchp-spdiftx: remove references to mchp_i2s_caps

 sound/soc/atmel/mchp-spdifrx.c | 9 ++++++---
 sound/soc/atmel/mchp-spdiftx.c | 8 --------
 2 files changed, 6 insertions(+), 11 deletions(-)

-- 
2.34.1

