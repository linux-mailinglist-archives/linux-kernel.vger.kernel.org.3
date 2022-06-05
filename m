Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153DC53DE94
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 00:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351661AbiFEWOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 18:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245368AbiFEWOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 18:14:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C1A4A3C9
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 15:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654467242; x=1686003242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OqAu0TIQgKHqhNgNYHS6ymIPIAjfxpIImb7kHTeFIag=;
  b=RC4Wh/1QUHtUzN5ho7pIZg2msKrh6OfBYO2LCLQKo7EAvqwmZaFpaXNJ
   OAdyc4EB2Bjl2QW6uBS9KLLGuscDsWpEGsLglEMylUAZWviVB0dEk8UtA
   TAkgwBQTjakvvDTly2SsEzmyB2RnaLlVEEOdbKQ8+JTjS/H0l/8ZuedIL
   FsfVrTPO/FiUqKMLori/G3bOqr6LJfI5ncJz6nPHUCB8yjUkgDa/LCQWT
   3SjsWiOdZ+EIQDKSEk9DSaN1n+6xdq7JcLN9gtew7SD9T3AmLagoLGW1e
   pe2w2GBO6AKpPM1VZH1eaHE9XQr4NUxIDxmcgIJFnGE7lwO7OwjZtWgg1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="258741655"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="258741655"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 15:14:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="758314031"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 05 Jun 2022 15:13:59 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxyVS-000CI3-CX;
        Sun, 05 Jun 2022 22:13:58 +0000
Date:   Mon, 6 Jun 2022 06:13:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v1 1/1] kernel.h: Move sysfs related macro to sysfs.h
Message-ID: <202206060647.TvX3UWaq-lkp@intel.com>
References: <20220603172101.49950-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603172101.49950-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
config: arm-pcm027_defconfig (https://download.01.org/0day-ci/archive/20220606/202206060647.TvX3UWaq-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 416a5080d89066029f9889dc23f94de47c2fa895)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/0fad3ce70c6f6736d3913e3238642a056f70b123
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/kernel-h-Move-sysfs-related-macro-to-sysfs-h/20220606-004344
        git checkout 0fad3ce70c6f6736d3913e3238642a056f70b123
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/arm/mm/alignment.c:87:1: error: call to undeclared function 'VERIFY_OCTAL_PERMISSIONS'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   core_param(alignment, ai_usermode, int, 0600);
   ^
   include/linux/moduleparam.h:330:2: note: expanded from macro 'core_param'
           __module_param_call("", name, &param_ops_##type, &var, perm, -1, 0)
           ^
   include/linux/moduleparam.h:294:6: note: expanded from macro '__module_param_call'
               VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
               ^
>> arch/arm/mm/alignment.c:87:1: error: initializer element is not a compile-time constant
   core_param(alignment, ai_usermode, int, 0600);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:330:2: note: expanded from macro 'core_param'
           __module_param_call("", name, &param_ops_##type, &var, perm, -1, 0)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/moduleparam.h:294:6: note: expanded from macro '__module_param_call'
               VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +/VERIFY_OCTAL_PERMISSIONS +87 arch/arm/mm/alignment.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  86  
d944d549aa86e0 Russell King   2010-02-20 @87  core_param(alignment, ai_usermode, int, 0600);
d944d549aa86e0 Russell King   2010-02-20  88  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
