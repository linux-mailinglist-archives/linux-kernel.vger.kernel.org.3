Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBB154E0E1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 14:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376427AbiFPMeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 08:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiFPMeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 08:34:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2844A4F9C4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 05:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655382841; x=1686918841;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VdIfYFjnAHQRKCvjB/PosFc98TS07Kc3GzWERBcZLLM=;
  b=bg7/qTSIEls6VRj+hfUBMXKUEf4mgi8t2LLPgkBllRXIfsIBqjKBGEIO
   U0Zl/245nr350K3AybvXXJKYS474unD/7a+r6RhD82ePYZcAx9xUeCBTB
   r+x+uXcRYegR3o3vwmVmdoPiWbcpVELAnwba256tHKpy3UoKbEL/zQQq8
   aJ0zp4AxtYqN2Alw6LpBMptUQkaqPuTMyozi/AH2JWjJsd0iAsD3+kl0g
   kaERXIE6yvQhet3HdBYTFJAouDcr1WLqkA+JyPrxPhUnnNjj3f5mLe3MO
   qTY3gLayQM/bCInNyAvqsVNAigw7F653cdzCNmsZeeYRpcTXI3S/jdTTP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="259091008"
X-IronPort-AV: E=Sophos;i="5.91,305,1647327600"; 
   d="scan'208";a="259091008"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 05:34:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,305,1647327600"; 
   d="scan'208";a="713338690"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 16 Jun 2022 05:33:59 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1ohD-000ONS-3T;
        Thu, 16 Jun 2022 12:33:59 +0000
Date:   Thu, 16 Jun 2022 20:33:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [sudeep-holla:wip/acpi_ffh_opregion 2/3]
 drivers/acpi/acpi_ffh.c:16:12: warning: no previous prototype for
 'acpi_ffh_address_space_arch_setup'
Message-ID: <202206162019.SclXvEpW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git wip/acpi_ffh_opregion
head:   0ca2d8d167ffa471639fc885ecd9ca010cb04deb
commit: 42de507063eebc8c7d728fbac4012e35c8b854df [2/3] ACPI: Implement a generic FFH Opregion handler
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220616/202206162019.SclXvEpW-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/commit/?id=42de507063eebc8c7d728fbac4012e35c8b854df
        git remote add sudeep-holla https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git
        git fetch --no-tags sudeep-holla wip/acpi_ffh_opregion
        git checkout 42de507063eebc8c7d728fbac4012e35c8b854df
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/acpi/ kernel/trace/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/acpi/acpi_ffh.c:16:12: warning: no previous prototype for 'acpi_ffh_address_space_arch_setup' [-Wmissing-prototypes]
      16 | int __weak acpi_ffh_address_space_arch_setup(void *handler_ctxt,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/acpi/acpi_ffh.c:22:12: warning: no previous prototype for 'acpi_ffh_address_space_arch_handler' [-Wmissing-prototypes]
      22 | int __weak acpi_ffh_address_space_arch_handler(acpi_integer *value,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/acpi_ffh_address_space_arch_setup +16 drivers/acpi/acpi_ffh.c

    15	
  > 16	int __weak acpi_ffh_address_space_arch_setup(void *handler_ctxt,
    17						     void **region_ctxt)
    18	{
    19		return -EOPNOTSUPP;
    20	}
    21	
  > 22	int __weak acpi_ffh_address_space_arch_handler(acpi_integer *value,
    23						       void *region_context)
    24	{
    25		return -EOPNOTSUPP;
    26	}
    27	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
