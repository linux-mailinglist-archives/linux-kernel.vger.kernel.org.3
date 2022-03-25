Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726F54E7DDD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiCYUGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbiCYUGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:06:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7C391AD0;
        Fri, 25 Mar 2022 13:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648238469; x=1679774469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6k+DJ48aVd7N/P40eA7ak4kwTvd6Fg58OSC9AHzaH94=;
  b=YjJK/OC6C8h8Z8yEU5a5O/hyAhzfNn2JPFKg6YWJbW6ir57VQdC3iCWT
   unpEMvLixHLSH6zX8os9ukLwRQyNMgl9nfkmbZIzIAEzq/9b+CFGdXXqX
   4gPV02lPZlXNmfg6TKGVDuPpt3yzBO6LvsuX0oCEcfJJFO36onCm4rkWb
   zETiL1UzPGqrbh/fTqb8ziW2pJD4uyYwktkoqQNL1vxcTqg/kpvrczn1P
   2lxoEs/DQsFGnOI1xO+Vh0QpWX7iXLM+T0Llf4Y2bDWEgZuIQTdgkmNt8
   Xfw8E2KYzUnW+bFeFTmV3qdqPvCPUZyhetKFDB60itGRo3g+qFOABRcVz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="345145685"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="345145685"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 13:01:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="545205990"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 25 Mar 2022 13:01:06 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXq7N-000MY6-Kz; Fri, 25 Mar 2022 20:01:05 +0000
Date:   Sat, 26 Mar 2022 04:01:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v1 1/1] Makefile.extrawarn: Turn off -Werror when extra
 warnings are enabled
Message-ID: <202203260359.nhs6ZZb9-lkp@intel.com>
References: <20220325131348.3995-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325131348.3995-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.17 next-20220325]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/Makefile-extrawarn-Turn-off-Werror-when-extra-warnings-are-enabled/20220325-211517
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 34af78c4e616c359ed428d79fe4758a35d2c5473
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220326/202203260359.nhs6ZZb9-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/6b5eeef1471c693165f2bdec5fb19c2ba20e9345
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Andy-Shevchenko/Makefile-extrawarn-Turn-off-Werror-when-extra-warnings-are-enabled/20220325-211517
        git checkout 6b5eeef1471c693165f2bdec5fb19c2ba20e9345
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> clang-15: warning: 'x86_64' does not support '-mno-outline-atomics'; flag ignored [-Woption-ignored]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
