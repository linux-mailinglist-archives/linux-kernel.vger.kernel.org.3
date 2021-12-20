Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A658F47B5F7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 23:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhLTWta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 17:49:30 -0500
Received: from mga05.intel.com ([192.55.52.43]:24856 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230348AbhLTWt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 17:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640040569; x=1671576569;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=my0KIrmXAw+5z5ffRD5IcbXV6540slU+/vIMI7WMMZM=;
  b=ct+MZTT9f7tPJ02G9V0yI13yYrXxngQVG/axBDkzNSAvDkOagNZXtH34
   qiEgDpVMZBrop5DenvGJhQiWgI56NbSga2adUtrybU+NiN4d/UlpKyoWo
   vOTPXPj0BLsFYXrwWJR8nW2fH56pqs5L9a53KKUIqP57L/EUsM8PXCOL4
   zK94788TgSufL45WXD455XN8DvshE7OazAq2rosvr4RDDgLPNAzqox7Fl
   1bBintoyYZ7vx7x0dBXz7Wq+U4NdueDk556Bsg2O2SCrgTj0FG5OQ2v1M
   47SbT73PuJqjqJmNwnsUunqHMrV7Vzq+kucK3AOQTcNLk02H/oWXqBkF8
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="326580722"
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="326580722"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 14:49:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="467563796"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 20 Dec 2021 14:49:27 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzRTC-0008N0-S2; Mon, 20 Dec 2021 22:49:26 +0000
Date:   Tue, 21 Dec 2021 06:49:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Cc:     kbuild-all@lists.01.org, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org
Subject: [chao:feature/dax 5/9] fs/f2fs/data.c:4178:16: error: implicit
 declaration of function 'dax_writeback_mapping_range'
Message-ID: <202112210648.cDXIAYGW-lkp@intel.com>
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
config: microblaze-randconfig-r015-20211220 (https://download.01.org/0day-ci/archive/20211221/202112210648.cDXIAYGW-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?id=2908c6445a36c37b0af40ba94f72c957a87d8fd8
        git remote add chao https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git
        git fetch --no-tags chao feature/dax
        git checkout 2908c6445a36c37b0af40ba94f72c957a87d8fd8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash fs/f2fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/f2fs/data.c: In function 'f2fs_dax_writepages':
>> fs/f2fs/data.c:4178:16: error: implicit declaration of function 'dax_writeback_mapping_range' [-Werror=implicit-function-declaration]
    4178 |         return dax_writeback_mapping_range(mapping, sbi->s_daxdev, wbc);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


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
