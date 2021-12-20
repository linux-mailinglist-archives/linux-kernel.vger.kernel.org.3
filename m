Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0105A47AFF2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239181AbhLTPW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:22:58 -0500
Received: from mga12.intel.com ([192.55.52.136]:63822 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237448AbhLTPWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:22:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640013722; x=1671549722;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l8AMP3pMeTOE0Bebgw47YiCbv8lrzVYPL5lB+0HCag0=;
  b=W0wAk8QJgRYODsYmey9Und7gxzn6ZS31BUnWB8tif5TW7vyJ1U+VuZDG
   tyuB7IaediATvNGso461+l51u1U02SOfQ8JRMOD2+xwESdayky6YBBXEq
   qdNU/TM/iS/iYBd1QKwBFlx745bKawqAbTdQpA8xjEpb2eK8Se9ESlfw5
   7I7ggyo77WQfVqzCbDc5OrjIwKPlMYRGpc30AfIbb1D2/sAGqKiI4ANIQ
   vyIp9z7Pl0pE6gAmswubFIPG7MCk4KU5X0RzgGWKVq48KVYSC6siSyiCx
   /fupG0FyY7+MZN9wj2Q8K8LnWeG+JbuzIoM9N/IymNXzu6+rUPhBudQGJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="220208161"
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="220208161"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 07:20:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="757330263"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 20 Dec 2021 07:20:10 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzKSP-0007ug-H5; Mon, 20 Dec 2021 15:20:09 +0000
Date:   Mon, 20 Dec 2021 23:19:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [chao:feature/dax 5/9] fs/f2fs/data.c:4178:9: error: implicit
 declaration of function 'dax_writeback_mapping_range'
Message-ID: <202112202302.OWA4emnZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git feature/dax
head:   d08999836fd60ab725eee1f5a5fb3b00f7bcefd3
commit: 2908c6445a36c37b0af40ba94f72c957a87d8fd8 [5/9] f2fs: support dax address space operation
config: mips-randconfig-r002-20211220 (https://download.01.org/0day-ci/archive/20211220/202112202302.OWA4emnZ-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 683cbc12b33e5c8dc8d29bf5ed79fbf45763aadd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?id=2908c6445a36c37b0af40ba94f72c957a87d8fd8
        git remote add chao https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git
        git fetch --no-tags chao feature/dax
        git checkout 2908c6445a36c37b0af40ba94f72c957a87d8fd8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash fs/f2fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/f2fs/data.c:4178:9: error: implicit declaration of function 'dax_writeback_mapping_range' [-Werror,-Wimplicit-function-declaration]
           return dax_writeback_mapping_range(mapping, sbi->s_daxdev, wbc);
                  ^
   1 error generated.


vim +/dax_writeback_mapping_range +4178 fs/f2fs/data.c

  4169	
  4170	static int f2fs_dax_writepages(struct address_space *mapping,
  4171						struct writeback_control *wbc)
  4172	{
  4173		struct f2fs_sb_info *sbi = F2FS_I_SB(mapping->host);
  4174	
  4175		if (unlikely(f2fs_cp_error(sbi)))
  4176			return -EIO;
  4177	
> 4178		return dax_writeback_mapping_range(mapping, sbi->s_daxdev, wbc);
  4179	}
  4180	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
