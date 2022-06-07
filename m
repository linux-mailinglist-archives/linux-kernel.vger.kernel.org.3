Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A4753F769
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237771AbiFGHkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237751AbiFGHkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:40:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FB19A985;
        Tue,  7 Jun 2022 00:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654587639; x=1686123639;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L+pWQiKVFTUk9f3rrp9Qu421lTiVrGXO1VHPp8ZzXIY=;
  b=LZMyZD6b7FCKCNeYF83N2CUS4hozSLcmOCCt0rrQQm0t8gkH05FEb4nU
   F5KISQ20f4Te64BBTak535ftySUu0xbLul/E814YLPsdrW5W+gwfOOxSI
   35qGO0f5gzkx/HDvAwXPrNUZ+oZWC2WWngn1+WgTrQDivCoIUUAt8pWEq
   LdLyg0Yq/6+s+n6fWsTqrvVMJ0JB061nbDm8LMUPqe60U95sSlCwTLKiP
   mR3AXF2ypr140EKbPJuzl07cuy2wBG+4ovRF4s5vBZrSVlg5eulMLq8i6
   iXhrG8wxgCpfXGzrv4eHa5N/ihLP4J7wjWCO1xEUeoUVpQZsMjS8XTkvI
   A==;
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="167043052"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jun 2022 00:40:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 7 Jun 2022 00:40:34 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 7 Jun 2022 00:40:32 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH 0/2] Add support for PolarFire SoC's spi controllers
Date:   Tue, 7 Jun 2022 08:38:32 +0100
Message-ID: <20220607073833.2331539-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Mark,

As it says on the tin, here's a patch adding support for the spi
controllers on PolarFire SoC. The binding for them was already
added in 5.18.

Thanks,
Conor.

Conor Dooley (2):
  spi: add support for microchip fpga spi controllers
  MAINTAINERS: add spi to PolarFire SoC entry

 MAINTAINERS                      |   1 +
 drivers/spi/Kconfig              |   9 +
 drivers/spi/Makefile             |   1 +
 drivers/spi/spi-microchip-core.c | 632 +++++++++++++++++++++++++++++++
 4 files changed, 643 insertions(+)
 create mode 100644 drivers/spi/spi-microchip-core.c


base-commit: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f
-- 
2.36.1

