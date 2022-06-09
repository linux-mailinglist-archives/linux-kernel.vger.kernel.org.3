Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457F45452BC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238958AbiFIRPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiFIRPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:15:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CD51ED
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 10:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654794945; x=1686330945;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OAVN0AFurxH3oxnoaKlsBkOYWYzIY7xBuPZ6xTo/cKo=;
  b=bKkUXP6TXz/PuqdC2NdW+l/UMJhlkXZhJg40TdSVWnK8PHiIMZVHcAnb
   4ODI3E4iz3K9L/MKBhjdZxirhlNGrzaRDV9t1Q1r3NXVPRUICSUFbVPV9
   vBZXelrEc79scqSRD2vU9oIqk+9iBYbnqPpoD8hEnajddbaY7x+ztxu9J
   qqRGFlZVPbek9f2U9oszfr/ro5yiU0ZcaapGfjEj/EIsA1JnuH8ovAYWh
   8S6au14VwBgb4JEUL3YJZoKn5Zxk9un9JorADpYwgO3st+b+kjH1gk3Zs
   yE/Y+fwUyABfG9xhepRWMNFV1jZkfTT79luI43BUrKP2S1jMMIeBQffee
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="257184545"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="257184545"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 10:15:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="649370353"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jun 2022 10:15:43 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzLl0-000GDR-Jo;
        Thu, 09 Jun 2022 17:15:42 +0000
Date:   Fri, 10 Jun 2022 01:14:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:arm64/ftrace/per-callsite-ops 2/4]
 arch/sparc/kernel/ioport.c:299:1: error: 'text_section' attribute directive
 ignored
Message-ID: <202206100113.Mdyelzgi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/ftrace/per-callsite-ops
head:   7f0d1ffaab77795e4ca97db4a901cc347c850ff7
commit: efc001292934b744fa4c8147668fa4bd0ee909bf [2/4] WIP: incomplete alignment hacks
config: sparc-allnoconfig (https://download.01.org/0day-ci/archive/20220610/202206100113.Mdyelzgi-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=efc001292934b744fa4c8147668fa4bd0ee909bf
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/ftrace/per-callsite-ops
        git checkout efc001292934b744fa4c8147668fa4bd0ee909bf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash arch/sparc/kernel/ arch/sparc/mm/ drivers/tty/serial/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> arch/sparc/kernel/ioport.c:299:1: error: 'text_section' attribute directive ignored [-Werror=attributes]
     299 | arch_initcall(sparc_register_ioport);
         | ^~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
>> arch/sparc/kernel/setup_32.c:414:1: error: 'text_section' attribute directive ignored [-Werror=attributes]
     414 | subsys_initcall(topology_init);
         | ^~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
>> arch/sparc/kernel/time_32.c:327:1: error: 'text_section' attribute directive ignored [-Werror=attributes]
     327 | fs_initcall(clock_init);
         | ^~~~~~~~~~~
   cc1: all warnings being treated as errors
--
>> arch/sparc/kernel/of_device_32.c:421:1: error: 'text_section' attribute directive ignored [-Werror=attributes]
     421 | postcore_initcall(scan_of_devices);
         | ^~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
>> arch/sparc/kernel/leon_pmc.c:94:1: error: 'text_section' attribute directive ignored [-Werror=attributes]
      94 | late_initcall(leon_pmc_install);
         | ^~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
>> arch/sparc/kernel/apc.c:196:1: error: 'text_section' attribute directive ignored [-Werror=attributes]
     196 | __initcall(apc_init);
         | ^~~~~~~~~~
   cc1: all warnings being treated as errors
--
>> arch/sparc/kernel/pmc.c:100:1: error: 'text_section' attribute directive ignored [-Werror=attributes]
     100 | __initcall(pmc_init);
         | ^~~~~~~~~~
   cc1: all warnings being treated as errors
--
>> arch/sparc/mm/iommu.c:153:1: error: 'text_section' attribute directive ignored [-Werror=attributes]
     153 | subsys_initcall(iommu_init);
         | ^~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
>> arch/sparc/mm/io-unit.c:93:1: error: 'text_section' attribute directive ignored [-Werror=attributes]
      93 | subsys_initcall(iounit_init);
         | ^~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
>> drivers/tty/serial/suncore.c:238:1: warning: 'text_section' attribute directive ignored [-Wattributes]
     238 | device_initcall(suncore_init);
         | ^~~~~~~~~~~~~~~


vim +/text_section +299 arch/sparc/kernel/ioport.c

576c352e89e57c David S. Miller 2006-06-23  298  
f8e4d32cb5153a David S. Miller 2008-08-27 @299  arch_initcall(sparc_register_ioport);
f8e4d32cb5153a David S. Miller 2008-08-27  300  

:::::: The code at line 299 was first introduced by commit
:::::: f8e4d32cb5153a9d6a8e8864e357dad1349f3b85 sparc: Kill sbus_arch_preinit().

:::::: TO: David S. Miller <davem@davemloft.net>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
