Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDE852DDD3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 21:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiESTah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 15:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244039AbiESTag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 15:30:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377DE9BADB
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 12:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652988634; x=1684524634;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gW0voMhRUpZ+BKubudljiwKR2MKSo1rFvfRCNXZD01U=;
  b=MRXsxfV8qB3wnIX7NC/SMpLI2lk0AS1Mc4r3QemOtua4vNQXRSFoRf5G
   g0xHbPFPGXhz4Y8H1N/s9amw/lQoy0YKpBcV79pk7aVUC1XbmyJ9c2V++
   jLA5yYUF7ivKZMrVcjPDySIxQOP5c4NnL+KQZjGhhuKpYzOWm/aB1Jg9x
   hMcfhzcXzJE/rlSYcBsi0iclGbTwUm1cOPzA1iZ+d3yWZCNJVKVgZJ1R0
   GIoFGV3sh8K0VV5B0gPX308FA0qnRq6ZRXfB6yiIEwLcyAFOtW4Bil+pQ
   Y3KLirTgFd34LpGBmRl3FyQNBA4WoWDByJ87BVAjSnEvSrt6pAVSga4pF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="259922446"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="259922446"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 12:30:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="743085938"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 19 May 2022 12:30:32 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrlqx-0003tB-TP;
        Thu, 19 May 2022 19:30:31 +0000
Date:   Fri, 20 May 2022 03:29:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: fs/ntfs3/fsntfs.c:770:5: warning: stack frame size (2112) exceeds
 limit (1024) in 'ntfs_clear_mft_tail'
Message-ID: <202205200352.WNFV7NdM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konstantin,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b015dcd62b86d298829990f8261d5d154b8d7af5
commit: 6e5be40d32fb1907285277c02e74493ed43d77fe fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile
date:   9 months ago
config: hexagon-randconfig-r011-20220519 (https://download.01.org/0day-ci/archive/20220520/202205200352.WNFV7NdM-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e00cbbec06c08dc616a0d52a20f678b8fbd4e304)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6e5be40d32fb1907285277c02e74493ed43d77fe
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6e5be40d32fb1907285277c02e74493ed43d77fe
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/ntfs3/fsntfs.c:1874:9: warning: variable 'cnt' set but not used [-Wunused-but-set-variable]
           size_t cnt, off;
                  ^
>> fs/ntfs3/fsntfs.c:770:5: warning: stack frame size (2112) exceeds limit (1024) in 'ntfs_clear_mft_tail' [-Wframe-larger-than]
   int ntfs_clear_mft_tail(struct ntfs_sb_info *sbi, size_t from, size_t to)
       ^
   2 warnings generated.


vim +/ntfs_clear_mft_tail +770 fs/ntfs3/fsntfs.c

82cae269cfa953 Konstantin Komarov 2021-08-13  763  
82cae269cfa953 Konstantin Komarov 2021-08-13  764  /*
82cae269cfa953 Konstantin Komarov 2021-08-13  765   * ntfs_clear_mft_tail
82cae269cfa953 Konstantin Komarov 2021-08-13  766   *
82cae269cfa953 Konstantin Komarov 2021-08-13  767   * formats empty records [from, to)
82cae269cfa953 Konstantin Komarov 2021-08-13  768   * sbi->mft.bitmap is locked for write
82cae269cfa953 Konstantin Komarov 2021-08-13  769   */
82cae269cfa953 Konstantin Komarov 2021-08-13 @770  int ntfs_clear_mft_tail(struct ntfs_sb_info *sbi, size_t from, size_t to)
82cae269cfa953 Konstantin Komarov 2021-08-13  771  {
82cae269cfa953 Konstantin Komarov 2021-08-13  772  	int err;
82cae269cfa953 Konstantin Komarov 2021-08-13  773  	u32 rs;
82cae269cfa953 Konstantin Komarov 2021-08-13  774  	u64 vbo;
82cae269cfa953 Konstantin Komarov 2021-08-13  775  	struct runs_tree *run;
82cae269cfa953 Konstantin Komarov 2021-08-13  776  	struct ntfs_inode *ni;
82cae269cfa953 Konstantin Komarov 2021-08-13  777  
82cae269cfa953 Konstantin Komarov 2021-08-13  778  	if (from >= to)
82cae269cfa953 Konstantin Komarov 2021-08-13  779  		return 0;
82cae269cfa953 Konstantin Komarov 2021-08-13  780  
82cae269cfa953 Konstantin Komarov 2021-08-13  781  	rs = sbi->record_size;
82cae269cfa953 Konstantin Komarov 2021-08-13  782  	ni = sbi->mft.ni;
82cae269cfa953 Konstantin Komarov 2021-08-13  783  	run = &ni->file.run;
82cae269cfa953 Konstantin Komarov 2021-08-13  784  
82cae269cfa953 Konstantin Komarov 2021-08-13  785  	down_read(&ni->file.run_lock);
82cae269cfa953 Konstantin Komarov 2021-08-13  786  	vbo = (u64)from * rs;
82cae269cfa953 Konstantin Komarov 2021-08-13  787  	for (; from < to; from++, vbo += rs) {
82cae269cfa953 Konstantin Komarov 2021-08-13  788  		struct ntfs_buffers nb;
82cae269cfa953 Konstantin Komarov 2021-08-13  789  
82cae269cfa953 Konstantin Komarov 2021-08-13  790  		err = ntfs_get_bh(sbi, run, vbo, rs, &nb);
82cae269cfa953 Konstantin Komarov 2021-08-13  791  		if (err)
82cae269cfa953 Konstantin Komarov 2021-08-13  792  			goto out;
82cae269cfa953 Konstantin Komarov 2021-08-13  793  
82cae269cfa953 Konstantin Komarov 2021-08-13  794  		err = ntfs_write_bh(sbi, &sbi->new_rec->rhdr, &nb, 0);
82cae269cfa953 Konstantin Komarov 2021-08-13  795  		nb_put(&nb);
82cae269cfa953 Konstantin Komarov 2021-08-13  796  		if (err)
82cae269cfa953 Konstantin Komarov 2021-08-13  797  			goto out;
82cae269cfa953 Konstantin Komarov 2021-08-13  798  	}
82cae269cfa953 Konstantin Komarov 2021-08-13  799  
82cae269cfa953 Konstantin Komarov 2021-08-13  800  out:
82cae269cfa953 Konstantin Komarov 2021-08-13  801  	sbi->mft.used = from;
82cae269cfa953 Konstantin Komarov 2021-08-13  802  	up_read(&ni->file.run_lock);
82cae269cfa953 Konstantin Komarov 2021-08-13  803  	return err;
82cae269cfa953 Konstantin Komarov 2021-08-13  804  }
82cae269cfa953 Konstantin Komarov 2021-08-13  805  

:::::: The code at line 770 was first introduced by commit
:::::: 82cae269cfa953032fbb8980a7d554d60fb00b17 fs/ntfs3: Add initialization of super block

:::::: TO: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
:::::: CC: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
