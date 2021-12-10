Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B260470806
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245002AbhLJSHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:07:20 -0500
Received: from mga17.intel.com ([192.55.52.151]:19589 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235392AbhLJSHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:07:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639159424; x=1670695424;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LAHwgZ9mmMRfEXXYxpHctVnwaqoW94BRjWxXAVA/q9g=;
  b=aA7QCT0rqHgxD50VVIhkZhAm74jjQF/a8QoNkJnx6DiQ8Obtfvrvvfqu
   iEJRZBv0DOjh82g6vHShUBZ0WA5nbgkvfKo42Rib6pmDNq9YlHdDzMb5v
   v9OolDB+lTzIll12sqYnj5FNdA3o9jJ4ALqYqKQMnaeHTiNvQU2uKu1W9
   9/Mb82/SImADaIBdJWPbPU1IC3wfHMxnj+RWj7p4GwRxPe+V7BbZTQfe0
   I0BMphxZFnVIfJvST7NVXi+JNpeKcHGDcXeku3F4kaMn5TCHmE5d/ndfA
   RmiB5eaOb3AY2l5dPAVtgXbswms/AhZlEYU6naVSqbmoBSrG2riCxLuxd
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="219094077"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="219094077"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 10:03:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="680827116"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 10 Dec 2021 10:03:14 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvkEj-0003Up-EO; Fri, 10 Dec 2021 18:03:13 +0000
Date:   Sat, 11 Dec 2021 02:03:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>
Subject: fs/ext4/ioctl.c:45:5: warning: no previous prototype for function
 'ext4_modify_primary_sb'
Message-ID: <202112110115.5HqRcRHH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20211210-231726/Lukas-Czerner/ext4-implement-support-for-get-set-fs-label/20211112-060030
head:   3645884240a4d5f00133b71e3a7fbb2070588706
commit: 3645884240a4d5f00133b71e3a7fbb2070588706 ext4: implement support for get/set fs label
date:   3 hours ago
config: hexagon-randconfig-r016-20211210 (https://download.01.org/0day-ci/archive/20211211/202112110115.5HqRcRHH-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/3645884240a4d5f00133b71e3a7fbb2070588706
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20211210-231726/Lukas-Czerner/ext4-implement-support-for-get-set-fs-label/20211112-060030
        git checkout 3645884240a4d5f00133b71e3a7fbb2070588706
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/ext4/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/ext4/ioctl.c:45:5: warning: no previous prototype for function 'ext4_modify_primary_sb' [-Wmissing-prototypes]
   int ext4_modify_primary_sb(struct super_block *sb, handle_t *handle,
       ^
   fs/ext4/ioctl.c:45:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int ext4_modify_primary_sb(struct super_block *sb, handle_t *handle,
   ^
   static 
>> fs/ext4/ioctl.c:165:5: warning: no previous prototype for function 'ext4_modify_superblocks_fn' [-Wmissing-prototypes]
   int ext4_modify_superblocks_fn(struct super_block *sb,
       ^
   fs/ext4/ioctl.c:165:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int ext4_modify_superblocks_fn(struct super_block *sb,
   ^
   static 
   2 warnings generated.


vim +/ext4_modify_primary_sb +45 fs/ext4/ioctl.c

    44	
  > 45	int ext4_modify_primary_sb(struct super_block *sb, handle_t *handle,
    46				   ext4_modify_sb_callback func,
    47				   const void *arg)
    48	{
    49		int err = 0;
    50		struct ext4_sb_info *sbi = EXT4_SB(sb);
    51		struct buffer_head *bh = sbi->s_sbh;
    52		struct ext4_super_block *es = sbi->s_es;
    53	
    54		trace_ext4_modify_sb(sb, bh->b_blocknr, 1);
    55	
    56		BUFFER_TRACE(bh, "get_write_access");
    57		err = ext4_journal_get_write_access(handle, sb,
    58						    bh,
    59						    EXT4_JTR_NONE);
    60		if (err)
    61			goto out_err;
    62	
    63		lock_buffer(bh);
    64		func(es, arg);
    65		ext4_superblock_csum_set(sb);
    66		unlock_buffer(bh);
    67	
    68		if (buffer_write_io_error(bh) || !buffer_uptodate(bh)) {
    69			ext4_msg(sbi->s_sb, KERN_ERR, "previous I/O error to "
    70				 "superblock detected");
    71			clear_buffer_write_io_error(bh);
    72			set_buffer_uptodate(bh);
    73		}
    74	
    75		err = ext4_handle_dirty_metadata(handle, NULL, bh);
    76		if (err)
    77			goto out_err;
    78		err = sync_dirty_buffer(bh);
    79	out_err:
    80		ext4_std_error(sb, err);
    81		return err;
    82	}
    83	
    84	/*
    85	 * Update one backup superblcok in the group 'grp' using the primary
    86	 * superblock data. If the handle is NULL the modification is not
    87	 * journalled.
    88	 *
    89	 * Returns: 0 when no modification was done (no superblock in the group)
    90	 *	    1 when the modification was successful
    91	 *	   <0 on error
    92	 */
    93	static int ext4_update_backup_sb(struct super_block *sb, handle_t *handle,
    94					 ext4_group_t grp)
    95	{
    96		int err = 0;
    97		ext4_fsblk_t sb_block;
    98		struct buffer_head *bh;
    99		unsigned long offset = 0;
   100	
   101		if (!ext4_bg_has_super(sb, grp))
   102			return 0;
   103	
   104		/*
   105		 * For the group 0 there is always 1k padding, so we have
   106		 * either adjust offset, or sb_block depending on blocksize
   107		 */
   108		if (grp == 0) {
   109			sb_block = 1 * EXT4_MIN_BLOCK_SIZE;
   110			offset = do_div(sb_block, sb->s_blocksize);
   111		} else {
   112			sb_block = ext4_group_first_block_no(sb, grp);
   113			offset = 0;
   114		}
   115	
   116		trace_ext4_modify_sb(sb, sb_block, handle ? 1 : 0);
   117	
   118		bh = sb_getblk(sb, sb_block);
   119		if (IS_ERR(bh))
   120			return PTR_ERR(bh);
   121	
   122		if (handle) {
   123			BUFFER_TRACE(bh, "get_write_access");
   124			err = ext4_journal_get_write_access(handle, sb,
   125							    bh,
   126							    EXT4_JTR_NONE);
   127			if (err)
   128				goto out_bh;
   129		}
   130	
   131		lock_buffer(bh);
   132		memcpy(bh->b_data + offset, EXT4_SB(sb)->s_es,
   133		       sizeof(struct ext4_super_block));
   134		set_buffer_uptodate(bh);
   135		unlock_buffer(bh);
   136	
   137		if (err)
   138			goto out_bh;
   139	
   140		if (handle) {
   141			err = ext4_handle_dirty_metadata(handle, NULL, bh);
   142			if (err)
   143				goto out_bh;
   144		} else {
   145			BUFFER_TRACE(bh, "marking dirty");
   146			mark_buffer_dirty(bh);
   147		}
   148		err = sync_dirty_buffer(bh);
   149	
   150	out_bh:
   151		brelse(bh);
   152		ext4_std_error(sb, err);
   153		return (err) ? err : 1;
   154	}
   155	
   156	/*
   157	 * Modify primary and backup superblocks using the provided function
   158	 * func and argument arg.
   159	 *
   160	 * Only the primary superblock and at most two backup superblock
   161	 * modifications are journalled; the rest is modified without journal.
   162	 * This is safe because e2fsck will re-write them if there is a problem,
   163	 * and we're very unlikely to ever need more than two backups.
   164	 */
 > 165	int ext4_modify_superblocks_fn(struct super_block *sb,
   166				       ext4_modify_sb_callback func,
   167				       const void *arg)
   168	{
   169		handle_t *handle;
   170		ext4_group_t ngroups;
   171		unsigned int three = 1;
   172		unsigned int five = 5;
   173		unsigned int seven = 7;
   174		int err = 0, ret, i;
   175		ext4_group_t grp, primary_grp;
   176		struct ext4_sb_info *sbi = EXT4_SB(sb);
   177	
   178		/*
   179		 * We can't modify superblocks while the online resize is running
   180		 */
   181		if (test_and_set_bit_lock(EXT4_FLAGS_RESIZING,
   182					  &sbi->s_ext4_flags)) {
   183			ext4_msg(sb, KERN_ERR, "Can't modify superblock while"
   184				 "performing online resize");
   185			return -EBUSY;
   186		}
   187	
   188		/*
   189		 * We're only going to modify primary superblock and two
   190		 * backup superblocks in this transaction.
   191		 */
   192		handle = ext4_journal_start_sb(sb, EXT4_HT_MISC, 3);
   193		if (IS_ERR(handle)) {
   194			err = PTR_ERR(handle);
   195			goto out;
   196		}
   197	
   198		/* Modify primary superblock */
   199		err = ext4_modify_primary_sb(sb, handle, func, arg);
   200		if (err) {
   201			ext4_msg(sb, KERN_ERR, "Failed to modify primary "
   202				 "superblock");
   203			goto out_journal;
   204		}
   205	
   206		primary_grp = ext4_get_group_number(sb, sbi->s_sbh->b_blocknr);
   207		ngroups = ext4_get_groups_count(sb);
   208	
   209		/*
   210		 * Update backup superblocks. We have to start from group 0
   211		 * because it might not be where the primary superblock is
   212		 * if the fs is mounted with -o sb=<backup_sb_block>
   213		 */
   214		i = 0;
   215		grp = 0;
   216		while (grp < ngroups) {
   217			/* Skip primary superblock */
   218			if (grp == primary_grp)
   219				goto next_grp;
   220	
   221			ret = ext4_update_backup_sb(sb, handle, grp);
   222			if (ret < 0) {
   223				err = ret;
   224				goto out_journal;
   225			}
   226	
   227			i += ret;
   228			if (handle && i > 1) {
   229				/*
   230				 * We're only journalling primary superblock and
   231				 * two backup superblocks; the rest is not
   232				 * journalled.
   233				 */
   234				err = ext4_journal_stop(handle);
   235				if (err)
   236					goto out;
   237				handle = NULL;
   238			}
   239	next_grp:
   240			grp = ext4_list_backups(sb, &three, &five, &seven);
   241		}
   242	
   243	out_journal:
   244		if (handle) {
   245			ret = ext4_journal_stop(handle);
   246			if (ret && !err)
   247				err = ret;
   248		}
   249	out:
   250		clear_bit_unlock(EXT4_FLAGS_RESIZING, &sbi->s_ext4_flags);
   251		smp_mb__after_atomic();
   252		return err ? err : 0;
   253	}
   254	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
