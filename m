Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354104DDF72
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239449AbiCRQ5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239435AbiCRQ5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:57:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9535D2BE2C6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647622573; x=1679158573;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/YkZgsPKuVYtYiQYozP9T/X8YwGF6IEEysEcFDNMfWE=;
  b=duNfYZHU7OfyFjAY59cp9tJLEwwo+/DTqGkIeEJV/WsZ1rCnqi/djMWZ
   QRL5YVvueZNatCXwpvmzoG1CO/tMfMNvWdmqouv3SZahkdJ69MnhtC0JT
   aQ4b5eCOBRp64ersm2WSHfoHl4bSiYRAkHdqnsNCO0OAIPdBzdGfltzPa
   /+9ughVUw2nZ9rIFMV2A/gaWC5igYzL3YKrGlZJcMXzWOqmoXLxXqjmdJ
   3/z1GE6foU4KBLI47duLlQglCoA7ZWhWJAABpRa3sr2uYXlQN8lzKX/h1
   pJk58lo3Mij3ho7EgRXqrq3ZZwixLcGuJsgfjjk39Uw4pdk8gSvKrNGsa
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="237786023"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="237786023"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 09:55:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="691378762"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 18 Mar 2022 09:55:45 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVFtA-000F0G-OD; Fri, 18 Mar 2022 16:55:44 +0000
Date:   Sat, 19 Mar 2022 00:55:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: fs/fat/dir.c:1279:1: warning: the frame size of 2080 bytes is larger
 than 1024 bytes
Message-ID: <202203190047.6huR1WwQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   551acdc3c3d2b6bc97f11e31dcf960bc36343bfc
commit: 4eeef098b43242ed145c83fba9989d586d707589 powerpc/44x: Remove STDBINUTILS kconfig option
date:   1 year, 2 months ago
config: powerpc-randconfig-r034-20220318 (https://download.01.org/0day-ci/archive/20220319/202203190047.6huR1WwQ-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4eeef098b43242ed145c83fba9989d586d707589
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4eeef098b43242ed145c83fba9989d586d707589
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/fat/dir.c: In function 'fat_add_new_entries':
>> fs/fat/dir.c:1279:1: warning: the frame size of 2080 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    1279 | }
         | ^
   fs/fat/dir.c: In function 'fat_alloc_new_dir':
   fs/fat/dir.c:1195:1: warning: the frame size of 2064 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    1195 | }
         | ^
--
   fs/fat/fatent.c: In function 'fat_free_clusters':
>> fs/fat/fatent.c:632:1: warning: the frame size of 2096 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     632 | }
         | ^
   fs/fat/fatent.c: In function 'fat_alloc_clusters':
   fs/fat/fatent.c:550:1: warning: the frame size of 2128 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     550 | }
         | ^
--
   fs/exfat/fatent.c: In function 'exfat_zeroed_cluster':
>> fs/exfat/fatent.c:277:1: warning: the frame size of 2064 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     277 | }
         | ^
--
   fs/buffer.c: In function 'block_read_full_page':
>> fs/buffer.c:2342:1: warning: the frame size of 2064 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    2342 | }
         | ^
--
   fs/ext4/move_extent.c: In function 'mext_page_mkuptodate':
>> fs/ext4/move_extent.c:227:1: warning: the frame size of 2064 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     227 | }
         | ^


vim +1279 fs/fat/dir.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  1197  
^1da177e4c3f41 Linus Torvalds 2005-04-16  1198  static int fat_add_new_entries(struct inode *dir, void *slots, int nr_slots,
^1da177e4c3f41 Linus Torvalds 2005-04-16  1199  			       int *nr_cluster, struct msdos_dir_entry **de,
^1da177e4c3f41 Linus Torvalds 2005-04-16  1200  			       struct buffer_head **bh, loff_t *i_pos)
^1da177e4c3f41 Linus Torvalds 2005-04-16  1201  {
^1da177e4c3f41 Linus Torvalds 2005-04-16  1202  	struct super_block *sb = dir->i_sb;
^1da177e4c3f41 Linus Torvalds 2005-04-16  1203  	struct msdos_sb_info *sbi = MSDOS_SB(sb);
^1da177e4c3f41 Linus Torvalds 2005-04-16  1204  	struct buffer_head *bhs[MAX_BUF_PER_PAGE];
^1da177e4c3f41 Linus Torvalds 2005-04-16  1205  	sector_t blknr, start_blknr, last_blknr;
^1da177e4c3f41 Linus Torvalds 2005-04-16  1206  	unsigned long size, copy;
^1da177e4c3f41 Linus Torvalds 2005-04-16  1207  	int err, i, n, offset, cluster[2];
^1da177e4c3f41 Linus Torvalds 2005-04-16  1208  
^1da177e4c3f41 Linus Torvalds 2005-04-16  1209  	/*
^1da177e4c3f41 Linus Torvalds 2005-04-16  1210  	 * The minimum cluster size is 512bytes, and maximum entry
^1da177e4c3f41 Linus Torvalds 2005-04-16  1211  	 * size is 32*slots (672bytes).  So, iff the cluster size is
^1da177e4c3f41 Linus Torvalds 2005-04-16  1212  	 * 512bytes, we may need two clusters.
^1da177e4c3f41 Linus Torvalds 2005-04-16  1213  	 */
^1da177e4c3f41 Linus Torvalds 2005-04-16  1214  	size = nr_slots * sizeof(struct msdos_dir_entry);
^1da177e4c3f41 Linus Torvalds 2005-04-16  1215  	*nr_cluster = (size + (sbi->cluster_size - 1)) >> sbi->cluster_bits;
^1da177e4c3f41 Linus Torvalds 2005-04-16  1216  	BUG_ON(*nr_cluster > 2);
^1da177e4c3f41 Linus Torvalds 2005-04-16  1217  
^1da177e4c3f41 Linus Torvalds 2005-04-16  1218  	err = fat_alloc_clusters(dir, cluster, *nr_cluster);
^1da177e4c3f41 Linus Torvalds 2005-04-16  1219  	if (err)
^1da177e4c3f41 Linus Torvalds 2005-04-16  1220  		goto error;
^1da177e4c3f41 Linus Torvalds 2005-04-16  1221  
^1da177e4c3f41 Linus Torvalds 2005-04-16  1222  	/*
^1da177e4c3f41 Linus Torvalds 2005-04-16  1223  	 * First stage: Fill the directory entry.  NOTE: This cluster
^1da177e4c3f41 Linus Torvalds 2005-04-16  1224  	 * is not referenced from any inode yet, so updates order is
^1da177e4c3f41 Linus Torvalds 2005-04-16  1225  	 * not important.
^1da177e4c3f41 Linus Torvalds 2005-04-16  1226  	 */
^1da177e4c3f41 Linus Torvalds 2005-04-16  1227  	i = n = copy = 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  1228  	do {
^1da177e4c3f41 Linus Torvalds 2005-04-16  1229  		start_blknr = blknr = fat_clus_to_blknr(sbi, cluster[i]);
^1da177e4c3f41 Linus Torvalds 2005-04-16  1230  		last_blknr = start_blknr + sbi->sec_per_clus;
^1da177e4c3f41 Linus Torvalds 2005-04-16  1231  		while (blknr < last_blknr) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  1232  			bhs[n] = sb_getblk(sb, blknr);
^1da177e4c3f41 Linus Torvalds 2005-04-16  1233  			if (!bhs[n]) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  1234  				err = -ENOMEM;
^1da177e4c3f41 Linus Torvalds 2005-04-16  1235  				goto error_nomem;
^1da177e4c3f41 Linus Torvalds 2005-04-16  1236  			}
^1da177e4c3f41 Linus Torvalds 2005-04-16  1237  
^1da177e4c3f41 Linus Torvalds 2005-04-16  1238  			/* fill the directory entry */
^1da177e4c3f41 Linus Torvalds 2005-04-16  1239  			copy = min(size, sb->s_blocksize);
07bfa4415ab607 OGAWA Hirofumi 2019-09-23  1240  			/* Avoid race with userspace read via bdev */
07bfa4415ab607 OGAWA Hirofumi 2019-09-23  1241  			lock_buffer(bhs[n]);
^1da177e4c3f41 Linus Torvalds 2005-04-16  1242  			memcpy(bhs[n]->b_data, slots, copy);
^1da177e4c3f41 Linus Torvalds 2005-04-16  1243  			set_buffer_uptodate(bhs[n]);
07bfa4415ab607 OGAWA Hirofumi 2019-09-23  1244  			unlock_buffer(bhs[n]);
b522412aeabadb Al Viro        2009-06-07  1245  			mark_buffer_dirty_inode(bhs[n], dir);
07bfa4415ab607 OGAWA Hirofumi 2019-09-23  1246  			slots += copy;
07bfa4415ab607 OGAWA Hirofumi 2019-09-23  1247  			size -= copy;
^1da177e4c3f41 Linus Torvalds 2005-04-16  1248  			if (!size)
^1da177e4c3f41 Linus Torvalds 2005-04-16  1249  				break;
^1da177e4c3f41 Linus Torvalds 2005-04-16  1250  			n++;
^1da177e4c3f41 Linus Torvalds 2005-04-16  1251  			blknr++;
^1da177e4c3f41 Linus Torvalds 2005-04-16  1252  		}
^1da177e4c3f41 Linus Torvalds 2005-04-16  1253  	} while (++i < *nr_cluster);
^1da177e4c3f41 Linus Torvalds 2005-04-16  1254  
^1da177e4c3f41 Linus Torvalds 2005-04-16  1255  	memset(bhs[n]->b_data + copy, 0, sb->s_blocksize - copy);
^1da177e4c3f41 Linus Torvalds 2005-04-16  1256  	offset = copy - sizeof(struct msdos_dir_entry);
^1da177e4c3f41 Linus Torvalds 2005-04-16  1257  	get_bh(bhs[n]);
^1da177e4c3f41 Linus Torvalds 2005-04-16  1258  	*bh = bhs[n];
^1da177e4c3f41 Linus Torvalds 2005-04-16  1259  	*de = (struct msdos_dir_entry *)((*bh)->b_data + offset);
^1da177e4c3f41 Linus Torvalds 2005-04-16  1260  	*i_pos = fat_make_i_pos(sb, *bh, *de);
^1da177e4c3f41 Linus Torvalds 2005-04-16  1261  
^1da177e4c3f41 Linus Torvalds 2005-04-16  1262  	/* Second stage: clear the rest of cluster, and write outs */
^1da177e4c3f41 Linus Torvalds 2005-04-16  1263  	err = fat_zeroed_cluster(dir, start_blknr, ++n, bhs, MAX_BUF_PER_PAGE);
^1da177e4c3f41 Linus Torvalds 2005-04-16  1264  	if (err)
^1da177e4c3f41 Linus Torvalds 2005-04-16  1265  		goto error_free;
^1da177e4c3f41 Linus Torvalds 2005-04-16  1266  
^1da177e4c3f41 Linus Torvalds 2005-04-16  1267  	return cluster[0];
^1da177e4c3f41 Linus Torvalds 2005-04-16  1268  
^1da177e4c3f41 Linus Torvalds 2005-04-16  1269  error_free:
^1da177e4c3f41 Linus Torvalds 2005-04-16  1270  	brelse(*bh);
^1da177e4c3f41 Linus Torvalds 2005-04-16  1271  	*bh = NULL;
^1da177e4c3f41 Linus Torvalds 2005-04-16  1272  	n = 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  1273  error_nomem:
^1da177e4c3f41 Linus Torvalds 2005-04-16  1274  	for (i = 0; i < n; i++)
^1da177e4c3f41 Linus Torvalds 2005-04-16  1275  		bforget(bhs[i]);
^1da177e4c3f41 Linus Torvalds 2005-04-16  1276  	fat_free_clusters(dir, cluster[0]);
^1da177e4c3f41 Linus Torvalds 2005-04-16  1277  error:
^1da177e4c3f41 Linus Torvalds 2005-04-16  1278  	return err;
^1da177e4c3f41 Linus Torvalds 2005-04-16 @1279  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  1280  

:::::: The code at line 1279 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
