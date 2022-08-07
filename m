Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267F358BCEA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 22:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiHGU27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 16:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiHGU24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 16:28:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED24564C4
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 13:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659904135; x=1691440135;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jJY85f0xRbhXpvvmezXbIZ2pZOB5s6SJ0cH5JblyMKI=;
  b=JWPdiJRFRZ0Bqu9LxDacuY92c5xtjl46dDFqJgQzXYo4FWGR64SUh7IK
   K0m/HCu2Mc5N9fJyhncyP+0EGxDt+Jctfm00Ggh3qL6t9wRRidDvFnxHI
   cjpb5LGOeeTnhN8EjNbVTONhTiqF/YQboCCdLw8wQdOw/SrAPDoZELFSD
   VAstTiFmFX+dDgjpmzpebZW11wOSlrH1YBdbqttsH1NocI8ZpOxkxFtAo
   8hyq1owwNrHSzRRk0Jnz2IMs/9S948JurhC3Vwd5cuKVOtZIGOFle1n69
   47suZXTNfNQhi19iV1LaaIEt/lT7BCrrS08xrlBlWnIgPknKPxgYBGfCh
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="352187140"
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="352187140"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 13:28:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="693532585"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Aug 2022 13:28:53 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKmtJ-000Lel-0a;
        Sun, 07 Aug 2022 20:28:53 +0000
Date:   Mon, 8 Aug 2022 04:28:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [chao:feature/dax 8/10] fs/f2fs/file.c:1107:10: error: call to
 undeclared function 'dax_layout_busy_page'; ISO C99 and later do not support
 implicit function declarations
Message-ID: <202208080435.GfrxXKZ0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git feature/dax
head:   42f73c9b2a369f724de6c1df5acb0bbde2688e35
commit: 59714a25c71315156f6ba8d49b3173915d6943cc [8/10] f2fs: handle layout changes to pinned DAX mappings
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220808/202208080435.GfrxXKZ0-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?id=59714a25c71315156f6ba8d49b3173915d6943cc
        git remote add chao https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git
        git fetch --no-tags chao feature/dax
        git checkout 59714a25c71315156f6ba8d49b3173915d6943cc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/f2fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/f2fs/file.c:585:7: error: call to undeclared function 'daxdev_mapping_supported'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           if (!daxdev_mapping_supported(vma, F2FS_I_SB(inode)->s_daxdev))
                ^
>> fs/f2fs/file.c:1107:10: error: call to undeclared function 'dax_layout_busy_page'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   page = dax_layout_busy_page(inode->i_mapping);
                          ^
>> fs/f2fs/file.c:1107:8: error: incompatible integer to pointer conversion assigning to 'struct page *' from 'int' [-Wint-conversion]
                   page = dax_layout_busy_page(inode->i_mapping);
                        ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   3 errors generated.


vim +/dax_layout_busy_page +1107 fs/f2fs/file.c

  1097	
  1098	int f2fs_break_layouts(struct inode *inode)
  1099	{
  1100		struct page *page;
  1101		int error;
  1102	
  1103		if (WARN_ON_ONCE(!rwsem_is_locked(&inode->i_mapping->invalidate_lock)))
  1104			return -EINVAL;
  1105	
  1106		do {
> 1107			page = dax_layout_busy_page(inode->i_mapping);
  1108			if (!page)
  1109				return 0;
  1110	
  1111			error = ___wait_var_event(&page->_refcount,
  1112					atomic_read(&page->_refcount) == 1,
  1113					TASK_INTERRUPTIBLE, 0, 0,
  1114					f2fs_wait_dax_page(inode));
  1115		} while (error == 0);
  1116	
  1117		return error;
  1118	}
  1119	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
