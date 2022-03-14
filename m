Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F2C4D7A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 06:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbiCNFF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 01:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiCNFFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 01:05:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C69D205D2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 22:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647234244; x=1678770244;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CmVupxfKm64xDAl1Jy2FjdwgqD4Ou5bnSylRRhYul5U=;
  b=JATAoBSehglsVlCp57BO1vnD+x+EiUWgTdPwnVQYYL6AUNz0EXH+mndg
   xoCW6QbqRdlxdOJknd5v2N49NVjshfYnpm2UaGKIsVxQ2JvUVfW0YilMg
   L9Ng33rqLLslGOxyxmIfFwjUnzXshVgmpXOfF/Cbin3XUa7whlCgnQadQ
   ejQIlg5WQrX+1SYByTnI6QTk8e04aswAJtE4f2sVSskBZkw2JEhMHOMAi
   XyZZzb8QzOWXD0ZAaTfkcEa7j4RuPek5+qg7kvtx5xmCkoS8RuDcVSkMd
   JBp1fhe6KTNvapmrSb1/Wjbk3Htumiwc3ouzXgWvBGUvCBKKFiL0Zx9K3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="255887336"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="255887336"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 22:04:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="713575642"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 13 Mar 2022 22:04:01 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTcsC-0009az-Sn; Mon, 14 Mar 2022 05:04:00 +0000
Date:   Mon, 14 Mar 2022 13:03:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     tien.sung.ang@intel.com, Dinh Nguyen <dinguyen@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: Re: [PATCH 3/3] firmware: stratix10-svc: add new FCS commands
Message-ID: <202203141252.lZgnKwUr-lkp@intel.com>
References: <20220314102807.1746893-1-tien.sung.ang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314102807.1746893-1-tien.sung.ang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
config: arm-socfpga_defconfig (https://download.01.org/0day-ci/archive/20220314/202203141252.lZgnKwUr-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 3e4950d7fa78ac83f33bbf1658e2f49a73719236)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/0day-ci/linux/commit/21427534c2a95b30f967d178ee997d8ca94b34e6
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review tien-sung-ang-intel-com/firmware-stratix10-svc-Add-new-FCS-support/20220314-102938
        git checkout 21427534c2a95b30f967d178ee997d8ca94b34e6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/mfd/ drivers/net/ethernet/stmicro/stmmac/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/mfd/altera-sysmgr.c:13:
   In file included from include/linux/mfd/altera-sysmgr.h:13:
>> include/linux/firmware/intel/stratix10-smc.h:406:4: warning: declaration specifier missing, defaulting to 'int'
    * Request INTEL_SIP_SMC_SERVICE_COMPLETED
      ^
    int
   include/linux/firmware/intel/stratix10-smc.h:406:11: error: expected ';' after top level declarator
    * Request INTEL_SIP_SMC_SERVICE_COMPLETED
             ^
             ;
   In file included from drivers/mfd/altera-sysmgr.c:13:
>> include/linux/mfd/altera-sysmgr.h:18:60: warning: declaration of 'struct device_node' will not be visible outside of this function [-Wvisibility]
   struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
                                                              ^
   drivers/mfd/altera-sysmgr.c:96:16: error: conflicting types for 'altr_sysmgr_regmap_lookup_by_phandle'
   struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
                  ^
   include/linux/mfd/altera-sysmgr.h:18:16: note: previous declaration is here
   struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
                  ^
   2 warnings and 2 errors generated.
--
   In file included from drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c:7:
   In file included from include/linux/mfd/altera-sysmgr.h:13:
>> include/linux/firmware/intel/stratix10-smc.h:406:4: warning: declaration specifier missing, defaulting to 'int'
    * Request INTEL_SIP_SMC_SERVICE_COMPLETED
      ^
    int
   include/linux/firmware/intel/stratix10-smc.h:406:11: error: expected ';' after top level declarator
    * Request INTEL_SIP_SMC_SERVICE_COMPLETED
             ^
             ;
   In file included from drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c:7:
>> include/linux/mfd/altera-sysmgr.h:18:60: warning: declaration of 'struct device_node' will not be visible outside of this function [-Wvisibility]
   struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
                                                              ^
   drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c:113:40: error: incompatible pointer types passing 'struct device_node *' to parameter of type 'struct device_node *' [-Werror,-Wincompatible-pointer-types]
                   altr_sysmgr_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");
                                                        ^~
   include/linux/mfd/altera-sysmgr.h:18:73: note: passing argument to parameter 'np' here
   struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
                                                                           ^
   2 warnings and 2 errors generated.


vim +/int +406 include/linux/firmware/intel/stratix10-smc.h

7ca5ce896524f5 Richard Gong  2018-11-13  147  
7ca5ce896524f5 Richard Gong  2018-11-13  148  /**
7ca5ce896524f5 Richard Gong  2018-11-13  149   * Request INTEL_SIP_SMC_FPGA_CONFIG_ISDONE
7ca5ce896524f5 Richard Gong  2018-11-13  150   *
7ca5ce896524f5 Richard Gong  2018-11-13  151   * Sync call used by service driver at EL1 to inform secure world that all
7ca5ce896524f5 Richard Gong  2018-11-13  152   * data are sent, to check whether or not the secure world had completed
7ca5ce896524f5 Richard Gong  2018-11-13  153   * the FPGA configuration process.
7ca5ce896524f5 Richard Gong  2018-11-13  154   *
7ca5ce896524f5 Richard Gong  2018-11-13  155   * Call register usage:
7ca5ce896524f5 Richard Gong  2018-11-13  156   * a0: INTEL_SIP_SMC_FPGA_CONFIG_ISDONE.
7ca5ce896524f5 Richard Gong  2018-11-13  157   * a1-7: not used.
7ca5ce896524f5 Richard Gong  2018-11-13  158   *
7ca5ce896524f5 Richard Gong  2018-11-13  159   * Return status:
7536ad8dbfcfd5 Richard Gong  2020-04-14  160   * a0: INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_BUSY or
7536ad8dbfcfd5 Richard Gong  2020-04-14  161   * INTEL_SIP_SMC_STATUS_ERROR.
7ca5ce896524f5 Richard Gong  2018-11-13  162   * a1-3: not used.
7ca5ce896524f5 Richard Gong  2018-11-13  163   */
7ca5ce896524f5 Richard Gong  2018-11-13  164  #define INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_ISDONE 4
7ca5ce896524f5 Richard Gong  2018-11-13  165  #define INTEL_SIP_SMC_FPGA_CONFIG_ISDONE \
7ca5ce896524f5 Richard Gong  2018-11-13  166  	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_ISDONE)
7ca5ce896524f5 Richard Gong  2018-11-13  167  
7ca5ce896524f5 Richard Gong  2018-11-13  168  /**
7ca5ce896524f5 Richard Gong  2018-11-13  169   * Request INTEL_SIP_SMC_FPGA_CONFIG_GET_MEM
7ca5ce896524f5 Richard Gong  2018-11-13  170   *
7ca5ce896524f5 Richard Gong  2018-11-13  171   * Sync call used by service driver at EL1 to query the physical address of
7ca5ce896524f5 Richard Gong  2018-11-13  172   * memory block reserved by secure monitor software.
7ca5ce896524f5 Richard Gong  2018-11-13  173   *
7ca5ce896524f5 Richard Gong  2018-11-13  174   * Call register usage:
7ca5ce896524f5 Richard Gong  2018-11-13  175   * a0:INTEL_SIP_SMC_FPGA_CONFIG_GET_MEM.
7ca5ce896524f5 Richard Gong  2018-11-13  176   * a1-7: not used.
7ca5ce896524f5 Richard Gong  2018-11-13  177   *
7ca5ce896524f5 Richard Gong  2018-11-13  178   * Return status:
7536ad8dbfcfd5 Richard Gong  2020-04-14  179   * a0: INTEL_SIP_SMC_STATUS_OK or INTEL_SIP_SMC_STATUS_ERROR.
7ca5ce896524f5 Richard Gong  2018-11-13  180   * a1: start of physical address of reserved memory block.
7ca5ce896524f5 Richard Gong  2018-11-13  181   * a2: size of reserved memory block.
7ca5ce896524f5 Richard Gong  2018-11-13  182   * a3: not used.
7ca5ce896524f5 Richard Gong  2018-11-13  183   */
7ca5ce896524f5 Richard Gong  2018-11-13  184  #define INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_GET_MEM 5
7ca5ce896524f5 Richard Gong  2018-11-13  185  #define INTEL_SIP_SMC_FPGA_CONFIG_GET_MEM \
7ca5ce896524f5 Richard Gong  2018-11-13  186  	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_GET_MEM)
7ca5ce896524f5 Richard Gong  2018-11-13  187  
7ca5ce896524f5 Richard Gong  2018-11-13  188  /**
7ca5ce896524f5 Richard Gong  2018-11-13  189   * Request INTEL_SIP_SMC_FPGA_CONFIG_LOOPBACK
7ca5ce896524f5 Richard Gong  2018-11-13  190   *
7ca5ce896524f5 Richard Gong  2018-11-13  191   * For SMC loop-back mode only, used for internal integration, debugging
7ca5ce896524f5 Richard Gong  2018-11-13  192   * or troubleshooting.
7ca5ce896524f5 Richard Gong  2018-11-13  193   *
7ca5ce896524f5 Richard Gong  2018-11-13  194   * Call register usage:
7ca5ce896524f5 Richard Gong  2018-11-13  195   * a0: INTEL_SIP_SMC_FPGA_CONFIG_LOOPBACK.
7ca5ce896524f5 Richard Gong  2018-11-13  196   * a1-7: not used.
7ca5ce896524f5 Richard Gong  2018-11-13  197   *
7ca5ce896524f5 Richard Gong  2018-11-13  198   * Return status:
7536ad8dbfcfd5 Richard Gong  2020-04-14  199   * a0: INTEL_SIP_SMC_STATUS_OK or INTEL_SIP_SMC_STATUS_ERROR.
7ca5ce896524f5 Richard Gong  2018-11-13  200   * a1-3: not used.
7ca5ce896524f5 Richard Gong  2018-11-13  201   */
7ca5ce896524f5 Richard Gong  2018-11-13  202  #define INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_LOOPBACK 6
7ca5ce896524f5 Richard Gong  2018-11-13  203  #define INTEL_SIP_SMC_FPGA_CONFIG_LOOPBACK \
7ca5ce896524f5 Richard Gong  2018-11-13  204  	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_LOOPBACK)
7ca5ce896524f5 Richard Gong  2018-11-13  205  
b5dc75c915cdae Richard Gong  2019-09-03  206  /**
7ca5ce896524f5 Richard Gong  2018-11-13  207   * Request INTEL_SIP_SMC_REG_READ
7ca5ce896524f5 Richard Gong  2018-11-13  208   *
7ca5ce896524f5 Richard Gong  2018-11-13  209   * Read a protected register at EL3
7ca5ce896524f5 Richard Gong  2018-11-13  210   *
7ca5ce896524f5 Richard Gong  2018-11-13  211   * Call register usage:
7ca5ce896524f5 Richard Gong  2018-11-13  212   * a0: INTEL_SIP_SMC_REG_READ.
7ca5ce896524f5 Richard Gong  2018-11-13  213   * a1: register address.
7ca5ce896524f5 Richard Gong  2018-11-13  214   * a2-7: not used.
7ca5ce896524f5 Richard Gong  2018-11-13  215   *
7ca5ce896524f5 Richard Gong  2018-11-13  216   * Return status:
7ca5ce896524f5 Richard Gong  2018-11-13  217   * a0: INTEL_SIP_SMC_STATUS_OK or INTEL_SIP_SMC_REG_ERROR.
7ca5ce896524f5 Richard Gong  2018-11-13  218   * a1: value in the register
7ca5ce896524f5 Richard Gong  2018-11-13  219   * a2-3: not used.
7ca5ce896524f5 Richard Gong  2018-11-13  220   */
7ca5ce896524f5 Richard Gong  2018-11-13  221  #define INTEL_SIP_SMC_FUNCID_REG_READ 7
7ca5ce896524f5 Richard Gong  2018-11-13  222  #define INTEL_SIP_SMC_REG_READ \
7ca5ce896524f5 Richard Gong  2018-11-13  223  	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_REG_READ)
7ca5ce896524f5 Richard Gong  2018-11-13  224  
b5dc75c915cdae Richard Gong  2019-09-03  225  /**
7ca5ce896524f5 Richard Gong  2018-11-13  226   * Request INTEL_SIP_SMC_REG_WRITE
7ca5ce896524f5 Richard Gong  2018-11-13  227   *
7ca5ce896524f5 Richard Gong  2018-11-13  228   * Write a protected register at EL3
7ca5ce896524f5 Richard Gong  2018-11-13  229   *
7ca5ce896524f5 Richard Gong  2018-11-13  230   * Call register usage:
7ca5ce896524f5 Richard Gong  2018-11-13  231   * a0: INTEL_SIP_SMC_REG_WRITE.
7ca5ce896524f5 Richard Gong  2018-11-13  232   * a1: register address
7ca5ce896524f5 Richard Gong  2018-11-13  233   * a2: value to program into register.
7ca5ce896524f5 Richard Gong  2018-11-13  234   * a3-7: not used.
7ca5ce896524f5 Richard Gong  2018-11-13  235   *
7ca5ce896524f5 Richard Gong  2018-11-13  236   * Return status:
7ca5ce896524f5 Richard Gong  2018-11-13  237   * a0: INTEL_SIP_SMC_STATUS_OK or INTEL_SIP_SMC_REG_ERROR.
7ca5ce896524f5 Richard Gong  2018-11-13  238   * a1-3: not used.
7ca5ce896524f5 Richard Gong  2018-11-13  239   */
7ca5ce896524f5 Richard Gong  2018-11-13  240  #define INTEL_SIP_SMC_FUNCID_REG_WRITE 8
7ca5ce896524f5 Richard Gong  2018-11-13  241  #define INTEL_SIP_SMC_REG_WRITE \
7ca5ce896524f5 Richard Gong  2018-11-13  242  	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_REG_WRITE)
7ca5ce896524f5 Richard Gong  2018-11-13  243  
b5dc75c915cdae Richard Gong  2019-09-03  244  /**
7ca5ce896524f5 Richard Gong  2018-11-13  245   * Request INTEL_SIP_SMC_FUNCID_REG_UPDATE
7ca5ce896524f5 Richard Gong  2018-11-13  246   *
7ca5ce896524f5 Richard Gong  2018-11-13  247   * Update one or more bits in a protected register at EL3 using a
7ca5ce896524f5 Richard Gong  2018-11-13  248   * read-modify-write operation.
7ca5ce896524f5 Richard Gong  2018-11-13  249   *
7ca5ce896524f5 Richard Gong  2018-11-13  250   * Call register usage:
7ca5ce896524f5 Richard Gong  2018-11-13  251   * a0: INTEL_SIP_SMC_REG_UPDATE.
7ca5ce896524f5 Richard Gong  2018-11-13  252   * a1: register address
7ca5ce896524f5 Richard Gong  2018-11-13  253   * a2: write Mask.
7ca5ce896524f5 Richard Gong  2018-11-13  254   * a3: value to write.
7ca5ce896524f5 Richard Gong  2018-11-13  255   * a4-7: not used.
7ca5ce896524f5 Richard Gong  2018-11-13  256   *
7ca5ce896524f5 Richard Gong  2018-11-13  257   * Return status:
7ca5ce896524f5 Richard Gong  2018-11-13  258   * a0: INTEL_SIP_SMC_STATUS_OK or INTEL_SIP_SMC_REG_ERROR.
7ca5ce896524f5 Richard Gong  2018-11-13  259   * a1-3: Not used.
7ca5ce896524f5 Richard Gong  2018-11-13  260   */
7ca5ce896524f5 Richard Gong  2018-11-13  261  #define INTEL_SIP_SMC_FUNCID_REG_UPDATE 9
7ca5ce896524f5 Richard Gong  2018-11-13  262  #define INTEL_SIP_SMC_REG_UPDATE \
7ca5ce896524f5 Richard Gong  2018-11-13  263  	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_REG_UPDATE)
7ca5ce896524f5 Richard Gong  2018-11-13  264  
b5dc75c915cdae Richard Gong  2019-09-03  265  /**
6b50d882d38d5a Richard Gong  2018-11-13  266   * Request INTEL_SIP_SMC_RSU_STATUS
6b50d882d38d5a Richard Gong  2018-11-13  267   *
6b50d882d38d5a Richard Gong  2018-11-13  268   * Request remote status update boot log, call is synchronous.
6b50d882d38d5a Richard Gong  2018-11-13  269   *
6b50d882d38d5a Richard Gong  2018-11-13  270   * Call register usage:
6b50d882d38d5a Richard Gong  2018-11-13  271   * a0 INTEL_SIP_SMC_RSU_STATUS
6b50d882d38d5a Richard Gong  2018-11-13  272   * a1-7 not used
6b50d882d38d5a Richard Gong  2018-11-13  273   *
6b50d882d38d5a Richard Gong  2018-11-13  274   * Return status
6b50d882d38d5a Richard Gong  2018-11-13  275   * a0: Current Image
6b50d882d38d5a Richard Gong  2018-11-13  276   * a1: Last Failing Image
6b50d882d38d5a Richard Gong  2018-11-13  277   * a2: Version | State
6b50d882d38d5a Richard Gong  2018-11-13  278   * a3: Error details | Error location
6b50d882d38d5a Richard Gong  2018-11-13  279   *
6b50d882d38d5a Richard Gong  2018-11-13  280   * Or
6b50d882d38d5a Richard Gong  2018-11-13  281   *
6b50d882d38d5a Richard Gong  2018-11-13  282   * a0: INTEL_SIP_SMC_RSU_ERROR
6b50d882d38d5a Richard Gong  2018-11-13  283   */
6b50d882d38d5a Richard Gong  2018-11-13  284  #define INTEL_SIP_SMC_FUNCID_RSU_STATUS 11
6b50d882d38d5a Richard Gong  2018-11-13  285  #define INTEL_SIP_SMC_RSU_STATUS \
6b50d882d38d5a Richard Gong  2018-11-13  286  	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_STATUS)
6b50d882d38d5a Richard Gong  2018-11-13  287  
b5dc75c915cdae Richard Gong  2019-09-03  288  /**
6b50d882d38d5a Richard Gong  2018-11-13  289   * Request INTEL_SIP_SMC_RSU_UPDATE
6b50d882d38d5a Richard Gong  2018-11-13  290   *
6b50d882d38d5a Richard Gong  2018-11-13  291   * Request to set the offset of the bitstream to boot after reboot, call
6b50d882d38d5a Richard Gong  2018-11-13  292   * is synchronous.
6b50d882d38d5a Richard Gong  2018-11-13  293   *
6b50d882d38d5a Richard Gong  2018-11-13  294   * Call register usage:
6b50d882d38d5a Richard Gong  2018-11-13  295   * a0 INTEL_SIP_SMC_RSU_UPDATE
6b50d882d38d5a Richard Gong  2018-11-13  296   * a1 64bit physical address of the configuration data memory in flash
6b50d882d38d5a Richard Gong  2018-11-13  297   * a2-7 not used
6b50d882d38d5a Richard Gong  2018-11-13  298   *
6b50d882d38d5a Richard Gong  2018-11-13  299   * Return status
6b50d882d38d5a Richard Gong  2018-11-13  300   * a0 INTEL_SIP_SMC_STATUS_OK
6b50d882d38d5a Richard Gong  2018-11-13  301   */
6b50d882d38d5a Richard Gong  2018-11-13  302  #define INTEL_SIP_SMC_FUNCID_RSU_UPDATE 12
6b50d882d38d5a Richard Gong  2018-11-13  303  #define INTEL_SIP_SMC_RSU_UPDATE \
6b50d882d38d5a Richard Gong  2018-11-13  304  	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_UPDATE)
fad9fab975cb9f Thor Thayer   2019-04-02  305  
b5dc75c915cdae Richard Gong  2019-09-03  306  /**
fad9fab975cb9f Thor Thayer   2019-04-02  307   * Request INTEL_SIP_SMC_ECC_DBE
fad9fab975cb9f Thor Thayer   2019-04-02  308   *
fad9fab975cb9f Thor Thayer   2019-04-02  309   * Sync call used by service driver at EL1 to alert EL3 that a Double
fad9fab975cb9f Thor Thayer   2019-04-02  310   * Bit ECC error has occurred.
fad9fab975cb9f Thor Thayer   2019-04-02  311   *
fad9fab975cb9f Thor Thayer   2019-04-02  312   * Call register usage:
fad9fab975cb9f Thor Thayer   2019-04-02  313   * a0 INTEL_SIP_SMC_ECC_DBE
fad9fab975cb9f Thor Thayer   2019-04-02  314   * a1 SysManager Double Bit Error value
fad9fab975cb9f Thor Thayer   2019-04-02  315   * a2-7 not used
fad9fab975cb9f Thor Thayer   2019-04-02  316   *
fad9fab975cb9f Thor Thayer   2019-04-02  317   * Return status
fad9fab975cb9f Thor Thayer   2019-04-02  318   * a0 INTEL_SIP_SMC_STATUS_OK
fad9fab975cb9f Thor Thayer   2019-04-02  319   */
fad9fab975cb9f Thor Thayer   2019-04-02  320  #define INTEL_SIP_SMC_FUNCID_ECC_DBE 13
fad9fab975cb9f Thor Thayer   2019-04-02  321  #define INTEL_SIP_SMC_ECC_DBE \
fad9fab975cb9f Thor Thayer   2019-04-02  322  	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_ECC_DBE)
fad9fab975cb9f Thor Thayer   2019-04-02  323  
b5dc75c915cdae Richard Gong  2019-09-03  324  /**
b5dc75c915cdae Richard Gong  2019-09-03  325   * Request INTEL_SIP_SMC_RSU_NOTIFY
b5dc75c915cdae Richard Gong  2019-09-03  326   *
b5dc75c915cdae Richard Gong  2019-09-03  327   * Sync call used by service driver at EL1 to report hard processor
b5dc75c915cdae Richard Gong  2019-09-03  328   * system execution stage to firmware
b5dc75c915cdae Richard Gong  2019-09-03  329   *
b5dc75c915cdae Richard Gong  2019-09-03  330   * Call register usage:
b5dc75c915cdae Richard Gong  2019-09-03  331   * a0 INTEL_SIP_SMC_RSU_NOTIFY
b5dc75c915cdae Richard Gong  2019-09-03  332   * a1 32bit value representing hard processor system execution stage
b5dc75c915cdae Richard Gong  2019-09-03  333   * a2-7 not used
b5dc75c915cdae Richard Gong  2019-09-03  334   *
b5dc75c915cdae Richard Gong  2019-09-03  335   * Return status
b5dc75c915cdae Richard Gong  2019-09-03  336   * a0 INTEL_SIP_SMC_STATUS_OK
b5dc75c915cdae Richard Gong  2019-09-03  337   */
b5dc75c915cdae Richard Gong  2019-09-03  338  #define INTEL_SIP_SMC_FUNCID_RSU_NOTIFY 14
b5dc75c915cdae Richard Gong  2019-09-03  339  #define INTEL_SIP_SMC_RSU_NOTIFY \
b5dc75c915cdae Richard Gong  2019-09-03  340  	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_NOTIFY)
b5dc75c915cdae Richard Gong  2019-09-03  341  
b5dc75c915cdae Richard Gong  2019-09-03  342  /**
b5dc75c915cdae Richard Gong  2019-09-03  343   * Request INTEL_SIP_SMC_RSU_RETRY_COUNTER
b5dc75c915cdae Richard Gong  2019-09-03  344   *
b5dc75c915cdae Richard Gong  2019-09-03  345   * Sync call used by service driver at EL1 to query RSU retry counter
b5dc75c915cdae Richard Gong  2019-09-03  346   *
b5dc75c915cdae Richard Gong  2019-09-03  347   * Call register usage:
b5dc75c915cdae Richard Gong  2019-09-03  348   * a0 INTEL_SIP_SMC_RSU_RETRY_COUNTER
b5dc75c915cdae Richard Gong  2019-09-03  349   * a1-7 not used
b5dc75c915cdae Richard Gong  2019-09-03  350   *
b5dc75c915cdae Richard Gong  2019-09-03  351   * Return status
b5dc75c915cdae Richard Gong  2019-09-03  352   * a0 INTEL_SIP_SMC_STATUS_OK
b5dc75c915cdae Richard Gong  2019-09-03  353   * a1 the retry counter
b5dc75c915cdae Richard Gong  2019-09-03  354   *
b5dc75c915cdae Richard Gong  2019-09-03  355   * Or
b5dc75c915cdae Richard Gong  2019-09-03  356   *
b5dc75c915cdae Richard Gong  2019-09-03  357   * a0 INTEL_SIP_SMC_RSU_ERROR
b5dc75c915cdae Richard Gong  2019-09-03  358   */
b5dc75c915cdae Richard Gong  2019-09-03  359  #define INTEL_SIP_SMC_FUNCID_RSU_RETRY_COUNTER 15
b5dc75c915cdae Richard Gong  2019-09-03  360  #define INTEL_SIP_SMC_RSU_RETRY_COUNTER \
b5dc75c915cdae Richard Gong  2019-09-03  361  	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_RETRY_COUNTER)
bf0e5bf68a207b Richard Gong  2020-06-15  362  
bf0e5bf68a207b Richard Gong  2020-06-15  363  /**
bf0e5bf68a207b Richard Gong  2020-06-15  364   * Request INTEL_SIP_SMC_RSU_DCMF_VERSION
bf0e5bf68a207b Richard Gong  2020-06-15  365   *
bf0e5bf68a207b Richard Gong  2020-06-15  366   * Sync call used by service driver at EL1 to query DCMF (Decision
bf0e5bf68a207b Richard Gong  2020-06-15  367   * Configuration Management Firmware) version from FW
bf0e5bf68a207b Richard Gong  2020-06-15  368   *
bf0e5bf68a207b Richard Gong  2020-06-15  369   * Call register usage:
bf0e5bf68a207b Richard Gong  2020-06-15  370   * a0 INTEL_SIP_SMC_RSU_DCMF_VERSION
bf0e5bf68a207b Richard Gong  2020-06-15  371   * a1-7 not used
bf0e5bf68a207b Richard Gong  2020-06-15  372   *
bf0e5bf68a207b Richard Gong  2020-06-15  373   * Return status
bf0e5bf68a207b Richard Gong  2020-06-15  374   * a0 INTEL_SIP_SMC_STATUS_OK
bf0e5bf68a207b Richard Gong  2020-06-15  375   * a1 dcmf1 | dcmf0
bf0e5bf68a207b Richard Gong  2020-06-15  376   * a2 dcmf3 | dcmf2
bf0e5bf68a207b Richard Gong  2020-06-15  377   *
bf0e5bf68a207b Richard Gong  2020-06-15  378   * Or
bf0e5bf68a207b Richard Gong  2020-06-15  379   *
bf0e5bf68a207b Richard Gong  2020-06-15  380   * a0 INTEL_SIP_SMC_RSU_ERROR
bf0e5bf68a207b Richard Gong  2020-06-15  381   */
bf0e5bf68a207b Richard Gong  2020-06-15  382  #define INTEL_SIP_SMC_FUNCID_RSU_DCMF_VERSION 16
bf0e5bf68a207b Richard Gong  2020-06-15  383  #define INTEL_SIP_SMC_RSU_DCMF_VERSION \
bf0e5bf68a207b Richard Gong  2020-06-15  384  	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_DCMF_VERSION)
bf0e5bf68a207b Richard Gong  2020-06-15  385  
bf0e5bf68a207b Richard Gong  2020-06-15  386  /**
bf0e5bf68a207b Richard Gong  2020-06-15  387   * Request INTEL_SIP_SMC_RSU_MAX_RETRY
bf0e5bf68a207b Richard Gong  2020-06-15  388   *
bf0e5bf68a207b Richard Gong  2020-06-15  389   * Sync call used by service driver at EL1 to query max retry value from FW
bf0e5bf68a207b Richard Gong  2020-06-15  390   *
bf0e5bf68a207b Richard Gong  2020-06-15  391   * Call register usage:
bf0e5bf68a207b Richard Gong  2020-06-15  392   * a0 INTEL_SIP_SMC_RSU_MAX_RETRY
bf0e5bf68a207b Richard Gong  2020-06-15  393   * a1-7 not used
bf0e5bf68a207b Richard Gong  2020-06-15  394   *
bf0e5bf68a207b Richard Gong  2020-06-15  395   * Return status
bf0e5bf68a207b Richard Gong  2020-06-15  396   * a0 INTEL_SIP_SMC_STATUS_OK
bf0e5bf68a207b Richard Gong  2020-06-15  397   * a1 max retry value
bf0e5bf68a207b Richard Gong  2020-06-15  398   *
bf0e5bf68a207b Richard Gong  2020-06-15  399   * Or
bf0e5bf68a207b Richard Gong  2020-06-15  400   * a0 INTEL_SIP_SMC_RSU_ERROR
bf0e5bf68a207b Richard Gong  2020-06-15  401   */
bf0e5bf68a207b Richard Gong  2020-06-15  402  #define INTEL_SIP_SMC_FUNCID_RSU_MAX_RETRY 18
bf0e5bf68a207b Richard Gong  2020-06-15  403  #define INTEL_SIP_SMC_RSU_MAX_RETRY \
bf0e5bf68a207b Richard Gong  2020-06-15  404  	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_MAX_RETRY)
19e0bcb19109ac Ang Tien Sung 2022-03-14  405  
19e0bcb19109ac Ang Tien Sung 2022-03-14 @406   * Request INTEL_SIP_SMC_SERVICE_COMPLETED
19e0bcb19109ac Ang Tien Sung 2022-03-14  407   * Sync call to check if the secure world have completed service request
19e0bcb19109ac Ang Tien Sung 2022-03-14  408   * or not.
19e0bcb19109ac Ang Tien Sung 2022-03-14  409   *
19e0bcb19109ac Ang Tien Sung 2022-03-14  410   * Call register usage:
19e0bcb19109ac Ang Tien Sung 2022-03-14  411   * a0: INTEL_SIP_SMC_SERVICE_COMPLETED
19e0bcb19109ac Ang Tien Sung 2022-03-14  412   * a1: the physical address for secure firmware to put output data
19e0bcb19109ac Ang Tien Sung 2022-03-14  413   * a2: size
19e0bcb19109ac Ang Tien Sung 2022-03-14  414   * a3-a7: not used
19e0bcb19109ac Ang Tien Sung 2022-03-14  415   *
19e0bcb19109ac Ang Tien Sung 2022-03-14  416   * Return status:
19e0bcb19109ac Ang Tien Sung 2022-03-14  417   * a0: INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_ERROR,
19e0bcb19109ac Ang Tien Sung 2022-03-14  418   *     INTEL_SIP_SMC_REJECTED or INTEL_SIP_SMC_STATUS_BUSY
19e0bcb19109ac Ang Tien Sung 2022-03-14  419   * a1: physical address for the output daat
19e0bcb19109ac Ang Tien Sung 2022-03-14  420   * a2: output data size
19e0bcb19109ac Ang Tien Sung 2022-03-14  421   */
19e0bcb19109ac Ang Tien Sung 2022-03-14  422  #define INTEL_SIP_SMC_FUNCID_SERVICE_COMPLETED 30
19e0bcb19109ac Ang Tien Sung 2022-03-14  423  #define INTEL_SIP_SMC_SERVICE_COMPLETED \
19e0bcb19109ac Ang Tien Sung 2022-03-14  424  	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_SERVICE_COMPLETED)
19e0bcb19109ac Ang Tien Sung 2022-03-14  425  

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
