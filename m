Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95477481AA9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 09:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbhL3IFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 03:05:49 -0500
Received: from mga03.intel.com ([134.134.136.65]:18597 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237324AbhL3IFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 03:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640851547; x=1672387547;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MODdKle9nElL4gd1Qie5kgjwbKH/TmToyl8f82P8Pc4=;
  b=KnbHSpDVc8AKNZAD/jpHricLPNvN4o8+jO0VH+SjL9W5b4KfhXteMD85
   iDLKUvU40+jAL+1y9rZNfUuGVLiLVl99lyxd5EIasnX0cjYxDRpV4VqxO
   HQI+w5LB16D0IEwDQ+fA4HdoQD80NNhFZvYMaSP/meuJTFu7NM1OkXEVT
   0eRU/6fowh+/7RzE6nP9LH8CfSO+eMw+vU3qvtg0pH7MJkZoENFXbO79b
   yZSmTsh4C8eJEXgbmzSUs7W5KJ1C0z2WbntYJQMVkKM+V2U69LqT+zMJy
   Qad2iRw0IgzznTza0sFU5baoCYUyUgI/76Yuk1SRzw8ly7KgZK3ttCMv7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="241591934"
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="241591934"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 00:05:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="524305917"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 30 Dec 2021 00:05:46 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2qRV-0009v3-QR; Thu, 30 Dec 2021 08:05:45 +0000
Date:   Thu, 30 Dec 2021 16:04:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [goldwynr:iomap 33/33] include/linux/kern_levels.h:5:25: warning:
 format '%lu' expects argument of type 'long unsigned int', but argument 7
 has type 'size_t' {aka 'unsigned int'}
Message-ID: <202112301636.DGrhXsTX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/goldwynr/linux iomap
head:   30c74a8c201365178cae26d0d7aefa120c3245ab
commit: 30c74a8c201365178cae26d0d7aefa120c3245ab [33/33] btrfs: debug patch
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20211230/202112301636.DGrhXsTX-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/goldwynr/linux/commit/30c74a8c201365178cae26d0d7aefa120c3245ab
        git remote add goldwynr https://github.com/goldwynr/linux
        git fetch --no-tags goldwynr iomap
        git checkout 30c74a8c201365178cae26d0d7aefa120c3245ab
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:22,
                    from arch/mips/include/asm/bug.h:42,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:5,
                    from ./arch/mips/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from fs/btrfs/volumes.c:6:
   fs/btrfs/volumes.c: In function 'btrfs_map_bio':
>> include/linux/kern_levels.h:5:25: warning: format '%lu' expects argument of type 'long unsigned int', but argument 7 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:422:25: note: in definition of macro 'printk_index_wrap'
     422 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:523:9: note: in expansion of macro 'printk'
     523 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:14:25: note: in expansion of macro 'KERN_SOH'
      14 | #define KERN_INFO       KERN_SOH "6"    /* informational */
         |                         ^~~~~~~~
   include/linux/printk.h:523:16: note: in expansion of macro 'KERN_INFO'
     523 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~
   fs/btrfs/volumes.c:6890:17: note: in expansion of macro 'pr_info'
    6890 |                 pr_info("%s: %d ioend: %lx inode %lu %llu/%lu",
         |                 ^~~~~~~
>> include/linux/kern_levels.h:5:25: warning: format '%lu' expects argument of type 'long unsigned int', but argument 7 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:422:25: note: in definition of macro 'printk_index_wrap'
     422 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:523:9: note: in expansion of macro 'printk'
     523 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:14:25: note: in expansion of macro 'KERN_SOH'
      14 | #define KERN_INFO       KERN_SOH "6"    /* informational */
         |                         ^~~~~~~~
   include/linux/printk.h:523:16: note: in expansion of macro 'KERN_INFO'
     523 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~
   fs/btrfs/volumes.c:6901:25: note: in expansion of macro 'pr_info'
    6901 |                         pr_info("%s: %d ioend: %lx inode %lu %llu/%lu",
         |                         ^~~~~~~
>> include/linux/kern_levels.h:5:25: warning: format '%lu' expects argument of type 'long unsigned int', but argument 7 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:422:25: note: in definition of macro 'printk_index_wrap'
     422 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:523:9: note: in expansion of macro 'printk'
     523 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:14:25: note: in expansion of macro 'KERN_SOH'
      14 | #define KERN_INFO       KERN_SOH "6"    /* informational */
         |                         ^~~~~~~~
   include/linux/printk.h:523:16: note: in expansion of macro 'KERN_INFO'
     523 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~
   fs/btrfs/volumes.c:6907:25: note: in expansion of macro 'pr_info'
    6907 |                         pr_info("%s: %d ioend: %lx inode %lu %llu/%lu",
         |                         ^~~~~~~
>> include/linux/kern_levels.h:5:25: warning: format '%lu' expects argument of type 'long unsigned int', but argument 7 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:422:25: note: in definition of macro 'printk_index_wrap'
     422 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:523:9: note: in expansion of macro 'printk'
     523 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:14:25: note: in expansion of macro 'KERN_SOH'
      14 | #define KERN_INFO       KERN_SOH "6"    /* informational */
         |                         ^~~~~~~~
   include/linux/printk.h:523:16: note: in expansion of macro 'KERN_INFO'
     523 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~
   fs/btrfs/volumes.c:6938:17: note: in expansion of macro 'pr_info'
    6938 |                 pr_info("%s: %d ioend: %lx inode %lu %llu/%lu",
         |                 ^~~~~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

:::::: The code at line 5 was first introduced by commit
:::::: 04d2c8c83d0e3ac5f78aeede51babb3236200112 printk: convert the format for KERN_<LEVEL> to a 2 byte pattern

:::::: TO: Joe Perches <joe@perches.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
