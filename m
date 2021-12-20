Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300A347B647
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 00:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhLTXve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 18:51:34 -0500
Received: from mga04.intel.com ([192.55.52.120]:63181 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230155AbhLTXvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 18:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640044293; x=1671580293;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=825SKF4lonUtoVZOI3apuJmktrwRZh5DSjnDcvikato=;
  b=W2ZDhIlix3HoDJ4Z8WanYgPQ3BW6KrB3Mh+EtoYI/HyHA03sRSBGJ4s9
   qX2TVPA9rw8/QgC66949ZZNRIltPENqR5A219Qt+f2Fzmim0IbboMBnBx
   3H0JH/ymXlFcebJ8r/2JnZzWCEsvah30aXTsM8RUYIDxeCD016+G3wOpU
   yiZlYsih0MhhENSg3gYBdm8v1NSnmhXKBjLa6zhvVKM3bti+ErY5Gq7jL
   BzBi+c4He8Ah+L3VzwQBo/8oQGUFqZ6KoIdg9iZmertmtpweX8Wt0uqlq
   tSfMwXxkKLFE+TVcZJKH6sXWW/Q0TM99U7h0quWlRuD5l0ZADMYoRI7AC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="239035611"
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="239035611"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 15:51:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="616578347"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 20 Dec 2021 15:51:31 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzSRG-0008QK-IN; Mon, 20 Dec 2021 23:51:30 +0000
Date:   Tue, 21 Dec 2021 07:51:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Cc:     kbuild-all@lists.01.org, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org
Subject: [chao:feature/dax 8/9] fs/f2fs/file.c:1106:24: error: implicit
 declaration of function 'dax_layout_busy_page'
Message-ID: <202112210758.BoWlhZBt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git feature/dax
head:   d08999836fd60ab725eee1f5a5fb3b00f7bcefd3
commit: ddf2be0f55254d0a1a8bc51f2c1597c09b1dd2aa [8/9] f2fs: handle layout changes to pinned DAX mappings
config: microblaze-randconfig-r015-20211220 (https://download.01.org/0day-ci/archive/20211221/202112210758.BoWlhZBt-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?id=ddf2be0f55254d0a1a8bc51f2c1597c09b1dd2aa
        git remote add chao https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git
        git fetch --no-tags chao feature/dax
        git checkout ddf2be0f55254d0a1a8bc51f2c1597c09b1dd2aa
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash fs/f2fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from fs/f2fs/file.c:8:
   fs/f2fs/file.c: In function 'f2fs_file_mmap':
   fs/f2fs/file.c:584:14: error: implicit declaration of function 'daxdev_mapping_supported' [-Werror=implicit-function-declaration]
     584 |         if (!daxdev_mapping_supported(vma, F2FS_I_SB(inode)->s_daxdev))
         |              ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
      58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   fs/f2fs/file.c:584:9: note: in expansion of macro 'if'
     584 |         if (!daxdev_mapping_supported(vma, F2FS_I_SB(inode)->s_daxdev))
         |         ^~
   fs/f2fs/file.c: In function 'f2fs_break_layouts':
>> fs/f2fs/file.c:1106:24: error: implicit declaration of function 'dax_layout_busy_page' [-Werror=implicit-function-declaration]
    1106 |                 page = dax_layout_busy_page(inode->i_mapping);
         |                        ^~~~~~~~~~~~~~~~~~~~
>> fs/f2fs/file.c:1106:22: warning: assignment to 'struct page *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1106 |                 page = dax_layout_busy_page(inode->i_mapping);
         |                      ^
   cc1: some warnings being treated as errors


vim +/dax_layout_busy_page +1106 fs/f2fs/file.c

  1096	
  1097	int f2fs_break_layouts(struct inode *inode)
  1098	{
  1099		struct page *page;
  1100		int error;
  1101	
  1102		if (WARN_ON_ONCE(!rwsem_is_locked(&inode->i_mapping->invalidate_lock)))
  1103			return -EINVAL;
  1104	
  1105		do {
> 1106			page = dax_layout_busy_page(inode->i_mapping);
  1107			if (!page)
  1108				return 0;
  1109	
  1110			error = ___wait_var_event(&page->_refcount,
  1111					atomic_read(&page->_refcount) == 1,
  1112					TASK_INTERRUPTIBLE, 0, 0,
  1113					f2fs_wait_dax_page(inode));
  1114		} while (error == 0);
  1115	
  1116		return error;
  1117	}
  1118	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
