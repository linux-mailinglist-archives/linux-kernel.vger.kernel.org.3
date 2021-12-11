Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1E64715B1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 20:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhLKTax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 14:30:53 -0500
Received: from mga11.intel.com ([192.55.52.93]:13514 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229642AbhLKTaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 14:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639251052; x=1670787052;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lQoo0ISAzgQZzm/56C60vnkWnhIFvX23VxzFKfIBtoM=;
  b=ifU/lrnVFB4SEJm3a2v+LXz1KzaCs9+NjhdMkrpff9mzxMcqEGrteZc/
   RiMCKO5zuxTXb+YIdWG79P+d/ewtG+y1m9CBd4wnLDR144oCUAovEmUdc
   J6rwUv3TpgRZ7Rxb/gysovJ/eH58j/B8AVCj1tvs93vwXgkgNs+J1zcuN
   ySpRCxnI/BPvujNMXVeYpF2hPQ1H1gh7AqnnbScr1DOnW33LG9seHtjtm
   s2BBfjfsNsdpsfc+NjqbEuF3/Hnv5PUT83jSt9y1VIt7/GZjhIMeq28bg
   d8mb0Lbwo22hwLR8kpswZQjK7U3NNt5XT9namxCjLWda4+zc1W0r7MOza
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10195"; a="236076204"
X-IronPort-AV: E=Sophos;i="5.88,198,1635231600"; 
   d="scan'208";a="236076204"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2021 11:30:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,198,1635231600"; 
   d="scan'208";a="464136583"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 11 Dec 2021 11:30:50 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mw853-00050T-NU; Sat, 11 Dec 2021 19:30:49 +0000
Date:   Sun, 12 Dec 2021 03:30:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [chao:dev 2/5] fs/f2fs/xattr.c:691:20: warning: format specifies
 type 'unsigned long' but the argument has type 'unsigned int'
Message-ID: <202112120347.GGgB0mVe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git dev
head:   0f9e12d0df416311a310873984101b0b6b4ab054
commit: 0514b392fdbe2e6681e4fb513ce78b2d05d51496 [2/5] f2fs: fix to do sanity check on last xattr entry in __f2fs_setxattr()
config: i386-buildonly-randconfig-r003-20211211 (https://download.01.org/0day-ci/archive/20211212/202112120347.GGgB0mVe-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?id=0514b392fdbe2e6681e4fb513ce78b2d05d51496
        git remote add chao https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git
        git fetch --no-tags chao dev
        git checkout 0514b392fdbe2e6681e4fb513ce78b2d05d51496
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/f2fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/f2fs/xattr.c:691:20: warning: format specifies type 'unsigned long' but the argument has type 'unsigned int' [-Wformat]
                                           inode->i_ino, ENTRY_SIZE(last));
                                                         ^~~~~~~~~~~~~~~~
   fs/f2fs/f2fs.h:2247:35: note: expanded from macro 'f2fs_err'
           f2fs_printk(sbi, KERN_ERR fmt, ##__VA_ARGS__)
                                     ~~~    ^~~~~~~~~~~
   fs/f2fs/xattr.h:62:27: note: expanded from macro 'ENTRY_SIZE'
   #define ENTRY_SIZE(entry) (XATTR_ALIGN(sizeof(struct f2fs_xattr_entry) + \
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +691 fs/f2fs/xattr.c

   629	
   630	static int __f2fs_setxattr(struct inode *inode, int index,
   631				const char *name, const void *value, size_t size,
   632				struct page *ipage, int flags)
   633	{
   634		struct f2fs_xattr_entry *here, *last;
   635		void *base_addr, *last_base_addr;
   636		int found, newsize;
   637		size_t len;
   638		__u32 new_hsize;
   639		int error;
   640	
   641		if (name == NULL)
   642			return -EINVAL;
   643	
   644		if (value == NULL)
   645			size = 0;
   646	
   647		len = strlen(name);
   648	
   649		if (len > F2FS_NAME_LEN)
   650			return -ERANGE;
   651	
   652		if (size > MAX_VALUE_LEN(inode))
   653			return -E2BIG;
   654	
   655		error = read_all_xattrs(inode, ipage, &base_addr);
   656		if (error)
   657			return error;
   658	
   659		last_base_addr = (void *)base_addr + XATTR_SIZE(inode);
   660	
   661		/* find entry with wanted name. */
   662		here = __find_xattr(base_addr, last_base_addr, index, len, name);
   663		if (!here) {
   664			f2fs_err(F2FS_I_SB(inode), "inode (%lu) has corrupted xattr",
   665									inode->i_ino);
   666			set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
   667			error = -EFSCORRUPTED;
   668			goto exit;
   669		}
   670	
   671		found = IS_XATTR_LAST_ENTRY(here) ? 0 : 1;
   672	
   673		if (found) {
   674			if ((flags & XATTR_CREATE)) {
   675				error = -EEXIST;
   676				goto exit;
   677			}
   678	
   679			if (value && f2fs_xattr_value_same(here, value, size))
   680				goto same;
   681		} else if ((flags & XATTR_REPLACE)) {
   682			error = -ENODATA;
   683			goto exit;
   684		}
   685	
   686		last = here;
   687		while (!IS_XATTR_LAST_ENTRY(last)) {
   688			if ((void *)(last) + sizeof(__u32) > last_base_addr ||
   689				(void *)XATTR_NEXT_ENTRY(last) > last_base_addr) {
   690				f2fs_err(F2FS_I_SB(inode), "inode (%lu) has invalid last xattr entry, entry_size: %lu",
 > 691						inode->i_ino, ENTRY_SIZE(last));
   692				set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
   693				error = -EFSCORRUPTED;
   694				goto exit;
   695			}
   696			last = XATTR_NEXT_ENTRY(last);
   697		}
   698	
   699		newsize = XATTR_ALIGN(sizeof(struct f2fs_xattr_entry) + len + size);
   700	
   701		/* 1. Check space */
   702		if (value) {
   703			int free;
   704			/*
   705			 * If value is NULL, it is remove operation.
   706			 * In case of update operation, we calculate free.
   707			 */
   708			free = MIN_OFFSET(inode) - ((char *)last - (char *)base_addr);
   709			if (found)
   710				free = free + ENTRY_SIZE(here);
   711	
   712			if (unlikely(free < newsize)) {
   713				error = -E2BIG;
   714				goto exit;
   715			}
   716		}
   717	
   718		/* 2. Remove old entry */
   719		if (found) {
   720			/*
   721			 * If entry is found, remove old entry.
   722			 * If not found, remove operation is not needed.
   723			 */
   724			struct f2fs_xattr_entry *next = XATTR_NEXT_ENTRY(here);
   725			int oldsize = ENTRY_SIZE(here);
   726	
   727			memmove(here, next, (char *)last - (char *)next);
   728			last = (struct f2fs_xattr_entry *)((char *)last - oldsize);
   729			memset(last, 0, oldsize);
   730		}
   731	
   732		new_hsize = (char *)last - (char *)base_addr;
   733	
   734		/* 3. Write new entry */
   735		if (value) {
   736			char *pval;
   737			/*
   738			 * Before we come here, old entry is removed.
   739			 * We just write new entry.
   740			 */
   741			last->e_name_index = index;
   742			last->e_name_len = len;
   743			memcpy(last->e_name, name, len);
   744			pval = last->e_name + len;
   745			memcpy(pval, value, size);
   746			last->e_value_size = cpu_to_le16(size);
   747			new_hsize += newsize;
   748		}
   749	
   750		error = write_all_xattrs(inode, new_hsize, base_addr, ipage);
   751		if (error)
   752			goto exit;
   753	
   754		if (index == F2FS_XATTR_INDEX_ENCRYPTION &&
   755				!strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTEXT))
   756			f2fs_set_encrypted_inode(inode);
   757		f2fs_mark_inode_dirty_sync(inode, true);
   758		if (!error && S_ISDIR(inode->i_mode))
   759			set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
   760	
   761	same:
   762		if (is_inode_flag_set(inode, FI_ACL_MODE)) {
   763			inode->i_mode = F2FS_I(inode)->i_acl_mode;
   764			inode->i_ctime = current_time(inode);
   765			clear_inode_flag(inode, FI_ACL_MODE);
   766		}
   767	
   768	exit:
   769		kfree(base_addr);
   770		return error;
   771	}
   772	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
