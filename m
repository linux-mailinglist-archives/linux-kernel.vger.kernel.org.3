Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0074C50ACBB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 02:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442901AbiDVAWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 20:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiDVAWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 20:22:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B9744A2C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 17:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650586770; x=1682122770;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=waJ2WI7UIrtRsCzLFsWBPUOCBra7zi8gq9vAo7d3Iw0=;
  b=MmCAi1AD9x5oKCKzCclBSH2EezlmKwdDvDzrMNn9xPoHlIXKjYvokSj0
   5Ft1S0uHw09WpxedHcJDKQZKLnghShUI4gv1BWU25GKw2gUPsW9h9jHdQ
   Eb1BrJwqto+hXfc00K9JnMPut7FHATwthbPCYSDq41R+16OdxVMVCwxzX
   0EBqn91KNekQjW6SYUFhs/sw5FqmljOIhbGepmQLSL4nfbQmbk+nXhlNn
   6954DT0/mqQVW2cBjxNIEyfjiajp6xvK6cwD5IaZn7sc+OBfWr7Oilxnw
   0m61iz6kzZyNFyKSGzf/1AlTROygGH51qjP5YGpCvOU1mxH1xPsI8IK+A
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="350962559"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="350962559"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 17:19:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="805742061"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 21 Apr 2022 17:19:28 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhh1E-00090I-0l;
        Fri, 22 Apr 2022 00:19:28 +0000
Date:   Fri, 22 Apr 2022 08:18:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     YunQiang Su <yunqiang.su@cipunited.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/boot/compressed/dbg.c:12:13: warning: no previous
 prototype for 'putc'
Message-ID: <202204220803.gjpqZj5l-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YunQiang,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   59f0c2447e2553b0918b4a9fd38763a5c0587d02
commit: 31b2f3dc851c65fee288612432c4fc956f1a264e MIPS: enable both vmlinux.gz.itb and vmlinuz for generic
date:   4 months ago
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20220422/202204220803.gjpqZj5l-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=31b2f3dc851c65fee288612432c4fc956f1a264e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 31b2f3dc851c65fee288612432c4fc956f1a264e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/mips/boot/compressed/dbg.c:12:13: warning: no previous prototype for 'putc' [-Wmissing-prototypes]
      12 | void __weak putc(char c)
         |             ^~~~
>> arch/mips/boot/compressed/dbg.c:16:6: warning: no previous prototype for 'puts' [-Wmissing-prototypes]
      16 | void puts(const char *s)
         |      ^~~~
>> arch/mips/boot/compressed/dbg.c:26:6: warning: no previous prototype for 'puthex' [-Wmissing-prototypes]
      26 | void puthex(unsigned long long val)
         |      ^~~~~~


vim +/putc +12 arch/mips/boot/compressed/dbg.c

1b93b3c3e94be2 Wu Zhangjin 2009-10-14  11  
e52dd9fc6b9e0c Wu Zhangjin 2010-01-26 @12  void __weak putc(char c)
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  13  {
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  14  }
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  15  
1b93b3c3e94be2 Wu Zhangjin 2009-10-14 @16  void puts(const char *s)
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  17  {
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  18  	char c;
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  19  	while ((c = *s++) != '\0') {
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  20  		putc(c);
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  21  		if (c == '\n')
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  22  			putc('\r');
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  23  	}
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  24  }
1b93b3c3e94be2 Wu Zhangjin 2009-10-14  25  
1b93b3c3e94be2 Wu Zhangjin 2009-10-14 @26  void puthex(unsigned long long val)

:::::: The code at line 12 was first introduced by commit
:::::: e52dd9fc6b9e0c17b220bd38371ff15032a1a155 MIPS: Simplify the weak annotation with __weak

:::::: TO: Wu Zhangjin <wuzhangjin@gmail.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
