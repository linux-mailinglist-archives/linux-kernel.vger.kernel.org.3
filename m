Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6BE51CFED
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 05:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388896AbiEFECC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 00:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344554AbiEFEBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 00:01:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10FC1A06A
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 20:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651809483; x=1683345483;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pDxxVR3O79qUpOv5tkT2HfXe7BUFMNZEqYVvxFgTC8Q=;
  b=JP2o3iLK0gH3DZ+jOADrqaP4XKZ//55vunGDXcHrD/ZS2CXXwzfuv477
   bmMkm++dC6oznZPey5WM13qdCoKZSywrFZ4YzSS8jKCVCT5Eyx2IkuRGL
   2oy8TreGKcT4xi70QBbRunsezFEOi5XM/q6t0LXOj1wi8cCdXgdswFbLX
   gl4gKwBEEx2IydoUdPWIQ9YTRcGw08yvESLXkM/upciBXVIw2C2QQxvTX
   4eSqtylBjxzf3aG8RvwhICAP6kRV5XLJGWzUoSW2O2vj9JCLBbTI/1jWJ
   VlXIeNL5pv6fwoaFJpS3fozsQh3RvvU7UB0I2aSRPmp4eeMxDxcxfgP97
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="267942329"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="267942329"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 20:58:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="694984391"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 05 May 2022 20:58:01 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmp6O-000D4q-Vq;
        Fri, 06 May 2022 03:58:00 +0000
Date:   Fri, 6 May 2022 11:57:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>
Subject: fs/f2fs/inode.c:284:26: warning: format specifies type 'long' but
 the argument has type 'unsigned int'
Message-ID: <202205061127.vt9N0sP5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220505-223550/Chao-Yu/f2fs-fix-to-do-sanity-check-for-inline-inode/20220428-105005
head:   632856cc52a2023c9f07eea39ea41ddff5389997
commit: 632856cc52a2023c9f07eea39ea41ddff5389997 f2fs: fix to do sanity check for inline inode
date:   13 hours ago
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20220506/202205061127.vt9N0sP5-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e004fb787698440a387750db7f8028e7cb14cfc)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/632856cc52a2023c9f07eea39ea41ddff5389997
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review UPDATE-20220505-223550/Chao-Yu/f2fs-fix-to-do-sanity-check-for-inline-inode/20220428-105005
        git checkout 632856cc52a2023c9f07eea39ea41ddff5389997
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/net/wireless/ath/ath6kl/ drivers/net/wireless/broadcom/brcm80211/brcmfmac/ drivers/net/wireless/marvell/libertas/ drivers/net/wireless/marvell/mwifiex/ drivers/net/wireless/microchip/wilc1000/ drivers/staging/rtl8723bs/ fs/f2fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/f2fs/inode.c:284:26: warning: format specifies type 'long' but the argument has type 'unsigned int' [-Wformat]
                             i_size_read(inode), MAX_INLINE_DATA(inode),
                                                 ^~~~~~~~~~~~~~~~~~~~~~
   fs/f2fs/f2fs.h:2353:39: note: expanded from macro 'f2fs_warn'
           f2fs_printk(sbi, KERN_WARNING fmt, ##__VA_ARGS__)
                                         ~~~    ^~~~~~~~~~~
   fs/f2fs/f2fs.h:463:32: note: expanded from macro 'MAX_INLINE_DATA'
   #define MAX_INLINE_DATA(inode)  (sizeof(__le32) *                       \
                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +284 fs/f2fs/inode.c

   202	
   203	static bool sanity_check_inode(struct inode *inode, struct page *node_page)
   204	{
   205		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
   206		struct f2fs_inode_info *fi = F2FS_I(inode);
   207		struct f2fs_inode *ri = F2FS_INODE(node_page);
   208		unsigned long long iblocks;
   209	
   210		iblocks = le64_to_cpu(F2FS_INODE(node_page)->i_blocks);
   211		if (!iblocks) {
   212			set_sbi_flag(sbi, SBI_NEED_FSCK);
   213			f2fs_warn(sbi, "%s: corrupted inode i_blocks i_ino=%lx iblocks=%llu, run fsck to fix.",
   214				  __func__, inode->i_ino, iblocks);
   215			return false;
   216		}
   217	
   218		if (ino_of_node(node_page) != nid_of_node(node_page)) {
   219			set_sbi_flag(sbi, SBI_NEED_FSCK);
   220			f2fs_warn(sbi, "%s: corrupted inode footer i_ino=%lx, ino,nid: [%u, %u] run fsck to fix.",
   221				  __func__, inode->i_ino,
   222				  ino_of_node(node_page), nid_of_node(node_page));
   223			return false;
   224		}
   225	
   226		if (f2fs_sb_has_flexible_inline_xattr(sbi)
   227				&& !f2fs_has_extra_attr(inode)) {
   228			set_sbi_flag(sbi, SBI_NEED_FSCK);
   229			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, run fsck to fix.",
   230				  __func__, inode->i_ino);
   231			return false;
   232		}
   233	
   234		if (f2fs_has_extra_attr(inode) &&
   235				!f2fs_sb_has_extra_attr(sbi)) {
   236			set_sbi_flag(sbi, SBI_NEED_FSCK);
   237			f2fs_warn(sbi, "%s: inode (ino=%lx) is with extra_attr, but extra_attr feature is off",
   238				  __func__, inode->i_ino);
   239			return false;
   240		}
   241	
   242		if (fi->i_extra_isize > F2FS_TOTAL_EXTRA_ATTR_SIZE ||
   243				fi->i_extra_isize % sizeof(__le32)) {
   244			set_sbi_flag(sbi, SBI_NEED_FSCK);
   245			f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_extra_isize: %d, max: %zu",
   246				  __func__, inode->i_ino, fi->i_extra_isize,
   247				  F2FS_TOTAL_EXTRA_ATTR_SIZE);
   248			return false;
   249		}
   250	
   251		if (f2fs_has_extra_attr(inode) &&
   252			f2fs_sb_has_flexible_inline_xattr(sbi) &&
   253			f2fs_has_inline_xattr(inode) &&
   254			(!fi->i_inline_xattr_size ||
   255			fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE)) {
   256			set_sbi_flag(sbi, SBI_NEED_FSCK);
   257			f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_inline_xattr_size: %d, max: %zu",
   258				  __func__, inode->i_ino, fi->i_inline_xattr_size,
   259				  MAX_INLINE_XATTR_SIZE);
   260			return false;
   261		}
   262	
   263		if (F2FS_I(inode)->extent_tree) {
   264			struct extent_info *ei = &F2FS_I(inode)->extent_tree->largest;
   265	
   266			if (ei->len &&
   267				(!f2fs_is_valid_blkaddr(sbi, ei->blk,
   268							DATA_GENERIC_ENHANCE) ||
   269				!f2fs_is_valid_blkaddr(sbi, ei->blk + ei->len - 1,
   270							DATA_GENERIC_ENHANCE))) {
   271				set_sbi_flag(sbi, SBI_NEED_FSCK);
   272				f2fs_warn(sbi, "%s: inode (ino=%lx) extent info [%u, %u, %u] is incorrect, run fsck to fix",
   273					  __func__, inode->i_ino,
   274					  ei->blk, ei->fofs, ei->len);
   275				return false;
   276			}
   277		}
   278	
   279		if (f2fs_has_inline_data(inode) && !f2fs_may_inline_data(inode)) {
   280			set_sbi_flag(sbi, SBI_NEED_FSCK);
   281			f2fs_warn(sbi, "%s: inode (ino=%lx, mode=%u) reason(%d, %llu, %ld, %d, %d, %lu) should not have inline_data, run fsck to fix",
   282				  __func__, inode->i_ino, inode->i_mode,
   283				  f2fs_is_atomic_file(inode),
 > 284				  i_size_read(inode), MAX_INLINE_DATA(inode),
   285				  file_is_encrypt(inode), file_is_verity(inode),
   286				  F2FS_I(inode)->i_flags & F2FS_COMPR_FL);
   287			return false;
   288		}
   289	
   290		if (f2fs_has_inline_dentry(inode) && !S_ISDIR(inode->i_mode)) {
   291			set_sbi_flag(sbi, SBI_NEED_FSCK);
   292			f2fs_warn(sbi, "%s: inode (ino=%lx, mode=%u) should not have inline_dentry, run fsck to fix",
   293				  __func__, inode->i_ino, inode->i_mode);
   294			return false;
   295		}
   296	
   297		if ((fi->i_flags & F2FS_CASEFOLD_FL) && !f2fs_sb_has_casefold(sbi)) {
   298			set_sbi_flag(sbi, SBI_NEED_FSCK);
   299			f2fs_warn(sbi, "%s: inode (ino=%lx) has casefold flag, but casefold feature is off",
   300				  __func__, inode->i_ino);
   301			return false;
   302		}
   303	
   304		if (f2fs_has_extra_attr(inode) && f2fs_sb_has_compression(sbi) &&
   305				fi->i_flags & F2FS_COMPR_FL &&
   306				F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
   307							i_log_cluster_size)) {
   308			if (ri->i_compress_algorithm >= COMPRESS_MAX) {
   309				set_sbi_flag(sbi, SBI_NEED_FSCK);
   310				f2fs_warn(sbi, "%s: inode (ino=%lx) has unsupported "
   311					"compress algorithm: %u, run fsck to fix",
   312					  __func__, inode->i_ino,
   313					  ri->i_compress_algorithm);
   314				return false;
   315			}
   316			if (le64_to_cpu(ri->i_compr_blocks) >
   317					SECTOR_TO_BLOCK(inode->i_blocks)) {
   318				set_sbi_flag(sbi, SBI_NEED_FSCK);
   319				f2fs_warn(sbi, "%s: inode (ino=%lx) has inconsistent "
   320					"i_compr_blocks:%llu, i_blocks:%llu, run fsck to fix",
   321					  __func__, inode->i_ino,
   322					  le64_to_cpu(ri->i_compr_blocks),
   323					  SECTOR_TO_BLOCK(inode->i_blocks));
   324				return false;
   325			}
   326			if (ri->i_log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
   327				ri->i_log_cluster_size > MAX_COMPRESS_LOG_SIZE) {
   328				set_sbi_flag(sbi, SBI_NEED_FSCK);
   329				f2fs_warn(sbi, "%s: inode (ino=%lx) has unsupported "
   330					"log cluster size: %u, run fsck to fix",
   331					  __func__, inode->i_ino,
   332					  ri->i_log_cluster_size);
   333				return false;
   334			}
   335		}
   336	
   337		return true;
   338	}
   339	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
