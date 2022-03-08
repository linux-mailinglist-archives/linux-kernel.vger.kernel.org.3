Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDD24D271F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiCIBkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiCIBkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:40:31 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F47D5DD5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646789965; x=1678325965;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nq7TLCy8Yv0GpYqMYR80Z81yi6Re6AZfB/yw1zWXOKo=;
  b=e/FLFR308T1YQ3rYAXS7g1GyUKuzR0jkyCO1xNS92pULmqC31cY2db/m
   tT02dkX6WI0HD/9FKaRrlWQsjDf6WzjeAyfenym6aulCprqERcgXkVmZR
   9zpEHRucmFanNO4yllm3tVVBk8VxNXPNdjn34rx5USKY3IC8Kv33Ervsv
   +m+780OfQrbSaolI1/+KryD8zmppLf07TIDJz2CaEM98PZsBG0CKqUPCE
   uO26kGewuwHT8Gcw8TVARGZVWcYeKxiHshX95Ij9dUa+jmuTUDjjzLV+R
   HZD9v+6O/BxErbhrCgzmK8L83LDRCZGMgD9jx+i4E43uvMJuvJyt6PPZO
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="252412567"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="252412567"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 15:30:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="711729553"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 08 Mar 2022 15:30:43 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRjHu-0002BJ-H4; Tue, 08 Mar 2022 23:30:42 +0000
Date:   Wed, 9 Mar 2022 07:30:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.10
 3194/9999] kernel/module.c:4792:6: warning: no previous prototype for
 function 'android_debug_for_each_module'
Message-ID: <202203090739.89kwW2Yp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elliot,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.10
head:   8ffc7ff817fe552592daa2b0de1760e3539663f3
commit: 0bb433e0140efece0a1ce8124283cb68fda33a3f [3194/9999] ANDROID: debug_symbols: Add android_debug_for_each_module
config: i386-randconfig-a013-20220307 (https://download.01.org/0day-ci/archive/20220309/202203090739.89kwW2Yp-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/0bb433e0140efece0a1ce8124283cb68fda33a3f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.10
        git checkout 0bb433e0140efece0a1ce8124283cb68fda33a3f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/module.c:4792:6: warning: no previous prototype for function 'android_debug_for_each_module' [-Wmissing-prototypes]
   void android_debug_for_each_module(int (*fn)(const char *mod_name, void *mod_addr, void *data),
        ^
   kernel/module.c:4792:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void android_debug_for_each_module(int (*fn)(const char *mod_name, void *mod_addr, void *data),
   ^
   static 
   1 warning generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for ASYNC_TX_ENABLE_CHANNEL_SWITCH
   Depends on DMADEVICES
   Selected by
   - GKI_HIDDEN_DMA_CONFIGS


vim +/android_debug_for_each_module +4792 kernel/module.c

  4790	
  4791	#ifdef CONFIG_ANDROID_DEBUG_SYMBOLS
> 4792	void android_debug_for_each_module(int (*fn)(const char *mod_name, void *mod_addr, void *data),
  4793		void *data)
  4794	{
  4795		struct module *module;
  4796	
  4797		preempt_disable();
  4798		list_for_each_entry_rcu(module, &modules, list) {
  4799			if (fn(module->name, module->core_layout.base, data))
  4800				goto out;
  4801		}
  4802	out:
  4803		preempt_enable();
  4804	}
  4805	EXPORT_SYMBOL_GPL(android_debug_for_each_module);
  4806	#endif
  4807	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
