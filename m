Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DE757FD0B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbiGYKJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbiGYKJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:09:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D677A17070
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658743747; x=1690279747;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=23Lw4hO9PnrAnUiexgQt9P4+WeHQTapIxHltzfSk/RQ=;
  b=Lm7OcK/IsBjfDcm1g2O6A8Wnj0ohA84Sl4tFnan6PJXtM0ybzjjXfBA6
   +Mlx0qhlvucSfeZnETHuBxlIDLvncJ4+Hkj0Z/IYQoq8raaV/jzC1WC0y
   tBWAZ/x0yT5Bx/xFc9/ULoj53jNKJFnSEDMUVPrntYsN9b02tJqlhNlkX
   r6gY4xCfMdWODM44OkjDzAnUCcGZH5PPDdP3bia8DwhajEwfWTG7GZnI9
   oLO4TEUD+HExyyNebOObISbfsxuRY94kcRSgjJPX/5m38QmkMpmSUe/d4
   Afdd1Bltv4GAfZzGDxDop4VfGBO9itZFSBiaF/12ScWNPDN05GdMnEBCn
   g==;
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="173496299"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jul 2022 03:09:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 25 Jul 2022 03:09:06 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 25 Jul 2022 03:09:04 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/5] ASoC: atmel: one fix and few cleanups
Date:   Mon, 25 Jul 2022 13:11:25 +0300
Message-ID: <20220725101130.1780393-1-claudiu.beznea@microchip.com>
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

