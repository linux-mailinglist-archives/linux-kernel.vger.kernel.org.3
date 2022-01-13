Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA8148DDBB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbiAMSfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:35:02 -0500
Received: from mga03.intel.com ([134.134.136.65]:35168 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230151AbiAMSfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:35:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642098901; x=1673634901;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=M1x1I2ZaoP0gBUI/PDkLCK7zbYHlaPsdpAvqy842+wM=;
  b=cKmQ4BiAYOpiRlx9ymyjOL46iGmIh1TuRB9UPK8oKZXWB3eAb24NiKLt
   X3FA4sjQ1Q6nmk7zfwSRpWwdW1zUD/D3pDQu4h8bcJFMi2/p0Ms5Gzz8E
   6GVbfZ4bjkhwCLCK8PnYQHARg3CIutk2lecwmDB6sGjZBWbqK2QXU4Sip
   GTfokj3u3t6umFCIZCYtDwq/jHOqcb7xecIoM3SsKdxWSSVK0oBNjT00Q
   xVAH1bW1AQvAu0Xn3XYbIzl4xMpLj+GL4aOvqIERZ8kHWmJNW0STl4PKC
   f2a1HWsxgxwJ1U+a5viIaJXUF2kvM+w+58W51zJCRmpIopafd6soNA7XG
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="244039894"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="244039894"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 10:35:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="516042666"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 13 Jan 2022 10:34:59 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n84w7-0007XT-6z; Thu, 13 Jan 2022 18:34:59 +0000
Date:   Fri, 14 Jan 2022 02:34:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/s390/net/qeth_core_main.c:6194:9: warning: 'strncpy'
 specified bound 20 equals destination size
Message-ID: <202201140208.SgphJJdy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   455e73a07f6e288b0061dfcf4fcf54fa9fe06458
commit: 334ef6ed06fa1a54e35296b77b693bcf6d63ee9e init/Kconfig: make COMPILE_TEST depend on !S390
date:   1 year, 2 months ago
config: s390-randconfig-r016-20220113 (https://download.01.org/0day-ci/archive/20220114/202201140208.SgphJJdy-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=334ef6ed06fa1a54e35296b77b693bcf6d63ee9e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 334ef6ed06fa1a54e35296b77b693bcf6d63ee9e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/s390/net/qeth_core_main.c: In function 'qeth_dbf_longtext':
   drivers/s390/net/qeth_core_main.c:6066:9: warning: function 'qeth_dbf_longtext' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    6066 |         vsnprintf(dbf_txt_buf, sizeof(dbf_txt_buf), fmt, args);
         |         ^~~~~~~~~
   drivers/s390/net/qeth_core_main.c: In function 'qeth_add_dbf_entry':
>> drivers/s390/net/qeth_core_main.c:6194:9: warning: 'strncpy' specified bound 20 equals destination size [-Wstringop-truncation]
    6194 |         strncpy(new_entry->dbf_name, name, DBF_NAME_LEN);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +6194 drivers/s390/net/qeth_core_main.c

819dc537fd7fcd Stefan Raspl 2013-01-21  6179  
819dc537fd7fcd Stefan Raspl 2013-01-21  6180  static int qeth_add_dbf_entry(struct qeth_card *card, char *name)
819dc537fd7fcd Stefan Raspl 2013-01-21  6181  {
819dc537fd7fcd Stefan Raspl 2013-01-21  6182  	struct qeth_dbf_entry *new_entry;
819dc537fd7fcd Stefan Raspl 2013-01-21  6183  
819dc537fd7fcd Stefan Raspl 2013-01-21  6184  	card->debug = debug_register(name, 2, 1, 8);
819dc537fd7fcd Stefan Raspl 2013-01-21  6185  	if (!card->debug) {
819dc537fd7fcd Stefan Raspl 2013-01-21  6186  		QETH_DBF_TEXT_(SETUP, 2, "%s", "qcdbf");
819dc537fd7fcd Stefan Raspl 2013-01-21  6187  		goto err;
819dc537fd7fcd Stefan Raspl 2013-01-21  6188  	}
819dc537fd7fcd Stefan Raspl 2013-01-21  6189  	if (debug_register_view(card->debug, &debug_hex_ascii_view))
819dc537fd7fcd Stefan Raspl 2013-01-21  6190  		goto err_dbg;
819dc537fd7fcd Stefan Raspl 2013-01-21  6191  	new_entry = kzalloc(sizeof(struct qeth_dbf_entry), GFP_KERNEL);
819dc537fd7fcd Stefan Raspl 2013-01-21  6192  	if (!new_entry)
819dc537fd7fcd Stefan Raspl 2013-01-21  6193  		goto err_dbg;
819dc537fd7fcd Stefan Raspl 2013-01-21 @6194  	strncpy(new_entry->dbf_name, name, DBF_NAME_LEN);
819dc537fd7fcd Stefan Raspl 2013-01-21  6195  	new_entry->dbf_info = card->debug;
819dc537fd7fcd Stefan Raspl 2013-01-21  6196  	mutex_lock(&qeth_dbf_list_mutex);
819dc537fd7fcd Stefan Raspl 2013-01-21  6197  	list_add(&new_entry->dbf_list, &qeth_dbf_list);
819dc537fd7fcd Stefan Raspl 2013-01-21  6198  	mutex_unlock(&qeth_dbf_list_mutex);
819dc537fd7fcd Stefan Raspl 2013-01-21  6199  
819dc537fd7fcd Stefan Raspl 2013-01-21  6200  	return 0;
819dc537fd7fcd Stefan Raspl 2013-01-21  6201  
819dc537fd7fcd Stefan Raspl 2013-01-21  6202  err_dbg:
819dc537fd7fcd Stefan Raspl 2013-01-21  6203  	debug_unregister(card->debug);
819dc537fd7fcd Stefan Raspl 2013-01-21  6204  err:
819dc537fd7fcd Stefan Raspl 2013-01-21  6205  	return -ENOMEM;
819dc537fd7fcd Stefan Raspl 2013-01-21  6206  }
819dc537fd7fcd Stefan Raspl 2013-01-21  6207  

:::::: The code at line 6194 was first introduced by commit
:::::: 819dc537fd7fcd799c5f7f85693d29e2635a84f9 qeth: Make s390dbf card entries persistent

:::::: TO: Stefan Raspl <raspl@linux.vnet.ibm.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
