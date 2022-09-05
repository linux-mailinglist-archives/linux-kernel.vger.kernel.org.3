Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5135ADBE4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 01:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiIEX2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 19:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiIEX2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 19:28:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A849258DEF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 16:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662420483; x=1693956483;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zxh+oOorwr2X74jc3gzeWqpVrVOTyGXFjScPKn6QTUI=;
  b=VnpnaPEU51KyfNcRIYB42tklqPXeB7BfknLxwsbrvwL2vghct90AsrG1
   EqDbdl5W9dtFPBkF1yg/OKvUbWVmjOPBEiOVqZorb5ovciXuyMzs20mOH
   QIms+bk2wqvINMDovCe6mcRv/baDMhP7n6ASAFPlQ+sY9NUUOSl+qyEpL
   q7wWcdNu8dMhctmv4nJs4wtydj7nbx302bx+wZjX1xO86gjO/0xAMxnSr
   nSkgBdawSEYHSLG+EJzAUdkpY+qVE10x4n+Tui2A9PySN4eqc88dyfgSB
   nPQL25PLxj8XyC3057H2ZI5uhRjbRW1jDBB/I2r4NuYK0EYt6ztLJnDso
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="276202470"
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="276202470"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 16:28:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,292,1654585200"; 
   d="scan'208";a="682188538"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 05 Sep 2022 16:28:02 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVLVZ-0004d1-2r;
        Mon, 05 Sep 2022 23:28:01 +0000
Date:   Tue, 6 Sep 2022 07:27:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_aia_v1 21/41] include/linux/cpuhotplug.h:287:
 undefined reference to `ipi_mux_create'
Message-ID: <202209060754.NTMLgEr3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_kvm_aia_v1
head:   98a7169ff2516ac22eecb21f2267097400d67ea9
commit: 7a7eae3dbc24b9a2169dc19a742f0e6da65fe69b [21/41] RISC-V: Treat IPIs as normal Linux IRQs
config: riscv-randconfig-c003-20220905 (https://download.01.org/0day-ci/archive/20220906/202209060754.NTMLgEr3-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/avpatel/linux/commit/7a7eae3dbc24b9a2169dc19a742f0e6da65fe69b
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_kvm_aia_v1
        git checkout 7a7eae3dbc24b9a2169dc19a742f0e6da65fe69b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: drivers/clocksource/timer-clint.o: in function `cpuhp_setup_state':
>> include/linux/cpuhotplug.h:287: undefined reference to `ipi_mux_create'


vim +287 include/linux/cpuhotplug.h

cff7d378d3fdbb Thomas Gleixner           2016-02-26  261  
5b7aa87e0482be Thomas Gleixner           2016-02-26  262  int __cpuhp_setup_state(enum cpuhp_state state,	const char *name, bool invoke,
5b7aa87e0482be Thomas Gleixner           2016-02-26  263  			int (*startup)(unsigned int cpu),
cf392d10b69e6e Thomas Gleixner           2016-08-12  264  			int (*teardown)(unsigned int cpu), bool multi_instance);
5b7aa87e0482be Thomas Gleixner           2016-02-26  265  
71def423fe3da0 Sebastian Andrzej Siewior 2017-05-24  266  int __cpuhp_setup_state_cpuslocked(enum cpuhp_state state, const char *name,
71def423fe3da0 Sebastian Andrzej Siewior 2017-05-24  267  				   bool invoke,
71def423fe3da0 Sebastian Andrzej Siewior 2017-05-24  268  				   int (*startup)(unsigned int cpu),
71def423fe3da0 Sebastian Andrzej Siewior 2017-05-24  269  				   int (*teardown)(unsigned int cpu),
71def423fe3da0 Sebastian Andrzej Siewior 2017-05-24  270  				   bool multi_instance);
5b7aa87e0482be Thomas Gleixner           2016-02-26  271  /**
c9871c800f65ff Thomas Gleixner           2021-09-09  272   * cpuhp_setup_state - Setup hotplug state callbacks with calling the @startup
c9871c800f65ff Thomas Gleixner           2021-09-09  273   *                     callback
5b7aa87e0482be Thomas Gleixner           2016-02-26  274   * @state:	The state for which the calls are installed
5b7aa87e0482be Thomas Gleixner           2016-02-26  275   * @name:	Name of the callback (will be used in debug output)
c9871c800f65ff Thomas Gleixner           2021-09-09  276   * @startup:	startup callback function or NULL if not required
c9871c800f65ff Thomas Gleixner           2021-09-09  277   * @teardown:	teardown callback function or NULL if not required
5b7aa87e0482be Thomas Gleixner           2016-02-26  278   *
c9871c800f65ff Thomas Gleixner           2021-09-09  279   * Installs the callback functions and invokes the @startup callback on
c9871c800f65ff Thomas Gleixner           2021-09-09  280   * the online cpus which have already reached the @state.
5b7aa87e0482be Thomas Gleixner           2016-02-26  281   */
5b7aa87e0482be Thomas Gleixner           2016-02-26  282  static inline int cpuhp_setup_state(enum cpuhp_state state,
5b7aa87e0482be Thomas Gleixner           2016-02-26  283  				    const char *name,
5b7aa87e0482be Thomas Gleixner           2016-02-26  284  				    int (*startup)(unsigned int cpu),
5b7aa87e0482be Thomas Gleixner           2016-02-26  285  				    int (*teardown)(unsigned int cpu))
5b7aa87e0482be Thomas Gleixner           2016-02-26  286  {
cf392d10b69e6e Thomas Gleixner           2016-08-12 @287  	return __cpuhp_setup_state(state, name, true, startup, teardown, false);
5b7aa87e0482be Thomas Gleixner           2016-02-26  288  }
5b7aa87e0482be Thomas Gleixner           2016-02-26  289  

:::::: The code at line 287 was first introduced by commit
:::::: cf392d10b69e6e6c57ceea48b347a2ab1a4b75b2 cpu/hotplug: Add multi instance support

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
