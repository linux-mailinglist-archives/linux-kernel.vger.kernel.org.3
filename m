Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521BF4D14E4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345886AbiCHKfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245490AbiCHKfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:35:20 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0831542ED1;
        Tue,  8 Mar 2022 02:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646735663; x=1678271663;
  h=from:to:cc:subject:date:message-id;
  bh=h1vUEL0DN/oUSb36gk/HqrGMDSCs6MvYHYh+sCPN8mw=;
  b=gnc7cO6ilvR9fLAl2jCeVWaq1kRQ9cAr/feuvK54RKWIb2SKLBaA1F3h
   XFMlDoqaq9kkSeWASU+vWhCZvmWYuWIsQNpfI2/zlDqVU1MZBWf0X9IsN
   vxYHaqYaZ8v5G2aYThEEXondKgeuOE8J8PiYIFFrlw7wuLWpnWJtuUrG5
   wGAQ9BEBNpXhnTy4cpGYA9+2569em5ri6jfoTnqt0yr82ZDxiyn8pJMhj
   QH9f0kIaOm3qsO+JJig6cSjFxfPRdpEzV63gekD3TocpavuWHk6Bq+tg2
   kajCyMAklRICgBqy6P7HllcsGLZom5k6M+Gw+y9fNy+B/FsToRcVG+N0w
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="234605578"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="234605578"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 02:34:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="643612217"
Received: from srikandan-ilbpg12.png.intel.com ([10.88.229.69])
  by orsmga004.jf.intel.com with ESMTP; 08 Mar 2022 02:34:19 -0800
From:   nandhini.srikandan@intel.com
To:     fancer.lancer@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        rashmi.a@intel.com
Subject: [PATCH v4 0/3] Add support for Intel Thunder Bay SPI controller
Date:   Tue,  8 Mar 2022 18:33:28 +0800
Message-Id: <20220308103331.4116-1-nandhini.srikandan@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nandhini Srikandan <nandhini.srikandan@intel.com>

Hi,

This patch enables support for DW SPI on Intel Thunder Bay (patch 1,2).
This patch set also enables master mode for latest Designware SPI versions (patch 3).

Patch 1: DW SPI DT bindings for Intel Thunder Bay SoC.
Patch 2: Adds support for Designware SPI on Intel Thunderbay SoC.
Patch 3: Adds master mode support for Designware SPI controller.

The driver is tested on Keem Bay and Thunder Bay evaluation board

Summary:
Changes from v3:
1) Dropped SSTE support in this patch.
2) Rebased to the latest code.

Changes from v2:
1) SSTE support made using dt and created seperate patches.
2) SPI controller master mode selection made common to all DW SPI controllers.
3) Using a common init function for both keem bay and thunder bay.

Changes from v1:
1) Designware CR0 specific macros are named in a generic way.
2) SPI CAP macros are named in generic way rather than naming project specific.
3) SPI KEEM BAY specific macros are replaced by generic macros.
4) Resued the existing SPI deassert API instead of adding another reset


Changes in patches:
Patch 1: 
Changes from v3/v2/v1:
1) No change in this patch

Patch 2:
Changes from v3:
1) No changes.

Changes from v2:
1) Init function is made common for Keem Bay and Thunder Bay.
 
Patch 3:
Changes from v3:
1) Corrected dw_spi_ip_is macro with the missing underscore.
2) Setting CTRLR0 BIT31 without any condition check as in older version of 
   DW SPI controller this bit is reserved.

Changes from v2/v1:
1)Newly introduced in v3 to make master mode selection as seperate patch

Thanks & Regards,
Nandhini


Nandhini Srikandan (3):
  dt-bindings: spi: Add bindings for Intel Thunder Bay SoC
  spi: dw: Add support for Intel Thunder Bay SPI controller
  spi: dw: Add support for master mode selection for DWC SSI controller

 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml          | 2 ++
 drivers/spi/spi-dw-core.c                                 | 4 ++--
 drivers/spi/spi-dw-mmio.c                                 | 8 ++++----
 drivers/spi/spi-dw.h                                      | 7 +++----
 4 files changed, 11 insertions(+), 10 deletions(-)

-- 
2.17.1

