Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB30257FF82
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 15:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbiGYNHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 09:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiGYNHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 09:07:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFB1B8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 06:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658754424; x=1690290424;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4MVD07uVz8TokT7Qhzd/sDyjjIjUsb7epkzs9go0QoM=;
  b=EYet1Z7/QTwjqIJcsD1qZusCdtqxE8TGXc9ICJDtz9sLJ8lpFSw8xbXz
   DcRWEr7L9fkMH+vzaBH4sxQwK5/sqLfGwaO9BztBN8Q8Bxbr+Ksn1IMiB
   T3Wy1xX3FakCakvq7UydIhtxy0I5LiWZ/zPfYrx3FJ1h8ra/xdMr24Occ
   yi3vxzAS0DDvqVK70mqOXnkYRAQYGogSvaqCzGXEUl5r97FyosB7/g6/q
   l0Pp/Yl5rBmfio9O68JLMqjV6343ijULOFAaVyTCZI0XyeGAL8GH31xR+
   6X6Y9ZhC0jd9k4y/SkjSXdM4yA823ZtEfQeVXZr9vBkxwE+UHnJKQJtKO
   w==;
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="106005848"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jul 2022 06:07:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 25 Jul 2022 06:07:02 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 25 Jul 2022 06:07:00 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 0/5] ASoC: atmel: one fix and few cleanups
Date:   Mon, 25 Jul 2022 16:09:20 +0300
Message-ID: <20220725130925.1781791-1-claudiu.beznea@microchip.com>
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

The series adds one fix for mchp-spdifrx and few cleanups for
mchp-spdifrx and mchp-spdifrx drivers.

Thank you,
Claudiu Beznea

Changes in v2:
- s/tag/tab in the title of patch 2/5

Claudiu Beznea (5):
  ASoC: mchp-spdifrx: disable end of block interrupt on failures
  ASoC: mchp-spdifrx: use single tag indent for structure
  ASoC: mchp-spdiftx: remove references to mchp_i2s_caps
  ASoC: mchp-spdiftx: return directly ret
  ASoC: mchp-spdiftx: add and remove black line around
    MODULE_DEVICE_TABLE()

 sound/soc/atmel/mchp-spdifrx.c | 19 +++++++++++--------
 sound/soc/atmel/mchp-spdiftx.c | 21 +++++----------------
 2 files changed, 16 insertions(+), 24 deletions(-)

-- 
2.34.1

