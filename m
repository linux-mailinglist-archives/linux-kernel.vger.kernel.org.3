Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8D953DE79
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 23:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348056AbiFEVyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 17:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiFEVyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 17:54:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9AA25D9
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 14:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654466041; x=1686002041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S3EW8RPbsmeWe2P3TetCDIDC1Ez1339KoCM37Z2SAgs=;
  b=M63oJoyzCm8zOD2SRXhP8YllTAlTPeUyybL9lIE5CIOuMiFI/+cX5evZ
   uv6RFcp4pPqHr6Scd70uo3ZX02uus9kwnLQa43mlSHwvwX+pJrYC+Bmd2
   X5y7x3OPiVeXyhZkOJS7MFOn5/GPHKJglwmNIX2z5j1/PZWPrh6cBWLXw
   sVdZJLmpaGExoXunaytEQXcjjdXdxwPWGtK6axXv0z2Z0BhbLeeMcZMtH
   vXY46dfMP2Ge3Z944Po3c+L5SUI4CfPNB3TwVQA1FJC8LSaVCIl/52eJh
   q7mj+mpuesrM2Fhjn04bTCMD9m6TfXZwQmeSpAWL3xrwdpv+zcWxEPYBM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="276406636"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="276406636"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 14:54:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="531869373"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 Jun 2022 14:53:58 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxyC6-000CHd-3k;
        Sun, 05 Jun 2022 21:53:58 +0000
Date:   Mon, 6 Jun 2022 05:53:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v1 1/1] kernel.h: Move sysfs related macro to sysfs.h
Message-ID: <202206060529.iKPUpMUp-lkp@intel.com>
References: <20220603172101.49950-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603172101.49950-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v5.18 next-20220603]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/kernel-h-Move-sysfs-related-macro-to-sysfs-h/20220606-004344
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: arm-at91_dt_defconfig (https://download.01.org/0day-ci/archive/20220606/202206060529.iKPUpMUp-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0fad3ce70c6f6736d3913e3238642a056f70b123
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/kernel-h-Move-sysfs-related-macro-to-sysfs-h/20220606-004344
        git checkout 0fad3ce70c6f6736d3913e3238642a056f70b123
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arm/mm/alignment.c:11:
>> include/linux/moduleparam.h:294:13: error: implicit declaration of function 'VERIFY_OCTAL_PERMISSIONS' [-Werror=implicit-function-declaration]
     294 |             VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:330:9: note: in expansion of macro '__module_param_call'
     330 |         __module_param_call("", name, &param_ops_##type, &var, perm, -1, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   arch/arm/mm/alignment.c:87:1: note: in expansion of macro 'core_param'
      87 | core_param(alignment, ai_usermode, int, 0600);
         | ^~~~~~~~~~
>> include/linux/moduleparam.h:294:13: error: initializer element is not constant
     294 |             VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:330:9: note: in expansion of macro '__module_param_call'
     330 |         __module_param_call("", name, &param_ops_##type, &var, perm, -1, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   arch/arm/mm/alignment.c:87:1: note: in expansion of macro 'core_param'
      87 | core_param(alignment, ai_usermode, int, 0600);
         | ^~~~~~~~~~
   include/linux/moduleparam.h:294:13: note: (near initialization for '__param_alignment.perm')
     294 |             VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:330:9: note: in expansion of macro '__module_param_call'
     330 |         __module_param_call("", name, &param_ops_##type, &var, perm, -1, 0)
         |         ^~~~~~~~~~~~~~~~~~~
   arch/arm/mm/alignment.c:87:1: note: in expansion of macro 'core_param'
      87 | core_param(alignment, ai_usermode, int, 0600);
         | ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/VERIFY_OCTAL_PERMISSIONS +294 include/linux/moduleparam.h

91d35dd93e14c3 Ivan Kokshaysky 2008-02-13  284  
^1da177e4c3f41 Linus Torvalds  2005-04-16  285  /* This is the fundamental function for registering boot/module
546970bc6afc7f Rusty Russell   2010-08-11  286     parameters. */
91f9d330cc1493 Jani Nikula     2014-08-27  287  #define __module_param_call(prefix, name, ops, arg, perm, level, flags)	\
9774a1f54f173a Alexey Dobriyan 2006-12-06  288  	/* Default value instead of permissions? */			\
22e48eaf587d04 Jan Beulich     2007-10-16  289  	static const char __param_str_##name[] = prefix #name;		\
91d35dd93e14c3 Ivan Kokshaysky 2008-02-13  290  	static struct kernel_param __moduleparam_const __param_##name	\
fe2f4fe139b321 Johan Hovold    2020-11-23  291  	__used __section("__param")					\
fe2f4fe139b321 Johan Hovold    2020-11-23  292  	__aligned(__alignof__(struct kernel_param))			\
b51d23e4e9fea6 Dan Streetman   2015-06-17  293  	= { __param_str_##name, THIS_MODULE, ops,			\
b51d23e4e9fea6 Dan Streetman   2015-06-17 @294  	    VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
^1da177e4c3f41 Linus Torvalds  2005-04-16  295  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
