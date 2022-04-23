Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00ACF50C774
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 06:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbiDWFAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 01:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiDWFAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 01:00:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A32D1A921A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 21:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650689869; x=1682225869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xGggyQUO1bhk35uzumc+QrFv6rg6rQZPFjQ9Dm76t08=;
  b=EZnlKtWBcbiHEuALex6ecEJvFxjrnv6YkYynHqQda8iJOIr7Qh3gz/cz
   kvBKKWgnO2tnaV1Lt2sIz36xnshphcDIvnqHHSIJ1Y5nwabRrIQ7WMuog
   FrJhW6JE4pOLaIC0Vd+uYCmIip0z/nGe1xi1k29TwZd5Tt//OrXepDRrA
   sWKOD4arpVMtPeohZMx7R1K/7wOzAOKFTpbMtvbaKXWjdVuAi8vTwQozJ
   6wJKTBEcSzZ2cGLqQ6OxILR1lOivQ9PVuHhxkqKcmNvNibRJZWCiYOYQ+
   +zLZRWF6OdYNf+KlwiFHMlQwFTb8ZpO1CdZMiEo4NEUeEBMHmLRpQciTU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="252182197"
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="252182197"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 21:57:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="563325645"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 22 Apr 2022 21:57:45 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ni7q4-000B1r-So;
        Sat, 23 Apr 2022 04:57:44 +0000
Date:   Sat, 23 Apr 2022 12:57:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Donghai Qiao <dqiao@redhat.com>, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, arnd@arndb.de, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com
Cc:     kbuild-all@lists.01.org, donghai.w.qiao@gmail.com,
        linux-kernel@vger.kernel.org, Donghai Qiao <dqiao@redhat.com>
Subject: Re: [PATCH v2 01/11] smp: consolidate the structure definitions to
 smp.h
Message-ID: <202204231212.Os1QwhiN-lkp@intel.com>
References: <20220422200040.93813-2-dqiao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422200040.93813-2-dqiao@redhat.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Donghai,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on rafael-pm/linux-next linus/master v5.18-rc3 next-20220422]
[cannot apply to tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Donghai-Qiao/smp-cross-CPU-call-interface/20220423-060436
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: sparc-randconfig-r026-20220422 (https://download.01.org/0day-ci/archive/20220423/202204231212.Os1QwhiN-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1c14bdafe09740690b249824f3526527e4c02d2a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Donghai-Qiao/smp-cross-CPU-call-interface/20220423-060436
        git checkout 1c14bdafe09740690b249824f3526527e4c02d2a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash lib/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/kref.h:16,
                    from include/linux/mm_types.h:8,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from lib/test_bitops.c:9:
>> include/linux/smp.h:131:14: error: 'seq_type' defined but not used [-Werror=unused-variable]
     131 | static char *seq_type[] = {
         |              ^~~~~~~~
   cc1: all warnings being treated as errors


vim +/seq_type +131 include/linux/smp.h

   130	
 > 131	static char *seq_type[] = {
   132		[CFD_SEQ_QUEUE]		= "queue",
   133		[CFD_SEQ_IPI]		= "ipi",
   134		[CFD_SEQ_NOIPI]		= "noipi",
   135		[CFD_SEQ_PING]		= "ping",
   136		[CFD_SEQ_PINGED]	= "pinged",
   137		[CFD_SEQ_HANDLE]	= "handle",
   138		[CFD_SEQ_DEQUEUE]	= "dequeue (src CPU 0 == empty)",
   139		[CFD_SEQ_IDLE]		= "idle",
   140		[CFD_SEQ_GOTIPI]	= "gotipi",
   141		[CFD_SEQ_HDLEND]	= "hdlend (src CPU 0 == early)",
   142	};
   143	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
