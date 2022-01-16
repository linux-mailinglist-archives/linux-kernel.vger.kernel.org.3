Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C672A48FED6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 21:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbiAPUdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 15:33:21 -0500
Received: from mga07.intel.com ([134.134.136.100]:1456 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236143AbiAPUdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 15:33:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642365197; x=1673901197;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ScSyL19dnqJjEmA+jUX5mCWrkYZzjobm6YH2ILOC3Mg=;
  b=EoZgjdjPjHmLIfSTkOisExzS9ypHQvW7P8Elp+5cAN8FkcxAnVps9HVw
   nFTyfDjl2DWZQj5mhg/3VxO/EAR7f6sZkfyrCs8VcELenq8pd09k4POnr
   27yVzZZ0EK30SIzPMkf7MCrrrfZ44sGbjitzBhSawKJ27a5S9o7IO+Z+F
   d7Lnp2igQGBZ/x2NtDdkfhm5IcsoSzENMH6PSgarhcKnR/LEHHaRqx//6
   /nXEDpR7ztBufDLAHT3R8CKq9dc5X9S4X14q27nGu4YOItO4Cz0VzvGcn
   ovHl5UaSZpHHenkRKnrF4J2zknnwdeHgixgG1uUkS5P66NqK7eeH8Rg47
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="307855393"
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="307855393"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 12:33:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,293,1635231600"; 
   d="scan'208";a="692853549"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 Jan 2022 12:33:14 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9CDC-000AyC-5m; Sun, 16 Jan 2022 20:33:14 +0000
Date:   Mon, 17 Jan 2022 04:33:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: include/linux/seq_file.h:262:9: warning: 'strncpy' output may be
 truncated copying 4 bytes from a string of length 4
Message-ID: <202201170456.6rWV7FEz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   79e06c4c4950be2abd8ca5d2428a8c915aa62c24
commit: dd03762ab608e058c8f390ad9cf667e490089796 arm64: Enable KCSAN
date:   5 weeks ago
config: arm64-buildonly-randconfig-r001-20220116 (https://download.01.org/0day-ci/archive/20220117/202201170456.6rWV7FEz-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dd03762ab608e058c8f390ad9cf667e490089796
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout dd03762ab608e058c8f390ad9cf667e490089796
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/char/ipmi/ drivers/pci/controller/ fs/ocfs2/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/seq_file_net.h:5,
                    from include/net/net_namespace.h:181,
                    from include/linux/inet.h:42,
                    from fs/ocfs2/super.c:21:
   fs/ocfs2/super.c: In function 'ocfs2_show_options':
>> include/linux/seq_file.h:262:9: warning: 'strncpy' output may be truncated copying 4 bytes from a string of length 4 [-Wstringop-truncation]
     262 |         strncpy(val_buf, value, length);                \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/ocfs2/super.c:1539:17: note: in expansion of macro 'seq_show_option_n'
    1539 |                 seq_show_option_n(s, "cluster_stack", osb->osb_cluster_stack,
         |                 ^~~~~~~~~~~~~~~~~
--
   drivers/char/ipmi/ipmi_msghandler.c: In function 'send_panic_events':
>> drivers/char/ipmi/ipmi_msghandler.c:5283:17: warning: 'strncpy' specified bound 11 equals destination size [-Wstringop-truncation]
    5283 |                 strncpy(data+5, p, 11);
         |                 ^~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +262 include/linux/seq_file.h

a068acf2ee77693 Kees Cook 2015-09-04  248  
a068acf2ee77693 Kees Cook 2015-09-04  249  /**
a068acf2ee77693 Kees Cook 2015-09-04  250   * seq_show_option_n - display mount options with appropriate escapes
a068acf2ee77693 Kees Cook 2015-09-04  251   *		       where @value must be a specific length.
a068acf2ee77693 Kees Cook 2015-09-04  252   * @m: the seq_file handle
a068acf2ee77693 Kees Cook 2015-09-04  253   * @name: the mount option name
a068acf2ee77693 Kees Cook 2015-09-04  254   * @value: the mount option name's value, cannot be NULL
a068acf2ee77693 Kees Cook 2015-09-04  255   * @length: the length of @value to display
a068acf2ee77693 Kees Cook 2015-09-04  256   *
a068acf2ee77693 Kees Cook 2015-09-04  257   * This is a macro since this uses "length" to define the size of the
a068acf2ee77693 Kees Cook 2015-09-04  258   * stack buffer.
a068acf2ee77693 Kees Cook 2015-09-04  259   */
a068acf2ee77693 Kees Cook 2015-09-04  260  #define seq_show_option_n(m, name, value, length) {	\
a068acf2ee77693 Kees Cook 2015-09-04  261  	char val_buf[length + 1];			\
a068acf2ee77693 Kees Cook 2015-09-04 @262  	strncpy(val_buf, value, length);		\
a068acf2ee77693 Kees Cook 2015-09-04  263  	val_buf[length] = '\0';				\
a068acf2ee77693 Kees Cook 2015-09-04  264  	seq_show_option(m, name, val_buf);		\
a068acf2ee77693 Kees Cook 2015-09-04  265  }
a068acf2ee77693 Kees Cook 2015-09-04  266  

:::::: The code at line 262 was first introduced by commit
:::::: a068acf2ee77693e0bf39d6e07139ba704f461c3 fs: create and use seq_show_option for escaping

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
