Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C62958CD13
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243980AbiHHRxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243182AbiHHRxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:53:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4629EE0D2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659981217; x=1691517217;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pCSf7Mc7k6Nuf0lZb47S6l5lfVrSvLoi02wCOJWZfD0=;
  b=QooamlocAA1YlJ4rXUJLzJvw0qu0U2ckOj0SWW28zmsD5kYL6qmeqFIL
   NuYgJ8L+ADaZO94o/PJHzBOrGQhvjoBhqhWsibaulV+WUAZRlBxY7HDrK
   QWrRtH7MPlQbZLvJynK1A/UmJAzY9VreLUGc3QgfC3nvuTddaAj/IekwZ
   T9ZM0nyKgaaQrsYQSysZwyJk1yyuKOWjmFhqMBV8uHCKrtBZjfM9uGFIG
   XHBbp4N0SV+GtLHb9MbC1KqMc37Czeecx/oiIIVXy6fMTtn7MOqW3yOVF
   OVWH8Q4mii9iaWY2yvUQp0vCj3hUiRoUXeFseV1YR87CsEcHmzXCml8f6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="288220614"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="288220614"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 10:53:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="746730717"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 08 Aug 2022 10:53:31 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oL6wU-000MSX-2S;
        Mon, 08 Aug 2022 17:53:30 +0000
Date:   Tue, 9 Aug 2022 01:53:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>
Subject: drivers/ufs/host/tc-dwc-g210-pltfrm.c:36:34: warning:
 'tc_dwc_g210_pltfm_match' defined but not used
Message-ID: <202208090144.eBgN7MG1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4e23eeebb2e57f5a28b36221aa776b5a1122dde5
commit: dd11376b9f1b73aca3f8c6eb541486bbb6996f05 scsi: ufs: Split the drivers/scsi/ufs directory
date:   3 months ago
config: i386-buildonly-randconfig-r001-20220808 (https://download.01.org/0day-ci/archive/20220809/202208090144.eBgN7MG1-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dd11376b9f1b73aca3f8c6eb541486bbb6996f05
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout dd11376b9f1b73aca3f8c6eb541486bbb6996f05
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/ufs/host/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/ufs/host/tc-dwc-g210-pltfrm.c:36:34: warning: 'tc_dwc_g210_pltfm_match' defined but not used [-Wunused-const-variable=]
      36 | static const struct of_device_id tc_dwc_g210_pltfm_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~


vim +/tc_dwc_g210_pltfm_match +36 drivers/ufs/host/tc-dwc-g210-pltfrm.c

fc040a3fc47cad drivers/scsi/ufs/tc-dwc-g210-pltfrm.c Joao Pinto 2016-05-11  35  
fc040a3fc47cad drivers/scsi/ufs/tc-dwc-g210-pltfrm.c Joao Pinto 2016-05-11 @36  static const struct of_device_id tc_dwc_g210_pltfm_match[] = {
fc040a3fc47cad drivers/scsi/ufs/tc-dwc-g210-pltfrm.c Joao Pinto 2016-05-11  37  	{
fc040a3fc47cad drivers/scsi/ufs/tc-dwc-g210-pltfrm.c Joao Pinto 2016-05-11  38  		.compatible = "snps,g210-tc-6.00-20bit",
fc040a3fc47cad drivers/scsi/ufs/tc-dwc-g210-pltfrm.c Joao Pinto 2016-05-11  39  		.data = &tc_dwc_g210_20bit_pltfm_hba_vops,
fc040a3fc47cad drivers/scsi/ufs/tc-dwc-g210-pltfrm.c Joao Pinto 2016-05-11  40  	},
fc040a3fc47cad drivers/scsi/ufs/tc-dwc-g210-pltfrm.c Joao Pinto 2016-05-11  41  	{
fc040a3fc47cad drivers/scsi/ufs/tc-dwc-g210-pltfrm.c Joao Pinto 2016-05-11  42  		.compatible = "snps,g210-tc-6.00-40bit",
fc040a3fc47cad drivers/scsi/ufs/tc-dwc-g210-pltfrm.c Joao Pinto 2016-05-11  43  		.data = &tc_dwc_g210_40bit_pltfm_hba_vops,
fc040a3fc47cad drivers/scsi/ufs/tc-dwc-g210-pltfrm.c Joao Pinto 2016-05-11  44  	},
fc040a3fc47cad drivers/scsi/ufs/tc-dwc-g210-pltfrm.c Joao Pinto 2016-05-11  45  	{ },
fc040a3fc47cad drivers/scsi/ufs/tc-dwc-g210-pltfrm.c Joao Pinto 2016-05-11  46  };
fc040a3fc47cad drivers/scsi/ufs/tc-dwc-g210-pltfrm.c Joao Pinto 2016-05-11  47  MODULE_DEVICE_TABLE(of, tc_dwc_g210_pltfm_match);
fc040a3fc47cad drivers/scsi/ufs/tc-dwc-g210-pltfrm.c Joao Pinto 2016-05-11  48  

:::::: The code at line 36 was first introduced by commit
:::::: fc040a3fc47cad038f774275ea61fe6d5b57d7cc ufs: add TC G210 platform driver

:::::: TO: Joao Pinto <Joao.Pinto@synopsys.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
