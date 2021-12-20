Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760CA47B11D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 17:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238105AbhLTQc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 11:32:28 -0500
Received: from mga03.intel.com ([134.134.136.65]:36040 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237052AbhLTQc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:32:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640017947; x=1671553947;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AmeYQ2+C1rq8NgcMuvBbnlKuOlgOSEfDw7amnUjKDY8=;
  b=F/Pvv9bVJuc1uKua0jjDTsHN4Eu9qkTk6rSk2nbgV0I721akvS/Bz+W1
   T4zqrdIRWGVB07654zjXI6Hp5iBlNhvL5gKWuqePs1YvoE0M5tDJ2lpxP
   PxxGHJgRfdsm75aO43Bg2OqeLiWRTD+Iik1LMv4iHO2LbL6Pkf6U0RefZ
   PRLpgtU+cAE62A+GbTd/5YUhqGC29pz1Je3VTmj2xltfzr5q5wnizP3Lr
   01UifAI5xs5YMwdOgBEvzGQ1LQYUBP3wSfUn6pVvIxjIF6ubz+IlgTHcN
   ReyVy0AZKi7MYACDEiSa8/Q89oewB6IZG37V3DkiaL73/qbflT8QRxLxf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="240170939"
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="240170939"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 08:32:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="569903457"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 20 Dec 2021 08:32:12 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzLa7-0007zD-H4; Mon, 20 Dec 2021 16:32:11 +0000
Date:   Tue, 21 Dec 2021 00:31:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [chao:feature/dax 8/9] fs/f2fs/file.c:1106:10: error: implicit
 declaration of function 'dax_layout_busy_page'
Message-ID: <202112210031.prMeKhRK-lkp@intel.com>
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
config: mips-randconfig-r002-20211220 (https://download.01.org/0day-ci/archive/20211221/202112210031.prMeKhRK-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 683cbc12b33e5c8dc8d29bf5ed79fbf45763aadd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?id=ddf2be0f55254d0a1a8bc51f2c1597c09b1dd2aa
        git remote add chao https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git
        git fetch --no-tags chao feature/dax
        git checkout ddf2be0f55254d0a1a8bc51f2c1597c09b1dd2aa
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash fs/f2fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   fs/f2fs/file.c:584:7: error: implicit declaration of function 'daxdev_mapping_supported' [-Werror,-Wimplicit-function-declaration]
           if (!daxdev_mapping_supported(vma, F2FS_I_SB(inode)->s_daxdev))
                ^
>> fs/f2fs/file.c:1106:10: error: implicit declaration of function 'dax_layout_busy_page' [-Werror,-Wimplicit-function-declaration]
                   page = dax_layout_busy_page(inode->i_mapping);
                          ^
>> fs/f2fs/file.c:1106:8: warning: incompatible integer to pointer conversion assigning to 'struct page *' from 'int' [-Wint-conversion]
                   page = dax_layout_busy_page(inode->i_mapping);
                        ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 2 errors generated.


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
