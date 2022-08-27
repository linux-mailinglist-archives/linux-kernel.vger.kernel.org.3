Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBCA5A39E3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 21:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiH0TrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 15:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiH0TrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 15:47:16 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1964E1EF
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 12:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661629635; x=1693165635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yNB0l+bW56hu/+fUvmGz/Xwj9wXUK6Ds+0g+l6YnadE=;
  b=fnERP6HwWk1nrjUvYzTTk/EB36EIzY9f+mp5EwhmveqEEcEdxCGkexDt
   hu/OxATNVUYrzi6uvelLl6oH8YReCTgn9g24iIzyqfk7LFPa0h0avBnax
   o0bEy2ToxRl9Igpeqf/xxYUS+DTvQsgtzeuZcioYZPo5OecDhB/HqUB9x
   Fhu3dhyD9YRsoKqULhMKNj5bVP+rEbumJ998e05T1mvp7YSn+5l/xhBji
   W4YsFh8WmUo70yEnne0f2pXR1Ltlc6wpdTBDaPlywNS24XE/CgHUtbkgE
   NmfpbH+lmIpN9RjDBY3SkUyHfSqkLLM0knxNSnYYwcsdRQ/cOTYm13Z16
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10452"; a="292265763"
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="292265763"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 12:47:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="561789386"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 Aug 2022 12:47:12 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oS1lv-0000QT-18;
        Sat, 27 Aug 2022 19:47:11 +0000
Date:   Sun, 28 Aug 2022 03:46:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shaomin Deng <dengshaomin@cdjrlc.com>, agk@redhat.com,
        snitzer@kernel.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: Re: [PATCH] dm: Remove the unneeeded variable
Message-ID: <202208280313.Avg378Ql-lkp@intel.com>
References: <20220827163848.24296-1-dengshaomin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220827163848.24296-1-dengshaomin@cdjrlc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shaomin,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v6.0-rc2]
[also build test ERROR on linus/master next-20220826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shaomin-Deng/dm-Remove-the-unneeeded-variable/20220828-004044
base:    1c23f9e627a7b412978b4e852793c5e3c3efc555
config: riscv-randconfig-r003-20220828 (https://download.01.org/0day-ci/archive/20220828/202208280313.Avg378Ql-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project a2100daf12fb980a29fd1a9c85ccf8eaaaf79730)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/fd20974ffc753b102401c766eb62117c276a1527
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Shaomin-Deng/dm-Remove-the-unneeeded-variable/20220828-004044
        git checkout fd20974ffc753b102401c766eb62117c276a1527
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/md/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/md/dm-log.c:810:3: error: use of undeclared identifier 'sz'
                   DMEMIT("3 %s %s %c", log->type->name, lc->log_dev->name,
                   ^
   include/linux/device-mapper.h:615:22: note: expanded from macro 'DMEMIT'
   #define DMEMIT(x...) sz += ((sz >= maxlen) ? \
                        ^
>> drivers/md/dm-log.c:810:3: error: use of undeclared identifier 'sz'
   include/linux/device-mapper.h:615:30: note: expanded from macro 'DMEMIT'
   #define DMEMIT(x...) sz += ((sz >= maxlen) ? \
                                ^
>> drivers/md/dm-log.c:810:3: error: use of undeclared identifier 'sz'
   include/linux/device-mapper.h:616:29: note: expanded from macro 'DMEMIT'
                             0 : scnprintf(result + sz, maxlen - sz, x))
                                                    ^
>> drivers/md/dm-log.c:810:3: error: use of undeclared identifier 'sz'
   include/linux/device-mapper.h:616:42: note: expanded from macro 'DMEMIT'
                             0 : scnprintf(result + sz, maxlen - sz, x))
                                                                 ^
   drivers/md/dm-log.c:817:3: error: use of undeclared identifier 'sz'
                   DMEMIT("%s %u %s %u ", log->type->name,
                   ^
   include/linux/device-mapper.h:615:22: note: expanded from macro 'DMEMIT'
   #define DMEMIT(x...) sz += ((sz >= maxlen) ? \
                        ^
   drivers/md/dm-log.c:817:3: error: use of undeclared identifier 'sz'
   include/linux/device-mapper.h:615:30: note: expanded from macro 'DMEMIT'
   #define DMEMIT(x...) sz += ((sz >= maxlen) ? \
                                ^
   drivers/md/dm-log.c:817:3: error: use of undeclared identifier 'sz'
   include/linux/device-mapper.h:616:29: note: expanded from macro 'DMEMIT'
                             0 : scnprintf(result + sz, maxlen - sz, x))
                                                    ^
   drivers/md/dm-log.c:817:3: error: use of undeclared identifier 'sz'
   include/linux/device-mapper.h:616:42: note: expanded from macro 'DMEMIT'
                             0 : scnprintf(result + sz, maxlen - sz, x))
                                                                 ^
   drivers/md/dm-log.c:820:3: error: use of undeclared identifier 'sz'
                   DMEMIT_SYNC;
                   ^
   drivers/md/dm-log.c:776:3: note: expanded from macro 'DMEMIT_SYNC'
                   DMEMIT("%ssync ", lc->sync == NOSYNC ? "no" : "")
                   ^
   include/linux/device-mapper.h:615:22: note: expanded from macro 'DMEMIT'
   #define DMEMIT(x...) sz += ((sz >= maxlen) ? \
                        ^
   drivers/md/dm-log.c:820:3: error: use of undeclared identifier 'sz'
   drivers/md/dm-log.c:776:3: note: expanded from macro 'DMEMIT_SYNC'
                   DMEMIT("%ssync ", lc->sync == NOSYNC ? "no" : "")
                   ^
   include/linux/device-mapper.h:615:30: note: expanded from macro 'DMEMIT'
   #define DMEMIT(x...) sz += ((sz >= maxlen) ? \
                                ^
   drivers/md/dm-log.c:820:3: error: use of undeclared identifier 'sz'
   drivers/md/dm-log.c:776:3: note: expanded from macro 'DMEMIT_SYNC'
                   DMEMIT("%ssync ", lc->sync == NOSYNC ? "no" : "")
                   ^
   include/linux/device-mapper.h:616:29: note: expanded from macro 'DMEMIT'
                             0 : scnprintf(result + sz, maxlen - sz, x))
                                                    ^
   drivers/md/dm-log.c:820:3: error: use of undeclared identifier 'sz'
   drivers/md/dm-log.c:776:3: note: expanded from macro 'DMEMIT_SYNC'
                   DMEMIT("%ssync ", lc->sync == NOSYNC ? "no" : "")
                   ^
   include/linux/device-mapper.h:616:42: note: expanded from macro 'DMEMIT'
                             0 : scnprintf(result + sz, maxlen - sz, x))
                                                                 ^
   12 errors generated.


vim +/sz +810 drivers/md/dm-log.c

^1da177e4c3f41 Linus Torvalds     2005-04-16  802  
416cd17b198221 Heinz Mauelshagen  2008-04-24  803  static int disk_status(struct dm_dirty_log *log, status_type_t status,
^1da177e4c3f41 Linus Torvalds     2005-04-16  804  		       char *result, unsigned int maxlen)
^1da177e4c3f41 Linus Torvalds     2005-04-16  805  {
^1da177e4c3f41 Linus Torvalds     2005-04-16  806  	struct log_c *lc = log->context;
^1da177e4c3f41 Linus Torvalds     2005-04-16  807  
^1da177e4c3f41 Linus Torvalds     2005-04-16  808  	switch(status) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  809  	case STATUSTYPE_INFO:
315dcc226f066c Jonathan E Brassow 2007-05-09 @810  		DMEMIT("3 %s %s %c", log->type->name, lc->log_dev->name,
64b30c46e866bb Mikulas Patocka    2009-12-10  811  		       lc->log_dev_flush_failed ? 'F' :
64b30c46e866bb Mikulas Patocka    2009-12-10  812  		       lc->log_dev_failed ? 'D' :
64b30c46e866bb Mikulas Patocka    2009-12-10  813  		       'A');
^1da177e4c3f41 Linus Torvalds     2005-04-16  814  		break;
^1da177e4c3f41 Linus Torvalds     2005-04-16  815  
^1da177e4c3f41 Linus Torvalds     2005-04-16  816  	case STATUSTYPE_TABLE:
^1da177e4c3f41 Linus Torvalds     2005-04-16  817  		DMEMIT("%s %u %s %u ", log->type->name,
315dcc226f066c Jonathan E Brassow 2007-05-09  818  		       lc->sync == DEFAULTSYNC ? 2 : 3, lc->log_dev->name,
^1da177e4c3f41 Linus Torvalds     2005-04-16  819  		       lc->region_size);
^1da177e4c3f41 Linus Torvalds     2005-04-16  820  		DMEMIT_SYNC;
8ec456629d0bf0 Tushar Sugandhi    2021-07-12  821  		break;
8ec456629d0bf0 Tushar Sugandhi    2021-07-12  822  
8ec456629d0bf0 Tushar Sugandhi    2021-07-12  823  	case STATUSTYPE_IMA:
8ec456629d0bf0 Tushar Sugandhi    2021-07-12  824  		*result = '\0';
8ec456629d0bf0 Tushar Sugandhi    2021-07-12  825  		break;
^1da177e4c3f41 Linus Torvalds     2005-04-16  826  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  827  
fd20974ffc753b Shaomin Deng       2022-08-27  828  	return 0;
^1da177e4c3f41 Linus Torvalds     2005-04-16  829  }
^1da177e4c3f41 Linus Torvalds     2005-04-16  830  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
