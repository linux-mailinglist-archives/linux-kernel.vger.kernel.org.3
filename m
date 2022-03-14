Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A846D4D79FC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 05:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbiCNEyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 00:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiCNEyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 00:54:10 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4358BDFF6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 21:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647233581; x=1678769581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bDcfuJ4fQYIg26RqU/vjViaReE8o3gL8fjB6ap8civ0=;
  b=HLXbVofsXFSthwvCw3NEnYAHH3sa1LCE1avEpv2GQ1676PkRvcXSk+h7
   l69Imf3cQAXQ4Zb2RlwMi86WieBh7cWPqglv6WGOw/wgWRLvuGiHAa0Aq
   WCoRKiGpkA3KmvqpHM2z6sf+HXwr0ENhaHT3J28aHluvZ1BD+Jv7ESWKc
   pOsk9QGu8go6uOg3JQO3B9kw7x8O15whC2iJT+w+DXvWjdTj2NHlsxKWu
   pFModdsW+z4vSc/Zgc3zPSTIcHYvfzmSfHM0otBUCtI2H5hHiK8MvTAVS
   dpHXtua61j6sArQ4fsKNRtJWoYAEPTfQiWf/WBrBZbxFyjCJqt7krE8Ka
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="253493978"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="253493978"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 21:53:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="515266932"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Mar 2022 21:52:59 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTchW-0009aV-J4; Mon, 14 Mar 2022 04:52:58 +0000
Date:   Mon, 14 Mar 2022 12:52:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     tien.sung.ang@intel.com, Dinh Nguyen <dinguyen@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: Re: [PATCH 3/3] firmware: stratix10-svc: add new FCS commands
Message-ID: <202203141217.H2LzQEuO-lkp@intel.com>
References: <20220314102807.1746893-1-tien.sung.ang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314102807.1746893-1-tien.sung.ang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on linus/master v5.17-rc8]
[cannot apply to next-20220310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/tien-sung-ang-intel-com/firmware-stratix10-svc-Add-new-FCS-support/20220314-102938
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2c271fe77d52a0555161926c232cd5bc07178b39
config: h8300-allyesconfig (https://download.01.org/0day-ci/archive/20220314/202203141217.H2LzQEuO-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/21427534c2a95b30f967d178ee997d8ca94b34e6
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review tien-sung-ang-intel-com/firmware-stratix10-svc-Add-new-FCS-support/20220314-102938
        git checkout 21427534c2a95b30f967d178ee997d8ca94b34e6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=h8300 SHELL=/bin/bash drivers/net/ethernet/stmicro/stmmac/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/mfd/altera-sysmgr.h:13,
                    from drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c:7:
   include/linux/firmware/intel/stratix10-smc.h:406:12: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'INTEL_SIP_SMC_SERVICE_COMPLETED'
     406 |  * Request INTEL_SIP_SMC_SERVICE_COMPLETED
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/firmware/intel/stratix10-smc.h:406:12: error: unknown type name 'INTEL_SIP_SMC_SERVICE_COMPLETED'
   In file included from drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c:7:
>> include/linux/mfd/altera-sysmgr.h:22:45: warning: 'struct device_node' declared inside parameter list will not be visible outside of this definition or declaration
      22 | altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
         |                                             ^~~~~~~~~~~
   In file included from include/linux/err.h:5,
                    from include/linux/mfd/altera-sysmgr.h:11,
                    from drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c:7:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   include/asm-generic/page.h:89:51: warning: ordered comparison of pointer with null pointer [-Wextra]
      89 | #define virt_addr_valid(kaddr)  (((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
         |                                                   ^~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/scatterlist.h:160:9: note: in expansion of macro 'BUG_ON'
     160 |         BUG_ON(!virt_addr_valid(buf));
         |         ^~~~~~
   include/linux/scatterlist.h:160:17: note: in expansion of macro 'virt_addr_valid'
     160 |         BUG_ON(!virt_addr_valid(buf));
         |                 ^~~~~~~~~~~~~~~
   drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c: In function 'socfpga_dwmac_parse_data':
   drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c:113:54: error: passing argument 1 of 'altr_sysmgr_regmap_lookup_by_phandle' from incompatible pointer type [-Werror=incompatible-pointer-types]
     113 |                 altr_sysmgr_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");
         |                                                      ^~
         |                                                      |
         |                                                      struct device_node *
   In file included from drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c:7:
   include/linux/mfd/altera-sysmgr.h:22:58: note: expected 'struct device_node *' but argument is of type 'struct device_node *'
      22 | altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
         |                                      ~~~~~~~~~~~~~~~~~~~~^~
   cc1: some warnings being treated as errors


vim +22 include/linux/mfd/altera-sysmgr.h

f36e789a1f8d0b Thor Thayer 2019-03-11  10  
f36e789a1f8d0b Thor Thayer 2019-03-11  11  #include <linux/err.h>
f36e789a1f8d0b Thor Thayer 2019-03-11  12  #include <linux/errno.h>
f36e789a1f8d0b Thor Thayer 2019-03-11 @13  #include <linux/firmware/intel/stratix10-smc.h>
f36e789a1f8d0b Thor Thayer 2019-03-11  14  
f36e789a1f8d0b Thor Thayer 2019-03-11  15  struct device_node;
f36e789a1f8d0b Thor Thayer 2019-03-11  16  
f36e789a1f8d0b Thor Thayer 2019-03-11  17  #ifdef CONFIG_MFD_ALTERA_SYSMGR
f36e789a1f8d0b Thor Thayer 2019-03-11  18  struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
f36e789a1f8d0b Thor Thayer 2019-03-11  19  						    const char *property);
f36e789a1f8d0b Thor Thayer 2019-03-11  20  #else
f36e789a1f8d0b Thor Thayer 2019-03-11  21  static inline struct regmap *
f36e789a1f8d0b Thor Thayer 2019-03-11 @22  altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
f36e789a1f8d0b Thor Thayer 2019-03-11  23  				     const char *property)
f36e789a1f8d0b Thor Thayer 2019-03-11  24  {
f36e789a1f8d0b Thor Thayer 2019-03-11  25  	return ERR_PTR(-ENOTSUPP);
f36e789a1f8d0b Thor Thayer 2019-03-11  26  }
f36e789a1f8d0b Thor Thayer 2019-03-11  27  #endif
f36e789a1f8d0b Thor Thayer 2019-03-11  28  

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
