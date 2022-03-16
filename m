Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223214DA8AF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 03:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353394AbiCPCzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 22:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239548AbiCPCzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:55:54 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA3A32ED9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647399280; x=1678935280;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=S/LO3bclK4nzXPPfLRzXebbXETeX/ip++37bZWsrdHY=;
  b=C6PiOVUg4XsmPyes9Vs9TAgQqX0vtVf6VrR2XOu0vOS8bBNTEq2Sw/C3
   CewNKieTCFJOCBMHeQ7cqmd7tmz+1S9TtwDqefKcSIR3WIRjKfcA3o3st
   Q31yPC7qcryCBSaXMwHSTNQHUyPIadAMV586xbtAVDr9ZemzCJJJrco9K
   BjnUnzVLVbxuPyULdsLbsYsGg0+HPNoplClpuAfm05WajCTHQgcIEAIfo
   MXeuceE0apj1VBC8Gyxs5GuObFHuvPczNJOoGTvQ7nFmbbgFk2DCtSSN4
   58i2tSL3IBVa9THW/WnInbRH8vWq0ExNNOkr+wQmcO+BH/GHamMMB3Kmi
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="317196407"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="317196407"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 19:54:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="646470698"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Mar 2022 19:54:38 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUJo5-000Bpy-Ro; Wed, 16 Mar 2022 02:54:37 +0000
Date:   Wed, 16 Mar 2022 10:54:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.19-q-release
 499/7636] fs/f2fs/data.c:420:47: sparse: sparse: Using plain integer as NULL
 pointer
Message-ID: <202203161001.WNuuYWHv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.19-q-release
head:   1a3500dc59324a85c20f025cfa6485a1a0debbdf
commit: c258edb28a2a2f7db55d849efa431fca304a4851 [499/7636] Revert: "f2fs: check last page index in cached bio to decide submission"
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220316/202203161001.WNuuYWHv-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/c258edb28a2a2f7db55d849efa431fca304a4851
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.19-q-release
        git checkout c258edb28a2a2f7db55d849efa431fca304a4851
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/f2fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/f2fs/data.c:420:47: sparse: sparse: Using plain integer as NULL pointer
   In file included from fs/f2fs/data.c:22:
   fs/f2fs/f2fs.h: In function 'blkaddr_in_node':
   fs/f2fs/f2fs.h:2147:30: warning: taking address of packed member of 'struct f2fs_inode' may result in an unaligned pointer value [-Waddress-of-packed-member]
    2147 |  return RAW_IS_INODE(node) ? node->i.i_addr : node->dn.addr;
         |                              ^~~~
   fs/f2fs/f2fs.h:2147:47: warning: taking address of packed member of 'struct direct_node' may result in an unaligned pointer value [-Waddress-of-packed-member]
    2147 |  return RAW_IS_INODE(node) ? node->i.i_addr : node->dn.addr;
         |                                               ^~~~
   fs/f2fs/f2fs.h: In function '__mark_inode_dirty_flag':
   fs/f2fs/f2fs.h:2340:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
    2340 |   if (set)
         |      ^
   fs/f2fs/f2fs.h:2342:2: note: here
    2342 |  case FI_DATA_EXIST:
         |  ^~~~
   fs/f2fs/data.o: warning: objtool: f2fs_xattr_fiemap()+0x312: sibling call from callable instruction with modified stack frame
   fs/f2fs/data.o: warning: objtool: f2fs_set_data_page_dirty()+0x380: sibling call from callable instruction with modified stack frame
   fs/f2fs/data.o: warning: objtool: f2fs_direct_IO()+0xd4: sibling call from callable instruction with modified stack frame
   fs/f2fs/data.o: warning: objtool: f2fs_write_end()+0x3cc: sibling call from callable instruction with modified stack frame
   fs/f2fs/data.o: warning: objtool: __submit_merged_bio()+0x91e: sibling call from callable instruction with modified stack frame
   fs/f2fs/data.o: warning: objtool: f2fs_submit_page_read()+0x312: sibling call from callable instruction with modified stack frame
   fs/f2fs/data.o: warning: objtool: f2fs_submit_page_bio()+0x719: sibling call from callable instruction with modified stack frame
   fs/f2fs/data.o: warning: objtool: f2fs_submit_page_write()+0xb7: sibling call from callable instruction with modified stack frame
   fs/f2fs/data.o: warning: objtool: __allocate_data_block()+0x599: sibling call from callable instruction with modified stack frame
   fs/f2fs/data.o: warning: objtool: f2fs_reserve_new_blocks()+0x8f: sibling call from callable instruction with modified stack frame
   fs/f2fs/data.o: warning: objtool: prepare_write_begin()+0x6f3: sibling call from callable instruction with modified stack frame
   fs/f2fs/data.o: warning: objtool: f2fs_write_begin()+0x1da: sibling call from callable instruction with modified stack frame
   fs/f2fs/data.o: warning: objtool: f2fs_map_blocks()+0xe8a: sibling call from callable instruction with modified stack frame
   fs/f2fs/data.o: warning: objtool: f2fs_mpage_readpages()+0x51: sibling call from callable instruction with modified stack frame
   fs/f2fs/data.o: warning: objtool: f2fs_read_data_pages()+0x1d4: sibling call from callable instruction with modified stack frame
   fs/f2fs/data.o: warning: objtool: f2fs_read_data_page()+0x1de: sibling call from callable instruction with modified stack frame
   fs/f2fs/data.o: warning: objtool: __get_data_block()+0x41: sibling call from callable instruction with modified stack frame
   fs/f2fs/data.o: warning: objtool: f2fs_fiemap()+0xf7: sibling call from callable instruction with modified stack frame
   fs/f2fs/data.o: warning: objtool: f2fs_should_update_inplace()+0x1fc: sibling call from callable instruction with modified stack frame
   fs/f2fs/data.o: warning: objtool: f2fs_do_write_data_page()+0x1097: sibling call from callable instruction with modified stack frame
   fs/f2fs/data.o: warning: objtool: __write_data_page()+0x469: sibling call from callable instruction with modified stack frame
   fs/f2fs/data.o: warning: objtool: f2fs_write_cache_pages()+0x587: sibling call from callable instruction with modified stack frame
   fs/f2fs/data.o: warning: objtool: __f2fs_write_data_pages()+0x6cb: sibling call from callable instruction with modified stack frame
   fs/f2fs/data.o: warning: objtool: f2fs_xattr_fiemap.cold()+0x14: call without frame pointer save/setup
   fs/f2fs/data.o: warning: objtool: f2fs_set_data_page_dirty.cold()+0x12: call without frame pointer save/setup
   fs/f2fs/data.o: warning: objtool: f2fs_direct_IO.cold()+0xf: call without frame pointer save/setup
   fs/f2fs/data.o: warning: objtool: f2fs_write_end.cold()+0x15: call without frame pointer save/setup
   fs/f2fs/data.o: warning: objtool: __submit_merged_bio.cold()+0x12: call without frame pointer save/setup
   fs/f2fs/data.o: warning: objtool: f2fs_submit_page_read.cold()+0x15: call without frame pointer save/setup
   fs/f2fs/data.o: warning: objtool: f2fs_submit_page_bio.cold()+0x13: call without frame pointer save/setup
   fs/f2fs/data.o: warning: objtool: f2fs_submit_page_write.cold()+0x15: call without frame pointer save/setup
   fs/f2fs/data.o: warning: objtool: __allocate_data_block.cold()+0x12: call without frame pointer save/setup
   fs/f2fs/data.o: warning: objtool: f2fs_reserve_new_blocks.cold()+0x1a: call without frame pointer save/setup
   fs/f2fs/data.o: warning: objtool: prepare_write_begin.cold()+0xa: call without frame pointer save/setup
   fs/f2fs/data.o: warning: objtool: f2fs_write_begin.cold()+0x17: call without frame pointer save/setup
   fs/f2fs/data.o: warning: objtool: f2fs_map_blocks.cold()+0x16: call without frame pointer save/setup
   fs/f2fs/data.o: warning: objtool: f2fs_mpage_readpages.cold()+0x15: call without frame pointer save/setup
   fs/f2fs/data.o: warning: objtool: f2fs_read_data_pages.cold()+0x12: call without frame pointer save/setup
   fs/f2fs/data.o: warning: objtool: f2fs_read_data_page.cold()+0x12: call without frame pointer save/setup
   fs/f2fs/data.o: warning: objtool: __get_data_block.cold()+0x18: call without frame pointer save/setup
   fs/f2fs/data.o: warning: objtool: f2fs_fiemap.cold()+0x10: call without frame pointer save/setup
   fs/f2fs/data.o: warning: objtool: f2fs_should_update_inplace.cold()+0x14: call without frame pointer save/setup
   fs/f2fs/data.o: warning: objtool: f2fs_do_write_data_page.cold()+0x13: call without frame pointer save/setup
   fs/f2fs/data.o: warning: objtool: __write_data_page.cold()+0x18: call without frame pointer save/setup
   fs/f2fs/data.o: warning: objtool: f2fs_write_cache_pages.cold()+0x13: call without frame pointer save/setup
   fs/f2fs/data.o: warning: objtool: __f2fs_write_data_pages.cold()+0x13: call without frame pointer save/setup

vim +420 fs/f2fs/data.c

a912b54d3aaa01 Jaegeuk Kim 2017-05-10  417  
b9109b0e49b93b Jaegeuk Kim 2017-05-10  418  void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type)
0c3a579758362d Chao Yu     2016-01-18  419  {
a912b54d3aaa01 Jaegeuk Kim 2017-05-10 @420  	__submit_merged_write_cond(sbi, NULL, 0, 0, type, true);
0c3a579758362d Chao Yu     2016-01-18  421  }
0c3a579758362d Chao Yu     2016-01-18  422  

:::::: The code at line 420 was first introduced by commit
:::::: a912b54d3aaa011266dc266e3694f782f27233cf f2fs: split bio cache

:::::: TO: Jaegeuk Kim <jaegeuk@kernel.org>
:::::: CC: Jaegeuk Kim <jaegeuk@kernel.org>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
