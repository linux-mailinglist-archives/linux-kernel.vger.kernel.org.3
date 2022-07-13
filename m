Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388FD572C8D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbiGME3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbiGME2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:28:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D76F222BE;
        Tue, 12 Jul 2022 21:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657686524; x=1689222524;
  h=from:to:cc:subject:date:message-id;
  bh=6SiSvwYpSrcAiIBIfoldM1RBHvBHBHxZggPTU5mW53M=;
  b=XH0jrJXERupBLLSllgJndPE6uXYc1eANMQOH0/GOn9KINjtT1LfBEJ71
   +4RgW5HTQ6uKWCzEx0JMLTvEPJYURvSibxyDhKNHXdeQHf0nqphyPPO9p
   3wDL3Oty3We6DjPznudn0hDHiLLQ/5kgnTLZR1LXcKivKN6Lmr6suAtjE
   GTXMQHK1Dvu0YUYFh2+s4u1xFw6ZsZSwclfMECGYbArM+n2PU/Ig04Fsj
   n0Rkuq62MqOMjkhERF2y7VtR/e9F66mlOq73t/lNXf4ClW5c2ZF2MRxHz
   5+eQou2K3jN2eoW4dlZSOQOZfxwTMH/759mcBAT0NWbHh3iy9VXfRpowE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="264894376"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="264894376"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 21:28:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="570463201"
Received: from srikandan-ilbpg12.png.intel.com ([10.88.229.69])
  by orsmga006.jf.intel.com with ESMTP; 12 Jul 2022 21:28:40 -0700
From:   nandhini.srikandan@intel.com
To:     fancer.lancer@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        rashmi.a@intel.com
Subject: [PATCH v6 0/4] Add support for Intel Thunder Bay SPI controller
Date:   Wed, 13 Jul 2022 12:22:19 +0800
Message-Id: <20220713042223.1458-1-nandhini.srikandan@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nandhini Srikandan <nandhini.srikandan@intel.com>

                                                                                   
This patch enables support for DW SPI on Intel Thunder Bay.                        
This patch set also enables master mode for latest Designware SPI versions.        
                                                                                   
Patch 1: Fixed dw_spi_ip_is macro with the missing underscore.                     
Patch 2: DW SPI DT bindings for Intel Thunder Bay SoC.                             
Patch 3: Adds master mode support for Designware SPI controller.                   
Patch 4: Adds support for Designware SPI on Intel Thunder Bay SoC.                 
                                                                                   
The driver is tested on Keem Bay and Thunder Bay evaluation board                  
                                                                                   
Summary: 
Changes from v5:
1) Added changelog for Patch 1.
2) Added Acked-by and Reviewed-by to applicable patches. 
3) There are no other changes other than changelog in any of the patches.
                                                                          
Changes from v4:                                                                   
1) Reordered master mode selection patch and Thunder Bay support patch.            
2) The typo fix for macro dw_spi_ip_is is made into seperate patch.                
                                                                                   
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
4) Resued the existing SPI deassert API instead of adding another reset.

Changes in patches:                                                             
Patch 1:                                                                        
--------                                           
Changes from v5:
1) Added changelog
                             
Changes from v4:                                                                
1) Newly introduced in v5 as seperate patch.                                    
                                                                                
Patch 2:                                                                        
--------                                                                        
Changes from v5/v4/v3/v2/v1:                                                       
1) No change in this patch.                                                     
                                                                                
                                                                                
Patch 3:                                                                        
--------        
Changes from v5:
1) No changes.
                                                                
Changes from v4:                                                                
1) Reordered the patch.                                                         
2) Setting CTRLR0 BIT31 is done conditionally for 1.02a version.                
                                                                                
Changes from v3:                                                                
1) Corrected dw_spi_ip_is macro with the missing underscore.                    
2) Setting CTRLR0 BIT31 without any condition check as in older version of      
   DW SPI controller this bit is reserved.                                      
                                                                                
Changes from v2/v1:                                                             
1)Newly introduced in v3 to make master mode selection as seperate patch.

Patch 4:                                                                        
--------                                                                        
Changes from v5:
1) No changes. 

Changes from v4:                                                                
1) Reordered the patch.                                                         
                                                                                
Changes from v3:                                                                
1) No changes.                                                                  
                                                                                
Changes from v2:                                                                
1) Init function is made common for Keem Bay and Thunder Bay.                   
                                                                                
Thanks & Regards,                                                               
Nandhini 

Nandhini Srikandan (4):
  spi: dw: Fix IP-core versions macro
  dt-bindings: spi: Add bindings for Intel Thunder Bay SOC
  spi: dw: Add support for master mode selection for DWC SSI controller
  spi: dw: Add support for Intel Thunder Bay SPI controller

 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml    |  2 ++
 drivers/spi/spi-dw-core.c                           |  5 +++--
 drivers/spi/spi-dw-mmio.c                           |  8 ++++----
 drivers/spi/spi-dw.h                                | 13 +++----------
 4 files changed, 12 insertions(+), 16 deletions(-)

-- 
2.17.1

