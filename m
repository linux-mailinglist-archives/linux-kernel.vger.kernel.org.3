Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3694A3224
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 22:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353273AbiA2V6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 16:58:07 -0500
Received: from mga04.intel.com ([192.55.52.120]:47408 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353252AbiA2V6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 16:58:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643493481; x=1675029481;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=R6Y5dXxTzRObnoHU4ghO35lv2sXUDQnmSlkZ91l7wd4=;
  b=HUhVN6hZaVnxAJTdrg95i1IVrD81Z2wIHw4PpOKYR+HXjDYBcIt0ozJV
   xfi7Atbvuy8ob0hOe65rgu8hSB8u3xioh/hrAaRrnI2XtDDfNTX7c3FkK
   hNknkjyHUTm+1NobQdjGYc1AVd5+7WZt7wmBL3au+W81iyRgiplAgYrBt
   TlTnxhItQOVm5mPdDgyz7ymSB9l0El7oUYKZydmMftcvm0JBIV60voBAi
   Ub2c7Ldi4aeYTdoaGiaqWgm3aavDUlEmcbxzAFE2r4+NW528jHvT7r5eL
   xcoxUewyGAP6QxaeR2GQ/XIrBfmM7lmQQfhJUeH658WvHG817HVc900to
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="246136608"
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="246136608"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2022 13:57:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="768215708"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jan 2022 13:57:58 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDvjJ-000Pgk-Pt; Sat, 29 Jan 2022 21:57:57 +0000
Date:   Sun, 30 Jan 2022 05:57:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: include/linux/eventpoll.h:81:13: sparse: sparse: restricted __poll_t
 degrades to integer
Message-ID: <202201300547.RZdxWp6u-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cb323ee75d24e7acc2f188d123ba6df46159cf09
commit: 249dbe74d3c4b568a623fb55c56cddf19fdf0b89 ARM: 9108/1: oabi-compat: rework epoll_wait/epoll_pwait emulation
date:   5 months ago
config: riscv-randconfig-s031-20220129 (https://download.01.org/0day-ci/archive/20220130/202201300547.RZdxWp6u-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=249dbe74d3c4b568a623fb55c56cddf19fdf0b89
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 249dbe74d3c4b568a623fb55c56cddf19fdf0b89
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   fs/eventpoll.c: note: in included file:
>> include/linux/eventpoll.h:81:13: sparse: sparse: restricted __poll_t degrades to integer
>> include/linux/eventpoll.h:81:13: sparse: sparse: restricted __poll_t degrades to integer
   include/linux/eventpoll.h:81:13: sparse: sparse: cast from restricted __poll_t

vim +81 include/linux/eventpoll.h

    70	
    71	#if defined(CONFIG_ARM) && defined(CONFIG_OABI_COMPAT)
    72	/* ARM OABI has an incompatible struct layout and needs a special handler */
    73	extern struct epoll_event __user *
    74	epoll_put_uevent(__poll_t revents, __u64 data,
    75			 struct epoll_event __user *uevent);
    76	#else
    77	static inline struct epoll_event __user *
    78	epoll_put_uevent(__poll_t revents, __u64 data,
    79			 struct epoll_event __user *uevent)
    80	{
  > 81		if (__put_user(revents, &uevent->events) ||
    82		    __put_user(data, &uevent->data))
    83			return NULL;
    84	
    85		return uevent+1;
    86	}
    87	#endif
    88	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
