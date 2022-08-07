Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B70F58BCCF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 21:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiHGT65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 15:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiHGT6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 15:58:55 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0375FE5
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 12:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659902334; x=1691438334;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PNJpUYpS/xBotUnmKKxvLKOVpwfoZX4dbSC11UL+vWU=;
  b=PogNtlifJUFuB0/RRyU7RZmDuAaz0TlGkY0i855Ld0VYlJHgxdkL0tsq
   WtPNkzw+ioTHWm9bI40LP8c19Pw6K7iepKgd8+AyJgS1ALkvkwbA+aurI
   bbFTY2zivnGXZ2U54VdQY2xi7iVylztMKBSKHZJO19+ZZYma573JKeA1p
   cHU8dCIGmz9eMeaEmDPIK1xVc6xQDn9iIGKKUk6+xu5i0hRqmBn6hVWLK
   DdAzz8TJlBz6Q6oJSGW5crP3z4k1K8ehHJ3MiaNmsNj5NklY2kSubWL6o
   AYJyeSMT1iszlFy0/FLCAVet9fgTC8aArmYHdAHPld1KU0/jnbVDUNwAK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="288025096"
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="288025096"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 12:58:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="672236363"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Aug 2022 12:58:52 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKmQG-000LdZ-07;
        Sun, 07 Aug 2022 19:58:52 +0000
Date:   Mon, 8 Aug 2022 03:58:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [chao:feature/dax 5/10] fs/f2fs/data.c:4269:9: error: call to
 undeclared function 'dax_writeback_mapping_range'; ISO C99 and later do not
 support implicit function declarations
Message-ID: <202208080311.PD3w4obC-lkp@intel.com>
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
commit: aaddcbec6617facbd1efa6f3d42747bc9eddcb26 [5/10] f2fs: support dax address space operation
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220808/202208080311.PD3w4obC-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 5f1c7e2cc5a3c07cbc2412e851a7283c1841f520)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?id=aaddcbec6617facbd1efa6f3d42747bc9eddcb26
        git remote add chao https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git
        git fetch --no-tags chao feature/dax
        git checkout aaddcbec6617facbd1efa6f3d42747bc9eddcb26
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/f2fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/f2fs/data.c:4269:9: error: call to undeclared function 'dax_writeback_mapping_range'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           return dax_writeback_mapping_range(mapping, sbi->s_daxdev, wbc);
                  ^
   1 error generated.


vim +/dax_writeback_mapping_range +4269 fs/f2fs/data.c

  4260	
  4261	static int f2fs_dax_writepages(struct address_space *mapping,
  4262						struct writeback_control *wbc)
  4263	{
  4264		struct f2fs_sb_info *sbi = F2FS_I_SB(mapping->host);
  4265	
  4266		if (unlikely(f2fs_cp_error(sbi)))
  4267			return -EIO;
  4268	
> 4269		return dax_writeback_mapping_range(mapping, sbi->s_daxdev, wbc);
  4270	}
  4271	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
