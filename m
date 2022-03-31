Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8680C4ED78B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 12:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbiCaKIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 06:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbiCaKIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 06:08:02 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5799369CD
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 03:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648721174; x=1680257174;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XvJz3a1518vqn7QRBPgtGZuGTdlKtmBcEY0FBxjEmWg=;
  b=Ym3HspwZT8afPBMCtNxDPzUoA6pYXpV67fZuboo+fItlmlukcJmrjPMt
   tRzvD8clpomF0PQkPgJ//3BfkZX9xqP/ksWbgIyNNr6o7aT48wJ2IUFLf
   iWVCDKcxXN5EOt3etQiamFV6Wbk0/ut5cROOoJ2fCv4JmhYYoiVN7W61b
   yd3hptXglXa1ax8gP+y7Fv3QFCBhnS2AI8ZnFVso9CX8yyikqrhojiaWN
   z2JSzMwEq9aerJHrV6r3LKgSYVIV1CZtKun7hBih5DX5T3EVisvjzNV/u
   tEsegm8vbsyJ+mIu92xfOqbE7i2gsMlfb4K8lAI/NCqpVFWvSS6JHD28n
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="247284437"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="247284437"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 03:06:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="503680432"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 31 Mar 2022 03:06:01 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZrgm-00009L-IB;
        Thu, 31 Mar 2022 10:06:00 +0000
Date:   Thu, 31 Mar 2022 18:05:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [vishal:cxl-osc 1/3] include/linux/acpi.h:1013:55: warning:
 declaration of 'struct acpi_osc_context' will not be visible outside of this
 function
Message-ID: <202203311839.nb45wpQK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vishal/linux.git cxl-osc
head:   1b14cb29c313c4288f576c2480ba62a7721a2e9b
commit: c2618c3e767f53a8a62b82eaa919082378c925e5 [1/3] acpi: add a helper for retrieving _OSC Control DWORDs
config: hexagon-randconfig-r035-20220331 (https://download.01.org/0day-ci/archive/20220331/202203311839.nb45wpQK-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 881350a92d821d4f8e4fa648443ed1d17e251188)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/vishal/linux.git/commit/?id=c2618c3e767f53a8a62b82eaa919082378c925e5
        git remote add vishal https://git.kernel.org/pub/scm/linux/kernel/git/vishal/linux.git
        git fetch --no-tags vishal cxl-osc
        git checkout c2618c3e767f53a8a62b82eaa919082378c925e5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/char/tpm/st33zp24/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/char/tpm/st33zp24/st33zp24.c:21:
   In file included from drivers/char/tpm/st33zp24/../tpm.h:27:
   In file included from include/linux/tpm.h:21:
>> include/linux/acpi.h:1013:55: warning: declaration of 'struct acpi_osc_context' will not be visible outside of this function [-Wvisibility]
   static inline u32 acpi_osc_ctx_get_pci_control(struct acpi_osc_context *context)
                                                         ^
   In file included from drivers/char/tpm/st33zp24/st33zp24.c:21:
   In file included from drivers/char/tpm/st33zp24/../tpm.h:28:
   include/linux/tpm_eventlog.h:167:6: warning: variable 'mapping_size' set but not used [-Wunused-but-set-variable]
           int mapping_size;
               ^
   2 warnings generated.
--
   In file included from drivers/char/tpm/st33zp24/i2c.c:8:
   In file included from include/linux/i2c.h:13:
>> include/linux/acpi.h:1013:55: warning: declaration of 'struct acpi_osc_context' will not be visible outside of this function [-Wvisibility]
   static inline u32 acpi_osc_ctx_get_pci_control(struct acpi_osc_context *context)
                                                         ^
   In file included from drivers/char/tpm/st33zp24/i2c.c:17:
   In file included from drivers/char/tpm/st33zp24/../tpm.h:28:
   include/linux/tpm_eventlog.h:167:6: warning: variable 'mapping_size' set but not used [-Wunused-but-set-variable]
           int mapping_size;
               ^
   drivers/char/tpm/st33zp24/i2c.c:285:34: warning: unused variable 'of_st33zp24_i2c_match' [-Wunused-const-variable]
   static const struct of_device_id of_st33zp24_i2c_match[] = {
                                    ^
   drivers/char/tpm/st33zp24/i2c.c:291:36: warning: unused variable 'st33zp24_i2c_acpi_match' [-Wunused-const-variable]
   static const struct acpi_device_id st33zp24_i2c_acpi_match[] = {
                                      ^
   4 warnings generated.


vim +1013 include/linux/acpi.h

  1009	
  1010	static inline void acpi_unregister_wakeup_handler(
  1011		bool (*wakeup)(void *context), void *context) { }
  1012	
> 1013	static inline u32 acpi_osc_ctx_get_pci_control(struct acpi_osc_context *context)
  1014	{
  1015		return 0;
  1016	}
  1017	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
