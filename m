Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7067D4A3363
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 03:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353711AbiA3CxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 21:53:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:26189 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353586AbiA3CxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 21:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643511197; x=1675047197;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ymGE3GP7HJInAeXZ6HE+VzUYWssWUyQLzLRaNVchgsI=;
  b=fTlsFNrxfmy2SbW/S5sXJZXM+JWazhqj1BXukAmI92lUJiVFcb17f8g2
   plwsG8SXnUKGyHMhxRPDPjlQYmvEeRKi3PNuPre7c4dJkvLIxLv1XSxIw
   NEBWZvd6dVDV8Ay+n7UHO+D7w6LAsIMNTr4gUBkrWpWFoYpcRIDRg0UKs
   ZZsxZ5VRv76omqhUvjF0hhbqW9m41wDiJvHa3/eO4jpu8VLe/kkMG0AAT
   zEAOcZvt9r4Gz93rkt2cBFfEnW5ab6dULZhrKdI+EhK2sl/7Wa/M363TE
   2VtKmscu+ljrEZmvNfpvnyHGodHtMr9PcFkKc2/ihwH6BkVwYjCWgEVTz
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="247533172"
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="247533172"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2022 18:53:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="619068539"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jan 2022 18:53:15 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nE0L5-000Pye-AZ; Sun, 30 Jan 2022 02:53:15 +0000
Date:   Sun, 30 Jan 2022 10:52:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mic:next 1/4] kernel/sysctl.c:897:51: sparse: sparse: incorrect
 type in argument 3 (different address spaces)
Message-ID: <202201301017.4PgkIeBv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git next
head:   e8a1a72b5883a6aa1480e0a46f1df1960e18fa3a
commit: c96303ec34ab5dffd825142d2c1b30484b6ca879 [1/4] printk: Move back proc_dointvec_minmax_sysadmin() to sysctl.c
config: sparc-randconfig-s032-20220130 (https://download.01.org/0day-ci/archive/20220130/202201301017.4PgkIeBv-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/commit/?id=c96303ec34ab5dffd825142d2c1b30484b6ca879
        git remote add mic git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git
        git fetch --no-tags mic next
        git checkout c96303ec34ab5dffd825142d2c1b30484b6ca879
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/sysctl.c:897:51: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void * @@     got void [noderef] __user *buffer @@
   kernel/sysctl.c:897:51: sparse:     expected void *
   kernel/sysctl.c:897:51: sparse:     got void [noderef] __user *buffer
   kernel/sysctl.c:891:5: sparse: sparse: symbol 'proc_dointvec_minmax_sysadmin' redeclared with different type (incompatible argument 3 (different address spaces)):
>> kernel/sysctl.c:891:5: sparse:    int extern [addressable] [signed] [toplevel] proc_dointvec_minmax_sysadmin( ... )
   kernel/sysctl.c: note: in included file (through include/linux/umh.h, include/linux/kmod.h, include/linux/module.h):
   include/linux/sysctl.h:72:5: sparse: note: previously declared as:
>> include/linux/sysctl.h:72:5: sparse:    int extern [addressable] [signed] [toplevel] proc_dointvec_minmax_sysadmin( ... )

vim +897 kernel/sysctl.c

   890	
 > 891	int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
   892					void __user *buffer, size_t *lenp, loff_t *ppos)
   893	{
   894		if (write && !capable(CAP_SYS_ADMIN))
   895			return -EPERM;
   896	
 > 897		return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
   898	}
   899	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
