Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A26A49B057
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574303AbiAYJdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:33:02 -0500
Received: from mga04.intel.com ([192.55.52.120]:62356 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355319AbiAYJ2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:28:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643102918; x=1674638918;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nZjPFP6UH/U8IVgtLu81A+WgziLleI8nGlkeLFyix8w=;
  b=Fsqf+CDOqhht1C0REWaSjoVDe5WoGQx3RWGWZ6V6guKARzHT/7kJFUZ1
   ZNVXPnUG4mM3ARaHahfHYEx+JgW8sdP3OfmtK+c9/xzRlAeb/prkepJyA
   OcJGrbPkY5nXRR/8kSuS/7J7jclwg9IyU24RaqvtBph2XO++c0RoPlEkS
   ZViRifp9u+KYJdN6Pt7hg9mji/BdVGJABCtyyZ5DfywqWkJdylPG4HQ2q
   YqIU0ba0YsS5Gsl0UQPqN2Gi+asqAqH+0r/0XJ6MblrjFO2L+B6cOWCUS
   +Ymb24UeHkxDW6y7tF1QpCYNBUJxP4sxdO1MRxYswFOzfW/SjeLc5pqGS
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="245096240"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="245096240"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 01:19:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="520317463"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 25 Jan 2022 01:19:34 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCHzB-000JeF-JZ; Tue, 25 Jan 2022 09:19:33 +0000
Date:   Tue, 25 Jan 2022 17:18:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: fs/fscache/cookie.c:32:14: sparse: sparse: symbol
 'fscache_lru_cookie_timeout' was not declared. Should it be static?
Message-ID: <202201251717.ssGUprks-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
commit: 12bb21a29c19aae50cfad4e2bb5c943108f34a7d fscache: Implement cookie user counting and resource pinning
date:   3 weeks ago
config: csky-randconfig-s032-20220120 (https://download.01.org/0day-ci/archive/20220125/202201251717.ssGUprks-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=12bb21a29c19aae50cfad4e2bb5c943108f34a7d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 12bb21a29c19aae50cfad4e2bb5c943108f34a7d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash block// fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/fscache/cookie.c:32:14: sparse: sparse: symbol 'fscache_lru_cookie_timeout' was not declared. Should it be static?

vim +/fscache_lru_cookie_timeout +32 fs/fscache/cookie.c

    23	
    24	#define fscache_cookie_hash_shift 15
    25	static struct hlist_bl_head fscache_cookie_hash[1 << fscache_cookie_hash_shift];
    26	static LIST_HEAD(fscache_cookies);
    27	static DEFINE_RWLOCK(fscache_cookies_lock);
    28	static LIST_HEAD(fscache_cookie_lru);
    29	static DEFINE_SPINLOCK(fscache_cookie_lru_lock);
    30	DEFINE_TIMER(fscache_cookie_lru_timer, fscache_cookie_lru_timed_out);
    31	static DECLARE_WORK(fscache_cookie_lru_work, fscache_cookie_lru_worker);
  > 32	static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR] = "-LCAIFUWRD";
    33	unsigned int fscache_lru_cookie_timeout = 10 * HZ;
    34	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
