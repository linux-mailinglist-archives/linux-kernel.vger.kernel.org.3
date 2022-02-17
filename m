Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0984B9AC8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbiBQIUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:20:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237434AbiBQIUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:20:21 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0BD297226
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645086007; x=1676622007;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mdFOwPu7ccrgmNmDwgcQ0TnE4G1/qKFUwsu9Wd7hCjA=;
  b=elsKyAoI/vf8wv4H1TLXgtuqX3n+QU+4kBLsdo3syL7t2TSqaNQ2Dj5b
   PwDCFTP15pZT5FuKbJsN7wD7C8mrYAfL8mclxt62tEWsmnXQQmPa4r/kG
   yzjyCNCNmJhNaeX9kHbPOk0CToiWxDdQ5f3Gc7w/14CuJx61v+7XmBRdj
   5JaSdriEXXwl4EX3dzsGGBrOsf3yh6lXo5dwYrkeyAZovg3XuT+EhbGX3
   /yiVz0ERaQK5coFAfpg3RoC/p8botNmD/op4QUyUXwl/HTnQN/gDK1wqM
   hI35hW4cOmkPyUUxJvoX/R5mRI3xIvikmVf1HWGLUGJ3kwlXqOBKwrn6N
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="250558994"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="250558994"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 00:20:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="503400743"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 17 Feb 2022 00:20:05 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKc1F-000BeC-4K; Thu, 17 Feb 2022 08:20:05 +0000
Date:   Thu, 17 Feb 2022 16:19:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yejune Deng <yejune.deng@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Rich Felker <dalias@libc.org>
Subject: arch/sh/kernel/crash_dump.c:37:61: sparse: sparse: incorrect type in
 argument 2 (different address spaces)
Message-ID: <202202171614.EFFhggHO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f71077a4d84bbe8c7b91b7db7c4ef815755ac5e3
commit: 12285ff8667bf06c168113c10d3619834e423ae6 sh: kdump: add some attribute to function
date:   5 months ago
config: sh-randconfig-s032-20220217 (https://download.01.org/0day-ci/archive/20220217/202202171614.EFFhggHO-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=12285ff8667bf06c168113c10d3619834e423ae6
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 12285ff8667bf06c168113c10d3619834e423ae6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sh SHELL=/bin/bash arch/sh/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/sh/kernel/crash_dump.c:37:61: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void [noderef] __iomem * @@
   arch/sh/kernel/crash_dump.c:37:61: sparse:     expected void const *from
   arch/sh/kernel/crash_dump.c:37:61: sparse:     got void [noderef] __iomem *
>> arch/sh/kernel/crash_dump.c:42:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *__from @@     got void [noderef] __iomem * @@
   arch/sh/kernel/crash_dump.c:42:28: sparse:     expected void const *__from
   arch/sh/kernel/crash_dump.c:42:28: sparse:     got void [noderef] __iomem *

vim +37 arch/sh/kernel/crash_dump.c

    12	
    13	/**
    14	 * copy_oldmem_page - copy one page from "oldmem"
    15	 * @pfn: page frame number to be copied
    16	 * @buf: target memory address for the copy; this can be in kernel address
    17	 *	space or user address space (see @userbuf)
    18	 * @csize: number of bytes to copy
    19	 * @offset: offset in bytes into the page (based on pfn) to begin the copy
    20	 * @userbuf: if set, @buf is in user address space, use copy_to_user(),
    21	 *	otherwise @buf is in kernel address space, use memcpy().
    22	 *
    23	 * Copy a page from "oldmem". For this page, there is no pte mapped
    24	 * in the current kernel. We stitch up a pte, similar to kmap_atomic.
    25	 */
    26	ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
    27	                               size_t csize, unsigned long offset, int userbuf)
    28	{
    29		void  __iomem *vaddr;
    30	
    31		if (!csize)
    32			return 0;
    33	
    34		vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
    35	
    36		if (userbuf) {
  > 37			if (copy_to_user((void __user *)buf, (vaddr + offset), csize)) {
    38				iounmap(vaddr);
    39				return -EFAULT;
    40			}
    41		} else
  > 42		memcpy(buf, (vaddr + offset), csize);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
