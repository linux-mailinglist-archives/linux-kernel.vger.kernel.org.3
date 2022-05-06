Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444C551CE71
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387680AbiEFAz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241986AbiEFAzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:55:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172BE1EEEA;
        Thu,  5 May 2022 17:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651798334; x=1683334334;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RXBway8aqei9K09kwNWoZBifM54ZYmb3DHugyR1DrrE=;
  b=SSYRXYOv/dsqv8NAe25PQB2ZqVMsK/dKt4WbJ2P2aEXkHERSoW0a+bLW
   nllkvgmnzOKpyacYp8vkR/2KLn/knxK4OR+HAx5doqF3sflh1lVSTSrqs
   HbUvL/wLOJDgrx991P9OhqJarxCly/hWkSnpQfEBO/1J1Q/p9vBhR1fQB
   5Rub0NLigmY2ixHoNCJMALUSyfu9VLWXz3PwfZ+YctnA8yS+iLWxQi7Rx
   wW5SGskzuoTxChxEUnIoKLtXdlftUGWZfJZl/NNOJszKMsJNsDKh21aVr
   Ahrm2SwNJqo3ZPjy9SdD8EU7A0fhj+s1bbD3JDsiFKZIiJFbNxbQofEcU
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="268201722"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="268201722"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 17:52:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="585667620"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 05 May 2022 17:52:11 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmmCZ-000CtK-7u;
        Fri, 06 May 2022 00:52:11 +0000
Date:   Fri, 6 May 2022 08:51:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Moulding <dmoulding@me.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-doc@vger.kernel.org,
        tglx@linutronix.de, akpm@linux-foundation.org, corbet@lwn.net,
        Dan Moulding <dmoulding@me.com>
Subject: Re: [PATCH 1/1] init: Add "hostname" kernel parameter
Message-ID: <202205060821.6KCNxZBf-lkp@intel.com>
References: <20220505180651.22849-2-dmoulding@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505180651.22849-2-dmoulding@me.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on hnaz-mm/master linus/master v5.18-rc5 next-20220505]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Dan-Moulding/Allow-setting-hostname-before-userspace-starts/20220506-023146
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 107c948d1d3e61d10aee9d0f7c3d81bbee9842af
config: riscv-randconfig-r042-20220505 (https://download.01.org/0day-ci/archive/20220506/202205060821.6KCNxZBf-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1071875b349d9b8307eb0f4d23dda06a2301fe03
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Dan-Moulding/Allow-setting-hostname-before-userspace-starts/20220506-023146
        git checkout 1071875b349d9b8307eb0f4d23dda06a2301fe03
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   init/version.c: In function 'early_hostname':
>> init/version.c:45:9: warning: 'strncpy' specified bound 65 equals destination size [-Wstringop-truncation]
      45 |         strncpy(init_uts_ns.name.nodename, arg, bufsize);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +45 init/version.c

    39	
    40	static int __init early_hostname(char *arg)
    41	{
    42		size_t bufsize = sizeof(init_uts_ns.name.nodename);
    43		size_t maxlen  = bufsize - 1;
    44	
  > 45		strncpy(init_uts_ns.name.nodename, arg, bufsize);
    46		if (strlen(arg) > maxlen) {
    47			pr_warn("hostname parameter exceeds %zd characters and will be truncated",
    48				maxlen);
    49			init_uts_ns.name.nodename[maxlen] = '\0';
    50		}
    51		return 0;
    52	}
    53	early_param("hostname", early_hostname);
    54	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
