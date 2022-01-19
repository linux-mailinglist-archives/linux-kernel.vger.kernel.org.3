Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C9D4942AB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 22:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357463AbiASVzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 16:55:51 -0500
Received: from mga17.intel.com ([192.55.52.151]:59510 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343606AbiASVzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 16:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642629347; x=1674165347;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=otFg3swqPlUELCxL5/8SOVueOWKX3jF6HqiI/xk8r4Q=;
  b=D3Soczo6qeg8wtIIhuZ7Pe2fQzCHTgpg8orfVcLmuL+bKo/BAwuAr8W+
   I/YooU+wpMTuLkU6nKgaJRdYCJQ8KykH9zcY5imt6jn2rwEfQe5pSs8I3
   os9Ilc2Vk06plJcONhrbqp1WhaReSpfeoyMcnCD1F1ZDPBPmc/SKBcUAr
   Qk75VBUvDyQqhSjB7wWQdQT72bphw3aBUq6Dd+IhiBQI5KfAAD2B/2SX/
   3YKwplp7W1qKBdoJyxb8RGU7EUiTh6ehE/wg59iRe46/es4J51AhOmrsd
   9bbhttOAOdi6Z9v9nA9HntJWZbQinlHi6EZSdYCCGiLvVJEWOdwlrK7Nk
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="225876262"
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="225876262"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 13:55:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="477548959"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 19 Jan 2022 13:55:42 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAIvd-000DmU-Ea; Wed, 19 Jan 2022 21:55:41 +0000
Date:   Thu, 20 Jan 2022 05:54:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: mm/gup.c:1674:16: error: unexpected token, expected comma
Message-ID: <202201200528.F5X9Vnfb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1d1df41c5a33359a00e919d54eaebfb789711fdc
commit: bb523b406c849eef8f265a07cd7f320f1f177743 gup: Turn fault_in_pages_{readable,writeable} into fault_in_{readable,writeable}
date:   3 months ago
config: mips-randconfig-r003-20220118 (https://download.01.org/0day-ci/archive/20220120/202201200528.F5X9Vnfb-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5f782d25a742302d25ef3c8b84b54f7483c2deb9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bb523b406c849eef8f265a07cd7f320f1f177743
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout bb523b406c849eef8f265a07cd7f320f1f177743
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/gup.c:1674:16: error: unexpected token, expected comma
                   if (unlikely(__put_user(0, uaddr) != 0))
                                ^
   arch/mips/include/asm/uaccess.h:171:18: note: expanded from macro '__put_user'
                   __put_data_asm(user_sb, __pu_ptr);                      \
                                  ^
   <inline asm>:3:10: note: instantiated into assembly here
           .set    eva
                      ^
>> mm/gup.c:1674:16: error: invalid operand for instruction
                   if (unlikely(__put_user(0, uaddr) != 0))
                                ^
   arch/mips/include/asm/uaccess.h:171:18: note: expanded from macro '__put_user'
                   __put_data_asm(user_sb, __pu_ptr);                      \
                                  ^
   <inline asm>:4:10: note: instantiated into assembly here
           sbe $0, 0($17)
                   ^
   mm/gup.c:1682:16: error: unexpected token, expected comma
                   if (unlikely(__put_user(0, uaddr) != 0))
                                ^
   arch/mips/include/asm/uaccess.h:171:18: note: expanded from macro '__put_user'
                   __put_data_asm(user_sb, __pu_ptr);                      \
                                  ^
   <inline asm>:3:10: note: instantiated into assembly here
           .set    eva
                      ^
   mm/gup.c:1682:16: error: invalid operand for instruction
                   if (unlikely(__put_user(0, uaddr) != 0))
                                ^
   arch/mips/include/asm/uaccess.h:171:18: note: expanded from macro '__put_user'
                   __put_data_asm(user_sb, __pu_ptr);                      \
                                  ^
   <inline asm>:4:10: note: instantiated into assembly here
           sbe $0, 0($2)
                   ^
   mm/gup.c:1710:16: error: unexpected token, expected comma
                   if (unlikely(__get_user(c, uaddr) != 0))
                                ^
   arch/mips/include/asm/uaccess.h:218:23: note: expanded from macro '__get_user'
                   __get_data_asm((x), user_lb, __gu_ptr);                 \
                                       ^
   <inline asm>:3:10: note: instantiated into assembly here
           .set    eva
                      ^
   mm/gup.c:1710:16: error: invalid operand for instruction
                   if (unlikely(__get_user(c, uaddr) != 0))
                                ^
   arch/mips/include/asm/uaccess.h:218:23: note: expanded from macro '__get_user'
                   __get_data_asm((x), user_lb, __gu_ptr);                 \
                                       ^
   <inline asm>:4:10: note: instantiated into assembly here
           lbe $3, 0($17)
                   ^
   mm/gup.c:1718:16: error: unexpected token, expected comma
                   if (unlikely(__get_user(c, uaddr) != 0))
                                ^
   arch/mips/include/asm/uaccess.h:218:23: note: expanded from macro '__get_user'
                   __get_data_asm((x), user_lb, __gu_ptr);                 \
                                       ^
   <inline asm>:3:10: note: instantiated into assembly here
           .set    eva
                      ^
   mm/gup.c:1718:16: error: invalid operand for instruction
                   if (unlikely(__get_user(c, uaddr) != 0))
                                ^
   arch/mips/include/asm/uaccess.h:218:23: note: expanded from macro '__get_user'
                   __get_data_asm((x), user_lb, __gu_ptr);                 \
                                       ^
   <inline asm>:4:10: note: instantiated into assembly here
           lbe $5, 0($2)
                   ^
   8 errors generated.


vim +1674 mm/gup.c

  1658	
  1659	/**
  1660	 * fault_in_writeable - fault in userspace address range for writing
  1661	 * @uaddr: start of address range
  1662	 * @size: size of address range
  1663	 *
  1664	 * Returns the number of bytes not faulted in (like copy_to_user() and
  1665	 * copy_from_user()).
  1666	 */
  1667	size_t fault_in_writeable(char __user *uaddr, size_t size)
  1668	{
  1669		char __user *start = uaddr, *end;
  1670	
  1671		if (unlikely(size == 0))
  1672			return 0;
  1673		if (!PAGE_ALIGNED(uaddr)) {
> 1674			if (unlikely(__put_user(0, uaddr) != 0))
  1675				return size;
  1676			uaddr = (char __user *)PAGE_ALIGN((unsigned long)uaddr);
  1677		}
  1678		end = (char __user *)PAGE_ALIGN((unsigned long)start + size);
  1679		if (unlikely(end < start))
  1680			end = NULL;
  1681		while (uaddr != end) {
  1682			if (unlikely(__put_user(0, uaddr) != 0))
  1683				goto out;
  1684			uaddr += PAGE_SIZE;
  1685		}
  1686	
  1687	out:
  1688		if (size > uaddr - start)
  1689			return size - (uaddr - start);
  1690		return 0;
  1691	}
  1692	EXPORT_SYMBOL(fault_in_writeable);
  1693	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
