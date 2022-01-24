Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42AB14984A8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243694AbiAXQZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:25:00 -0500
Received: from mga09.intel.com ([134.134.136.24]:33130 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241035AbiAXQY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:24:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643041499; x=1674577499;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r2LR73LQKloyaOT9ly1BGRSqZuXVJPR17XcCs+ZhQ00=;
  b=ZMcbHpkLDsiLh4DD6wBhcI1QJ+aXwtV5/ROwsy0bZbzUcDsGziSZN7K7
   CjXE4/0oLtMdJvRt1gldZp+pojAW98t3Vw6yGsbJOT88XnpB9yf7r7CH+
   c86GYwisOqBK0rr32licuyWLADPlCXLKwR8WwO1HwnOSoyMktrVonjfYJ
   Ox6Bui+UkE+daaTh9lBFjfXqB87UYuas/lUtMPab7zAw4/6SDINFM4Mt9
   tSS6X8mbcCIf/2/P3SwqODnzBAZI8rKb20dcKm75IybqYhRDw/uXaXu+X
   56FZ6PLn3RkDUgOjPdMFGqqv0PsWsLbdQwwNsqo2heAiOvR751cA5Mf6C
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245865708"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245865708"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 08:24:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="580440247"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jan 2022 08:24:55 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nC29G-000IbA-Jx; Mon, 24 Jan 2022 16:24:54 +0000
Date:   Tue, 25 Jan 2022 00:23:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xin Yin <yinxin.x@bytedance.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: fs/ext4/fast_commit.c:1774:50: sparse: sparse: incorrect type in
 argument 2 (different base types)
Message-ID: <202201250031.GhpANyOP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
commit: 0b5b5a62b945a141e64011b2f90ee7e46f14be98 ext4: use ext4_ext_remove_space() for fast commit replay delete range
date:   2 weeks ago
config: csky-randconfig-s032-20220120 (https://download.01.org/0day-ci/archive/20220125/202201250031.GhpANyOP-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0b5b5a62b945a141e64011b2f90ee7e46f14be98
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0b5b5a62b945a141e64011b2f90ee7e46f14be98
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/ext4/fast_commit.c:1774:50: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] start @@     got restricted __le32 [addressable] [usertype] fc_lblk @@
   fs/ext4/fast_commit.c:1774:50: sparse:     expected unsigned int [usertype] start
   fs/ext4/fast_commit.c:1774:50: sparse:     got restricted __le32 [addressable] [usertype] fc_lblk
>> fs/ext4/fast_commit.c:1775:39: sparse: sparse: restricted __le32 degrades to integer
   fs/ext4/fast_commit.c:1775:56: sparse: sparse: restricted __le32 degrades to integer

vim +1774 fs/ext4/fast_commit.c

  1724	
  1725	/* Replay DEL_RANGE tag */
  1726	static int
  1727	ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl,
  1728				 u8 *val)
  1729	{
  1730		struct inode *inode;
  1731		struct ext4_fc_del_range lrange;
  1732		struct ext4_map_blocks map;
  1733		ext4_lblk_t cur, remaining;
  1734		int ret;
  1735	
  1736		memcpy(&lrange, val, sizeof(lrange));
  1737		cur = le32_to_cpu(lrange.fc_lblk);
  1738		remaining = le32_to_cpu(lrange.fc_len);
  1739	
  1740		trace_ext4_fc_replay(sb, EXT4_FC_TAG_DEL_RANGE,
  1741			le32_to_cpu(lrange.fc_ino), cur, remaining);
  1742	
  1743		inode = ext4_iget(sb, le32_to_cpu(lrange.fc_ino), EXT4_IGET_NORMAL);
  1744		if (IS_ERR(inode)) {
  1745			jbd_debug(1, "Inode %d not found", le32_to_cpu(lrange.fc_ino));
  1746			return 0;
  1747		}
  1748	
  1749		ret = ext4_fc_record_modified_inode(sb, inode->i_ino);
  1750	
  1751		jbd_debug(1, "DEL_RANGE, inode %ld, lblk %d, len %d\n",
  1752				inode->i_ino, le32_to_cpu(lrange.fc_lblk),
  1753				le32_to_cpu(lrange.fc_len));
  1754		while (remaining > 0) {
  1755			map.m_lblk = cur;
  1756			map.m_len = remaining;
  1757	
  1758			ret = ext4_map_blocks(NULL, inode, &map, 0);
  1759			if (ret < 0) {
  1760				iput(inode);
  1761				return 0;
  1762			}
  1763			if (ret > 0) {
  1764				remaining -= ret;
  1765				cur += ret;
  1766				ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, 0);
  1767			} else {
  1768				remaining -= map.m_len;
  1769				cur += map.m_len;
  1770			}
  1771		}
  1772	
  1773		down_write(&EXT4_I(inode)->i_data_sem);
> 1774		ret = ext4_ext_remove_space(inode, lrange.fc_lblk,
> 1775					lrange.fc_lblk + lrange.fc_len - 1);
  1776		up_write(&EXT4_I(inode)->i_data_sem);
  1777		if (ret) {
  1778			iput(inode);
  1779			return 0;
  1780		}
  1781		ext4_ext_replay_shrink_inode(inode,
  1782			i_size_read(inode) >> sb->s_blocksize_bits);
  1783		ext4_mark_inode_dirty(NULL, inode);
  1784		iput(inode);
  1785	
  1786		return 0;
  1787	}
  1788	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
