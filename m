Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395AD4C2269
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiBXDdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiBXDdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:33:31 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9AC22B968
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645673582; x=1677209582;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=T2RmvMfhYe+mcYpkVvHp7elOfG0QQiptnIbgnl21R94=;
  b=JZi7e6bOXtMut26aSJwg+BhJzhygJ/scbH7XJB2HJw2c18CpQNW+P5/l
   iG9RT/J0TwgzbQyOclCckX6lv5F3XMQHJFOrltPl5qM3VPdLzw6cNiie8
   7KSmO6u8LT4PuHPVA2Hs/5Y/XhLGc+UY4hH1lkWqQoANE2K1qVlvhNDIL
   U3SWJjBEj4IIPtVq4Yw8SAHWpa/j/YDzoCIGDPI/CIG2uvS5r1jKRQE7/
   J+m1goVbgn24ndxpp2X94RoH5rQxJ0B2nfyIDmthD10EES1Jc7NXh8I4h
   pbApS2e99wNN0YEPstriRWrpR5NLk40fVZKOwtfL8ifEuza+ZSWxyXoJg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="276765694"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="276765694"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 19:33:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="508706439"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 23 Feb 2022 19:33:01 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN4sG-0002Bf-CR; Thu, 24 Feb 2022 03:33:00 +0000
Date:   Thu, 24 Feb 2022 11:32:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1978/2340] arch/mips/lantiq/prom.c:70:9:
 error: 'ioport_resource' undeclared
Message-ID: <202202241142.i6djmjny-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   97c5eeb4de3ad324ed2a4656b46465299cfd010a
commit: 5127da32c5398fee63cfadc941be700540249cf9 [1978/2340] headers/deps: dev/core: Optimize <linux/device.h> dependencies, remove <linux/device_api.h> inclusion
config: mips-xway_defconfig (https://download.01.org/0day-ci/archive/20220224/202202241142.i6djmjny-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=5127da32c5398fee63cfadc941be700540249cf9
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 5127da32c5398fee63cfadc941be700540249cf9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/mips/lantiq/prom.c: In function 'plat_mem_setup':
>> arch/mips/lantiq/prom.c:70:9: error: 'ioport_resource' undeclared (first use in this function)
      70 |         ioport_resource.start = IOPORT_RESOURCE_START;
         |         ^~~~~~~~~~~~~~~
   arch/mips/lantiq/prom.c:70:9: note: each undeclared identifier is reported only once for each function it appears in
>> arch/mips/lantiq/prom.c:72:9: error: 'iomem_resource' undeclared (first use in this function)
      72 |         iomem_resource.start = IOMEM_RESOURCE_START;
         |         ^~~~~~~~~~~~~~


vim +/ioport_resource +70 arch/mips/lantiq/prom.c

171bb2f19ed6f3 John Crispin        2011-03-30  65  
a0392222d9a374 John Crispin        2012-04-13  66  void __init plat_mem_setup(void)
171bb2f19ed6f3 John Crispin        2011-03-30  67  {
84f47cf49e3c83 Hauke Mehrtens      2016-03-19  68  	void *dtb;
84f47cf49e3c83 Hauke Mehrtens      2016-03-19  69  
a0392222d9a374 John Crispin        2012-04-13 @70  	ioport_resource.start = IOPORT_RESOURCE_START;
a0392222d9a374 John Crispin        2012-04-13  71  	ioport_resource.end = IOPORT_RESOURCE_END;
a0392222d9a374 John Crispin        2012-04-13 @72  	iomem_resource.start = IOMEM_RESOURCE_START;
a0392222d9a374 John Crispin        2012-04-13  73  	iomem_resource.end = IOMEM_RESOURCE_END;
a0392222d9a374 John Crispin        2012-04-13  74  
a0392222d9a374 John Crispin        2012-04-13  75  	set_io_port_base((unsigned long) KSEG1);
a0392222d9a374 John Crispin        2012-04-13  76  
b83ba0b9df56f8 Thomas Bogendoerfer 2021-01-27  77  	dtb = get_fdt();
b83ba0b9df56f8 Thomas Bogendoerfer 2021-01-27  78  	if (dtb == NULL)
84f47cf49e3c83 Hauke Mehrtens      2016-03-19  79  		panic("no dtb found");
84f47cf49e3c83 Hauke Mehrtens      2016-03-19  80  
a0392222d9a374 John Crispin        2012-04-13  81  	/*
84f47cf49e3c83 Hauke Mehrtens      2016-03-19  82  	 * Load the devicetree. This causes the chosen node to be
a0392222d9a374 John Crispin        2012-04-13  83  	 * parsed resulting in our memory appearing
a0392222d9a374 John Crispin        2012-04-13  84  	 */
84f47cf49e3c83 Hauke Mehrtens      2016-03-19  85  	__dt_setup_arch(dtb);
a0392222d9a374 John Crispin        2012-04-13  86  }
171bb2f19ed6f3 John Crispin        2011-03-30  87  

:::::: The code at line 70 was first introduced by commit
:::::: a0392222d9a374588803454c4d2211108c64d4e4 OF: MIPS: lantiq: implement OF support

:::::: TO: John Crispin <blogic@openwrt.org>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
