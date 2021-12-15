Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD5947632D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbhLOUZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:25:21 -0500
Received: from mga14.intel.com ([192.55.52.115]:1244 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235696AbhLOUZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:25:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639599919; x=1671135919;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MgslzzP5kR+7+beKecc+2qJE2wbRP6ryZCH5m7rfd8Q=;
  b=DZ+23a935TYFe0ghUWq2Sv1XLoTOmm2mXdp4YGGBNE/LzDKd4g2O70XN
   220y5RzjgL10Mkfy+YlHWD6aSmmD3EynJf74QRDe69JzXu78ARyqTJtOs
   mhwX7iY1Z/MK/J5xYrA0qoEpgO3IiPImf4TvXBdlHZysIeyzAo/Bbn5bb
   e8gQvpIHPSaH8BRg+sQoU15M5sYj4NTyXFcFQm8oyMGTTo0SMcG9rbyJS
   F6kDgEQayzFMiojRErOiAHWCtplHRH8Izl45wSpZOjiunhlsJlOQuCu6d
   SJFqX6qabB6VWlyIA5YUH9YWHiwqwOLTXo8Vv1uEr4Ga+o8BhnlALj8yk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="239550962"
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="239550962"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 12:25:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="465760509"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Dec 2021 12:25:17 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxapw-0002Hv-IZ; Wed, 15 Dec 2021 20:25:16 +0000
Date:   Thu, 16 Dec 2021 04:25:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jirislaby:devel 22/33] drivers/acpi/acpi_dbg.c:263:6: warning:
 comparison of distinct pointer types ('typeof (len) *' (aka 'int *') and
 'typeof ((CIRC_SPACE_TO_END((crc)->head, (crc)->tail, ((1UL) << 12)))) *'
 (aka 'unsigned int *'))
Message-ID: <202112160440.3ZOATMun-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git devel
head:   d61595c5423534810c1a3c0d4a88dd2fd81d750c
commit: 4671e2ec5eadf881696fad611235561e94c6be9c [22/33] circ_buf: switch macros to inlines
config: i386-randconfig-a011-20211214 (https://download.01.org/0day-ci/archive/20211216/202112160440.3ZOATMun-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dd245bab9fbb364faa1581e4f92ba3119a872fba)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git/commit/?id=4671e2ec5eadf881696fad611235561e94c6be9c
        git remote add jirislaby https://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git
        git fetch --no-tags jirislaby devel
        git checkout 4671e2ec5eadf881696fad611235561e94c6be9c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/acpi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/acpi/acpi_dbg.c:263:6: warning: comparison of distinct pointer types ('typeof (len) *' (aka 'int *') and 'typeof ((CIRC_SPACE_TO_END((crc)->head, (crc)->tail, ((1UL) << 12)))) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
           n = min(len, circ_space_to_end(crc));
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
>> drivers/acpi/acpi_dbg.c:585:6: warning: comparison of distinct pointer types ('typeof (len) *' (aka 'int *') and 'typeof ((CIRC_CNT_TO_END((crc)->head, (crc)->tail, ((1UL) << 12)))) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
           n = min(len, circ_count_to_end(crc));
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
   drivers/acpi/acpi_dbg.c:655:6: warning: comparison of distinct pointer types ('typeof (len) *' (aka 'int *') and 'typeof ((CIRC_SPACE_TO_END((crc)->head, (crc)->tail, ((1UL) << 12)))) *' (aka 'unsigned int *')) [-Wcompare-distinct-pointer-types]
           n = min(len, circ_space_to_end(crc));
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
   3 warnings generated.


vim +263 drivers/acpi/acpi_dbg.c

8cfb0cdf07e2c2 Lv Zheng      2015-12-03  249  
8cfb0cdf07e2c2 Lv Zheng      2015-12-03  250  static int acpi_aml_write_kern(const char *buf, int len)
8cfb0cdf07e2c2 Lv Zheng      2015-12-03  251  {
8cfb0cdf07e2c2 Lv Zheng      2015-12-03  252  	int ret;
8cfb0cdf07e2c2 Lv Zheng      2015-12-03  253  	struct circ_buf *crc = &acpi_aml_io.out_crc;
8cfb0cdf07e2c2 Lv Zheng      2015-12-03  254  	int n;
8cfb0cdf07e2c2 Lv Zheng      2015-12-03  255  	char *p;
8cfb0cdf07e2c2 Lv Zheng      2015-12-03  256  
8cfb0cdf07e2c2 Lv Zheng      2015-12-03  257  	ret = acpi_aml_lock_write(crc, ACPI_AML_OUT_KERN);
287980e49ffc0f Arnd Bergmann 2016-05-27  258  	if (ret < 0)
8cfb0cdf07e2c2 Lv Zheng      2015-12-03  259  		return ret;
8cfb0cdf07e2c2 Lv Zheng      2015-12-03  260  	/* sync tail before inserting logs */
8cfb0cdf07e2c2 Lv Zheng      2015-12-03  261  	smp_mb();
8cfb0cdf07e2c2 Lv Zheng      2015-12-03  262  	p = &crc->buf[crc->head];
8cfb0cdf07e2c2 Lv Zheng      2015-12-03 @263  	n = min(len, circ_space_to_end(crc));
8cfb0cdf07e2c2 Lv Zheng      2015-12-03  264  	memcpy(p, buf, n);
8cfb0cdf07e2c2 Lv Zheng      2015-12-03  265  	/* sync head after inserting logs */
8cfb0cdf07e2c2 Lv Zheng      2015-12-03  266  	smp_wmb();
8cfb0cdf07e2c2 Lv Zheng      2015-12-03  267  	crc->head = (crc->head + n) & (ACPI_AML_BUF_SIZE - 1);
8cfb0cdf07e2c2 Lv Zheng      2015-12-03  268  	acpi_aml_unlock_fifo(ACPI_AML_OUT_KERN, true);
8cfb0cdf07e2c2 Lv Zheng      2015-12-03  269  	return n;
8cfb0cdf07e2c2 Lv Zheng      2015-12-03  270  }
8cfb0cdf07e2c2 Lv Zheng      2015-12-03  271  

:::::: The code at line 263 was first introduced by commit
:::::: 8cfb0cdf07e2c260c4d1a102bfec35183907834f ACPI / debugger: Add IO interface to access debugger functionalities

:::::: TO: Lv Zheng <lv.zheng@intel.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
