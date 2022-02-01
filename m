Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447204A55F2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 05:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbiBAEiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 23:38:21 -0500
Received: from mga12.intel.com ([192.55.52.136]:38017 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231182AbiBAEiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 23:38:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643690300; x=1675226300;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fZQB9I0NhR5pbxfa5F4MEMcztxDxXT6iwabpzVfIaak=;
  b=U/xvhCKxIunEcxzzIsHMSBWEpuhHCNAbqUMGq2rNzGDmib4klneqB8oH
   2yaxtMx8V/zlVkDeuuFIFKmh11pZdYSAPxlgNN0PlzeIJPwY1hne8MNHK
   OMUx9o3c4Tai/Y3dne3IQOlDfMhpvPhfFQuw2IBnkk2HbLLVocalHj8/U
   fUA3lvehMHF2P1f0GCk56JKXpg5y34i+jumq5+wEGppHc94+4xEgmFheo
   mK1LFCd1RSCb5/dsb2u9F7ALDQS5WJskA+FZHpqwSMK475/ntYAwf5zGM
   f2jtvfraxE4PkR/tDvuQdr9+HeR2AF3ulzoepxy8PK2nhwgnOXDaxnhjK
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="227590964"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="227590964"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 20:38:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="582914961"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 31 Jan 2022 20:38:17 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEkvo-000Sme-Iz; Tue, 01 Feb 2022 04:38:16 +0000
Date:   Tue, 1 Feb 2022 12:37:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jlayton:ceph-fscrypt 53/54] net/ceph/messenger.c:1122:16: warning:
 comparison of distinct pointer types ('typeof (bytes) *' (aka 'unsigned int
 *') and 'typeof (((1UL) << 12)) *' (aka 'unsigned long *'))
Message-ID: <202202011252.GlKY0IdE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git ceph-fscrypt
head:   14cb86455b249f05d1b11dbab353e33f4fad6a5a
commit: 7e935aa6d4c23a6bcbd27a28c4f5457885c9ae98 [53/54] libceph: allow ceph_msg_data_advance to advance more than a page
config: i386-randconfig-r013-20220131 (https://download.01.org/0day-ci/archive/20220201/202202011252.GlKY0IdE-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 6b1e844b69f15bb7dffaf9365cd2b355d2eb7579)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?id=7e935aa6d4c23a6bcbd27a28c4f5457885c9ae98
        git remote add jlayton https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
        git fetch --no-tags jlayton ceph-fscrypt
        git checkout 7e935aa6d4c23a6bcbd27a28c4f5457885c9ae98
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/ceph/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/ceph/messenger.c:1122:16: warning: comparison of distinct pointer types ('typeof (bytes) *' (aka 'unsigned int *') and 'typeof (((1UL) << 12)) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
                   size_t cur = min(bytes, PAGE_SIZE);
                                ^~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:45:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   1 warning generated.


vim +1122 net/ceph/messenger.c

  1118	
  1119	void ceph_msg_data_advance(struct ceph_msg_data_cursor *cursor, size_t bytes)
  1120	{
  1121		while (bytes) {
> 1122			size_t cur = min(bytes, PAGE_SIZE);
  1123	
  1124			__ceph_msg_data_advance(cursor, cur);
  1125			bytes -= cur;
  1126		}
  1127	}
  1128	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
