Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B626F58BDF5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 00:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbiHGWhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 18:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbiHGWhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 18:37:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5B0262A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 15:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659911459; x=1691447459;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ksSulHuho9W6i4hx0e/C1ZaHWldsvExDJG9sI01Dlo0=;
  b=adoUosCvGe7nB2D8VdHspOe6Rl+fTzCOmvBndxt3AiuUT5TvtmAPSHvx
   vYCcJWD9VVO3iiX7LEHSNVKqEDQuCFO2nNyovqNRSWNvMc7MxdtH+PFfp
   oIRicBOZPuGubjU/je2tIp10eMkljBbTiT5J68jpAI/G/4lE/1b3y/WV3
   Pk1o0uyTCVVhlktPf60wlWd++32Fr6aYZqvqICZLecRikBO7lJNmP6csb
   2X25A8yswAnUj4UJhTXJ14C0byx8zg+zQwx6wzbzMqsoeI5giuYXceG7N
   gUakCw7axa4LAzW0Uu0l6mSxFgZQeXyODoMEbcxMwtLsn+YOb/55rJVvf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="290476672"
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="290476672"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 15:30:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="554696648"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Aug 2022 15:30:57 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKonQ-000Lj3-1B;
        Sun, 07 Aug 2022 22:30:56 +0000
Date:   Mon, 8 Aug 2022 06:30:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Cc:     kbuild-all@lists.01.org, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org
Subject: [chao:feature/dax 8/10] fs/f2fs/file.c:1107:22: warning: assignment
 to 'struct page *' from 'int' makes pointer from integer without a cast
Message-ID: <202208080625.gFSUHC8I-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: arm-randconfig-r001-20220807 (https://download.01.org/0day-ci/archive/20220808/202208080625.gFSUHC8I-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?id=59714a25c71315156f6ba8d49b3173915d6943cc
        git remote add chao https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git
        git fetch --no-tags chao feature/dax
        git checkout 59714a25c71315156f6ba8d49b3173915d6943cc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash fs/f2fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/f2fs/file.c: In function 'f2fs_file_mmap':
   fs/f2fs/file.c:585:14: error: implicit declaration of function 'daxdev_mapping_supported' [-Werror=implicit-function-declaration]
     585 |         if (!daxdev_mapping_supported(vma, F2FS_I_SB(inode)->s_daxdev))
         |              ^~~~~~~~~~~~~~~~~~~~~~~~
   fs/f2fs/file.c: In function 'f2fs_break_layouts':
   fs/f2fs/file.c:1107:24: error: implicit declaration of function 'dax_layout_busy_page' [-Werror=implicit-function-declaration]
    1107 |                 page = dax_layout_busy_page(inode->i_mapping);
         |                        ^~~~~~~~~~~~~~~~~~~~
>> fs/f2fs/file.c:1107:22: warning: assignment to 'struct page *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1107 |                 page = dax_layout_busy_page(inode->i_mapping);
         |                      ^
   cc1: some warnings being treated as errors


vim +1107 fs/f2fs/file.c

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
